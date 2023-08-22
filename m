Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25D784D33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjHVXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHVXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:14:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28055CE9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:14:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso7584525e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692746062; x=1693350862;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSHMwkSWj+u0BB4H/Eo8pB+iKXhMpxFBtrURAK/KgwY=;
        b=CFQLVEZLykqjzDO7usGcMJuYkJlvatCTEZRBqCa5ZQK+ctOL++F8hjWBQU/QQNbz1x
         ddIRInCUD8C2fG5FUO/vHg+B/KkgFbXq2pbO7k6qHnqQrhMjV5f5cfy0sW+JF5vwePBo
         HNM+NJz7fv46v8rG41AMguHMRE2oMWrER6LZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692746062; x=1693350862;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSHMwkSWj+u0BB4H/Eo8pB+iKXhMpxFBtrURAK/KgwY=;
        b=FTzseubgUqdVacITm5JrK9rvkqRWk5p5SsyFDOPWOOECn1qFkXVZvaUe3ZHDZUg5yE
         3O7EnL6Lp5qbuQvPJd8rB2IHG3Kz8+pt5xQ9xYINcARrtpyw0cHAj6adz2qRIkiSwgC9
         wfLSiFFZN/DLzrZU3yjnOkZ/YfVW9J7oVPrN5O/ihpNpIWgXzq5wbfxkPLReO4hX9f4Z
         IzKtqQ/vLPf2DvBl9EVteAXtfi+Vb4tJxRsRJYfcPB67FO+Et8cHasFoPdWKZ1sLWsIt
         8QgIYNzzTWdvPtt9F98mLwXpWx4wmWJLr+hnIAtA3yLHOyMhu8ehBKtRQraCxw6Rj7/q
         AUOQ==
X-Gm-Message-State: AOJu0Ywb1YwTjCSrDZ3RNBCSwqQjZib7eGlA4Ev4qFy/ZkQMEtS7QEJE
        ualklP3qy3PpSRtwt96QS9uVMYs4VN/OubjbFMBBgQ==
X-Google-Smtp-Source: AGHT+IE9cNxYcnE+sNDcjWkiOsU52/mJjpudLz7kYq/Voq07K6+JEnzA+zqz02s367o6vNiTqYWr4E4Lc//Ttvw4Omw=
X-Received: by 2002:a19:7b12:0:b0:4f6:2b25:194e with SMTP id
 w18-20020a197b12000000b004f62b25194emr6213559lfc.58.1692746062347; Tue, 22
 Aug 2023 16:14:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:14:21 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:14:21 -0700
Message-ID: <CAE-0n53QBBfX77ibE+NdWZa70VVOKkNnhn5BNhBk04XKEFKNJw@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] arm64: idle: Tag the arm64 idle functions as __cpuidle
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-08-22 14:26:57)
> As per the (somewhat recent) comment before the definition of
> `__cpuidle`, the tag is like `noinstr` but also marks a function so it
> can be identified by cpu_in_idle(). Let'a add this.

s/Let'a/Let's/

Maybe also define "this" to be "Let's add these markings to arm64
cpuidle functions".

>
> After doing this then when we dump stack traces of all processors
> using nmi_cpu_backtrace() then instead of getting useless backtraces
> we get things like:

Sorry, this sentence is really hard for me to read. Perhaps:

With this change we get useful backtraces like:

   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98

instead of useless backtraces when dumping all processors using
nmi_cpu_backtrace().

>
>   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98
>
> NOTE: this patch won't make cpu_in_idle() work perfectly for arm64,
> but it doesn't hurt and does catch some cases. Specifically an example
> that wasn't caught in my testing looked like this:

I wonder if it improves locality of cpu idle code as well by moving the
functions to the idle text section so any branch targets are closer.

>
>  gic_cpu_sys_reg_init+0x1f8/0x314
>  gic_cpu_pm_notifier+0x40/0x78
>  raw_notifier_call_chain+0x5c/0x134
>  cpu_pm_notify+0x38/0x64
>  cpu_pm_exit+0x20/0x2c
>  psci_enter_idle_state+0x48/0x70
>  cpuidle_enter_state+0xb8/0x260
>  cpuidle_enter+0x44/0x5c
>  do_idle+0x188/0x30c
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
