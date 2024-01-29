Return-Path: <linux-kernel+bounces-43208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E978410E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D731F22D17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7C76C8A;
	Mon, 29 Jan 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eM40Jqqp"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6276C83
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550029; cv=none; b=UXgk/Hm9QZZcyVLwFwaKrsYWEIxD99Dmt/wun09zucdJH3QNLYfiOeYKL8OCEZxPt1eKGMHYr9vp6aP37OLyIXG5ko9P3VeVCsJFyPJGHo/VyLYrP1Bo3XqngtCjRcF7J4IvW7xRN4W4wv4mrbKjYHbhOx3jeO5XhaseJzs2xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550029; c=relaxed/simple;
	bh=kkIzpH18wDHfYouguHhG1jnDHVScQ73RnQm28C2mofo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RELdMQ53oe9p2RxJxEF7uqdx/Y5mTiYU9wpqIKngXSyvtjizf5fVghNHw/yO9BsV/MuHMs7y35oPEEA0j+vFvsRVVdS10K5pYcTmXNFYTvPWfUuZId2vfDotCPeQxFYoAyXq3fIbArxPREGQ6h4WtD+IGqdbW4bqxZ1O0aGbFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eM40Jqqp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51031ae95a1so2372594e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706550025; x=1707154825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMTUvx/6SM2X/X8eIaLRq0dCrVO/7O0bBhRFSLcgZrI=;
        b=eM40Jqqpth7AaTOlekds2v29GqXn+THHGLemssEnUNZ7n/kecprb+HO1ISZXwNAoMT
         LIC1NLbKTqCevbSlaQC1PuK2vnXQR3XEYEJ8lAWisQe9kQfjCqfOrlLNVXwzyXlVI5fH
         xytD2ZtnT9JWihwd2j/uXzQq/woLe+Mq0/EzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550025; x=1707154825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMTUvx/6SM2X/X8eIaLRq0dCrVO/7O0bBhRFSLcgZrI=;
        b=mL+Sa0yhWN/tTN5T/YfwOTgLPvQRqk5RpH6vsI1FqoMtWn8mJVhdllMOffpRsw5mua
         NAt7begNnfBHECbZ2sHukX2Sozmrpxq4MDbydeCofMO9I6avzfCUdTciD3MaMNXmvpNK
         VvE77LS+ft/oKfJgleVF0M43Ar60DgtoYZ2f338mO/qlvdwYVgH0I+gpWP7oF+zbwDi4
         qJbMou4D1UJwwte50WH7ESujp9pfVP2NaifiT46mM5uYVMZHUr5n7ELw08aSs0taBVvY
         RjKI2BFPAowL3cGYk71XwOp1HO516iVxTN/Aw3mQbLgBgDjT3AjtoYdlJpb+bD9r5RTH
         0C1A==
X-Gm-Message-State: AOJu0YyNM166TxteiP8M+OZnz5S4D76DzfaNYJB91Pruw7fow+J14gG7
	Q3ph9czTVh7s71ia1Qiso7zF+FcpSFkBwa5hIz4arT5t1MOpcd9tXmng3RynwDKNyy0s+qfuYbr
	ZFAMOEA==
X-Google-Smtp-Source: AGHT+IGCny5/qcrpiljQaqNKZb7/BGi4zPlHKFxtzbCQ4kWYi3jp4E5OFDCdNVzyoZ0WQIGRUwbEsw==
X-Received: by 2002:a05:6512:6d0:b0:511:17d2:8bc0 with SMTP id u16-20020a05651206d000b0051117d28bc0mr263662lff.41.1706550025550;
        Mon, 29 Jan 2024 09:40:25 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b6-20020ac25626000000b005110e785a14sm497832lff.64.2024.01.29.09.40.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:40:24 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so27251541fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:40:24 -0800 (PST)
X-Received: by 2002:a2e:bc83:0:b0:2cf:48c9:1554 with SMTP id
 h3-20020a2ebc83000000b002cf48c91554mr5355393ljf.0.1706550024205; Mon, 29 Jan
 2024 09:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home>
In-Reply-To: <20240129120125.605e97af@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 09:40:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
Message-ID: <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 09:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Thanks for the analysis. I have a patch that removes the dropping of the
> mutex over the create_dir/file() calls, and lockdep hasn't complained about
> it.
>
> I was going to add that to my queue for the next merge window along with
> other clean ups but this looks like it actually fixes a real bug. I'll move
> that over to my urgent queue and start testing it.

Note that it is *not* enough to just keep the mutex.

All the *users* need to get the mutex too.

Otherwise you have this:

CPU1:

   create_dir_dentry():
      mutex locked the whole time..
        dentry = create_dir(ei, parent);
           does d_instantiate(dentry, inode);
        eventfs_post_create_dir(ei);
           dentry->d_fsdata = ei;
        mutex dropped;

but CPU2 can still come in, see the dentry immediately after the
"d_instantiate()", and do an "open()" or "stat()" on the dentry (which
will *not* cause a 'lookup()', since it's in the dentry cache), and
that will then cause either

 ->permission() -> eventfs_permission() -> set_top_events_ownership()

or

 ->get_attr() -> eventfs_get_attr() -> set_top_events_ownership()

and both of those will now do the dentry->inode->ei lookup. And
neither of them takes the mutex.

So then it doesn't even matter that you didn't drop the mutex in the
middle, because the users simply won't be serializing with it anyway.

So you'd have to make set_top_events_ownership() take the mutex around
it all too.

In fact, pretty much *any* use of "ti->private" needs the mutex.

Which is obviously a bit painful.

Honestly, I think the right model is to just make sure that the inode
is fully initialized when you do 'd_instantiate()'

The patch looks obvious, and I think this actually fixes *another*
bug, namely that the old

        ti = get_tracefs(inode);
        ti->flags |= TRACEFS_EVENT_INODE;

was buggy, because 'ti->flags' was uninitialized before.

eventfs_create_events_dir() seems to have the same bug with ti->flags,
btw, but got the ti->private initialization right.

Funnily enough, create_file() got this right. I don't even understand
why create_dir() did what it did.

IOW, I think the right fix is really just this:

  --- a/fs/tracefs/event_inode.c
  +++ b/fs/tracefs/event_inode.c
  @@ -328,7 +328,8 @@
        inode->i_ino = EVENTFS_FILE_INODE_INO;

        ti = get_tracefs(inode);
  -     ti->flags |= TRACEFS_EVENT_INODE;
  +     ti->flags = TRACEFS_EVENT_INODE;
  +     ti->private = ei;
        d_instantiate(dentry, inode);
        fsnotify_create(dentry->d_parent->d_inode, dentry);
        return eventfs_end_creating(dentry);
  @@ -513,7 +514,6 @@
   static void eventfs_post_create_dir(struct eventfs_inode *ei)
   {
        struct eventfs_inode *ei_child;
  -     struct tracefs_inode *ti;

        lockdep_assert_held(&eventfs_mutex);

  @@ -523,9 +523,6 @@
                                 srcu_read_lock_held(&eventfs_srcu)) {
                ei_child->d_parent = ei->dentry;
        }
  -
  -     ti = get_tracefs(ei->dentry->d_inode);
  -     ti->private = ei;
   }

   /**
  @@ -943,7 +940,7 @@
        INIT_LIST_HEAD(&ei->list);

        ti = get_tracefs(inode);
  -     ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
  +     ti->flags = TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
        ti->private = ei;

        inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;

which fixes the initialization errors with the 'ti' fields.

Now, I do agree that your locking is strange, and that should be fixed
*too*, but I think the above is the "right" fix for this particular
issue.

                Linus

