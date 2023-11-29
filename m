Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924587FDCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjK2QRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjK2QR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:17:28 -0500
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E526AA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9nN6oik6II8sOQ1UNPbsvRq7CVPCG/jUOq68+fl6qwM=; b=V8YbwTrXLLXE+TGQ0d0I8cNmMt
        AaCeij18XBV3+sVLGacs0vxyfJnG5e17jBufvLrO93KC2Qx9SY4ijOTl2K4BAECoUBh0qKwz0MtZY
        ZkzeKo3mjzP22OV9UPX36IZRsWOQ64sg/fP371OBe6mT6oPFvr901y59c3HAMdw2vG0Y7OFZpcBsl
        e7cld42tos2Mp2N2+tDHZuNB/BbzbL39pViVrNv+iU0Evc0FYr8Y2f9ABYheEoRHnfaBBw9W3jWwF
        xeZA+KSqORU4+OvFoWt5jiD7Vpo7y8lZoiTdbzA2x/yz4tlBE1JLFdCCBe/HF6nH88h+grVWFhhah
        9cHt7dUw==;
Received: from [63.135.74.212] (helo=[192.168.1.184])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r8NEA-007yrK-97; Wed, 29 Nov 2023 16:15:55 +0000
Message-ID: <2feb3ff4-3d26-41f7-83f5-6440393d6e43@codethink.co.uk>
Date:   Wed, 29 Nov 2023 16:15:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Implement archrandom when Zkr is available
Content-Language: en-GB
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231129160325.1119803-1-cleger@rivosinc.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20231129160325.1119803-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 16:03, Clément Léger wrote:
> From: Samuel Ortiz <sameo@rivosinc.com>
> 
> From: Samuel Ortiz <sameo@rivosinc.com>
> 
> The Zkr extension is ratified and provides 16 bits of entropy seed when
> reading the SEED CSR.
> 
> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> that CSR and filling an unsigned long with valid entropy bits.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
> 
> This series depends on "riscv: report more ISA extensions through
> hwprobe" series [1].
> 
> Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/ [1]
> ---
>   arch/riscv/include/asm/archrandom.h | 69 +++++++++++++++++++++++++++++
>   arch/riscv/include/asm/csr.h        |  9 ++++
>   2 files changed, 78 insertions(+)
>   create mode 100644 arch/riscv/include/asm/archrandom.h
> 
> diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
> new file mode 100644
> index 000000000000..795837ccb583
> --- /dev/null
> +++ b/arch/riscv/include/asm/archrandom.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Kernel interface for the RISCV arch_random_* functions
> + *
> + * Copyright (c) 2023 by Rivos Inc.
> + *
> + */
> +
> +#ifndef ASM_RISCV_ARCHRANDOM_H
> +#define ASM_RISCV_ARCHRANDOM_H
> +
> +#include <asm/csr.h>
> +
> +#define SEED_RETRY_LOOPS 100
> +
> +static inline bool __must_check csr_seed_long(unsigned long *v)
> +{
> +	unsigned int retry = SEED_RETRY_LOOPS, valid_seeds = 0;
> +	const int needed_seeds = sizeof(long) / sizeof(u16);
> +	u16 *entropy = (u16 *)v;
> +
> +	do {
> +		/*
> +		 * The SEED CSR must be accessed with a read-write instruction.
> +		 */
> +		unsigned long csr_seed = csr_swap(CSR_SEED, 0);
> +
> +		switch (csr_seed & SEED_OPST_MASK) {
> +		case SEED_OPST_ES16:
> +			entropy[valid_seeds++] = csr_seed & SEED_ENTROPY_MASK;
> +			if (valid_seeds == needed_seeds)
> +				return true;
> +			break;
> +
> +		case SEED_OPST_DEAD:
> +			pr_err_once("archrandom: Unrecoverable error\n");
> +			return false;
> +
> +		case SEED_OPST_BIST:
> +		case SEED_OPST_WAIT:
> +		default:
> +			continue;

is it worth adding a cpu_relax() here?

> +		}
> +	} while (--retry);
> +
> +	return false;
> +}
> +
> +static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
> +{
> +	return 0;
> +}
> +
> +static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
> +{
> +	if (!max_longs)
> +		return 0;
> +
> +	/*
> +	 * If Zkr is supported and csr_seed_long succeeds, we return one long
> +	 * worth of entropy.
> +	 */
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_long(v))
> +		return 1;

I'm assuming the code will retry if max_longs > 1 ?



> +	return 0;
> +}
> +
> +#endif /* ASM_RISCV_ARCHRANDOM_H */
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 306a19a5509c..510014051f5d 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -411,6 +411,15 @@
>   #define CSR_VTYPE		0xc21
>   #define CSR_VLENB		0xc22
>   
> +/* Scalar Crypto Extension - Entropy */
> +#define CSR_SEED		0x015
> +#define SEED_OPST_MASK		_AC(0xC0000000, UL)
> +#define SEED_OPST_BIST		_AC(0x00000000, UL)
> +#define SEED_OPST_WAIT		_AC(0x40000000, UL)
> +#define SEED_OPST_ES16		_AC(0x80000000, UL)
> +#define SEED_OPST_DEAD		_AC(0xC0000000, UL)
> +#define SEED_ENTROPY_MASK	_AC(0xFFFF, UL)
> +
>   #ifdef CONFIG_RISCV_M_MODE
>   # define CSR_STATUS	CSR_MSTATUS
>   # define CSR_IE		CSR_MIE

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

