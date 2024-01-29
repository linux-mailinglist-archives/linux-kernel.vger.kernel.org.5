Return-Path: <linux-kernel+bounces-42157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77183FD42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440692855FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF360339BC;
	Mon, 29 Jan 2024 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ej0cPmGB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1A3C481
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706502994; cv=none; b=uo0T7vWUzq1sX9SRzhOo5j199jMjw/mnvo9XQ1MvSEQiW+dj4OWS6ESNlIzLbEeI9N3MPa9coPs/6NW+o4G1V3MSHttbZQ54hmSJWntIbJs7OSyp71/LEE34Jr/9LQqcJDdSFZMma5bqaTW1h9pa1arxUDvdTO7hnuQjfHUw1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706502994; c=relaxed/simple;
	bh=Qvclxu84S/Vj00n5XJGicbf+1n9+wvgXNZJSxffCMaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOOwBygJAOBbzj/ec1vAeuICQzz9yhQM87soZvei2u1aOlIrISuaIxxFglGDibZkZdbU3x1JqkFxSxMeejhZ2JGkMG7JaiJpp85jkYKeFg2ABqGx4pd8XFKP9LIUUXAKZqJ3T/U7XQxCel5cQhlbZE/3Jw9vwr0wgw4yodfC40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ej0cPmGB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26f73732c5so236559066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706502990; x=1707107790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNrDOkLUoRhPhAZaq9nU6yW/IkHOgSVhQm/kSJS29jU=;
        b=ej0cPmGBny+KdMuseOrUhYXXVycTUu3+fxdZfL1Z2YgKqqGdUTgu1Z0Rd3E/nYABYZ
         fbBAnusZ3NgXP4YiXRr9iTodT7ygtVFbHqTiuK+gS8Dm443gpN2Ft+znUx0qOVgxc4Hy
         /oIDFQ2POU2NVLBhy1q4VjW9r8x+sOysReZns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706502990; x=1707107790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNrDOkLUoRhPhAZaq9nU6yW/IkHOgSVhQm/kSJS29jU=;
        b=XvmFnNu6YY34/KLbmtDtccUmJ8WdGFiQshP9CqUmf25XnstqkZT3Lx0QZznQPle9Pk
         r+X5hg2cuZ7gy7GNXJqjhNJS+lMBse9iNOPTtLG5kXBnsvkodXVEY59nJbE9tYF3lijY
         KnOnWjWQQUBtarP9J/SOuFoQ48mQLEJ4pgIlK2N/am/mgMGnxUQgJKdvrT1CDyy3ohUP
         5XljBgQlD8vDejOLyRVjhCpej2QMs/KaVhrgwH7Ze7hWpTC08RuW68xI2fhXdxkEakuf
         zKSv6N1YKjriB7sJlBoioIkymeuEegSXROIa8co4lVkMTAicdk/HD8S07YUCmGFl43Yd
         4nnA==
X-Gm-Message-State: AOJu0Yx6R0CdeD1KVS6SPd6MzAYxfp8966zXOLb6CATzVgOcC8sng/Jp
	zZQ6MEbuEWocquTFeCkwmirkT6obBDJr/7t0cKx57uTvz8/VjQS81bus62pBlBx8xZCeA34FMbS
	MEtKMvA==
X-Google-Smtp-Source: AGHT+IE9wihg2DUE9wMe1uBewTis98Pn0NhL63GVfRChMaBS7RR5F/95UGs1ENL/FJ9oET3ANvjVfA==
X-Received: by 2002:a17:906:560e:b0:a35:3ce3:c48c with SMTP id f14-20020a170906560e00b00a353ce3c48cmr3281085ejq.23.1706502990139;
        Sun, 28 Jan 2024 20:36:30 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id vu5-20020a170907a64500b00a313ba55c35sm3521262ejc.98.2024.01.28.20.36.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 20:36:29 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso1963484a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:36:29 -0800 (PST)
X-Received: by 2002:a05:6402:2709:b0:55a:813f:8802 with SMTP id
 y9-20020a056402270900b0055a813f8802mr3784740edd.25.1706502988865; Sun, 28 Jan
 2024 20:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com>
In-Reply-To: <202401291043.e62e89dc-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 20:36:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
Message-ID: <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: kernel test robot <oliver.sang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 18:59, kernel test robot <oliver.sang@intel.com> wrote:
>
>   21:   48 8b 47 f8             mov    -0x8(%rdi),%rax
>   25:   48 85 c0                test   %rax,%rax
>   28:   74 11                   je     0x3b
>   2a:*  f6 40 78 02             testb  $0x2,0x78(%rax)          <-- trapping instruction

So this is

        struct tracefs_inode *ti = get_tracefs(inode);
        struct eventfs_inode *ei = ti->private;

        if (!ei || !ei->is_events || ..

in set_top_events_ownership(), and it's that 'ei->is_events' test that oopses.

The 'inode' is the incoming argument (in %rdi), and you don't see code
generation for the "get_tracefs(inode)" because it's just an offset
off the inode.

So the "ti->private" read is that read off "-8(%rdi)", because

  struct tracefs_inode {
        unsigned long           flags;
        void                    *private;
        struct inode            vfs_inode;
  };

so 'private' is 8 bytes below the 'struct inode' pointer.

So 'ei' isn't NULL, but it's a bad pointer, and 'ei->is_events' is
that "testb  $0x2,0x78(%rax)" and it oopses as a result.

I don't think this is directly related to that commit 852e46e239ee
("eventfs: Do not create dentries nor inodes in iterate_shared") that
the kernel test robot talks about.

It looks like some inode creation never filled in the ->private field
at all, and it's just garbage.

I note that we have code like this:

 create_dir_dentry():
        ...
        mutex_unlock(&eventfs_mutex);

        dentry = create_dir(ei, parent);

        mutex_lock(&eventfs_mutex);
        ...
        if (!ei->dentry && !ei->is_freed) {
                ei->dentry = dentry;
                eventfs_post_create_dir(ei);
                dentry->d_fsdata = ei;
        } else {

and that eventfs_post_create_dir() seems to be where it fills in that
->private pointer:

        ti = get_tracefs(ei->dentry->d_inode);
        ti->private = ei;

but notice how create_dir() has done that

        d_instantiate(dentry, inode);

which exposes the inode to lookup - long before it's actually then filled in.

IOW, what I think is going on is a very basic race, where
create_dir_dentry() will allocate the inode and attach it to the
dentry long before the inode has been fully initialized.

So if somebody comes in *immediately* after that, and does a 'stat()'
on that name that now is exposed, it will see an inode that has not
yet made it to that eventfs_post_create_dir() phase, and that in turn
explains why

        struct eventfs_inode *ei = ti->private;

just reads random garbage values.

So if I'm right (big "if" - it looks likely, but who knows) this bug
is entirely unrelated to any dentry caching or any reference counting.

It just needs just the right timing, where one CPU happens to do a
'stat()' just as another one creates the directory.

It's not a big window, so you do need some timing "luck".

End result: the d_instantiate() needs to be done *after* the inode has
been fully filled in.

Alternatively, you could

 (a) not drop the eventfs_mutex around the create_dir() call

 (b) take the eventfs_mutex around all of set_top_events_ownership()

and just fix it by having the lock protect the lack of ordering.

                 Linus

