Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0267BF6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjJJJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:13:06 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8093;
        Tue, 10 Oct 2023 02:13:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0420540E01A5;
        Tue, 10 Oct 2023 09:13:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zIxRtCHyP9KY; Tue, 10 Oct 2023 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696929177; bh=r19Pofs5YPEJUqm6xMsNDsii8MPrvf//VmD3Yjpm95U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dm3EQFpfNtri1vigfMJccC2yNJbZT6vhdQioD8q3IYIze751eDuMqvVDiZ+MrPpPg
         WkFFqZ1ghjebGRdhZzgSssger6VJDsuV3ITVEludS7a6b0/yxKkl+NvlIF3cwa9CPv
         OrmCnjFJw85mimCLrpzqEs5oyGMsBQMpWDARfBYOD+M6tPtf1DObiYYG+Lkke6LDhD
         pskfIp34JLZokB/2P3mBwzWzFeiWUNIXAlPsfFvztCOasxL1oW084EDtJHeL73EfjF
         GiDtM02o2bsB2D4CDz7LlKQQzmIpbcS/ZYCkWR8KF5RbLANUvPemWEytmIse8+X7qa
         aJeAZ9jIHp7nb8Nd2pNcGRB7OXOmfAFzslhpdJd457SGlWPLuKg9Z8rWOyCWdKja6z
         zG2FrWlPABRvCjw3IRNp/mKopIWLRtzpuccoJIAuEQK52OcJ44LKvL3opxPqVDx1Tj
         8vElxElD/Xl+nZO2y56417G37ie1sOlSodtgxW9asZJOKTUt6BYOB/5Y2pXw4tmUPp
         FtOgkBYdcwpl38XsbuYU8loqJqPjUoAIAzbdWMPWnpaIDgprFcvV+/C/BV1ND/r1Ku
         AEVRVQKDpltaQXwe5m7KLGQ8jSjcBEydWvToyWCuLlOm1KmQGEzV62oqK4ITubTB9K
         rCydKoJLthx4FhKYXMBS3Tao=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2137E40E01AA;
        Tue, 10 Oct 2023 09:12:41 +0000 (UTC)
Date:   Tue, 10 Oct 2023 11:12:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Disable KASAN on text_poke_early() in
 apply_alternatives()
Message-ID: <20231010091235.GFZSUVgzTetLj2K+s8@fat_crate.local>
References: <20231010053716.2481-1-kirill.shutemov@linux.intel.com>
 <20231010081938.GBZSUJGlSvEkFIDnES@fat_crate.local>
 <20231010084041.ut5sshyrofh27yyx@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010084041.ut5sshyrofh27yyx@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:40:41AM +0300, Kirill A. Shutemov wrote:
> __VIRTUAL_MASK_SHIFT used in many places. I don't think it is good idea to
> give up on patching completely.

Have you even looked at boot_cpu_has()'s asm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
