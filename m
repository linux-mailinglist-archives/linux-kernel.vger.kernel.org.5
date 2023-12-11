Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BB80C596
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjLKKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjLKKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:05:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFC107
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1702289137;
        bh=rlfqbyyd+AtkXsEpEv1WncfhVdk1Vp9VajzWq/dwkls=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ACbBRqCHBrv36OFbZ0Rd6BYgudHg0So7dfIkRI+ALi69BnOELtAhdoiOVsG0fBI22
         uNZPrm0xDtQ1g7ImuCCHtLZ6DqUqzp1r/nBx0XHJPUom0BHo5EI6qpYKvuFylgaYP3
         e49sJ8Kv3jUs6ZpqOAR2Vey5GOTun+AwdHzBhR0voeQN5xfTvTzu6X5nRDTYV3wit4
         4xyOCC45hLG9bAVIteG5T7J9El3W11TYm01YgfqKhIGUMzBl6sPUR5+qvXZi0BA8cQ
         MrX4nGOg/2CXUVZwOeHdk4Ms82Pd00wVbDyM20JmVnKNxsXjaviTUJ1xMt0Y5CzjwW
         tGVcnbeVDM5TA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpcnY1yL4z4wdD;
        Mon, 11 Dec 2023 21:05:36 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
        shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH 1/1] powerpc/debug: implement HAVE_USER_RETURN_NOTIFIER
In-Reply-To: <475A60AEEAA99F6C+20231211025054.885-1-luming.yu@shingroup.cn>
References: <475A60AEEAA99F6C+20231211025054.885-1-luming.yu@shingroup.cn>
Date:   Mon, 11 Dec 2023 21:05:32 +1100
Message-ID: <87plzddpg3.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luming Yu <luming.yu@shingroup.cn> writes:

> The support for user return notifier infrastructure
> is hooked into powerpc architecture.
> ---
>  arch/powerpc/Kconfig                    |  1 +
>  arch/powerpc/include/asm/entry-common.h | 16 ++++++++++++++++
>  arch/powerpc/include/asm/thread_info.h  |  2 ++
>  arch/powerpc/kernel/process.c           |  2 ++
>  4 files changed, 21 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/entry-common.h
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c10229c0243c..b968068cc04a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -277,6 +277,7 @@ config PPC
>  	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
>  	select HAVE_STATIC_CALL			if PPC32
>  	select HAVE_SYSCALL_TRACEPOINTS
> +	select HAVE_USER_RETURN_NOTIFIER
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
>  	select HOTPLUG_SMT			if HOTPLUG_CPU
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> new file mode 100644
> index 000000000000..51f1eb767696
> --- /dev/null
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_POWERPC_ENTRY_COMMON_H
> +#define ARCH_POWERPC_ENTRY_COMMON_H
> +
> +#include <linux/user-return-notifier.h>
> +
> +static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> +						  unsigned long ti_work)
> +{
> +	if (ti_work & _TIF_USER_RETURN_NOTIFY)
> +		fire_user_return_notifiers();
> +}
> +
> +#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare

AFAICS this is never called because we don't use CONFIG_GENERIC_ENTRY ?

cheers
