Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208C97FF919
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346725AbjK3SKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjK3SKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:10:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C5D50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:10:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AE6C433C8;
        Thu, 30 Nov 2023 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701367853;
        bh=V6uKp5swnL/aySQKGTAEm30joG3gXQBj6L1/dfwNL+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q000qmGaH/Ep9K11XVDfrz/oFCNtkM1gYg0VsicONnglf/BybLrUl/DQ4THxPlhF/
         eDKU2XS1JJoM5pO3rlyWtA6a/bVX2awA/Y89oFy1tvijwP1K2Mb0lOv5431Tg1eAjb
         1B1K0Tl1b79xK8IpamWoxCs22+2NhVVAdERMt5NRfB6L9N3AosN1WtIzUW+U2d3flu
         UNm5tW4b/u/fqJ1dwa4u3bFUET/aLfl0ZzE4O1FU2UbD5d5WRMoZt6IPoWsKZDA2KX
         pp33cB50t7BkQluvmXjoSP7QIPZVcyEmCYtKAZ8eyjmAR5qfGOskVprmZWgn5UM6aS
         6l6SrhgOB839Q==
Date:   Thu, 30 Nov 2023 11:10:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231130181051.GA3357088@dev-arch.thelio-3990X>
References: <20231130120552.6735-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130120552.6735-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:05:52PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Having KASLR enabled makes debugging a kernel completely useless because
> virtual addresses are not stable, leading to people poking at kernel
> internals to have to go and rebuild with RANDOMIZE_BASE=off.
> 
> Just disable it on debugging builds where it is not needed anyway.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

I know Peter pointed out that there is a runtime switch for this, which
should make this patch obsolete but in case there is more reasons needed
for why this might be a bad idea, most distribution configurations have
CONFIG_DEBUG_KERNEL enabled because CONFIG_EXPERT selects it:

archlinux/x86_64.config:CONFIG_DEBUG_KERNEL=y
debian/amd64.config:CONFIG_DEBUG_KERNEL=y
fedora/x86_64.config:CONFIG_DEBUG_KERNEL=y
opensuse/x86_64.config:CONFIG_DEBUG_KERNEL=y

> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c456c9b1fc7c..da94354b1b75 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2159,7 +2159,7 @@ config RELOCATABLE
>  
>  config RANDOMIZE_BASE
>  	bool "Randomize the address of the kernel image (KASLR)"
> -	depends on RELOCATABLE
> +	depends on RELOCATABLE && !DEBUG_KERNEL
>  	default y
>  	help
>  	  In support of Kernel Address Space Layout Randomization (KASLR),
> -- 
> 2.42.0.rc0.25.ga82fb66fed25
> 
