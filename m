Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5177EA33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbjHPT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346040AbjHPT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:58:17 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB722D51;
        Wed, 16 Aug 2023 12:58:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1035F40E0193;
        Wed, 16 Aug 2023 19:57:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mrsFoKu8Jvqu; Wed, 16 Aug 2023 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692215875; bh=414IKdRjGea6+cUaxcSXEurk5XXXdwdwi/jML1NBsFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BE7/ZpGKp6wlxKi8EPaKQrBFK1O+9/Y814IHWpPTpFfB0PD9cVB6xTvtZTM3qf53p
         KRpiNWcok8ZwpXzGuS7l+W+X6xqXouvY4WrRfzAzEO0zbQYJmTbgz0J8SHumZgVfOk
         QFzBnSmUovcrgTFERhnEjYm4MxUlHcLMZSdCsjWz1JJlIYC/tsdfT1zJYu2PRYW61x
         Qoxh4agFSXGvLZXNePTvTGCDRUHMflOFOP1nlITK9lvE6lfq+dhvuYV6Ws1Wn28L3a
         +STeNxaX/VbwNV8tJBu/BG++t9Dl2PIByTFacDCGSVDh/qD6uTBcvTYdHwJATAiN/7
         uE6CkJl6wHp0u205Z2sLLwVDrmRau4C+AJqjbLj2uh6kOn8+7yGj4RjHHE5BgnEMrR
         1rt31KSAm33FR/07Rxm1kaQxUxL2x7k+KXSLyz1TdFJ+bMSF4yD6rxQ1ekFNEob2bI
         v43KaYYKHDh3Q6HpJze4oG20vgcUPasOBQ0r/xrS+KhyjUVasQdBPGbFJAU/QSV6GG
         RfFoRf1KL57+9Ygu/79wE58ATTnsiYTqEudrh853DfaFz7nrK22Coc1hwMCccOQ4e3
         72ynBGMfMkNme6+pd+39oScHdb/zKFu14e61fptpekdMVQEo/IzsC3AZPxJU/8x1q1
         l1TkLS7RitMsbyDTffIYKMag=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84F4D40E0196;
        Wed, 16 Aug 2023 19:57:50 +0000 (UTC)
Date:   Wed, 16 Aug 2023 21:57:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816195746.GSZN0qOhMh29qY6Loz@fat_crate.local>
References: <20230814121148.842775684@infradead.org>
 <169217251663.27769.14430226618442726061.tip-bot2@tip-bot2>
 <20230816185839.GA3843691@dev-arch.thelio-3990X>
 <20230816192413.GPZN0iXRRpOGKVMm47@fat_crate.local>
 <20230816193011.GA855169@dev-arch.thelio-3990X>
 <20230816194238.GRZN0mrvQ5Xg3qgsuY@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816194238.GRZN0mrvQ5Xg3qgsuY@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

now I know what the problem was: I fixed it up but then the rebasing
didn't pick it up when it came to

"x86/cpu: Rename srso_(.*)_alias to srso_alias_\1"

so I have to explicitly select that one and fix it up.

Hohumm, nasty.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
