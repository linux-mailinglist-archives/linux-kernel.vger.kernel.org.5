Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56746785C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbjHWPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjHWPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:34:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DFE5E;
        Wed, 23 Aug 2023 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bdZCYS5SPqQedWjwa/DjmCAhvMNMuHRnxN4lWjXUYEs=; b=SPMv9SI6N+QxbYdqeGdGl4Sgrp
        bxI2vAeU55230m4843q2EyxlhXpZKWOI5KbV1Jp76tye/+ghuP/RDrRoZbGk6rjlMpotPPmbe/FTx
        wQVZ/sOkt0T2dwaYb25r8SstqYTW5sJjp47qD5znai6v+M0yKbk0V3xLkrt0n2Qp205cf8WTZ56+b
        63cLX0KlCFCckHiBkJgtbHzON+VQ6HDvftvkvjSXA1ZziYNyfjGa799wpR/zaLmCPlT74XZJdnYVq
        WP64LXjlsAkZLaTo57h25tf+nxUI4HxnqoRNWHd1T3IUsdqWicYahO5AkQZHcyzzjKMPRlD2fpdoE
        Jmi+3NCQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYps0-000zTr-0B;
        Wed, 23 Aug 2023 15:34:08 +0000
Message-ID: <23368823-0377-00c0-28a1-e804e3a2acac@infradead.org>
Date:   Wed, 23 Aug 2023 08:34:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] riscv: Require FRAME_POINTER for some configurations
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230823082845.354839-1-bjorn@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230823082845.354839-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 8/23/23 01:28, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Some V configurations implicitly turn on '-fno-omit-frame-pointer',
> but leaving FRAME_POINTER disabled. This makes it hard to reason about
> the FRAME_POINTER config, and also triggers build failures introduced
> in by the commit in the Fixes: tag.
> 
> Select FRAME_POINTER explicitly for these configurations.
> 
> Fixes: ebc9cb03b21e ("riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTER=n")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

WorksForMe. Thanks.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/riscv/Kconfig  | 1 +
>  arch/riscv/Makefile | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 10e7a7ad175a..cd8075c092c3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -62,6 +62,7 @@ config RISCV
>  	select COMMON_CLK
>  	select CPU_PM if CPU_IDLE || HIBERNATION
>  	select EDAC_SUPPORT
> +	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6ec6d52a4180..1329e060c548 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -87,9 +87,6 @@ endif
>  ifeq ($(CONFIG_CMODEL_MEDANY),y)
>  	KBUILD_CFLAGS += -mcmodel=medany
>  endif
> -ifeq ($(CONFIG_PERF_EVENTS),y)
> -        KBUILD_CFLAGS += -fno-omit-frame-pointer
> -endif
>  
>  # Avoid generating .eh_frame sections.
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
> 
> base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d

-- 
~Randy
