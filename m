Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D677B959
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjHNNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHNNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:02:45 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70DE5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:02:44 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87D4240E0195;
        Mon, 14 Aug 2023 13:02:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t08Q_LIXX9Ds; Mon, 14 Aug 2023 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692018160; bh=BOZXSqx31InDKbXTf3s2cfMjyRvzBuAxEmuj9h+XgL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXL8GPmFMa/DAqlmEECZDAtEy9PxdZHlc0GQvhYq5DrrcfMstSvMOhT2ctKZpugg5
         LUvMz1CP5Zu+JBfBivSeuxJAXwf+oQ+OsPEwyqjApgQ6ukEy5+q3mfKvVlwuaWXchJ
         KJvFngZY2UPo29mgFOZS6uK7vTl6dzeaMzV8iULHkSBxa26V/UZskRCMtxVrdhvtSU
         LSRa4eBqAp9pBNx6q8oHbrM9xrq+K25JGQcSIAvPFBU4d8zI5uZCWyMkQvqbtJsdAr
         WX+3jMMDlsgt2QHsossHMJfNngCsNt38sR2KwI+DGrLIgWwwHmid0vHojrdkjfaJRt
         MWOuKoX4rsl671PMqbVRWFwPtQaLgCfMPNyHmKqvP+l0bF5d6dFmXwLjtV2esZGdo8
         a6JOZi3mgKZePON8Y1yGJY72gSmijtr4gDEM1UFX+gKL58+5e9l1LeXwqefn4gWKDZ
         3+4WIvfpBKY5xVyGi9ZhQZf9bz1IM7VZNmMTDGvgO5wVufSrX1A0nuT6Yfoqf3zgEy
         ZM/7cEzsF0QYUNRnAVYhR130obsHyEKL85bNNSBcI6SA6Y5kg9y/4duSzv0p8z4W3D
         UvxqAH0AsgSFXPmkqgEZeIuth97VfngP/ag5MDoYVS2icxh1+pYXP0m1TiaWSYjjhQ
         KIJENJzE+DVjMe0r1OGQPfLk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57D5D40E0140;
        Mon, 14 Aug 2023 13:02:32 +0000 (UTC)
Date:   Mon, 14 Aug 2023 15:02:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230814130231.GDZNol588M1vUDIK6a@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814121148.842775684@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:44:31PM +0200, Peter Zijlstra wrote:
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1034,6 +1034,7 @@ static void __init retbleed_select_mitig
>  	case RETBLEED_MITIGATION_UNRET:
>  		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
>  		setup_force_cpu_cap(X86_FEATURE_UNRET);
> +		x86_return_thunk = zen_return_thunk;
>  
>  		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>  		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> @@ -2451,10 +2452,13 @@ static void __init srso_select_mitigatio

Note to self: When applying, add a comment that srso_select_mitigation()
depends on and must run after retbleed_select_mitigation().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
