Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC0801FC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjLBXYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:24:01 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD8124;
        Sat,  2 Dec 2023 15:24:07 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 049B240E025E;
        Sat,  2 Dec 2023 23:24:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Niido9d84076; Sat,  2 Dec 2023 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701559440; bh=9MUOeGeZ5B/ijKebEMHCI1M4SgxyUmLcB9iMR+JlMLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMB1Y3tkckvcPzSIMFzmO3QkTWIi54wspB5lmz1p3wTg6sxvgAQFS/nx36pDTM0Sq
         NgyyYA2BJjSs7mKalgZjLnssy9RIcogY/ezUBLtJSnSwvaN+XnU5Q5hoPq6ey5XoNV
         6i90Aks8zWvQzMrvKCE5JQCJaUAOU4vauU5u20R0RY+FOSPtmhNz7S07ruwEpCyljE
         Zb4HbsOKfUmciNg9PdeQk3uLL+uq60AT+D/jnZyFPFOlGc4/9lxSUnjq7/nrc6ngtY
         0knlTxmZsBU3V9L64c5k459EgRJwLOUS5s1LkhThC/cC5hR+QwuT0CTvf6tC2xwiou
         yepw3gnX7/Y6zWZ0dZqtIdVdM/aKXqa0GEY1vGHu4DKt5YznVMOr4f/+IqoEJMgxvP
         FqKfr1f5QsXC4gL42/Xiy15FtLlx/TfRSPZ08FFR8FHMIOGAG9ZQE9lEweuHN39f8x
         DkjCdnOJpfKb0NLaNGgStt710K9S2259FgCEMmkaaHH88Y+snZGFi6BcpkfHXAuwuM
         G+Gr0/GajAaNadrPeOZf03ISMk2hx9VOPR7KTqjZPfUWklUcKDe6raWSXDSZXRxgAS
         4hdDMInA/pVlpCBNIPHhSt1v1VTU4AAmV1i7LX110RdsrPcVsxU+SSFaTt6AF/cTVk
         CfeM1jrzHeYaLK5JmqqRPwG0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05E0D40E024E;
        Sat,  2 Dec 2023 23:23:26 +0000 (UTC)
Date:   Sun, 3 Dec 2023 00:23:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, alex.williamson@redhat.com,
        naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        tony.luck@intel.com, linmiaohe@huawei.com, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, shiju.jose@huawei.com,
        bhelgaas@google.com, pabeni@redhat.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, anuaggarwal@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, mochs@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-edac@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mm: Change ghes code to allow poison of
 non-struct pfn
Message-ID: <20231202232319.GAZWu8Z6gsLp1kI5Dw@fat_crate.local>
References: <20231123003513.24292-1-ankita@nvidia.com>
 <20231123003513.24292-4-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123003513.24292-4-ankita@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:05:11AM +0530, ankita@nvidia.com wrote:
> -	pfn = PHYS_PFN(physical_addr);
> -	if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) {
> -		pr_warn_ratelimited(FW_WARN GHES_PFX
> -		"Invalid address in generic error data: %#llx\n",
> -		physical_addr);
> -		return false;
> -	}

You don't just remove a pfn valid test just because your weird device
can't stomach it - you extend it, like

  3ad6fd77a2d6 ("x86/sgx: Add check for SGX pages to ghes_do_memory_failure()")

did, for example.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
