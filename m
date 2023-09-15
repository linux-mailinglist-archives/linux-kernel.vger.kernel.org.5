Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54477A1D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjIOLHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIOLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:07:16 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A705CC1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:07:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABB14E000A;
        Fri, 15 Sep 2023 11:07:04 +0000 (UTC)
Message-ID: <51f5c170-2659-d76a-afbb-632b7a55586c@ghiti.fr>
Date:   Fri, 15 Sep 2023 13:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] riscv: Improve PTDUMP to show RSW with non-zero
 value
To:     Yu Chien Peter Lin <peterlin@andestech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, david@redhat.com, akpm@linux-foundation.org,
        alexghiti@rivosinc.com, bjorn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ycliang@andestech.com
References: <20230914014027.273002-1-peterlin@andestech.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230914014027.273002-1-peterlin@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 03:40, Yu Chien Peter Lin wrote:
> RSW field can be used to encode 2 bits of software defined
> information, currently PTDUMP only prints RSW when its value
> is 1 or 3.
>
> To fix this issue and enhance the debug experience with PTDUMP,
> we use _PAGE_SOFT as the RSW mask and redefine _PAGE_SPECIAL to
> (1 << 8), allow it to print the RSW with any non-zero value,
> otherwise, it will print an empty string for each row.
>
> This patch also removes the val from the struct prot_bits as
> it is no longer needed.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
>   arch/riscv/include/asm/pgtable-bits.h |  4 +--
>   arch/riscv/mm/ptdump.c                | 36 +++++++++++----------------
>   2 files changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index f896708e8331..99e60fd3eb72 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -16,9 +16,9 @@
>   #define _PAGE_GLOBAL    (1 << 5)    /* Global */
>   #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
>   #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
> -#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
> +#define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>   
> -#define _PAGE_SPECIAL   _PAGE_SOFT


That's nit, but maybe you could have introduced a _PAGE_SOFT_1 and 
_PAGE_SOFT_2


> +#define _PAGE_SPECIAL   (1 << 8)


instead of hardcoding (1<<8) here, but that can be done when we'll use 
the second bit :)


>   #define _PAGE_TABLE     _PAGE_PRESENT
>   
>   /*
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 20a9f991a6d7..85686652f342 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -129,7 +129,6 @@ static struct ptd_mm_info efi_ptd_info = {
>   /* Page Table Entry */
>   struct prot_bits {
>   	u64 mask;
> -	u64 val;
>   	const char *set;
>   	const char *clear;
>   };
> @@ -137,47 +136,38 @@ struct prot_bits {
>   static const struct prot_bits pte_bits[] = {
>   	{
>   		.mask = _PAGE_SOFT,
> -		.val = _PAGE_SOFT,
> -		.set = "RSW",
> -		.clear = "   ",
> +		.set = "RSW(%d)",
> +		.clear = "      ",
>   	}, {
>   		.mask = _PAGE_DIRTY,
> -		.val = _PAGE_DIRTY,
>   		.set = "D",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_ACCESSED,
> -		.val = _PAGE_ACCESSED,
>   		.set = "A",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_GLOBAL,
> -		.val = _PAGE_GLOBAL,
>   		.set = "G",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_USER,
> -		.val = _PAGE_USER,
>   		.set = "U",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_EXEC,
> -		.val = _PAGE_EXEC,
>   		.set = "X",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_WRITE,
> -		.val = _PAGE_WRITE,
>   		.set = "W",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_READ,
> -		.val = _PAGE_READ,
>   		.set = "R",
>   		.clear = ".",
>   	}, {
>   		.mask = _PAGE_PRESENT,
> -		.val = _PAGE_PRESENT,
>   		.set = "V",
>   		.clear = ".",
>   	}
> @@ -208,15 +198,19 @@ static void dump_prot(struct pg_state *st)
>   	unsigned int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
> -		const char *s;
> -
> -		if ((st->current_prot & pte_bits[i].mask) == pte_bits[i].val)
> -			s = pte_bits[i].set;
> -		else
> -			s = pte_bits[i].clear;
> -
> -		if (s)
> -			pt_dump_seq_printf(st->seq, " %s", s);
> +		char s[7];
> +		unsigned long val;
> +
> +		val = st->current_prot & pte_bits[i].mask;
> +		if (val) {
> +			if (pte_bits[i].mask == _PAGE_SOFT)
> +				sprintf(s, pte_bits[i].set, val >> 8);
> +			else
> +				sprintf(s, "%s", pte_bits[i].set);
> +		} else
> +			sprintf(s, "%s", pte_bits[i].clear);
> +
> +		pt_dump_seq_printf(st->seq, " %s", s);
>   	}
>   }
>   


I don't see any issue in your patch, but just the output is a bit 
"weird" now as the there is a large "hole" between the PTE type and the 
PTE protection bits:

Before:

0xffffffd800000000-0xffffffd800200000 0x0000000080000000         2M 
PMD     D A G . . W R V

After:

0xffffaf8000000000-0xffffaf8000200000 0x0000000080000000         2M PMD 
.               D A G . . W R V

Maybe you could add the PBMT/N bits after the protections bits to void 
this hole?

Anyway, as a heavy user of this kernel page table dump, that's really 
appreciated, thanks :)

Alex

