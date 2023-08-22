Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0842784D69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHVXlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjHVXlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:41:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66DCD7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:41:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe11652b64so7725337e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692747696; x=1693352496;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0ITuLKhlzaPZQWpkBry/7ALb2l4JBYh1AZmqI1V7FM=;
        b=Y7w4OUtznxoS71/IslUNopqCMutP14NzKPcUtiLyCOnZerbLBGx6vJn5dkPegAHOds
         biZnYSMOGTRwNZysAvohXQKG9JD/9dTXN6lhtQFPNpvGHYNaRP98qcGL+O7AFuso/ZL/
         C24MllDubIzuurS/lnUb9pMBFaD7yR0RbeVOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747696; x=1693352496;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0ITuLKhlzaPZQWpkBry/7ALb2l4JBYh1AZmqI1V7FM=;
        b=bMQBGQPY2CauLcX6r5Jr3EwBhfACef4h5hHAMLnM6ydtXYSpU/pThVnp/t12WVSfqn
         2Q+lJLs6cMVQVfyWM4z6a/WoODhWu+PfF8EdETc6ifY68Rv+3msL4VlVz+3WpPNlMhRe
         FIL4bclgDi3scX7jJWWEFs1qjrvPgAjZUtQ8BwOl/6x4N/tteTRu6I4hZWdo5uzPCGiR
         JrCLOhS5tr45txeUHkvcBwAiRpMIo4WkOn0RW8DgzOA36/makai4c/w3/TBlObduZpCY
         bTsPm6eVEzMGfetqpW9IbN8XG2A+uTPMrgC3yOKfUw2esTLjd6RqFFTIFSVmWoG9iS++
         lWFg==
X-Gm-Message-State: AOJu0YzjAUJ++XMgCpRKuLoHDZ9arTuwKVsskUOfCBP0FDZvTVqDixra
        ha9/CTrGA9qWEsv8IF8mqi0SNn7l2ppl1NvAWg2HiA==
X-Google-Smtp-Source: AGHT+IEhLsAs1tdCvUcl8AJ/GjjhJa/5joZKAoaHiUriI6gZb72jKvliVBs4CN5qEiAdPBs1NXCLssMlgEeI5HQHyWk=
X-Received: by 2002:a19:4305:0:b0:4fd:faa5:64ed with SMTP id
 q5-20020a194305000000b004fdfaa564edmr7217449lfa.11.1692747695945; Tue, 22 Aug
 2023 16:41:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:41:35 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:41:35 -0700
Message-ID: <CAE-0n51weSj5thSdTdpKmQsycsQgc2MovsTanSUmQ4GEtYBcxw@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP
 should try for NMI
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
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-08-22 14:27:00)
> There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
> handled as NMI. They are very simple and everything in them is
> NMI-safe. Mark them as things to use NMI for if NMI is available.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
