Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB6784D76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjHVXuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHVXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:50:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761EE47
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:50:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso7712134e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692748203; x=1693353003;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIRpVWVNE+Q6hOPS1O2UFBquGTLRNlUx0pFJvzId0+0=;
        b=BhX6h+6BHRigZyr1u1JtAp7x+mmpR1I23lvosD3zaZNEJXX7pP/KW3EXBris6W1P7e
         vs9/tZZwB+VC8ChAJrIS+1KhMxnHEOU/+o4uVrktRj5hr3lf1evT/b3cjBenAKeA3z8T
         s/D8szJzpHDjXwrT6WCkJx9yhbiS83OaR5MJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692748203; x=1693353003;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIRpVWVNE+Q6hOPS1O2UFBquGTLRNlUx0pFJvzId0+0=;
        b=Ggywhrp1uWbbBV9t9aP3frSPbsRpi+0S4TuZ8fQ6sTZUJNEgYBB38NRFt9skHanvIB
         gPekmoa2GR0AAqE0B+cb1dqb/PjtN+03UI8mNiRn4D09RPJDLX3KO+HAiwWyUWXIjtYy
         286xuoQL6j2BFFAO6ESPAR6nZGsRH2EglOi0q7+15NmeUSgBJfv6iTjIS1kaE/+u/6K3
         QnJZ/DnCXxfmssEDIM8JnXcZ6HGLK0fWKXby/Mprmp5c7hI64+y0/ljsKFFDSg5TtYZn
         vxzKlLfOyLZV132gytVQ70M08teqasOHUw70wxQ+WC0Pf4HfIsiDx4CO0tX83rV3Z9ie
         y9jw==
X-Gm-Message-State: AOJu0YylxBpVu3a/bESttxZ7BL1RKsktX2Gfy3q82BAvOIYAdTZocG/6
        q2iQxAau7wrSUSbwVNszeeqdklDTLEQTMlqBQmZJBA==
X-Google-Smtp-Source: AGHT+IFOXOL7TfudL+WI3zrqXmcjUL0QfEpAn1uhs5Lxh0RVge5wSfxCqipfqw2m9ouwuXu63XSlC+8FIVbY5mT+mRU=
X-Received: by 2002:a05:6512:3613:b0:500:8c19:d8c6 with SMTP id
 f19-20020a056512361300b005008c19d8c6mr2483247lfs.58.1692748203300; Tue, 22
 Aug 2023 16:50:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:50:02 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:50:02 -0700
Message-ID: <CAE-0n537USZdo+3902RzSvWYor2qx7bxoYckKs1jLeXFcg-NNA@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] arm64: kgdb: Implement kgdb_roundup_cpus() to
 enable pseudo-NMI roundup
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
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2023-08-22 14:27:01)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index c51d54019f5f..5ee6b69b4360 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -75,10 +76,11 @@ enum ipi_msg_type {
>         IPI_IRQ_WORK,
>         NR_IPI,
>         /*
> -        * CPU_BACKTRACE is special and not included in NR_IPI
> +        * CPU_BACKTRACE and KGDB_ROUNDUP are special and not included in NR_IPI
>          * or tracable with trace_ipi_*

If this is going to be added to in the future then the comment could be
more generic to avoid further updates.

	 /*
	  * Any enum equal to NR_IPI or less than MAX_IPI is special and
	  * not included in NR_IPI ...
	  /
