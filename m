Return-Path: <linux-kernel+bounces-146680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2A28A693C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9D1F21F18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934212838C;
	Tue, 16 Apr 2024 10:59:28 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E9127E28;
	Tue, 16 Apr 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265167; cv=none; b=S+NzcXcUHyO/Y7L7+0/GG4SSK6iy4fTtM+7M8p0SqhG0L5oidZoWEnxnG3AycYaw25LqzLR/nSOfRazYHeE9v2BvmldU5RLZnhERQTo6HQaYSsK5NChtGg28kuxeR8h/Fah8jLG5VeIlioLGlKslqjnAqoklyci4Ywhnv/8BwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265167; c=relaxed/simple;
	bh=PvS255wjURVZ/MYT7S5AJlPvHZNf3jCYChhFYFFkICY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coyKKUchq0Pz6o7R/un3piDBtFz6jWyk3iiIA0Z9V5RIeWGIUu6XrorV0D9+8GtGdYj6gMvqWg5saJ90F+rWqV4AZyzJvVE8156gMQi8kkIv2D0XB5YZWBTKRe1yVvD/iibQB3UtWPz2/J14bx/u6jgvkaaNFa/ThZrgOjJoteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-570097653faso2765159a12.0;
        Tue, 16 Apr 2024 03:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265164; x=1713869964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3Vqwew7df7Q0cpS04mc45fTchaqONsLx84vZpEBaL8=;
        b=NnYYESb4V7w73YWncl/oHdFYY7b0gWAgZq9Obvc6/e6N2ISp6XRiSsIPoLldYuNiwG
         y3JuClkIFE/48EH+OEODIMPlKK+959KnC8QV3p6tKRS046xF+b5Ybv9W//YU8Rx+YD5O
         0Fjqkrz9I4TBWuwtKDf8Q+b4BgHGvHrKdY32wWWp2Gk9taUJcb9Y1PkEmd0JIPtHBP/L
         1x3Gy06Scv/a/ufq+YOI/Euw3vTe10GlC48m4VJi4AKkYc3I4mbgDV9ppHbGyZ0bnuub
         FVIq2HmVoqN2y5cvuPU7U8yuo+8AFesiAh6dEZ/8nE1dP3nUwiIKpilQTwuJRsmrwfoe
         TLlg==
X-Forwarded-Encrypted: i=1; AJvYcCUaP7QvAY/FAx8vprvNUy6O48e0q0rXBGluQe0eJDKUVX1DGY1o0qpZJ+cHtM3A9zNZPAfwSFV7aIeEeC7Ga1/3uApEWjHULEez5l+aeFzQ/XLXP4r1kE9UOOJo9fjjSxfX2DjWXyS0vneL
X-Gm-Message-State: AOJu0YzscYLqIF/Lm08Rm+4eJMMPip30pTv2wXw+hyNoqalZ+MoOsGri
	KzY6JvbJ0FTuWxaQ9b8aihZwM0BnQvxHg0+x8Igf8MpMCPC8g4ZM
X-Google-Smtp-Source: AGHT+IHPld76jDc9Vh4nUIz61P7Z4nHjbk9sWvUDRvV8gctuxqMQSurmksm0BmVSvI8cQjB3sTfnmA==
X-Received: by 2002:a17:906:c309:b0:a52:4246:92fe with SMTP id s9-20020a170906c30900b00a52424692femr8207152ejz.48.1713265164091;
        Tue, 16 Apr 2024 03:59:24 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id em3-20020a170907288300b00a5180d5b31asm6671162ejc.32.2024.04.16.03.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 03:59:23 -0700 (PDT)
Message-ID: <69b4cd22-3a02-4d5c-a110-152b8ba8200b@kernel.org>
Date: Tue, 16 Apr 2024 12:59:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tty: n_gsm: race condition in gsmld_ioctl
To: Yewon Choi <woni9911@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 "D. Starke" <daniel.starke@siemens.com>
Cc: "Dae R. Jeong" <threeearcat@gmail.com>,
 syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com
References: <Zh5Zj35zeobGGzKj@libra05>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <Zh5Zj35zeobGGzKj@libra05>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello & thanks.

To: Daniel

On 16. 04. 24, 12:57, Yewon Choi wrote:
> Hello,
> 
> memory leak in gsmld_ioctl was reported by syzbot, and this issue seems to be
> raised from race condition involving gsm->dlci[addr].
> 
> https://syzkaller.appspot.com/bug?extid=6e3e8f30f269f5028e5d
> 
> When dlci object is checked and initialized in gsmld_ioctl(), it may be
> assigned multiple times because there is no lock which guards entering
> the critical section in gsm_dlci_alloc() from multiple threads.
> 
> For example, when multiple ioctl() are called concurrently, the following
> scenario is possible:
> 
> Thread 0                                Thread 1
> ioctl(GSMIOC_SETCONF_DLCI)              ioctl(GSMIOC_GETCONF_DLCI)
> 
> gsmld_ioctl():                          gsmld_ioctl():
>    dlci = gsm->dlci[addr];
>                                            dlci = gsm->dlci[addr];
>    if (!dlci) {
>      gsm_dlci_alloc(gsm, addr):
>        ...
>        gsm->dlci[addr] = dlci;
>                                            if (!dlci) {
>                                              gsm_dlci_alloc(gsm, addr):
>                                                ...
>                                                // overwritten & memory leak
>                                                gsm->dlci[addr] = dlci;
> 
> 
> We think either (1) gsm_dlci_alloc() should hold a lock(mutex) and do
> internal check about whether gsm->dlci[addr] is NUll or not, OR
> (2) all callers of gsm_dlci_alloc() should hold gsm->mutex and check
> whether gsm->dlci[addr] is NUll or not (like gsmtty_install()).
> 
> Could you check this? If it makes sense, we will write a patch following
> one of the suggestions.
> 
> Best Regards,
> Yewon Choi

-- 
js


