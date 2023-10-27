Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7C7DA1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbjJ0UXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjJ0UXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:23:45 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C01B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:23:43 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C36440E0173;
        Fri, 27 Oct 2023 20:23:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OOi0pDPZ906o; Fri, 27 Oct 2023 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698438219; bh=bt2XO54jcUHdSU+VXrFxeIQ09PMCzvAt99tlvZFaP+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dbi9ISdkwdd3GsyD/+Dgv40hnyA2+y7uuZfiP1TQuoYGmSrdNrTMjFPw51RZtvk3A
         M8NcIWoSiZUVyoni5u+Fvzni+w6b5IyvjCEvIhP3l2w9hTnp/qzM5EXETvEYK3b2Y2
         JhDC32udYHsZw49EGahLize2HkSHNacLcwNQmCBLaVA9zuCrBkvHNn1aWhcWgwo3nK
         +hI1i1KjLBN5eWo5Zaj6UDKvZKtXTL9Kv1o1oFumqpMRwNS2WPnlcrjDf99SlgTzAk
         Ih/u6JXpsjOErF9oG6tmmGxAQof9kMyTPBBt3ljGTbAuaX/82OdZMvfmtqq2mkBheq
         5zeRqMlz4B+XCc07oQveqNsD29IbtzGXHLQqK6QFU5Eg4M9v8wHrE/8uRhg+hQY4gV
         PUtUCqOt0Yq2qXtJeljNF6g/BJNedOSdUbzhwzfv4TJ2EyDsNfMKSClCGHoSVOklMv
         K3n1ULWaUxQmZMVrS7V5PIc9tZBgnPigV0/jZVHZGGB+lXyEapHk5hjSbct49OTmOq
         DgBWetvd6aIFDu2jXWivmBhJd1LamrcUitlNjJ+Hc8bbyYOkLyUiAZume4dzZXRyKO
         gA+7WxH2VddZunhoHuA3IbiPcrHts2eU++z/kCRUOh2K01SUvJaCjR/JYBpf3OzlXE
         dWB1CYJtttLw4PGToeESwHXs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB9C640E0171;
        Fri, 27 Oct 2023 20:23:33 +0000 (UTC)
Date:   Fri, 27 Oct 2023 22:23:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20231027202328.GTZTwcQIh8wFyZUtQd@fat_crate.local>
References: <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
 <20231027185641.GE26550@noisy.programming.kicks-ass.net>
 <20231027191633.GRZTwMkaiW1nyvnzzO@fat_crate.local>
 <20231027192907.GSZTwPg8v7NF6+Zn0w@fat_crate.local>
 <3c56e807-945c-4996-9ac1-3205a23248ab@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c56e807-945c-4996-9ac1-3205a23248ab@citrix.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:09:05PM +0100, Andrew Cooper wrote:
> There are other non-serialising MSRs on AMD CPUs, including the FS/GS
> base MSRs on more modern parts which is enumerated in 8000_0021.eax[1].
>=20
> So there isn't a boolean "MSRs need fencing, yes/no".=C2=A0

Well, I was implying that "MSRs need fencing" refers to this particular
use case where weak_wrmsr_fence() is used - IA32_TSC_DEADLINE and X2APIC
MSRs.

So the feature bit should be named something more specific:

	X86_FEATURE_APIC_TSC_MSRS_NEED_FENCING

or so.

If we have to do something for the other case, yes, we will have to
either generalize this or add yet another flag.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
