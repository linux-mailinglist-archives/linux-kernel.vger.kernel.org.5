Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E6784D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHVXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHVXQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:16:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9231010D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:16:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso7684950e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692746198; x=1693350998;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ne+QvARLPyJmWPOSrJZ8X8fHhrReARdSQtc8gHYhPWM=;
        b=izNsxqeDDqR8Taw686A/JA+R7wjulCx21d26ehlcDp+uRH97AKfo5hOYOJXQkMbFCy
         M0FYJLb865lMOG1vVO6DMGqss7CgorD/JW37SopF2VFiIMH5VQV3NxymxZFo50zvh+1s
         v8ycX3TpMlw7qflkWF5J5NBHcRsErx7InAtEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692746198; x=1693350998;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne+QvARLPyJmWPOSrJZ8X8fHhrReARdSQtc8gHYhPWM=;
        b=LwRqZrQZk9eJAKFkHx9i68jydAyRUSX97h393NqPPtXTCaB4EuUM3Wv6hmO8gMB13J
         MbRamVjkUOT+q8hIcIQAq/F8mil3QlcYXHdr4AD4fr65/sg8XW1BFoTYS66YU8rPsHan
         jfKMtyOAGbil3Mg3FQofuDo7TMId5W7tVYaHQZNXNnCs79cb9SunHxG+Fi54JqYNeYmi
         3VpLsjWN7iCsQPqv9WE4l1eRa42ze4C39FchJv/vQPe4RimWlKO9N2tjlrBma5BCbOpu
         20xyG2LFWuIDlSMvOcZA4mnHv3/v/AppEI9bEemFkyVhwu4yLbz9r4sh+JAwQaWJX2G+
         hVKg==
X-Gm-Message-State: AOJu0YyL/lcDTceBSPHcRK3h3wjw8rYiBFJ4cyL6j9GmQoOLSa1xeqEJ
        9iikyMehPutJ1Qc1CEk4zp/OtleiiSkQS37m1Fqq1Q==
X-Google-Smtp-Source: AGHT+IEMIIqUR2cKKxkSn0Xl2le40m5jCfwmqglTjMHe6IOHN8s+YCUP9cEbCmqaWfq8WalCP496sNNT5QAilRON1vI=
X-Received: by 2002:a05:6512:6ca:b0:4ff:9eed:b68d with SMTP id
 u10-20020a05651206ca00b004ff9eedb68dmr9502586lff.58.1692746197816; Tue, 22
 Aug 2023 16:16:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:16:37 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:16:37 -0700
Message-ID: <CAE-0n50va9r7wrRzbK2KduNPdNNimiKT9CkuP=meA6JaoMTpWw@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] arm64: smp: Remove dedicated wakeup IPI
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
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-08-22 14:26:58)
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 9b31e6d0da17..798fd76a883a 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -89,9 +89,9 @@ extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
>
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> +extern void arch_send_wakeup_ipi(int cpu);

Is int used instead of unsigned int because we want to sometimes pass a
negative value to indicate an error? Maybe it should be unsigned int.
