Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBD755EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGQJGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD6AE55;
        Mon, 17 Jul 2023 02:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC3B60FB2;
        Mon, 17 Jul 2023 09:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91122C433C7;
        Mon, 17 Jul 2023 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689584766;
        bh=fhM1KduE6ZQDroJeRpiYq4l0t19a4aXckDMswbOdBgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F66K6fjDAf2xcToYsuW06p/Qlv56O4e2lKamtmqt93ze69JvAsAJ+JuIRrcAXJkO1
         t14Han71dq89yGFvFvl5GE3qQYXyErweFYn/u6WyBd5yLUmZVu8P2xxE40KQv6JGNC
         pNIi+u/qQHHwM/M2fDtM8s4jPxnX/tcuKh85Q10MFhegStUR79AhuxbKlabdcnXEd0
         2rr6LSnp9WoJDFtPxnrXIMOQp5Il4KlCOJpesXart2Wg22S0rmMP/yO9SqEZ/JJSkg
         GNonHbdRa2X1lINVJOcKLaKXyyMv3vfqH0+hI6N51ZToxW8dhIKbVmd6iPPzmnFN6x
         NIjUGDhFs8sPg==
Date:   Mon, 17 Jul 2023 10:06:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Explicitly include correct DT includes
Message-ID: <20230717090601.GA7868@willie-the-truck>
References: <20230714174021.4039807-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174021.4039807-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:40:20AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/cpuidle.c | 2 --
>  arch/arm64/kernel/pci.c     | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index d1f68599c29f..f372295207fb 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -9,8 +9,6 @@
>  #include <linux/acpi.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu_pm.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/psci.h>

I don't grok how dropping 'linux/of.h' follows from the commit message.
Is it simply not needed by this file?

Will
