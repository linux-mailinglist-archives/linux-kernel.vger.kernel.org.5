Return-Path: <linux-kernel+bounces-152342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47D8ABCA4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2F01C20B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE93BB35;
	Sat, 20 Apr 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X27rLDYa"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB46339B1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713636372; cv=none; b=P4bEo1/l1mwc5dFqYxO9ikg8mTPa/RTdfZ376vO+Jmx0poLxs7/96hHztwG8mAx2+JUDsloJLTTYH9E3OLFisD7joYzzPPM1fzRVy0C7zMDuMpHHDu5iDSh1Uu0n50KYDiOCPQAFOo5Sp7mIN2UPfnJ2HUfZtCmd79F6/gfEP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713636372; c=relaxed/simple;
	bh=BlUmaU5cCzdfHYaIDu1dOY26l+Y9HZW2UwF8EAjxQ3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjI2vgZrHbOi8iBAm6gdOGfC9hG3BdffBNj74zwB4UdKIIVm13gez5kS2yHv5D/FAIGoBnc6h2dOv65SR0picS4vgsgvtKJO4htbAY2VdoB8+PWwM0+nec4lBrDkJDkVEUoG6R6IFLyD7Ihs1Sw3p0MIoLWm6w84Okb190WUCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X27rLDYa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db101c11beso35708101fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713636368; x=1714241168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9q4d+5HJT9JoCSnjfVAkQZ3NFNLdknjcESdIWM7gPdU=;
        b=X27rLDYa9MkI5kfd5giKAReH+VMASLyHFxQ+g+BCPjTa1TnyrrR3AajEdlsbkDbHRB
         YJr85wifJsSZuVIqQtbtCWI4ei+0rISVT4dqNWjp/nLIwZ0r0Mv0g1z5jKrfRQghUx08
         OYvFoeWgthSazH/4wWvFpWXifxEeCFZSs1mAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713636368; x=1714241168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q4d+5HJT9JoCSnjfVAkQZ3NFNLdknjcESdIWM7gPdU=;
        b=Gq8liOpQUKuipi9y/dcjAcEROFI98HMD6L1GCqsgGQ7e33pLWgIsovdIwsR2j9y0yi
         0GKfkHPde1nq9GXfAisWifbDuM5+VOrdAy/eGq5k15o7S+2GuOTFWNiramsk4m4dfFlz
         LRp+akbmI/lY6RJBdJ449wuRK+v4yp8Ha//trvkRMO+De5temfs5lm9gr91nu/LGlyoT
         1S/dMYz75alfcaJ+ZloY/h09n7pYGpjud/4jX5PRIWOoJaxoL3fSsgEw/vp2dCq5SG+q
         hqTeDUf15IJyfU4Rx/asqCdXeLM6DXp1lCTC1Yyt24EkFjbV5o4cnMtPT8v7A2cHk6j6
         LReA==
X-Forwarded-Encrypted: i=1; AJvYcCUqMa/+bxUhvibr/QYkY1tWPjYxamo2RLvTUKLEtNVvpAwOrItgtxhbxolnhECfs7yiqCyCeFBHFk7xLygurvtdn8d58Ts4AnOwDRJy
X-Gm-Message-State: AOJu0Yzvy5giyFgsd6meWFLeGk+il36IKJe70aqbBLUeyFBMGf3R4xew
	HtsM4dozlJPFzgBDVfSC9OMPaZaI13bbfay3qAnPpsn+5aWSMwNslxRGAxADPia4QOiFR8xKquD
	331nNqA==
X-Google-Smtp-Source: AGHT+IHE6ZMSCL7X2q98yJwyByoxtuXGsvSepeldjQ9OzdQquzxIJCGmutGfeG20hlw6wpo7xMc0zA==
X-Received: by 2002:a2e:86d3:0:b0:2d4:514b:428 with SMTP id n19-20020a2e86d3000000b002d4514b0428mr3363018ljj.6.1713636368530;
        Sat, 20 Apr 2024 11:06:08 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9614000000b002dba279f81asm958136ljh.59.2024.04.20.11.05.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 11:05:52 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so41476511fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:05:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyIBXGC6AkICU8CKKNwUfrFfTeIi+ldV9M+8+hhX+h32c0NGSitYmEF9toHl0hEUi5KW+nCRu8fBOLFbs9/nyq92BKWLfVbW2B8dGX
X-Received: by 2002:a05:6512:78e:b0:51a:bebb:690c with SMTP id
 x14-20020a056512078e00b0051abebb690cmr2860885lfr.12.1713636351915; Sat, 20
 Apr 2024 11:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com> <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Apr 2024 11:05:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
Message-ID: <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 11:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Most other normal tty devices just expect ->write() to be called in
> normal process context, so if we do a line discipline flag, it would
                                        ^^^^^^^^^^^^^^^^^^^^
> have to be something like "I'm ok with being called with interrupts
> disabled", and then the n_gsm ->open function would just check that.

Not line discipline - it would be a 'struct tty_operations' flag
saying 'my ->write() function is ok with atomic context".

             Linus

