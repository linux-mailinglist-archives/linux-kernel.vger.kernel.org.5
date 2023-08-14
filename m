Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87C77B83A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjHNMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjHNMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FBF5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12ED16303C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C8C433CA;
        Mon, 14 Aug 2023 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692014873;
        bh=fCU0Jjxw0M+i9kUlQNkjYu/ErKYo4MA2He7FJSPpqYM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=B63DZ5lx/U5egdadm4tGxK9T8HhOgMQBi1/DFIO8KuO+MDbqozCxIkaNWIfDFdjfT
         JJj2Se6ppUgXLTrC9/Og/VPTQR56nIj7nBc5nq2/9HhLdtXQRLYakQwAamteBLnfqC
         3nLLDCKcjibHB6XplA6/jCUhieiZ+d94DR3utDMAAqb5TdPrheOElEwPCTfW2qQiTk
         b1Jc2+tIprXjOY3VeYZorVmc+eNPJw45XN199hocTM50WgXvTP0B0UPcms/R1xeyjK
         WdxsGVyg/SRTrd+juHW3YMSlg9C0R4PcbMY1O1T5HEm74frFR+5HvWxbX2FDHMNzsx
         f8hlb9eECWdpA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>, charlie@rivosinc.com
Subject: Re: [PATCH] riscv: correct riscv_insn_is_c_jr() and
 riscv_insn_is_c_jalr()
In-Reply-To: <20230731183925.152145-1-namcaov@gmail.com>
References: <20230731183925.152145-1-namcaov@gmail.com>
Date:   Mon, 14 Aug 2023 14:07:50 +0200
Message-ID: <87o7j9g73d.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nam Cao <namcaov@gmail.com> writes:

> The instructions c.jr and c.jalr must have rs1 !=3D 0, but
> riscv_insn_is_c_jr() and riscv_insn_is_c_jalr() do not check for this. So,
> riscv_insn_is_c_jr() can match a reserved encoding, while
> riscv_insn_is_c_jalr() can match the c.ebreak instruction.
>
> Rewrite them with check for rs1 !=3D 0.
>
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/include/asm/insn.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 4e1505cef8aa..fce00400c9bc 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -110,6 +110,7 @@
>  #define RVC_INSN_FUNCT4_OPOFF	12
>  #define RVC_INSN_FUNCT3_MASK	GENMASK(15, 13)
>  #define RVC_INSN_FUNCT3_OPOFF	13
> +#define RVC_INSN_J_RS1_MASK	GENMASK(11, 7)
>  #define RVC_INSN_J_RS2_MASK	GENMASK(6, 2)
>  #define RVC_INSN_OPCODE_MASK	GENMASK(1, 0)
>  #define RVC_ENCODE_FUNCT3(f_)	(RVC_FUNCT3_##f_ << RVC_INSN_FUNCT3_OPOFF)
> @@ -245,8 +246,6 @@ __RISCV_INSN_FUNCS(c_jal, RVC_MASK_C_JAL, RVC_MATCH_C=
_JAL)
>  __RISCV_INSN_FUNCS(auipc, RVG_MASK_AUIPC, RVG_MATCH_AUIPC)
>  __RISCV_INSN_FUNCS(jalr, RVG_MASK_JALR, RVG_MATCH_JALR)
>  __RISCV_INSN_FUNCS(jal, RVG_MASK_JAL, RVG_MATCH_JAL)
> -__RISCV_INSN_FUNCS(c_jr, RVC_MASK_C_JR, RVC_MATCH_C_JR)
> -__RISCV_INSN_FUNCS(c_jalr, RVC_MASK_C_JALR, RVC_MATCH_C_JALR)
>  __RISCV_INSN_FUNCS(c_j, RVC_MASK_C_J, RVC_MATCH_C_J)
>  __RISCV_INSN_FUNCS(beq, RVG_MASK_BEQ, RVG_MATCH_BEQ)
>  __RISCV_INSN_FUNCS(bne, RVG_MASK_BNE, RVG_MATCH_BNE)
> @@ -273,6 +272,18 @@ static __always_inline bool riscv_insn_is_branch(u32=
 code)
>  	return (code & RV_INSN_OPCODE_MASK) =3D=3D RVG_OPCODE_BRANCH;
>  }
>=20=20
> +static __always_inline bool riscv_insn_is_c_jr(u32 code)
> +{
> +	return (code & RVC_MASK_C_JR) =3D=3D RVC_MATCH_C_JR &&
> +	       (code & RVC_INSN_J_RS1_MASK) !=3D 0;
> +}
> +
> +static __always_inline bool riscv_insn_is_c_jalr(u32 code)
> +{
> +	return (code & RVC_MASK_C_JALR) =3D=3D RVC_MATCH_C_JALR &&
> +	       (code & RVC_INSN_J_RS1_MASK) !=3D 0;
> +}
> +

Nice one!

In the future, add a Fixes-tag for these kind of changes!
Fixes: ec5f90877516 ("RISC-V: Move riscv_insn_is_* macros into a common hea=
der")

(No need for a respin, b4 will pick up the Fixes above.)


Bj=C3=B6rn
