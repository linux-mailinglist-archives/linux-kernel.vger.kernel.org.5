Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94697CA866
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjJPMrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjJPMrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:47:19 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8AEAD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:47:17 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C99D40E01B1;
        Mon, 16 Oct 2023 12:47:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QRweq4ucw-HH; Mon, 16 Oct 2023 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697460432; bh=Dy4w6gz5/yRefeJFNm4FDVjetCCa1G9LBCOX6qE1YP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABFdKjKFDPo4wWdUeKgyAWPvyzsnPe1LFVP9BZ710Hgo6F18GJ3TpzbnAPRzhLkbP
         xGYQn+IHGcZM/VhgvCi+fPYRdF6eBHSjsnPsP6B2PlVynEY+l2CGHLQ1lQ5n3BCIFI
         7ag7b7up9rm6y/GUBFi9lUiURqjp4AJPsbgLP5Bkhi8r9G77ASnqufA88yX3M5L68W
         02DBkHeD0Sw4lMQbDIiH2MWyo+Fh4L/CE3f3MwTn9wqUaoDwDzCFedH4Cgge1gn5nY
         0UDa1+R6ac9hRGiby3xuNmw8Q08EsEEiCCi8XatbvjInMRa9qCtV9kuET0jIJw3vTG
         5w+mdkzJXiV2CMDL6wg7/abenqK/tbiXQSrjlxuD5RV1sYRSsA6khemST1LB2gipJ1
         2HMp56AcQguemMrxTVcXGsTYLacAp9wnchGNcXpN+cJwqgWgXlWqbKcLkbvCSyv3Ad
         2x4amtv5Wgxpm5g7B2lEiAjwg1lH2e5cXMHaIp/D6XFafKWTyojdeTg7ej1QaeZPgA
         igIFnhOyy5P9iQLq3omdCGqN2rO26yiHs70m3ggPG4kSN4TI4iYF2uqVab3OCRAoA3
         f34qG3eB1NcPVnrGyF8vkXaveK5OSuF2Wloy2aXe+Hno/pCmKL0nd1U+H2eB3ZjwQg
         ioQqd1rW92k8M22BvEFVPL+U=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2895840E014B;
        Mon, 16 Oct 2023 12:46:59 +0000 (UTC)
Date:   Mon, 16 Oct 2023 14:46:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231016124654.GDZS0wvqJlsf+iVAeu@fat_crate.local>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
 <20231011220325.5uje4xnfxuccumm7@treble>
 <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
 <ZS0Lfy8LUdRG3ca0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS0Lfy8LUdRG3ca0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:07:59PM +0200, Ingo Molnar wrote:
> Unless someone like Linus shuts down this effort with a NAK, this kind of 
> harmonization would be welcome IMHO:

Harmonization being done for whom?

Because I doubt users read Kconfig names. So you must be wanting it for
us, who do stare at that code.

Which brings me to my initial question from uptread:

"What does the same namespace give you? So you see in the code a bunch
of ifdeffery and some or all of them have CONFIG_MITIGATION_ prepended.
To me it doesn't matter whether they're mitigations or not - it is just
the next Kconfig symbol."

IOW, I don't see the particular reason for having those namespaced. But
since you and Josh care so much and I don't - not that much :-) - and
I definitely won't be doing the work, feel free.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
