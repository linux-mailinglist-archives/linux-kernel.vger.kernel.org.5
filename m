Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6337A0E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbjINTa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbjINTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:30:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7126B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=AevdVbEeE/ZSF01htVC+Vg2ivg78mjd0b33rpJwaKrA=; b=l9JgvmXs7r6YikbpgfTBgQ47RP
        cqt2jgiF3Ob76e2yBQU1LocTVzibO2vihmOugHJiq75Lt0osHrKLIqZ0YKut50tR9IndOLFQEremb
        c4AlWRcGWob80bbmcmdUjyJyAqKvADJGLU9858haFK6TZ94NbMSowgwzZzkcPC+St7vYf7T/C8sWa
        iHBntoZc8t/yeAZyerpeHTFeyosWEL9/eRse1MRXSXjvTvNvQ4Zh3JjiW88U9ZquUo5fGcLteHrjD
        XrHXeaUPOnR8DiuE+UqnmXJ5Wb9EJZsTi8lEdE+rrdSTu4E90ZebCkYsIuWbugrzn2p4iXdyWl3pA
        R6bAcapQ==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgs2a-009ANC-2s;
        Thu, 14 Sep 2023 19:30:16 +0000
Message-ID: <624f326b-919a-43a8-983d-63977cabd443@infradead.org>
Date:   Thu, 14 Sep 2023 12:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/82xx: Select FSL_SOC
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 08:23, Christophe Leroy wrote:
> It used to be impossible to select CONFIG_CPM2 without selecting
> CONFIG_FSL_SOC at the same time because CONFIG_CPM2 was dependent
> on CONFIG_8260 and CONFIG_8260 was selecting CONFIG_FSL_SOC.
> 
> But after commit eb5aa2137275 ("powerpc/82xx: Remove CONFIG_8260
> and CONFIG_8272") CONFIG_CPM2 depends on CONFIG_MPC82xx instead
> but CONFIG_MPC82xx doesn't directly selects CONFIG_FSL_SOC.
> 
> Fix it by forcing CONFIG_MPC82xx to select CONFIG_FSL_SOC just
> like already done by MPC8xx, MPC512x, MPC83xx, PPC_86xx.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: eb5aa2137275 ("powerpc/82xx: Remove CONFIG_8260 and CONFIG_8272")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for tracking this down.

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

-- 
~Randy
