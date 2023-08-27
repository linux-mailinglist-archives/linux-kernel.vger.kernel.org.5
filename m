Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9BA789D02
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjH0Kep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjH0Kei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B0D8;
        Sun, 27 Aug 2023 03:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E91F961DD5;
        Sun, 27 Aug 2023 10:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED788C433C8;
        Sun, 27 Aug 2023 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693132474;
        bh=e5QUzPSQpe5m0BHjZDjZtmHkd1XzzyDtkKMwZgcBzqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOFIXMTuEDDZzHghgMd/2KXKH2+SLpeDrAJMYRyDEcBiCUuBsUygrfbCUjZqqe1Pe
         jVDrug2/YNru5OmQ3LcYMMUOPFXI6AJbUx7madmz8SO2JUsaS+H4/d2F4XF91QZk6G
         0/FCZxjRAlM0uF3//TsLN77lSdgAuv7bJW2B0brk05fk1Isbqtqj+jUkAY8q/EZUv6
         TU+xKpTxrVyXr6HZSLiBJFaz0S1P/J1ANwgGzx2W9OItfKZBJLRxGxe6hCubsGoWhU
         AY6btcJQ735GLEGFS9pHN2IIRIw1HhGbzlDF7CtyXHrVGHs83mI6y+qMkciGgStDTu
         fjz5AyWEijx2w==
Date:   Sun, 27 Aug 2023 18:22:44 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 2/3] riscv: dma-mapping: skip invalidation before
 bidirectional DMA
Message-ID: <ZOsj9HROczmyaS2L@xhacker>
References: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230816232336.164413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816232336.164413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:23:35AM +0100, Prabhakar wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
> 
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * No change
> 
> v1->v2
>  * Included RB and ACKs
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index 94614cf61cdd..fc6377a64c8d 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);

The code could be simplified a lot since after this patch, the action
is always "clean".

Thanks
>  		break;
>  	default:
>  		break;
> -- 
> 2.34.1
> 
