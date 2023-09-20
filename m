Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3380D7A76F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjITJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjITJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:12:27 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A27EC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:12:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5907D1BF207;
        Wed, 20 Sep 2023 09:12:14 +0000 (UTC)
Message-ID: <57862c7c-3158-c37b-baae-db6801f4d7e8@ghiti.fr>
Date:   Wed, 20 Sep 2023 11:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] riscv: Introduce PBMT field to PTDUMP
Content-Language: en-US
To:     Yu Chien Peter Lin <peterlin@andestech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, david@redhat.com, akpm@linux-foundation.org,
        alexghiti@rivosinc.com, bjorn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor.dooley@microchip.com
References: <20230920035522.3180558-1-peterlin@andestech.com>
 <20230920035522.3180558-2-peterlin@andestech.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230920035522.3180558-2-peterlin@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/09/2023 05:55, Yu Chien Peter Lin wrote:
> This patch introduces the PBMT field to the PTDUMP, so it can
> display the memory attributes for NC or IO.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v2
> - no change
> Changes v2 -> v3
> - Add ".." when PBMT field is clear
> ---
>   arch/riscv/mm/ptdump.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 57a0926c6627..13997cf3fe36 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -135,6 +135,12 @@ struct prot_bits {
>   
>   static const struct prot_bits pte_bits[] = {
>   	{
> +#ifdef CONFIG_64BIT
> +		.mask = _PAGE_MTMASK_SVPBMT,
> +		.set = "MT(%s)",
> +		.clear = "  ..  ",
> +	}, {
> +#endif
>   		.mask = _PAGE_SOFT,
>   		.set = "RSW(%d)",
>   		.clear = "  ..  ",
> @@ -205,6 +211,16 @@ static void dump_prot(struct pg_state *st)
>   		if (val) {
>   			if (pte_bits[i].mask == _PAGE_SOFT)
>   				sprintf(s, pte_bits[i].set, val >> 8);
> +#ifdef CONFIG_64BIT
> +			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
> +				if (val == _PAGE_NOCACHE_SVPBMT)
> +					sprintf(s, pte_bits[i].set, "NC");
> +				else if (val == _PAGE_IO_SVPBMT)
> +					sprintf(s, pte_bits[i].set, "IO");
> +				else
> +					sprintf(s, pte_bits[i].set, "??");
> +			}
> +#endif
>   			else
>   				sprintf(s, "%s", pte_bits[i].set);
>   		} else {


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex

