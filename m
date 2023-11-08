Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6D7E5A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjKHPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKHPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E11BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699457541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewskCS1rF9gOVBYcI4anbJ8kNzbRSyhUgQwAklJHaeU=;
        b=RQJpVF/ob85eEM4EL65dfgrFK2u3wP/VQw64aScaqj2O1iMcqRoDhF6z2KD5N9ZwLZktXy
        I5hQkKJKc5c5TvGejgZ91iiCBHzz6ldSL1adz61dnnZShyEapSwKd/d+vHoTuXBFSf9167
        xaijO4tzwv8TYi2tujdGvwqbdSpVw1M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Cseoflm2OwCEuCHu_iN-hQ-1; Wed, 08 Nov 2023 10:32:15 -0500
X-MC-Unique: Cseoflm2OwCEuCHu_iN-hQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7789a691086so811181985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 07:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457535; x=1700062335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewskCS1rF9gOVBYcI4anbJ8kNzbRSyhUgQwAklJHaeU=;
        b=hMTwejlZC4mxHwkrt+7+6tzORTDw11ELX5hCW0U+8vD+Gl5Pcja8oQ359l1HooI5M5
         PJ+O2Dmj03CBrDfhu8Aaftn5czyhuWsvYduUpG//N+wXFv4UY9RC/lZ7QEDVnslRg5ex
         9qb9UPXaH0DkitZui/TZe+JzHUjFRRyhbhAwM6z11S7PYs6ccYxCxkO5IkpR9fSmz/xT
         VZm7Fhdn4ErfvfOxSunCGcjLq+A0J01QHdfDjdukK1itDDvDGfR0OLiLG7jFIPHbQuk9
         X0l6u8kadXYb0R5WxMS7p5rq1EZDnKGw/Pl9njjzfKSJ5DjMPe5YeC0fya8PTDxxq8ZV
         nyHA==
X-Gm-Message-State: AOJu0YxrrML3nZ+czHg1LmouXFxFo3Dg3XTSbdXakNijw1Y4M6Pgdyai
        N+vA2nfv0AxlCPdJBZ1ocg0knbatcLeVWffVdjQ0ii4P5BqGFziyNnpAk3jms75DQkIQ2Dueb7g
        QQZf76Q8KqoimFvdBs7V0ncRm
X-Received: by 2002:a05:620a:bce:b0:77a:76c8:24bc with SMTP id s14-20020a05620a0bce00b0077a76c824bcmr2431339qki.45.1699457534994;
        Wed, 08 Nov 2023 07:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+05dp/d4w5qESRwSH9UXiHx3gamIz41M+iD584uZhxsaLrmlTItJlkFaR/98f9dz0F85Fww==
X-Received: by 2002:a05:620a:bce:b0:77a:76c8:24bc with SMTP id s14-20020a05620a0bce00b0077a76c824bcmr2431311qki.45.1699457534699;
        Wed, 08 Nov 2023 07:32:14 -0800 (PST)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f16-20020ae9ea10000000b0076ee973b9a7sm1152477qkg.27.2023.11.08.07.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:32:14 -0800 (PST)
Message-ID: <99645b01-f297-48ed-81f2-b6ce186085d1@redhat.com>
Date:   Wed, 8 Nov 2023 10:32:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Enhancing Boot Speed and Security with Delayed
 Module Signature Verification
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
Content-Language: en-US
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20230914112739.112729-1-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 07:27, Alessandro Carminati (Red Hat) wrote:
> This patch sets up a new feature to the Linux kernel to have the ability,
> while module signature checking is enabled, to delay the moment where
> these signatures are effectively checked. The feature is structure into
> two main key points, the feature can be enabled by a new command line
> kernel argument, while in delay mode, the kernel waits until the
> userspace communicates to start checking signature modules.
> This operation can be done by writing a value in a securityfs file,
> which works the same as /sys/kernel/security/lockdown.
> 
> Patch 1/2: Modules: Introduce boot-time module signature flexibility
> The first patch in this set fundamentally alters the kernel's behavior
> at boot time by implementing a delayed module signature verification
> mechanism. It introduces a new boot-time kernel argument that allows
> users to request this delay. By doing so, we aim to capitalize on the
> cryptographic checks already performed on the kernel and initrd images
> during the secure boot process. As a result, we can significantly
> improve the boot speed without compromising system security.
> 
> Patch 2/2: docs: Update kernel-parameters.txt for signature verification
> enhancement
> The second patch is just to update the kernel parameters list
> documentation.
> 
> Background and Motivation
> In certain contexts, boot speed becomes crucial. This patch follows the
> recognition that security checks can at times be redundant. Therefore,
> it proves valuable to skip those checks that have already been validated.
> 
> In a typical Secure Boot startup with an initrd, the bootloader is
> responsible for verifying artifacts before relinquishing control. In a
> verified initrd image, it is reasonable to assume that its content is
> also secure. Consequently, verifying module signatures may be deemed
> unnecessary.
> This patch introduces a feature to skip signature verification during
> the initrd boot phase.
> 

I think this is fine to do.  There is some risk for users who may use 
this without realizing what they're actually doing and then would end up 
creating a security hole.  But there are far worse ways you can do that 
with access to kernel paramaters.

P.

> Alessandro Carminati (Red Hat) (2):
>    Modules: Introduce boot-time module signature flexibility
>    docs: Update kernel-parameters.txt for signature verification
>      enhancement
> 
>   .../admin-guide/kernel-parameters.txt         |  9 +++
>   include/linux/module.h                        |  4 ++
>   kernel/module/main.c                          | 14 +++--
>   kernel/module/signing.c                       | 56 +++++++++++++++++++
>   4 files changed, 77 insertions(+), 6 deletions(-)
> 

