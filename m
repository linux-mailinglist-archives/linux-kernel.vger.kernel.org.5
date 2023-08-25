Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF27891B8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjHYW2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHYW21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:28:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53C211E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:28:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500760b296aso1720147e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002504; x=1693607304;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/6agghUlnzcFD5k9bdIOnu9jgMgVxK8eg7bQBbKSXA=;
        b=mItPAx/UGYcPcSxAVRQwnU5sZ+4qTl8el9xJ72Vsl3/8vqtU5cYlaaCsVsHNFnlmWT
         Aacfa3xGzdoA//R6GPCO5jTJ97DUV+6JBiaaMWbn2gKi8c7ukMjI3906eBVrlrzDaQYs
         txG+AaV0Hpsqt5sgQAT2z/Dz3uWfVnrX7UCUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002504; x=1693607304;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/6agghUlnzcFD5k9bdIOnu9jgMgVxK8eg7bQBbKSXA=;
        b=W6ErrZeCNhygope6Y2kKM2LOrrBr/HLSfpIJmgW4RxSz+f1NwUGpuCRn4mAHVt7t0r
         SXDM9VYy4N9dJjccZtq/ZL7WRQCOuJbog0XxKdwb46nyBKEoaZaKu24HGhHqnD0OmWdS
         EwFJTlYn0VXlONTMXlhlidD15tTFu6+ZNnwzf60aljOhc3Y9421Ofe8hk/8f6Nske1+l
         GE2m8RCx3szf2XdzXNEoAgP29MLE+n1tacBGwVCY20vi4j5H54yxqu+EQhkIVIbBelsG
         a4rdChO9kFAjc9Evi/v+viOMM/pirZ2qWrUxVQGMG1Wze81VNroAAIduM/7KCt4SpKUX
         o0pw==
X-Gm-Message-State: AOJu0YxVSi+/aYmdEoaBbYNLcamKjuHlhFvwYGW7r765Cg3GqOr8yWa8
        hUdP/LB8gkyE3Eohu+rR2+MO6xKsB8NXqLiuY5umJw==
X-Google-Smtp-Source: AGHT+IH4+ved9NrODcrL+cqJbDqjLcbW0OPzmoiiz6NJNlJxDjHXtWqNbZlF13w6x+zbyE8eQz2Y96JFLeuco6d5oUs=
X-Received: by 2002:a05:6512:2348:b0:500:8be5:1cb8 with SMTP id
 p8-20020a056512234800b005008be51cb8mr4417150lfu.30.1693002503728; Fri, 25 Aug
 2023 15:28:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 17:28:23 -0500
MIME-Version: 1.0
In-Reply-To: <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 17:28:23 -0500
Message-ID: <CAE-0n50sODsofOC-5uhs_1E6aHyTmyK45nPUvFddq9N9jhqUXg@mail.gmail.com>
Subject: Re: [PATCH v11 6/6] arm64: kgdb: Implement kgdb_roundup_cpus() to
 enable pseudo-NMI roundup
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-08-24 08:30:32)
> Up until now we've been using the generic (weak) implementation for
> kgdb_roundup_cpus() when using kgdb on arm64. Let's move to a custom
> one. The advantage here is that, when pseudo-NMI is enabled on a
> device, we'll be able to round up CPUs using pseudo-NMI. This allows
> us to debug CPUs that are stuck with interrupts disabled. If
> pseudo-NMIs are not enabled then we'll fallback to just using an IPI,
> which is still slightly better than the generic implementation since
> it avoids the potential situation described in the generic
> kgdb_call_nmi_hook().
>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
