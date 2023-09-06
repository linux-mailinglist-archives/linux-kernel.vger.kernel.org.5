Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1724B79454A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbjIFVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244717AbjIFVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:46:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF4A19BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:45:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so5642611fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694036756; x=1694641556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96tt7mjy0zwf48H2OXBzxLiMPsP9ITEZSEJu0hJniYk=;
        b=eahnv0VB1W2A/p6gU0kAa6MJ/xwki4ql73NMOxJrT3haG/DOCDCafuPra22wHTHNjM
         j2LMW0hVdWrP5OmZL9J+grEbI6NgQkgZk8DvjLZrRS99HVSJbrJRWS4JRtXWvhv5PkN1
         O/HuD5U5V3/UGPi77chy9kViGKIkhSUqHjzQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036756; x=1694641556;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96tt7mjy0zwf48H2OXBzxLiMPsP9ITEZSEJu0hJniYk=;
        b=loJETdhR9eOh54XgrDMPsGjcbKvAFSTA9OcsvWzbR8pvvucDUzuThNBgfU1kZJh3ql
         LvYXvJEGQAMD/uwyIpUVyh9c4NlIbnUZhzE5ez8wKo9NrAuAny6g918GCEbzoADEN3rA
         mkrtO5UrgtDVetbhJoJJ+x7NRmpOhkY0X0h2AEzpxB/oBNq/bR3dgdOkHHaGkgdEf9Zy
         91IYum83cWHeXbKdaksUvZ4zzn8oQRO5ICd7pZEjvTPefe8QV8jh5ePpWKvAiB8vaDIz
         uL/c8eromtJL25tUgVZqQmbuCo9/NWgzsCRBF7Mq4ZnVqOYYuwZjZsoo3/nF97kM/MMU
         LD5Q==
X-Gm-Message-State: AOJu0YwuwYjN9ays0xNj5rHYP16pgzxZYrYj775ACmBSMOLZGpFK0Hyy
        P5Y2iraygjHK1QBDtWBJAGrKIzMTB4QI0c1P1mt/Fw==
X-Google-Smtp-Source: AGHT+IEYoUZI7EWDiVFAQU39A6TrMXW8B5b18tDscF/EUhrbaZ1WRb+HiEMWcNMeUUEWh0eVYCDRP1QX9A6MMJC7hB8=
X-Received: by 2002:a05:6512:2820:b0:4fd:c84f:30d4 with SMTP id
 cf32-20020a056512282000b004fdc84f30d4mr3797056lfb.36.1694036756018; Wed, 06
 Sep 2023 14:45:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Sep 2023 16:45:55 -0500
MIME-Version: 1.0
In-Reply-To: <20230906090246.v13.7.I625d393afd71e1766ef73d3bfaac0b347a4afd19@changeid>
References: <20230906160505.2431857-1-dianders@chromium.org> <20230906090246.v13.7.I625d393afd71e1766ef73d3bfaac0b347a4afd19@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Sep 2023 16:45:55 -0500
Message-ID: <CAE-0n52v7kcfiX3=4PKUPJpiCm4rmSr8xpKnaD+Q4-BS9t_prg@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] arm64: smp: Mark IPI globals as __ro_after_init
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, scott@os.amperecomputing.com,
        vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-09-06 09:03:02)
> Mark the three IPI-related globals in smp.c as "__ro_after_init" since
> they are only ever set in set_smp_ipi_range(), which is marked
> "__init". This is a better and more secure marking than the old
> "__read_mostly".
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
