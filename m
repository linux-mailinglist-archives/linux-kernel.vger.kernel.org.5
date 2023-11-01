Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F597DE33B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjKAO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKAO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:56:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21A119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:55:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC28C433C8;
        Wed,  1 Nov 2023 14:55:55 +0000 (UTC)
Date:   Wed, 1 Nov 2023 10:55:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231101105554.6cd5a30f@gandalf.local.home>
In-Reply-To: <20231101001659.1456b3d4@gandalf.local.home>
References: <20231031144703.71eef3a0@gandalf.local.home>
        <20231101022553.GE1957730@ZenIV>
        <20231101001659.1456b3d4@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 00:16:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Nov 2023 02:25:53 +0000
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Umm...  Is there any reason not to use simple_recursive_removal() there?  
> 
> Hmm, I may be able to (I'm still a newbie with understanding of the vfs).
> 
> I did it this way thinking that a dentry may exist in the children but not
> at a higher level, but I don't think that can be the case. This creates
> dentries and inodes dynamically when they are referenced. The eventfs_inode
> maps to each directory (the files of a directory are created from the
> information from the eventfs_inode).

OK, as I tried to use the simple_recursive_remove() and I failed miserably!

I think I know why. What happened was the last child would get one extra
"dput" than it needed. That's because dentry's exist without any reference
on them and they don't disappear until a reclaim happens. What I mean is,
when a file is "open()'d" a dentry is created on the fly so that the user
can access the file. When it is "close()'d" the dentry count goes to zero.

Then on memory reclaim, the dentries may be removed. If another open
happens, the dentry is created again, or the one that is still cached can
be reinstated.

It looks like the simple_recursive_remove() expects all dentries to have at
least a 1 when entering, which is not the case here.

But!

Now what I could do is to do a dget() when removing the eventfs_inodes (ei)
on any dentry that is attached to them.

/me goes and tries that...

OK, that actually seems to work. With the assumption that there will never
be dentry without a parent I think I can go this approach.

Thanks!

-- Steve
