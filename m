Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB657A127A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjIOAoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIOAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:44:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619326B8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 17:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1694738641;
        bh=A2yKheXXYeVxgUYqKY0JwuarOyyrLHHqN46l251F9L0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KLdOsoMcXyPwJu7oy1hyRJvAzVA4MSQG8jN/N0hWl2RA8KGiWWCHGx5+mltwGIety
         4TFaQCSjeOwQidv7aFM+mkBpP6zgOTHuqrOvE+5naIiZtKjHpKv7BSEpXQg9NnmzC8
         F1IFQGGelU17mPoCRvPX+kyIZ6J3bRuHv802PzGro/RYpsiGuDes9t9A2Dw1cKEzM2
         UfZ4FE4OFnrBh3BbRtCor//9DmNHmssOnMN/7eUe02mJD3qM+IyxXmFu1d26lLKwI6
         Pwb7InIsfO2UK5xK33EVSk9iZd/4bQCjOQJQnG11F/Hj6nBlipabBAmi/T1H9D56oK
         vuJXqqMRR6ZBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmwRj26nkz4x3D;
        Fri, 15 Sep 2023 10:44:01 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/82xx: Select FSL_SOC
In-Reply-To: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
References: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
Date:   Fri, 15 Sep 2023 10:43:57 +1000
Message-ID: <87led86zaq.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> It used to be impossible to select CONFIG_CPM2 without selecting
> CONFIG_FSL_SOC at the same time because CONFIG_CPM2 was dependent
> on CONFIG_8260 and CONFIG_8260 was selecting CONFIG_FSL_SOC.
>
> But after commit eb5aa2137275 ("powerpc/82xx: Remove CONFIG_8260
> and CONFIG_8272") CONFIG_CPM2 depends on CONFIG_MPC82xx instead
                                           ^
                                           CONFIG_PPC_82xx

All the references to CONFIG_MPC82xx should be CONFIG_PPC_82xx right?
I can update when applying.

cheers


> but CONFIG_MPC82xx doesn't directly selects CONFIG_FSL_SOC.
>
> Fix it by forcing CONFIG_MPC82xx to select CONFIG_FSL_SOC just
> like already done by MPC8xx, MPC512x, MPC83xx, PPC_86xx.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: eb5aa2137275 ("powerpc/82xx: Remove CONFIG_8260 and CONFIG_8272")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/82xx/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
> index d9f1a2a83158..1824536cf6f2 100644
> --- a/arch/powerpc/platforms/82xx/Kconfig
> +++ b/arch/powerpc/platforms/82xx/Kconfig
> @@ -2,6 +2,7 @@
>  menuconfig PPC_82xx
>  	bool "82xx-based boards (PQ II)"
>  	depends on PPC_BOOK3S_32
> +	select FSL_SOC
>  
>  if PPC_82xx
>  
> @@ -9,7 +10,6 @@ config EP8248E
>  	bool "Embedded Planet EP8248E (a.k.a. CWH-PPC-8248N-VE)"
>  	select CPM2
>  	select PPC_INDIRECT_PCI if PCI
> -	select FSL_SOC
>  	select PHYLIB if NETDEVICES
>  	select MDIO_BITBANG if PHYLIB
>  	help
> @@ -22,7 +22,6 @@ config MGCOGE
>  	bool "Keymile MGCOGE"
>  	select CPM2
>  	select PPC_INDIRECT_PCI if PCI
> -	select FSL_SOC
>  	help
>  	  This enables support for the Keymile MGCOGE board.
>  
> -- 
> 2.41.0
