Return-Path: <linux-kernel+bounces-45434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C2D84306F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C28D282260
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711157EF05;
	Tue, 30 Jan 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="doLwZEcF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3267EEF5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655386; cv=none; b=V753tgzfgD6p27Jqc8W9h9GZ/ymu2GI2TLrJxIbhc5nmvAb6R00xFigmLE0+vb6MIcLypqz2zhFA3Zz0OCB8fn7K5TJ6dJXCHhu8CbH5sYGdh46TysGt4TE/KEjXX1+/TbCg7ru/OhhQbEN5N0B4PF99HkbaWwGkCMC2hBNpZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655386; c=relaxed/simple;
	bh=Cj4XOejVbe8op4QcSEepOhz4IYD/CrlYwEM8OfVbQIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB5y2AsFoMKVYSaUVZfY7UfYRHD2jjqB+zOmNWvkhWwjVE8D67KhZj8EJiZCg2FKEDZUdy+JioSs3U7OYrYrXRqQyhkfdn9dIpoO4hcdH9jmwZLwzypAHenvEJw5u/AkeDDvn+9fOKYz1af8HSwV3hwAKZ9u3i5UaNBp6hWz9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=doLwZEcF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so612868766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706655382; x=1707260182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/wk9TZxLvwAGmQGfbb+2jVKtz8EYTBjx8fsmhuikXo=;
        b=doLwZEcFmlPiMVP533kfnt+n7NhM+AHDkdmxPexWi3gYDx3YJ6I7ua8eBTVU16Ryam
         Rj+zJ7J5NN0PRvDxMIMgPZdTfffDj1xTZtlRJF0Trdlium7x8pUlULwhRx2ez5ou9aw2
         HDiYtAIxy29QYYtwiJIYSxI/3PLfz6DSlWDaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655382; x=1707260182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/wk9TZxLvwAGmQGfbb+2jVKtz8EYTBjx8fsmhuikXo=;
        b=tSA1JhPPB6EQS2s/r1RKodNNsbhclouzzmNF5FVqPGma1uWPMiUMXGu0qXxCDWEr3i
         15MXvyHQkzNoDICHT8msYSqDdU9mjx4J/oj3wimSyp3CgzC2YaxOWRCGHytHxFiA19UG
         xnlFVjO7gKqB816GzW2nysNsGd6XCNHNLWd5B0FaBLCpVX7pTAWDUKHKVbNxIqiVQDYV
         tYCOPb5YtixhxEOj9o8kG++VP3sE+67jAuLMwEFp5ql1guyr18HrXZBWJQNed8GhVC25
         gGZiqmfCyii2316dicMq6aRMAzt5tL1/G0UCXTYDZigABp+QSHHmPRE4BX3jGu4isr92
         A8Aw==
X-Gm-Message-State: AOJu0YzXflRXvu7N5Za87wLro8ML5r3/YuF1RN5hdZ9VZ4ldRKG+UEjD
	Hmb8EJe0zSzYc9cJUyAMFYLk9Pyll8DHYIF4ouZtuBZLbWFJ/DV3OB9zjWHSeHOF6GpWFcvx1uc
	xHiEXHQ==
X-Google-Smtp-Source: AGHT+IFqSRfYBWXtxXZlcAlkh5I78Achva9GYGgXAFv7150F5d+CZApLRqgi7i604jVpJV/4NdRBmQ==
X-Received: by 2002:a17:906:2693:b0:a35:6438:a935 with SMTP id t19-20020a170906269300b00a356438a935mr6837546ejc.55.1706655382431;
        Tue, 30 Jan 2024 14:56:22 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id pk27-20020a170906d7bb00b00a35242f5976sm4779395ejb.164.2024.01.30.14.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:56:22 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso3902693a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:56:21 -0800 (PST)
X-Received: by 2002:a05:6402:348c:b0:55e:f37f:7fc5 with SMTP id
 v12-20020a056402348c00b0055ef37f7fc5mr5872728edc.14.1706655381670; Tue, 30
 Jan 2024 14:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
In-Reply-To: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 14:56:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
Message-ID: <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 13:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Btw, you can look at name lengths in tracefs with something stupid like this:
>
>     find . | sed 's:^.*/::' | tr -c '\n' . | sort | uniq -c

Actually, since only directories have these 'ei' fields, that find
should have "-type d", and then the stats change.

Most directory filenames there are indeed longer than 8 bytes (16
bytes seems to be the most common length).

That means that whether it wins or loses in allocation size tends to
be mostly about the kmalloc sizes and the size of that structure.

And it turns out that the real memory savings there would be this patch

  --- a/fs/tracefs/internal.h
  +++ b/fs/tracefs/internal.h
  @@ -55,15 +55,6 @@ struct eventfs_inode {
        unsigned int                    is_events:1;
        unsigned int                    nr_entries:30;
        unsigned int                    ino;
  -     /*
  -      * Union - used for deletion
  -      * @llist:      for calling dput() if needed after RCU
  -      * @rcu:        eventfs_inode to delete in RCU
  -      */
  -     union {
  -             struct llist_node       llist;
  -             struct rcu_head         rcu;
  -     };
        const char name[];
   };

since with all the other cleanups, neither of those fields are actually used.

With that, the base size of 'struct eventfs_inode' actually becomes 96
bytes for me.

And at least on x86-64, the kmalloc sizes are 96 and then 128 bytes.

But that means that

 - with the added name pointer, the eventfs_inode would grow to 104
bytes, and grow to that next allocation size (128)

 - with the embedded name, the size is 96+strlen+1, and will also need
at least a 128 byte allocation, but any name that is shorter than 32
bytes is free

so it ends up being a wash. You're going to allocate 128 bytes
regardless. But the deallocation is simpler.

                  Linus

