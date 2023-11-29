Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFED07FCFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjK2H33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK2H31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:29:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A9B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:29:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0D9C433C8;
        Wed, 29 Nov 2023 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701242974;
        bh=JeS974xooxXbY2aUbrV+BCTn2Y8BWdv08zOfWtRHTxs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZM2ntIIB8LEbvWSNluhL7GsoM2lrtXQUYuc26m2cI2DaeWvTnNA9Z15PurRR0jith
         kSB9COSrxtY4UDD9NvFrtlZK7Rqf0cMLqLE52iGMdOIxUXyzKgudmJYTqhUf/ugNIy
         H+btzFiS+yFb7WQakZrT3k5sl+y1af7DkVYtBcaCGTZncF01MAHhIwcJH7B7SLx9ZZ
         ruvL+5pcbdTZQHnTCTaACsjVwyT0YPEJDDqPOol8EkuzxweuSTAsg2IEOns44rlUBR
         tekCD+Q85psU29Y4nNSdX/19aVqB1Dq/xYRbTzrXxOULv0bfqgE9OwKWeXwuj9Ruef
         1dH5DIekawzaw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v4 1/2] riscv: Safely remove entries from relocation list
In-Reply-To: <20231127-module_linking_freeing-v4-1-a2ca1d7027d0@rivosinc.com>
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
 <20231127-module_linking_freeing-v4-1-a2ca1d7027d0@rivosinc.com>
Date:   Wed, 29 Nov 2023 08:29:31 +0100
Message-ID: <877cm19fvo.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins <charlie@rivosinc.com> writes:

> Use the safe versions of list and hlist iteration to safely remove
> entries from the module relocation lists. To allow mutliple threads to
> load modules concurrently, move relocation list pointers onto the stack
> rather than using global variables.
>
> Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/linux-riscv/444de86a-7e7c-4de7-5d1d-c1c40=
eefa4ba@w6rz.net
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/module.c | 110 +++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 82 insertions(+), 28 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 56a8c78e9e21..53593fe58cd8 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -40,15 +40,6 @@ struct relocation_handlers {
>  				  long buffer);
>  };
>=20=20
> -unsigned int initialize_relocation_hashtable(unsigned int num_relocation=
s);
> -void process_accumulated_relocations(struct module *me);
> -int add_relocation_to_accumulate(struct module *me, int type, void *loca=
tion,
> -				 unsigned int hashtable_bits, Elf_Addr v);
> -
> -struct hlist_head *relocation_hashtable;
> -
> -struct list_head used_buckets_list;
> -
>  /*
>   * The auipc+jalr instruction pair can reach any PC-relative offset
>   * in the range [-2^31 - 2^11, 2^31 - 2^11)
> @@ -604,7 +595,10 @@ static const struct relocation_handlers reloc_handle=
rs[] =3D {
>  	/* 192-255 nonstandard ABI extensions  */
>  };
>=20=20
> -void process_accumulated_relocations(struct module *me)
> +static void
> +process_accumulated_relocations(struct module *me,

Nit/breaks my workflow ;-): Don't bother if you're not respinning for
other reasons. The linebreak after return type makes it harder to grep
the code (and also is not in line with the layout with rest of this).


Bj=C3=B6rn
