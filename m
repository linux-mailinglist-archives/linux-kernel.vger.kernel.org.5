Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769DE75192C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjGMG4e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 02:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjGMG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:56:30 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC871BFA;
        Wed, 12 Jul 2023 23:56:28 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qJqFU-000teD-9Z; Thu, 13 Jul 2023 08:56:24 +0200
Received: from p57bd9f0d.dip0.t-ipconnect.de ([87.189.159.13] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qJqFT-001aGv-Up; Thu, 13 Jul 2023 08:56:24 +0200
Message-ID: <787c97736d68dcb6968efc67d6a242b46ab74cf9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: hd64461: fix virq offsets
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jul 2023 08:56:22 +0200
In-Reply-To: <20230710233132.69734-1-contact@artur-rojek.eu>
References: <20230710233132.69734-1-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.13
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-11 at 01:31 +0200, Artur Rojek wrote:
> A recent change to start counting SuperH IRQ #s from 16 breaks support
> for the Hitachi HD64461 companion chip.
> 
> Move the offchip IRQ base and HD64461 IRQ # by 16 in order to
> accommodate for the new virq numbering rules.
> 
> Fixes: a8ac2961148e ("sh: Avoid using IRQ0 on SH3 and SH4")
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> v2: Make the IRQ base offset an explicit (64 + 16), as per review.
> 
>  arch/sh/cchips/Kconfig        | 4 ++--
>  arch/sh/include/asm/hd64461.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/cchips/Kconfig b/arch/sh/cchips/Kconfig
> index efde2edb5627..9659a0bc58de 100644
> --- a/arch/sh/cchips/Kconfig
> +++ b/arch/sh/cchips/Kconfig
> @@ -29,9 +29,9 @@ endchoice
>  config HD64461_IRQ
>  	int "HD64461 IRQ"
>  	depends on HD64461
> -	default "36"
> +	default "52"
>  	help
> -	  The default setting of the HD64461 IRQ is 36.
> +	  The default setting of the HD64461 IRQ is 52.
>  
>  	  Do not change this unless you know what you are doing.
>  
> diff --git a/arch/sh/include/asm/hd64461.h b/arch/sh/include/asm/hd64461.h
> index afb24cb034b1..d2c485fa333b 100644
> --- a/arch/sh/include/asm/hd64461.h
> +++ b/arch/sh/include/asm/hd64461.h
> @@ -229,7 +229,7 @@
>  #define	HD64461_NIMR		HD64461_IO_OFFSET(0x5002)
>  
>  #define	HD64461_IRQBASE		OFFCHIP_IRQ_BASE
> -#define	OFFCHIP_IRQ_BASE	64
> +#define	OFFCHIP_IRQ_BASE	(64 + 16)
>  #define	HD64461_IRQ_NUM		16
>  
>  #define	HD64461_IRQ_UART	(HD64461_IRQBASE+5)

Applied to my for-linus branch.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
