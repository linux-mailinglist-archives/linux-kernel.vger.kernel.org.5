Return-Path: <linux-kernel+bounces-165699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A708A8B8FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A72B212BD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E401607B3;
	Wed,  1 May 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ibfx7Qwb"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66037E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589809; cv=none; b=m/l1oSLGz+tKc0mdhtFvLXTotETb7EIoIivq+fxUgNruxif6vdNq6piAnqMwdFn/+JvvWvrn44cJNiPsO5l9SzOivu8i2BRMqcr0DVAsQeIqcodAGOaVYfszPulTJ+fSRIdWPUaZV3xon41NYuRkjAwe02l6jf1nzGokYBH/fOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589809; c=relaxed/simple;
	bh=Br+EzpgZN9LCgNuA9kr+jaYQNyybyllA+1Va0XfCsXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa9CItvnwpLdae49OnIB2UN1Pwxk0XKF3pQhsR5HyAI6d93jE1MYmmjElyI1aLo1VKT1A+diF2C8uCokX77571yH16awkIspKZFizO2iWsNtg5T7zG0fW5nfxap9dnCDHXi767opB/dr7TIv12QPiEYEnd9+wZg2F+hrb+I1wKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ibfx7Qwb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51967f75763so8297529e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714589806; x=1715194606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WAutz3PmkVltGwcJ2bneQMswKlTLtzTW8x9sexNITE=;
        b=Ibfx7QwbksrZfhf12o7Z2YRW6iOVBLN9dViDwF25xnKlPcIb16PF4PAxE0FuU4QTpy
         4pH0heEZT8/Axl2UwsYstLv8jTBLz5ZaVPJfrAgg6EY/DdTvGoVLgR/CNtGgxhA2v3Hm
         HtrodaUNCm350c+Ns6J4LUG+4XMfjDJChwNFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714589806; x=1715194606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WAutz3PmkVltGwcJ2bneQMswKlTLtzTW8x9sexNITE=;
        b=Qz9SANPBARJcbjc+EPk9PgZrudyIS5Ak9t0A756oheIy/1BX5jbxVLeBog2ZEPfe3/
         647N3IUKDEixNjMiA942VVXs6rEhQSpJB10VkgKgIn/nsRsthL4zsBSYVXsmJDz3B4iL
         yQEQjcPs7fOvrFPpwxc22ZD4iLunR9dAxQlKMUodKWi2megTnf77OJgdssE/Q0aiLtLN
         fz3GXCsPLJIaftins4HJxJzt4WfN/Q8gsKGhBt6taadhP7iJ2bPITnW4fiLh05+U878D
         HPp/eE0igMqTSAF3PKXa/oMqiRnD2nlHgGk+j1h4FHuJoNgKnP9MOnvGorog8nW93yzw
         xQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3Z9M3B5clj73MVm+I6jTRm7WpuBnyDuhvvtzn9zmYMXwR5IhFMP1AUkDgRdpGCKaIkIKkUazj5XJz2vroscsI8CEJsr9iiK1h9pGT
X-Gm-Message-State: AOJu0Yy9DfwvqF6tBcznGmI/cgXY/wbcLs78HXe+BW1jNeVldwoowDP+
	+YbM3yBIl/zi424FS4ss7DbvmADPrEP8aS3UfDKkOcc8pxXRBOnHDkUZ1ngpkenWxJCu6QgV4Dd
	8Pj0IEQ==
X-Google-Smtp-Source: AGHT+IHt1F9Oe/PAEVddcQbqMO9jteKHw8/R5HN8zXRwetCC1w+P0domsruSAA6Z99Jdee0Dt9foHg==
X-Received: by 2002:a19:5f43:0:b0:518:dae6:d0ec with SMTP id a3-20020a195f43000000b00518dae6d0ecmr2120341lfj.4.1714589804271;
        Wed, 01 May 2024 11:56:44 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e9-20020a196909000000b00519331d74c9sm5035194lfc.42.2024.05.01.11.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 11:56:43 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d4d80d00so9047011e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 11:56:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNM6TwoZdrH3WQLNY4PmJRwPRX/FC8uPenjVL8hvgQuvgOLRR5G/t8EKqWkVlVKTkIeQJT7ZxaWaraOHnyETleRmwq6au58cZZDGGV
X-Received: by 2002:a19:ae19:0:b0:51b:6ed6:af3f with SMTP id
 f25-20020a19ae19000000b0051b6ed6af3fmr2150643lfc.16.1714589803076; Wed, 01
 May 2024 11:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh> <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com> <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
In-Reply-To: <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 May 2024 11:56:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
Message-ID: <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: paulmck@kernel.org
Cc: Marco Elver <elver@google.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 11:46, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> In short, I for one do greatly value KCSAN's help.  Along with that of
> a great many other tools, none of which are perfect, but all of which
> are helpful.

It's not that I don't value what KCSAN does, but I really think this
is a KCSAN issue.

I absolutely *detest* these crazy "randomly add data race annotations".

Could we instead annotate particular structure fields? I don't want to
mark things actually "volatile", because that then causes the compiler
to generate absolutely horrendous code. But some KCSAN equivalent of
"this field has data races, and we don't care" kind of annotation
would be lovely..

                 Linus

