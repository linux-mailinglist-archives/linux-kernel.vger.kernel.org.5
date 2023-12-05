Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43EC8057CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbjLEOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345572AbjLEOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:46:28 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B33EAF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:46:34 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0EDAA40E0173;
        Tue,  5 Dec 2023 14:46:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CPXgmXOtt_gg; Tue,  5 Dec 2023 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701787589; bh=BJbP9AsQihwVtDIItX/UOvISEkEVBiqOOo4DUb6Mu3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXMmwLlT/R1Mnw2SWkkaYkB/H8/uwWKJxOchCK1dZk3odSjYfMs6VVlL/CxnFJF9O
         Rh/EW53DzPtLyJuPGgp7rPHNsIiwg+xKvIB571lvrPGUaFjzDT6xdFFkVkbIva5AQ3
         4abzcwSlrHrgjLyz1pCf/2soYpncvltQH6UE1BUohGcS4vqvd6YQ0Fuwtg/rtokFSG
         oPSCBySqJwXaqqa0UJTuzPzeT7ZEOAH6kmspKIIuFLVG33+yOtzvlA6xZidXC+3PJ9
         4c6GjvqecsJpZBrkbrS6TsStYMbsmlbQbVB/QRAlgNsBufL1RxQ5PQDDF4st+RrEgb
         UNZIrRnjYQONzXPWrESVs0bwS/ZpYrxqmstbVaW+Ds/ltN+ufPSpeOtgR4yPVxE/nE
         Wjo4E3eBVYP3azBo4F+4b+TduAGWT6uf/aRN4bIIalNfvLCR2B8noWDpzq5dt7WUWj
         K1mihZRfFU9C8HmGZFRqq1/sa072qvgNoq6Pqc2UowadI7MbgpnEAfqZYS23SmSY+U
         D5I0h5h4ysrzwehimB44hJR1HPW+l2e8eG87PWTO0tud4IULMik/wkWz99FXm8s2C5
         qDBfCD1WiYLijjudt8C5/OisdcRQs2ij+rS2Z39mx9bExVoEkl4O9i+sTJfJnczcwN
         JI5Ll8aB7UwekKShVumZfeGY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31D9440E014B;
        Tue,  5 Dec 2023 14:46:20 +0000 (UTC)
Date:   Tue, 5 Dec 2023 15:46:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
Message-ID: <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:37:38PM +0300, Kirill A. Shutemov wrote:
> The SEV code uses cc_platform_has() checks to detect the SEV flavor.
> However, these checks can sometimes produce false positives depending on
> the context.
> 
> For example, sev_map_percpu_data() uses CC_ATTR_GUEST_MEM_ENCRYPT to
> detect SEV guest, but this check will also pass for TDX guests.

Well, a function prefixed with "sev_" should check cc_vendor first...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
