Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0E7E5E80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjKHTZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKHTZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:25:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9052111
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:25:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc9b626a96so43635235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699471535; x=1700076335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWUjp1kT4QadWCPtlP2kQwh/Ipvn+sm+hKLdkqyjovw=;
        b=A8QtkpFWV0yoYeO7nkf1L1uajgS2jaLH1xnHmhbrt/jpiXmkFis51gQzCH5BsIO48k
         bKv2nN6ky9U9lGFIZmso0whW8z+pTngEUETkgaLPWosJBgEgaW0bMFslXVYj1boW/Nqd
         XxKge1wj32mHp4A6GLq+U6/Ml1Pe/5Dsn3eU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699471535; x=1700076335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWUjp1kT4QadWCPtlP2kQwh/Ipvn+sm+hKLdkqyjovw=;
        b=PZ1MpIJkSRyqW5n/Q1RlcaqN3rg0r0tidE3g8uCk/+DGzcit2WglqwH4npcvQFcsIC
         mcjPm3GlP71s/wIGri7tvflpWoSXXgxvTHb7n+dXbQUsyhJe9kPLhH1vtYzQWP0ecUtr
         0qM/SZN7Lg0xtxSqs3/Xktzo/MvAyKjbbW6jkLQ2hVGfJIAYZ/3fPd16pU6vgqSm9/dp
         Et9nJyIBscE/OxO4qbvsQdl374K+qRZjnNnU7np0kNkG33R3kg69JF1e0jDQP02pVokZ
         srcoCuXfQ52G9saTMP5uJg7UDByqV/FE3RXP/hLmnsWbbC57Ypj2NuBVmNCRm3iZ9kRd
         aTlg==
X-Gm-Message-State: AOJu0Yw8jeg+Fj9nmuVCwdZ1I2zk/gLAkPn/ywTwPfPRBBnLgaJy9wCy
        16WQEC6ravndplqApdvvAhOlKw==
X-Google-Smtp-Source: AGHT+IFWQvD64GPyRJT6Hb58vipaf+YJS2on70JhtNQdeZqsPwpz2F6tsQ6yRwN8BcF7cB5aQ/N19w==
X-Received: by 2002:a17:902:ecc6:b0:1cc:4072:22c6 with SMTP id a6-20020a170902ecc600b001cc407222c6mr3552930plh.24.1699471535672;
        Wed, 08 Nov 2023 11:25:35 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm2097005plb.9.2023.11.08.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:25:34 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:25:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Kees Cook <kees@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311081123.391A316@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook>
 <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
 <202311071445.53E5D72C@keescook>
 <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
 <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
 <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 01:03:33AM +0100, Mateusz Guzik wrote:
> [...]
> >>@[
> >>    __pv_queued_spin_lock_slowpath+1
> >>    _raw_spin_lock_irq+43
> >>    wait_for_completion+141
> >>    stop_one_cpu+127
> >>    sched_exec+165
> >
> > There's the suspicious sched_exec() I was talking about! :)
> >
> > I think it needs to be moved, and perhaps _later_ instead of earlier?
> > Hmm...
> >
> 
> I'm getting around 3.4k execs/s. However, if I "taskset -c 3
> ./static-doexec 1" the number goes up to about 9.5k and lock
> contention disappears from the profile. So off hand looks like the
> task is walking around the box when it perhaps could be avoided -- it
> is idle apart from running the test. Again this is going to require a
> serious look instead of ad hoc pokes.

Hm, that is pretty interesting. I'll see if I can go find the original
rationale for adding sched_exec() in there...

> Side note I actually read your patch this time around instead of
> skimming through it and assuming it did what I thought.
> 
> do_filp_open is of course very expensive and kmalloc + kfree are slow.
> On top of it deallocating a file object even after a failed open was
> very expensive due to delegation to task_work (recently fixed).
> 
> What I claim should be clear-cut faster is that lookup as in the
> original patch and only messing with file allocation et al if it
> succeeds.

I'm less familiar with the VFS guts here -- I'm open to alternatives! :)

-- 
Kees Cook
