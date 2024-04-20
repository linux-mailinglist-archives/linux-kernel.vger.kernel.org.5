Return-Path: <linux-kernel+bounces-152340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB898ABC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832F71F2137C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB83B299;
	Sat, 20 Apr 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P2ezNuv1"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AC2032C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713636190; cv=none; b=e4O14PackoXEtFBpMjNnbtC55cK1KbjhOathaaa4N9YOINnwI7X+p7/yXo9xeiwz8WARpBywpT6ht/S6g1FoEeyTlR2/YCal+GM4/x2sz6ObFpMYL/xw+ooRntys6mAEE2vu4lXUAfdnDJBDTNOXFx0n+xr+X/SsxzhiIxc1g7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713636190; c=relaxed/simple;
	bh=XD8kIuycNDgPcM0zNdB13KVRClY5a3l1yHaX8uhAPqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1iR4YcV6F5u0LuIZba0QCXL6Gd7jg90FNTKBD98RiebiL4BawazSXjgs0GKs79C7imnPnenbMjsMJgQrDQRGC/RbsSTBgpFELnFwuN+Np8kqxuFXY96n93DXcCyFFammahVcAEvJ0iXT1w46hoq/jUb7sKhZp/nPVtXirRe85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P2ezNuv1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a55996acbb0so94937766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713636186; x=1714240986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sqXoO3+h8rGnOZ9lr24FquhSup/PaoI+NzZzYVQGgdM=;
        b=P2ezNuv1z2gsBck//Cj3gPi+oyxMQHRKkHNoqx2wiIeuOflkn+k5qlVEXkAUQn7QeV
         UDst2+TFQBIQnpwDDKu51+3ogGs5/CWOOc8VkrYpBuGnVlgnVtGJNgcsaajc8A38hvoi
         A0mWkQqpG7/eJ4U779PDMQhKxpAuIY0aJIKA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713636186; x=1714240986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqXoO3+h8rGnOZ9lr24FquhSup/PaoI+NzZzYVQGgdM=;
        b=RbjLHdh9kkDG0EHfAs1Q9TxNPNL1E72fpZIh3b03EHnZpjlI9yXsVvRQC+3e6T05Pj
         8wUsystMZYyJ71MIDUZ5vNm+EyG7BdYT1I34lu+ZLKjPOsyKUudY/2CqFVgs/G2ZvlbD
         0VBowKDSyT0TbIblpOI4k5mn6DsJVPNJ+UMn9esJc8opZz6nX3pQ/StlE3RAnqiuea0I
         pBYwwrMbgFYyQ1mBZqwXuo8hGFNWjns/PShh1CwUVxoxBAwHmgKrMG1PpQEnpVbeQRDe
         Mg4eoUJ6qaN1lmzxAVo2H7yy5j+/UekGJt6hf6hZO18og5WX+5TyvJkm/BIM31ontfNq
         LYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx9gnUUSrkSj9atj5XG2wqYUkLGdhKhGyXH4GT7rRTUAdrnVq9ZdRvjQlKE2MhNaEqyiNDJhU80finjMY0DA/v77/3JUDEvAZ/SGQt
X-Gm-Message-State: AOJu0Yz2HIrKXxdGZByfzjwkcf9NA0oyR6ZEyjx8iCwKGynxT6hSvUph
	eEenrBxUnWk6NZBoEM1GsQRxMX0zt3dj13TtAkd620iGe1YF1ftLPi6THfk1piEauK6kGXakocR
	Q7Qo=
X-Google-Smtp-Source: AGHT+IHQfZSD8OBKkno+6sZ9lyeCcouEQQUeBAooE50ZoUz1Z2ic9783SG72dCOKPTTadrL0u4L6fw==
X-Received: by 2002:a17:906:c214:b0:a52:4edf:cc3 with SMTP id d20-20020a170906c21400b00a524edf0cc3mr7895954ejz.11.1713636186521;
        Sat, 20 Apr 2024 11:03:06 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906058d00b00a522d34fee8sm3632233ejn.114.2024.04.20.11.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 11:03:05 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so7223693a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVer4Z5TQPrwsv8/yCqlUQw0putTdKJ6IBHFHapFmvsqDthuqYLt6TrhAuKKqiOYBlRVt+CBmGfYlPZXKjGmccqDycWJ6GU1jpn579
X-Received: by 2002:a17:906:5d5:b0:a52:4bde:4999 with SMTP id
 t21-20020a17090605d500b00a524bde4999mr4978012ejt.31.1713636184639; Sat, 20
 Apr 2024 11:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp> <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Apr 2024 11:02:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
Message-ID: <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 10:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Alternatively, we could go the opposite way, and have some flag in the
> line discipline that says "I can be a console", and just check that in
> tty_set_ldisc() for the console.

Actually, I take that back. It's not /dev/console that is the problem,
that just happened to be the one oops I looked at.

Most other normal tty devices just expect ->write() to be called in
normal process context, so if we do a line discipline flag, it would
have to be something like "I'm ok with being called with interrupts
disabled", and then the n_gsm ->open function would just check that.

So it would end up being just another form of that

  +     if (tty->ops->set_serial == NULL)
  +             return -EINVAL;

check - but maybe more explicit and prettier.

Because a real serial driver might not be ok with it either, if it
uses a semaphore or something.

Whatever. I think the 'set_serial' test would at least be an improvement.

            Linus

