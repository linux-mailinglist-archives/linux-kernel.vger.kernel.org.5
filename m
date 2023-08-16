Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9677DC05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbjHPIUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbjHPIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:20:02 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383401FFF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:19:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FA8A40E0196;
        Wed, 16 Aug 2023 08:19:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jvc0mp2HUD5o; Wed, 16 Aug 2023 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692173993; bh=EpRE4HAN5/b5FxE5h+A0OkRvmtNN4jX7NTqJevC4RwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOnI3SXdaxSRJFp1bs/wEAGNDFY24V07SIVR/A5Bgi5NQChqp13FPXNIrsTsU3bAT
         Dm84JWncVoere6W+nD63lGUoKy35BxcM9gQOsuR1kosNqZ+Pwzajnr41L47SeutTud
         uGQCm5cbl6mVdwrYKiuaizuxLawynfJZCXyf3Wnv/YZu/ukA0PTjJHAY5w6G5hdzC+
         7fX9jHs45+FNnn+gtBPXilUAUPGdngbE+/m07yLf2yF8oCrAJuTB4kO+9/fhiUcA4Y
         BlrDznMbVfDtBKAJIXmeI7d1Kcmrvg3RFrIwYLNdmKEzGBxL8ye8a/TCVduMiBHZNc
         zxRE7Xh09kBvSWYl+3rypS9lCs5aPEA9q6Tq/SaIm+jXVQqQLWjek1QUo/46MRR4C7
         g1OqgcRxONxmdcPOfCm730iz+C7tyhXEV9imMA3eaXIfd/wo/fBIieU0EWq+4q7OLn
         HCr7HSe8fB6mvSA2o71pO2kPnbLuguGGLpiD/HpYWnUTB9abFTkhiqSORWtaxK2mcn
         geNxvPLeEjRJabltZ/KKDIEf0OSzUwwUzPH+ji5/+VxQaKzNaoPzeKgJTaj+ll86+M
         eHjRbv2t2mUnT4/Ebu6eRRM2J7gfDAt2nQiYdWTZs+23tiXEsISlJvhGNB4BCWfu6J
         GSuXdCav46nUYicVx9JkO8Qs=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72EB340E0185;
        Wed, 16 Aug 2023 08:19:47 +0000 (UTC)
Date:   Wed, 16 Aug 2023 10:19:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>
Subject: Re: [PATCH kernel v5] x86/sev: Do not handle #VC for DR7 read/write
Message-ID: <20230816081942.GBZNyGnk/K+nDuBzsC@fat_crate.local>
References: <20230816022122.981998-1-aik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816022122.981998-1-aik@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:21:22PM +1000, Alexey Kardashevskiy wrote:
> With MSR_AMD64_SEV_DEBUG_SWAP enabled, the guest is not expected to
> receive a #VC for reads or writes of DR7.
> 
> Update the SNP_FEATURES_PRESENT mask with MSR_AMD64_SNP_DEBUG_SWAP so
> an SNP guest doesn't gracefully terminate during SNP feature negotiation
> if MSR_AMD64_SEV_DEBUG_SWAP is enabled.
> 
> Since a guest is not expected to receive a #VC on DR7 accesses when
> MSR_AMD64_SEV_DEBUG_SWAP is enabled, return an error from the #VC
> handler in this situation.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
> 
> The KVM part of DebugSwap went to kvm-x86 tree:
> https://lore.kernel.org/all/169058576410.1024559.1052772292093755719.b4-ty@google.com/
> but it is been suggested that this one can go via TIP:
> https://lore.kernel.org/all/ZGv+Y60qvbjeTY57@google.com/
> I am trying to bribe now by reviewing patches (internally), does this
> work? :) Thanks,

Oh yeah, most definitely! Anyone can bribe me when helping out with
review.

I very much appreciate people helping out with review so thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
