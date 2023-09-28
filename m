Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A727B14E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjI1Ha2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjI1HaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:30:24 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F9E11F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:30:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC4FE40E01AD;
        Thu, 28 Sep 2023 07:30:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IBMkuN1e-nE3; Thu, 28 Sep 2023 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695886213; bh=z4BG31Q1gkVUkJg2uGgLI1FzyDQbxyqhIJweL2kvhrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg9bkgdEIrXwjBRPVaUr8phKBDya5ezmFYUAfqMOiOxBw15uQXoXoTF1QyA755K1Y
         nF00ARrCcYTBD8c4nr7Pv7ls7u+pm9KXKTI20bKtji9HLnQOBWORvFmpALcmYH4fbd
         MLeE719JLewMfhwqOe9JImG8o12rhwStpw5T/Cl1Ula5NTxO75+BNcc9mypBeMAGFp
         STFlYox30G+aANS9f86mYNREtM9Vd05INPRajkyy7cogcJSXWpKep1HYbVpKa1bwoK
         16Ds1Uee2qRN6tjnTmkpazXd+Ht3vF1U8dkPfvJwa1MOF9tl6c8Qazl7W1/n5ujAXv
         Ef2U/gsFTMx/YLPBv4Y9XcxIvwFTbw/Rhc3t7gEACko/IXM/EMoS8Ba70tn55jvSWD
         FRqwvxLyT6M4FbklE3AHidaHbGiF9WdD0X8ay5aSG/WUwKW76ghnNtdKJ/qUniGmrs
         MQ4jqSEyXWYkDWpR9GfveS5xiPEuym0+7+VAqb50lsSTP4wZ8mlyIvPUjbn6mXqofL
         88QkG9WKUBgorFdJLFljXA0Tszas4Va90F4h3lfC0szFKv7qRo4A9eqdigqIsBZEpK
         IJEa8mtAAog4Hh/o8O3l5UUJ5OfkbIkFLQy06hGXYf85zR+OGn1rbnO3PiHg2YmkXJ
         e5Du2TfdXRWPihITiIMSQWCQ=
Received: from nazgul.tnic (cust-west-par-46-193-35-178.cust.wifirst.net [46.193.35.178])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1185340E014B;
        Thu, 28 Sep 2023 07:30:03 +0000 (UTC)
Date:   Thu, 28 Sep 2023 09:30:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <pu_wen@foxmail.com>
Cc:     mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, kim.phillips@amd.com,
        linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/srso: Add SRSO mitigation for Hygon processors
Message-ID: <20230928073022.GAZRUrjgwn50bkYa6J@fat_crate.local>
References: <tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_4A14812842F104E93AA722EC939483CEFF05@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:59:16PM +0800, Pu Wen wrote:
> From: Pu Wen <puwen@hygon.cn>
> 
> Add mitigation for the speculative return stack overflow vulnerability
> which exists on Hygon processors.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/x86/kernel/cpu/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 382d4e6b848d..4e5ffc8b0e46 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1303,7 +1303,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
>  	VULNBL_AMD(0x15, RETBLEED),
>  	VULNBL_AMD(0x16, RETBLEED),
>  	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
> -	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB),
> +	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
>  	VULNBL_AMD(0x19, SRSO),
>  	{}
>  };
> -- 

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
