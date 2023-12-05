Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C13805E22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjLESwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:52:53 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA1BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:52:59 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 705DA40E01AD;
        Tue,  5 Dec 2023 18:52:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J6-BrYYixBWq; Tue,  5 Dec 2023 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701802375; bh=COpgCkikT3z+JRnd2ns06QRSDfXH8wlW9tuJ0ai1Q54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2LDMDZgpAK8mc+Y+JnHsQLOgod5dbCCOkwTjSoU5GWU4Iiw7QLIv5P7l2KV35keA
         vnm9DUxHxKPU9ShsZWSOIC8qIM1fAc8jnxAdwmqRSKibWVLmZfCLs+xeeNmT8RNXFy
         ycLZzX25TjUGQwyfSulbzjCZR1OkWG0nraW9vMK0JOffoVriyuwYKW7xO1aU0AAJjO
         7DZkXnUudBEevfOxa+WfreQK5I9EV5+x5HgH0PPQZsgcI/wTUc2iTpUFRECJ4KLwpu
         eizRrxra395oxqFTGnHjQ3tOchDdwBGt2wpA/UMzcZSAjjlhbv+tJrkhqy90pYcIe3
         vRbv5dIeKEjFteKEnQD/jzEEWJ/FVgXtwoj7cid8s3I0+TKFYCcOKJh4t8Lqty6ZYa
         +qfIsFWWI283HyQmz1veW7nkZGAdQ5ZXgixBhMJoAhzp+AHSytp/Lkvf3/5yT4Kmfm
         V2YC95zRco0aUNJYZ3dus+xX2GBd6Zc+F2Umt89CkHpAHY0OKxqbazLsdq/9CPZiv9
         wUpY4O2p7YvCq+/IFhV/wqNdb2fqC9XNkEFerRrUtskr8OZ+k5E7K8N+UZoGCtFwjD
         1MeJDBGlLRY2/Z3WgD2Lfz5FRWo/nbnZMm9SaZvvBljtFdksmno2pLRur7UE0egyps
         SyeMIpyx1zo6VoeiwAqxroHs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7823440E0239;
        Tue,  5 Dec 2023 18:52:46 +0000 (UTC)
Date:   Tue, 5 Dec 2023 19:52:41 +0100
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
Message-ID: <20231205185241.GGZW9xeTtiG6sORMTr@fat_crate.local>
References: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
 <20231205144619.GCZW83uzAomKmupn7j@fat_crate.local>
 <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
 <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
 <20231205172436.GFZW9c1EaCaguGhglb@fat_crate.local>
 <20231205180813.phbxg5jdumfovshz@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205180813.phbxg5jdumfovshz@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:08:13PM +0300, Kirill A. Shutemov wrote:
> It is here and it is broken.

It is not broken - it is getting improved as we go.

> I think legitimate use case for cc_platfrom_has() is to check platform
> capability, not specific implementation.

Yes, and I already agreed that it is used the wrong way there.

> And we have much more mature infrastructure around X86_FEATURE_ comparing
> to CC_ATRR_. If we can use it, we should.

Mature, shmature. X86_FEATURE_ has its own issues - don't even get me
started on it. You want it because you use TDX_GUEST and it works fine
for you. Yes, we can always do X86_FEATURE_ but X86_FEATURE_ doesn't
belong in arch-agnostic code. cc_platform_has() does, OTOH.

So yes, we will fix your issue, no worries. I'm figuring out the
details as we speak.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
