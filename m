Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A577DB1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjJ3ACj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ3ACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:02:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006418A57
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:20:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507adc3381cso5582679e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698621608; x=1699226408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKg6JBu0qEn61a+ycnEPSwXxhDr86sJsIrWNpil9hP0=;
        b=BKLw1KuCXDMVdZiAVFD3Xvn5LqMuFgh2pha4JAU/8WVS7Qdo9YeJBWLeIGlKAP3o4u
         mVMGrifPyu5eZUCeRfhRP8pdBSlhkINo4tc1Z1YTlIFo556jDaSV64PjbiyiuG911V2n
         MzJrKR4ufjhxyzuzht2W6l777QHG2+SZa1EGhnWmET8axrhY2+KJhxzNEuAogpA/Kpd+
         JAwlFm+GxrmyR4o+LAQpOYZXFv3NvbvswuRKNevCWhM4iuxK7dhrJpQKxyqGC49h5xnL
         9vHmKteZ1Mt+6W/RApbSeTqEWoCQYhntAMMZUkX/z3MZ/kYICTbZxe7KVp+7VQRzKB13
         uOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698621608; x=1699226408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKg6JBu0qEn61a+ycnEPSwXxhDr86sJsIrWNpil9hP0=;
        b=e6HcKYFem1s8aUOcF5RCvscLQzo22dvpjrvSNSW+GznC4TJaN+b5vNzAsoYm37mNCg
         rLYRd5oxwwqSrnJqU34rTNTQ3FzLq71vbYAQIoy6/S4wTUl1+s7AUGdnrafQfpjEpuNH
         5UaxbeR4f9IUw3WofgYdHhnDfPW4VA4dLN2C6eF4Zlb/SFegOpkXyauZbMr5MOArpnn0
         kpsr778s1jsEwwPoiNppu0sjgi3ippVBpBY0ZGecO8SeOgCzzOIyzcx4P3LemaVD4n1w
         QtE7M94a9cofNUyS7aKtFf6RerjJc1kziP5dm/5ShMbprJcjHG2Ntt9Qi5FHb4DxXzYG
         B9LQ==
X-Gm-Message-State: AOJu0YwW+AhVRjbGPLottZS1SeyZPKEa6W1VOIZ0I2iN2AUxYGP31z2G
        nlHU7mk4J3V5RV8sskYq5ITEVXNLGF8k4ohh+qMjNY0=
X-Google-Smtp-Source: AGHT+IEETk1eSYzZJ9IPkegzYsV5gV3OTI1ulG2OB0MVutaz0RWyhCW1WNt9WMm2uOJxEhIz/k4orR13ow9AwCiNlds=
X-Received: by 2002:a19:3812:0:b0:507:96fd:d3ee with SMTP id
 f18-20020a193812000000b0050796fdd3eemr5474633lfa.32.1698621607885; Sun, 29
 Oct 2023 16:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
In-Reply-To: <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 29 Oct 2023 19:19:56 -0400
Message-ID: <CAMzpN2iYWpUXF815yrujB0sM66Pw1gYU7PoYLURsP1tkcZiuSg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 5:42=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Brian Gerst
> > Sent: 26 October 2023 17:01
> >
> > Currently, x86-64 uses an unusual percpu layout, where the percpu secti=
on
> > is linked at absolute address 0.  The reason behind this is that older =
GCC
> > versions placed the stack protector (if enabled) at a fixed offset from=
 the
> > GS segment base.  Since the GS segement is also used for percpu variabl=
es,
> > this forced the current layout.
> >
> > GCC since version 8.1 supports a configurable location for the stack
> > protector value, which allows removal of the restriction on how the per=
cpu
> > section is linked.  This allows the percpu section to be linked
> > normally, like most other architectures.  In turn, this allows removal
> > of code that was needed to support the zero-based percpu section.
>
> I didn't think the minimum gcc version was anything like 8.1.
> I'm using 7.5.0 and I don't think that is the oldest version.

What distribution are you using that still relies on that old of a compiler=
?

Brian Gerst
