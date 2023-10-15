Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697BC7C99B2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJOPOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjJOPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:06:37 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02CCC5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:06:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5F67F40E01B2;
        Sun, 15 Oct 2023 15:06:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AoEmXokmbFbP; Sun, 15 Oct 2023 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697382391; bh=Ip7XgyxHYXg03CzEoaNp+cdH9vINoRPmBRHvt6lKUpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vi4DHQUGNdfdCUOJEs8CyZ+onvO3oyJUm2sAMWvCu2l5zkuRK8eODfWVaPCWY4Stu
         MPLBsL7VR8mFykiibGUiswFEyCWL5lOnzLZh+TNDqIkKEClGWa6HahRCLVid2NsyTx
         K6XEQN9U3HFxbTJAWnP41hWJJ8L6Dh+bvKMoxlSch+Rw5oM/2xN0NXP9ZVUQ9W5yr0
         4bhO1E0TZr8UvKKC5hGIH4UlfFkPwCZDJLNC7IcUsn0ZnkznEMuAyjbTPoc6dvPM8g
         9fGCgSHk8cngiGmZxqXX6Zb8ArzKD/XFaoQvVZJgGrbf1UGLvtDUzgT4V4RVCfmBdc
         8zffSx7cAWDuGRkTTflDHCOsxx/0Db1qoCtOw6LyXBVcuM9fYqWINrbyUWYqglm8jW
         pagzDf9ocR6E58qGwEyFudQS1qF4JAi2I5Fp2pN+98n5mzlS5BBqKuLPx/vcWlVT4r
         3t8bCWc5R2PrskFAVB6UV2Zvw8f+O4iiCjCB7RlLGe/lQPtlZgLQGZfWUD0qx1myWn
         rT0rG6NvzofZ5Wy0ZmRBq3PTuQKKJmlba7A51rRI+WIO/NOKuAL5C7T7j7dddG6NEG
         MtmlPNxYyn1wgdLqLgYf0TLAToSF0AlZrNIytug8/6zlN02HSF/9uJqKrDeBz1s0j4
         tVj0n+5MOs6kduBJCkvb9iDQ=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70B3D40E014B;
        Sun, 15 Oct 2023 15:06:20 +0000 (UTC)
Date:   Sun, 15 Oct 2023 17:06:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231015150615.GAZSv/59aIrSnprCKg@fat_crate.local>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
 <20231011220325.5uje4xnfxuccumm7@treble>
 <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
 <20231012164814.oc3r3sovsfrldpop@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012164814.oc3r3sovsfrldpop@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:48:14AM -0700, Josh Poimboeuf wrote:
> It adds clarity by making the options more self-documenting.

Why would you want to highlight mitigation-specific Kconfig options? You
grep for the symbol and you find what it is.

Why do the mitigation options need to self-document at all?

> For users who care about such things it makes it easier to identify
> which options they need to enable or disable.  And it makes it clearer
> what those options do without having to go read the docs.

Sorry, if I see CONFIG_MITIGATE_X and CONFIG_X, I still wanna go see
what X is.  And we enable the defaults for users - they don't really
need to read the docs.

> For developers it helps code readability: "ah, this nasty code is for a
> side channel mitigation".  Also it makes it easier to grep for.

It doesn't matter - Kconfig options are Kconfig options. We grep
regardless.

> Right, but we have a global option for that.  I was wondering if anybody
> actually uses the individual options (though I agree with Linus they
> should exist to help with code readability).

Read Linus' mail - there is some merit to having separate options.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
