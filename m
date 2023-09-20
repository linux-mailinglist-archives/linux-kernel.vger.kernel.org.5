Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E27A76FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjITJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:14:21 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FBD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:14:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61CFF2000B;
        Wed, 20 Sep 2023 09:14:09 +0000 (UTC)
Message-ID: <876d3cd5-bb99-edd0-47c0-6dc34c8402d1@ghiti.fr>
Date:   Wed, 20 Sep 2023 11:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] riscv: Introduce NAPOT field to PTDUMP
Content-Language: en-US
To:     Yu Chien Peter Lin <peterlin@andestech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, david@redhat.com, akpm@linux-foundation.org,
        alexghiti@rivosinc.com, bjorn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor.dooley@microchip.com
References: <20230920035522.3180558-1-peterlin@andestech.com>
 <20230920035522.3180558-3-peterlin@andestech.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230920035522.3180558-3-peterlin@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/09/2023 05:55, Yu Chien Peter Lin wrote:
> This patch introduces the NAPOT field to PTDUMP, allowing it
> to display the letter "N" for pages that have the 63rd bit set.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v3
> - no change
> ---
>   arch/riscv/mm/ptdump.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 13997cf3fe36..b71f08b91e53 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -136,6 +136,10 @@ struct prot_bits {
>   static const struct prot_bits pte_bits[] = {
>   	{
>   #ifdef CONFIG_64BIT
> +		.mask = _PAGE_NAPOT,
> +		.set = "N",
> +		.clear = ".",
> +	}, {
>   		.mask = _PAGE_MTMASK_SVPBMT,
>   		.set = "MT(%s)",
>   		.clear = "  ..  ",

Nice to see that we actually transparently use napot mappings:

---[ PCI I/O start ]---
0xffff8d7fff000000-0xffff8d7fff010000    0x0000000003000000 64K PTE N   
..     ..   D A G . . W R V

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the series, really appreciated!

Alex

