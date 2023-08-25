Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217257891A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjHYWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHYWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:17:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D58F2120
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:17:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so2165212e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693001826; x=1693606626;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrlOotjavXB0JqE55pt9ehBxyPFQpiJrYDjXTIglhZ0=;
        b=Ym/itz7Gtk0QnmD2HxbKyjjDXZ1SPqzcCAIeQ27erNIraYMX9ABmsl6JM6oJo+MJcQ
         G5G4uXwpd5tjwcovfCHznTiZVpuXrSW/zUC3VNNxCI3+X0gfsoiilxOuuR7V/ggNsj5W
         yQa84nEF7h2FarP7X0vagsDa39Fx68fLNueTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001826; x=1693606626;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrlOotjavXB0JqE55pt9ehBxyPFQpiJrYDjXTIglhZ0=;
        b=SaKmR93Y7eFYsPiB7ADN2StEzS9PQLYcfnTmXlv3GLC4vuAEJhyx8KINq+v2Yzdm1c
         gWN+tbcqemwQ+Cxbh7DqNxYxhEJLu4G5XzRNbj/AIj2otxhfl9oLBBc8XvEgidwXjBHA
         sM2m57WD8d1ZRdeWvE461WmFjMMVXyyzN5TgKiXAhGwAL3KOvo09OIMcoMf+0U3aPrTW
         faT5uguWiFLQVPa36e1OVD3WbvL7/fJbF+tdsjY5xT0BqXjiSjpjwoqMlrpIvfKRWVsI
         9Bq/rRiQmNnecRAlog94Y+If4jB1JVQsAVZ6yVh9X5Uei6ux1I4HAiGlXtYeH/0amKpM
         i5YA==
X-Gm-Message-State: AOJu0YxjhY2kseR7wZbHYaNoi8Yd/uM1iW/P4y4atEP4ma2avu2RDHBI
        ZCkbzKB0VcBRdqEuWFxoobPv2q3g994gS7Fp4NBdWg==
X-Google-Smtp-Source: AGHT+IFKi/FjhPlAtZuPfnduFO2X83UaOHf4igEYpqi6QoVsmqz2ZB7PjG3rx+zsaSbxAb1kDqzEuOme7CDM83+kHIs=
X-Received: by 2002:a05:6512:a86:b0:4f8:64f5:f591 with SMTP id
 m6-20020a0565120a8600b004f864f5f591mr14490218lfu.12.1693001826529; Fri, 25
 Aug 2023 15:17:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 17:17:06 -0500
MIME-Version: 1.0
In-Reply-To: <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 17:17:06 -0500
Message-ID: <CAE-0n51KWPN3bTSuVTTCxoULs_86A2WVm66FQ3jf+dztDU4G9g@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] arm64: smp: Remove dedicated wakeup IPI
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
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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

Quoting Douglas Anderson (2023-08-24 08:30:29)
> From: Mark Rutland <mark.rutland@arm.com>
>
> To enable NMI backtrace and KGDB's NMI cpu roundup, we need to free up
> at least one dedicated IPI.
>
> On arm64 the IPI_WAKEUP IPI is only used for the ACPI parking protocol,
> which itself is only used on some very early ARMv8 systems which
> couldn't implement PSCI.
>
> Remove the IPI_WAKEUP IPI, and rely on the IPI_RESCHEDULE IPI to wake
> CPUs from the parked state. This will cause a tiny amonut of redundant
> work to check the thread flags, but this is miniscule in relation to the
> cost of taking and handling the IPI in the first place. We can safely
> handle redundant IPI_RESCHEDULE IPIs, so there should be no functional
> impact as a result of this change.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
