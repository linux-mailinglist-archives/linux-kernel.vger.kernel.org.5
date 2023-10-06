Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502267BB497
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjJFJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJFJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:54:31 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B42D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:54:30 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5582B40E01AA;
        Fri,  6 Oct 2023 09:54:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VJ2XSBfofAFa; Fri,  6 Oct 2023 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696586066; bh=74yryaFy6GR9gkSgri8u4M2YlxggvHNVlh6lXHNM4Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfuoKUli0MibO8wb5xJd98B43AlKMiQDmFfLI11QRJ+YUBKs5dIZVdmV6xLhjxABW
         TvVkN5WLmH4+5EIzzDg2p7heXzx4oVLGWOsTA3GE/YPpkcH1KDtFfL63ni9hCoLZTz
         zQqJkyzatyEoiGECFmJzuzpkCXvnw1nWthzMZmUgl0VgIqJAbMjH38sP/ee0gQf2ET
         jqsefM/+PGcQ0cP6bVOLK+h6vdCvO7/jbQN1Ts97hvO1LTyKUBWmJ+ZdS94JgUBHIn
         K+GrKKZWHM5YUqaS1bvZa0LiGYpiw+WKIoyTy76AzcXwPaXeNVmoj2RoIEiuQuJaPu
         n7Pv4qYPcgMDGh0zhQhcv0/8lx/5+79OVjzVlVhi9Ilfel2PS3McmZPzpuFwJ3BJCg
         SC+c5p6lEN30PMfnlUQdtcDv2kQiJDbPalB1AIDTIfUzOcXWSTYTrqSRK4oJXDxyZr
         V3N2y3YaevJb25/WClny9yp/4ezSmb24p4/ebxd4bzd4n2WAxxwQGByzZ9mIMXUSA9
         7KLyKQk2BDteDtl+YDejX4ZDTOmC4xg809ZHmXe6DHJo18JgOzP6onYBRNBBmXoxgV
         5AYsJd1oxCNV8wid4yZAojPkXbwLAL88aUbaqJM/X/ErowIoCDGyiRr0C0AKJ7tUhy
         ciJ75TD88Tpj6bw4NHas5kW4=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7445B40E0177;
        Fri,  6 Oct 2023 09:54:14 +0000 (UTC)
Date:   Fri, 6 Oct 2023 11:54:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Breno Leitao <leitao@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231006095410.GBZR/ZQmaako5yMhVs@fat_crate.local>
References: <20230628142129.2468174-1-leitao@debian.org>
 <ZRV1bIuSXjZ+uPKB@gmail.com>
 <20231005162545.GFZR7jiUNyNkscijUl@fat_crate.local>
 <CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:29:02AM -0700, Linus Torvalds wrote:
> ...
> "complex" conditionals may also be annoying, but dammit, they are
> important documentation about why we do those things, and unlike just
> comments that will inevitably bit-rot, they have semantics and get
> tested.

Thanks for explaining - it does make sense to me.

So, from the looks of it, we're halfway there:

 - SPECULATION_MITIGATIONS is there for people who want to whack off the
   whole crap

 - the separate Kconfig switches are for people who want to do
   a finer-grained control. And yeah, they might be annoying the first
   time but you do them once and then you use the .config forever, like
   with anything else.

So yeah, sounds like a plan. Breno, please add Linus' explanation to the
commit message why we're doing it this way, when sending your new
version.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
