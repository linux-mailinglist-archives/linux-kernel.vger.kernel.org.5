Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694D77ADAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjIYOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjIYOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:53:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA01107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:53:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3366AC433C7;
        Mon, 25 Sep 2023 14:53:40 +0000 (UTC)
Date:   Mon, 25 Sep 2023 10:53:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for 6.6-rc2
Message-ID: <20230925105335.5d8f6af0@rorschach.local.home>
In-Reply-To: <CAHk-=wh=aOhPAJn-E8T+GofoBeCtXuoEXZcw6A009MO4s3mNAA@mail.gmail.com>
References: <20230923191420.10c42e4f@rorschach.local.home>
        <CAHk-=wh=aOhPAJn-E8T+GofoBeCtXuoEXZcw6A009MO4s3mNAA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 14:09:04 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 23 Sept 2023 at 16:14, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Fix a bug in eventfs where reading a dynamic event directory (open) and then
> >   creating a dynamic event that goes into that diretory screws up the accounting.  
> 
> Honestly, I'm getting more and more convinced that you just need to
> stop this eventfs stuff.
> 
> This is just *incredibly* ugly:
> 
>   /*
>    * This just sets the file->private_data back to the cursor and back.
>    */
>   static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
>   {
>         struct dentry_list *dlist = file->private_data;
>         int ret;
> 
>         file->private_data = dlist->cursor;
>         ret = dcache_readdir(file, ctx);
>         dlist->cursor = file->private_data;
>         file->private_data = dlist;
>         return ret;
>   }
> 
> I guess it works by the f_pos locking magic, but by christ is this
> ugly beyond words.
> 
> Honestly, now, are the eventfs changes *really* making up for this
> kind of continual "this is crazy" garbage? We had the whole "this is
> undebuggable" discussion, now there's stuff like this.

I never said "this is undebuggable". That show_event_dentries just
showed ref counts and what was allocated. Not that it was "undebuggable".
When ls is done on eventfs, the dentries are created. When the memory
is tight, any dentry that is not open should be reclaimed. The
show_event_dentries was to see if they were reclaimed or are still
around and taking up memory. It is also showing the ref counts, where
you can see if closing the file/directory would decrement the ref count
properly. It was used here because I found a way to dec a dentry
without first upping the refcount, as I explain below.

The purpose of eventfs here is that the /sys/kernel/tracing/events
directory currently allocates dentries and inodes for all existing
events in the kernel. Since there are now over a thousand events in the
kernel, and each event has several files created for them, and these
files are seldom looked at, why should they be allocated when not used?

These dentries and inodes are allocated for the top level directory and
wasting memory for most users. When an instance is created it makes
matters even worse.

 mkdir /sys/kernel/trace/instance/foo

Which creates an entire copy of the events directory to maintain state
(you can enable events for this instance and not for other instances),
all those dentries and inodes for the events are allocated again (like
20MB worth).

And we plan on using many instances in production, we rather not waste
all that memory. That was the reason for doing this in the first place.

Now, I presented this at LSFMM where I learned about /proc doing
something similar (and you pointed that out too) but when I looked at
that code I couldn't figure out how to easily make that work with
tracefs, so this work came out instead.

I'm not an FS developer so there may be a better way to do this. I
would be happy to hear about better alternatives.

> 
> Were people even *aware* of the f_pos locking, or did this just happen to work?

I looked at the implementation of dcache_dir_open(), dcache_readdir()
and dcache_dir_close() and saw how it allocated, modified, and freed
the file->private_data / cursor. I came to the conclusion that if
there wasn't protection around them then it would not work. In fact,
it's abstracted out enough that I could have just simply copied the
code and just use my struct dlist_entry directly. But instead of
copying of that code, I did it this way to reuse the existing code.

Would you prefer that I just copy that code (there's really not much)
and implement it less "ugly" by using my own cursor? Which would
require that f_pos locking magic just like any other implementation of
.iterate_shared and friends.

> 
> And that's entirely ignoring the disgusting thing that is that
> "allocate an array of every dentry we looked at" issue. Which honestly
> also looks disgusting.

How is it disgusting? How else would you do it?

You open a directory to read the files which creates the dentries and
ups their ref counts, in the mean time, a new file is created (it's OK
not to see it, as it's similar to RCU, only new opens will see the new
file), but when you close it, you only do the dput on the files you
opened and not the new file. The current code used just the link list
of all the files which also included the new file that wasn't updated
on open.

> 
> I beg of you: think hard about just reverting all the eventfs changes
> that moved away from using dentries natively, and instead started
> doing these *incredibly* hacky and ugly things.

And bring back all that wasted memory?

If there's a better way to achieve the same thing, I'll happily do it.

-- Steve
