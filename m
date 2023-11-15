Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1F7EC81F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjKOQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjKOQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:05:11 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E4181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:05:07 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d0f945893so9123826d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700064306; x=1700669106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MejHG9v78thYt1KCbL5Bhup5VOWpNmj9HgzD1QZtMTA=;
        b=AeBXp3FjmYcu6PwTQOMYiY6hY8V9m64eef4+yd7Rxcifr4LlNJezuuFpQ6wzh0RRVU
         5F0kcaICBeyizPSoqFXOm7YVQ9ncSQ8shEeT2gflMsnNwjgD13OdLogs16Lt+ZJ5MDHV
         TylzYiqzc2G2TZ7UW16OxKdxICpu9dyDFr4VnAFaDlr3OKo3fJDWDSJ7yyA2dh3JgTn1
         ynpRgHQ2eds3c1A7uNohCtierwscpGZZGcy+OVF+APHbzCxCIlRVQVrJsBGfJsdSyL9Y
         4w5TwJFVgU0gNjKnMNF8KAX9ZgvHrI4V/7NCBaZQWOXei0iZApimMfZx6m/9OUuOxup4
         UmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064306; x=1700669106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MejHG9v78thYt1KCbL5Bhup5VOWpNmj9HgzD1QZtMTA=;
        b=VwVot5m7i2nex41l5L/zLMp9DFnt6FWygz+mnuXUqKwomzybiHTAztNR+dPF+emGm5
         7Wn/v5aGVXizMvSzbjhCifrMh7KezmbcD2zsUnmGPSWrFAvMpfQet11Xfg9bB/Wa5C2+
         02BBDV03xagZGHihmHA8sfnXnGRHWmD60sYbnh7rlZH5fd1aI5vUz57g1+2jmTqxMpTk
         WDUJaEtVMzffKH7qurjHSUUk32Fbg2uX/eRyiD4gij4kGUFwpg3P0ZLbxBU5PrHjLDHR
         chog/AWLD8G3m+upHNlMPcyxPaxsW8BVeMHORHzSyRMNAQ1N+wEODKNRt65rvtb6j5/s
         0Lvg==
X-Gm-Message-State: AOJu0Yw1/nBc6n+x240wSvJApzTP4V+6xmgxUMFbNOXe7a6sIKlGGEY/
        CoPd/GmxIiPEBV2xoojuHeBnVg==
X-Google-Smtp-Source: AGHT+IEcj6XcTZ0mNvYbPmKaVsfiFpIwuHA7OmpjgBlO36wsG12GpSde51/jSBEJuULlMiocskZovg==
X-Received: by 2002:a05:6214:1706:b0:66d:6a92:16c2 with SMTP id db6-20020a056214170600b0066d6a9216c2mr10015972qvb.8.1700064306362;
        Wed, 15 Nov 2023 08:05:06 -0800 (PST)
Received: from x1 ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id k9-20020a05621414e900b00671ab3da5d0sm617138qvw.105.2023.11.15.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:05:06 -0800 (PST)
Date:   Wed, 15 Nov 2023 11:05:04 -0500
From:   Drew Fustini <dfustini@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/7] RISC-V: Add MMC support for TH1520 boards
Message-ID: <ZVTsMIHc50hkQ2fe@x1>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <CAPDyKFooGiv6fj+X9c4KXaBjvsTTRaHSrxinQYirTWXmX1Ht5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFooGiv6fj+X9c4KXaBjvsTTRaHSrxinQYirTWXmX1Ht5Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:51:30PM +0100, Ulf Hansson wrote:
> On Tue, 14 Nov 2023 at 22:08, Drew Fustini <dfustini@baylibre.com> wrote:
> >
> > This series adds support for the MMC controller in the T-Head TH1520
> > SoC, and it enables the eMMC and microSD slot on both the BeagleV
> > Ahead and the Sipeed LicheePi 4A.
> >
> > I tested on top of v6.6 with riscv defconfig. I was able to boot the
> > Ahead [1] and LPi4a [2] from eMMC. This patch series also exists as a
> > git branch [3].
> >
> > Note: I have only tested eMMC and microSD. I have not yet configured
> > or tested the mmc controller used for SDIO WiFi yet.
> >
> > References:
> > [1] https://gist.github.com/pdp7/881342620ec1509685f23a387e2fc8d7
> > [2] https://gist.github.com/pdp7/97017ad88d83fccac18eba69bff817b7
> > [3] https://github.com/pdp7/linux/tree/b4/th1520-mmc
> >
> > Changes in PATCH v6:
> > - set the mmc nodes to disabled in the th1520.dtsi
> 
> Patch 1 -> 3 , applied for next, thanks!
> 
> Kind regards
> Uffe

Thank you!

Drew
