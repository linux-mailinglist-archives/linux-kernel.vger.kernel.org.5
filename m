Return-Path: <linux-kernel+bounces-45433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241484306E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5FE1F2193F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A047EF00;
	Tue, 30 Jan 2024 22:55:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020F7EEEB;
	Tue, 30 Jan 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655352; cv=none; b=OYLgI8DaGfBq06oGOKDt2QRwMtPojiJ+XSpppwXQfcMi/ocR3m6HycsNLxaRTqSgp1eVtgtP3rQBoeBsZR6kYaHv/+PemLX3KgWSYBJCk6KCj9K6YtDUzPn7hng3RHuzES4ne5FR9hitAXno031h9QVuELnNhXlqjnmClv1q4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655352; c=relaxed/simple;
	bh=qKcGqyjYpxKBsqVBnxCCmJqR43+HQzG8Sc4B+BH9uf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN9F76+ce+sXUwp588CR03T98zKe6+I9dxxiPSTVFGrxPZe+qqo9SBcMbilIvCJk/g2OmhoQCDyyA8o1jmrtfk2TBK9G8aT9VYOyVAxDZNhsiED1Y6l9eVDtj2/pK5UAMOgPt8rTcZuFFG/lStrEdheH3r6LqdsWz55LjOTFaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E0C433C7;
	Tue, 30 Jan 2024 22:55:51 +0000 (UTC)
Date: Tue, 30 Jan 2024 17:56:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240130175603.5f686e46@gandalf.local.home>
In-Reply-To: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240130155550.4881d558@gandalf.local.home>
	<CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:52:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 12:55, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I'm going to be putting back the ei->name pointer as the above actually
> > adds more memory usage.  
> 
> I did it mainly because I hate having multiple different allocation
> sites that then have to do that kref_init() etc individually, and once
> there was a single site the "name" thing really looked lik ean obvious
> simplification.
> 
> That said, I think you're confused about the memory usage.
> 
> Sure, 'kstrdup_const()' optimizes away the allocation for static
> constant strings, but what it does *not* do is to optimize away the
> pointer.
> 
> In contrast, allocating them together gets rid of the pointer itself,
> because now the name is just an offset in the structure.
> 
> And the pointer is 8 bytes right there.
> 
> So allocating the string _with_ the ei will always save at least 8 bytes.

Not if the string is not allocated, and ei->name is just pointing to an
existing string. Which is what kstrdup_const() does if the string is a
constant.

If the length of the string was one byte, so you allocate sizeof(*ei) + 2
(for the '\0' as well), is kzalloc() going to allocate anything less than 8
byte alignment? According to /proc/slabinfo, any allocation will be 8
bytes. Thus it is the same as having the pointer if the string is constant
but less than 8 bytes in length. But a waste if it is more.

> 
> So whenever the string is less than that in length it's *always* a win.
> 
> And even when it's not an absolute win, it will take advantage of the
> kmalloc() quantized sizes too, and generally not be a loss even with
> longer names.
> 
> So I'm pretty sure you are simply entirely wrong on the memory usage.
> Not counting the size of the pointer is overlooking a big piece of the
> puzzle.
> 
> Btw, you can look at name lengths in tracefs with something stupid like this:
> 
>     find . | sed 's:^.*/::' | tr -c '\n' . | sort | uniq -c
> 
> and you will see that (at least in my case) names of lengths 1..7 are
> dominating it all:
> 
>       1 .
>    2189 ..
>      34 ...
>    2229 ....
>     207 .....
>    6833 ......
>    2211 .......
> 
> with the rest being insignificant in comparison.
> 
> The reason? There's a *lot* of those 'filter' and 'enable' and 'id'
> files. All of which are better off without a 'const char *name' taking
> 8 bytes.

Remember, the files don't have an ei allocated. Only directories.

 # find . -type d | sed 's:^.*/::' | tr -c '\n' . | sort | uniq -c
      1 .
      2 ..
     30 ...
     14 ....
     21 .....
     15 ......
     18 .......

Above is 8 bytes (length of 7 + '\0')

     27 ........
     36 .........
     35 ..........
     49 ...........
     63 ............
     85 .............
    140 ..............
    180 ...............
    180 ................
    155 .................
    171 ..................
    158 ...................
    134 ....................
    116 .....................
    106 ......................
     81 .......................
     61 ........................
     58 .........................
     43 ..........................
     41 ...........................
     23 ............................
     14 .............................
     13 ..............................
      9 ...............................
      7 ................................
      6 .................................
      5 ..................................
      1 ...................................
      2 ....................................
      1 .....................................
      1 ........................................

The rest is all greater than the pointer size.

Also, it does prevent me from switching to a slab.

I added the below patch (after changing this back to kstrdup_const), that
determines if the string is allocated by checking if ei->name is the same
as the pointer passed in. This showed me:

 # cat /sys/kernel/tracing/dyn_ftrace_total_info
53698 pages:220 groups: 8 const cnt:2099 len:22446 dyn cnt: 3 len:56

That is, 2099 ei->name's point to a constant string without allocation.
Granted, I built my system without many modules. If you have more code
built as modules, that number may be less.

I then counted the length of the string - 7 bytes (which is the same as the
length of the string plus the '\0' character - 8 bytes) to accommodate the
pointer size, and it's a savings of 22KB per instance. And in actuality, I
should have rounded to the nearest kmalloc slab size as kzalloc() isn't going to
return 35 bytes back but 64 bytes will be allocated.

I think that's a win.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index e9819d719d2a..ed9ffaac9a32 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -785,6 +785,25 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	goto out;
 }
 
+int sdr_ei_const;
+int sdr_ei_len;
+int sdr_ei_dyn;
+int sdr_ei_dyn_len;
+
+static void sdr_count(struct eventfs_inode *ei, const char *name)
+{
+	int len = strlen(name);
+
+	if (ei->name == name) {
+		sdr_ei_const++;
+		if (len > 7)
+			sdr_ei_len += len - 7;
+	} else {
+		sdr_ei_dyn++;
+		sdr_ei_dyn_len += len;
+	}
+}
+
 /**
  * eventfs_create_dir - Create the eventfs_inode for this directory
  * @name: The name of the directory to create.
@@ -838,6 +857,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 		kfree(ei);
 		return ERR_PTR(-ENOMEM);
 	}
+	sdr_count(ei, name);
 
 	if (size) {
 		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
@@ -920,6 +940,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	ei->name = kstrdup_const(name, GFP_KERNEL);
 	if (!ei->name)
 		goto fail;
+	sdr_count(ei, name);
 
 	/* Save the ownership of this directory */
 	uid = d_inode(dentry->d_parent)->i_uid;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..3b254ec4d831 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8701,6 +8701,11 @@ static const struct file_operations tracing_stats_fops = {
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
+extern int sdr_ei_const;
+extern int sdr_ei_len;
+extern int sdr_ei_dyn;
+extern int sdr_ei_dyn_len;
+
 static ssize_t
 tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		  size_t cnt, loff_t *ppos)
@@ -8714,10 +8719,11 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 	if (!buf)
 		return -ENOMEM;
 
-	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
+	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld const cnt:%d len:%d dyn cnt: %d len:%d\n",
 		      ftrace_update_tot_cnt,
 		      ftrace_number_of_pages,
-		      ftrace_number_of_groups);
+		      ftrace_number_of_groups,
+		      sdr_ei_const, sdr_ei_len, sdr_ei_dyn, sdr_ei_dyn_len);
 
 	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 	kfree(buf);

