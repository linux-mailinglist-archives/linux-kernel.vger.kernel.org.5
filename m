Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE5C75BDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGUFt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGUFst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB753AB1;
        Thu, 20 Jul 2023 22:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889B961185;
        Fri, 21 Jul 2023 05:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D86CC433C8;
        Fri, 21 Jul 2023 05:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689918494;
        bh=ahkbJ+oFoqBo9wkehSm+Ve4k00bHUAb6i7Wno4IX6Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOZhr7pfzyu3qz3dL57XPyWiK6pGctPlMOpLvIjeU99BEqoj84ejDo8SeZbGpmzmY
         g+sn0SuRHWCf2yKoF1VLYxFRFGBeegFJMq71mrfu/pwq02Y0fJqWZ5d2YwcoKwx73g
         qMXj2iy2JFGYSLyf6IG3vxhXIaRsbBSPDGvN3Iv9Nu0t+/EeuAJTrQF0P4yoYhd6bk
         xBQzvwBwn/aSymiDVnzMhxaEa5OF5v/CPUvd6yRGeCKtOXetPfcwZlpUWold+EszSe
         g5Egt94NgK97Upf9lc6SR1XewlxKGbBiHS+EEz+T7KCBCG2cNqzvx2mYtvABy4vJAO
         kdgfU25pLczMA==
Date:   Thu, 20 Jul 2023 22:48:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 04/12] RISC-V: add vector crypto extension detection
Message-ID: <20230721054812.GE847@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-5-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153743.1970625-5-heiko@sntech.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:37:35PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Add detection for some extensions of the vector-crypto specification:
> - Zvkb: Vector Bit-manipulation used in Cryptography
> - Zvkg: Vector GCM/GMAC
> - Zvknha and Zvknhb: NIST Algorithm Suite
> - Zvkns: AES-128, AES-256 Single Round Suite
> - Zvksed: ShangMi Algorithm Suite
> - Zvksh: ShangMi Algorithm Suite
> 
> As their use is very specific and will likely be limited to special places
> we expect current code to just pre-encode those instructions, so right now
> we don't introduce toolchain requirements.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/hwcap.h |  9 ++++++
>  arch/riscv/kernel/cpu.c        |  8 ++++++
>  arch/riscv/kernel/cpufeature.c | 50 ++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b80ca6e77088..0f5172fa87b0 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -64,6 +64,15 @@
>  #define RISCV_ISA_EXT_ZKSED		51
>  #define RISCV_ISA_EXT_ZKSH		52
>  #define RISCV_ISA_EXT_ZKT		53
> +#define RISCV_ISA_EXT_ZVBB		54
> +#define RISCV_ISA_EXT_ZVBC		55
> +#define RISCV_ISA_EXT_ZVKG		56
> +#define RISCV_ISA_EXT_ZVKNED		57
> +#define RISCV_ISA_EXT_ZVKNHA		58
> +#define RISCV_ISA_EXT_ZVKNHB		59
> +#define RISCV_ISA_EXT_ZVKSED		60
> +#define RISCV_ISA_EXT_ZVKSH		61
> +#define RISCV_ISA_EXT_ZVKT		62

It would be helpful if each RISCV_ISA_EXT_* definition had a comment that spells
out what it stands for, similar to what arch/x86/include/asm/cpufeatures.h does.
I know they can all be looked up, and they're sort of mnemonic, but it would be
helpful.

- Eric
