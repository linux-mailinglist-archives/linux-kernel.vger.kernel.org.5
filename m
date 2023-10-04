Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306457B85B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbjJDQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjJDQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:51:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29819B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:51:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B86C433C8;
        Wed,  4 Oct 2023 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438311;
        bh=8Q4QopUgWo8aKbA+HXXLKdUEg6EbLI8JyQNYO6KZYoE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=av2hGOlj3qAsSnrueTTJhKBE6PxCl//Zeuh3VoO/XfdvnzQf4ElpbWiVioyKym912
         2wNq2wRpALOw0C4+aFyLNXq1+E5/t5PjmVOWgYZUYqHxnWdx3OlItAMIbZPzcxnayy
         i+s7LRfYPiJM/UtUqeO2b0ZhixyI/nUolKM0t6Oyw61eAHZ900r7+sXn2I7lny412q
         PsyaDz/Ey6ecMa6rWEmf0UkUTrpFiWMkbVf8U8ITB4ErYK5MrXNkii0ZiUX7aCNfQL
         rpMrDNVxi09+zgmQJUObmc/ljp6wvb34uzkDksZOfi+m38zyudH5I/EmRuhmdaegEW
         b6o8l7E2kjLGA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 1/8] riscv: remove unused functions in
 traps_misaligned.c
In-Reply-To: <20231004151405.521596-2-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-2-cleger@rivosinc.com>
Date:   Wed, 04 Oct 2023 18:51:48 +0200
Message-ID: <877co2gwkb.fsf@all.your.base.are.belong.to.us>
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

Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> writes:

> Replace macros by the only two function calls that are done from this
> file, store_u8() and load_u8().
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 46 +++++-----------------------
>  1 file changed, 7 insertions(+), 39 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 378f5b151443..e7bfb33089c1 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -151,51 +151,19 @@
>  #define PRECISION_S 0
>  #define PRECISION_D 1
>=20=20
> -#define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
> -static inline type load_##type(const type *addr)			\
> -{									\
> -	type val;							\
> -	asm (#insn " %0, %1"						\
> -	: "=3D&r" (val) : "m" (*addr));					\
> -	return val;							\
> -}
> +static inline u8 load_u8(const u8 *addr)

Really a nit, and applies to the whole file: "static inline" in a .c
file is just useless.

> +{
> +	u8 val;
>=20=20
> -#define DECLARE_UNPRIVILEGED_STORE_FUNCTION(type, insn)			\
> -static inline void store_##type(type *addr, type val)			\
> -{									\
> -	asm volatile (#insn " %0, %1\n"					\
> -	: : "r" (val), "m" (*addr));					\
> -}
> +	asm volatile("lbu %0, %1" : "=3D&r" (val) : "m" (*addr));

Why do you need early clobber here?


Bj=C3=B6rn
