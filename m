Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D8E7D5C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjJXUTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjJXUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:19:34 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BACDD7F;
        Tue, 24 Oct 2023 13:19:31 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC07840E01AF;
        Tue, 24 Oct 2023 20:19:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CgqfiZwe5MTG; Tue, 24 Oct 2023 20:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698178767; bh=xi1FrAT40RHPFjhhihyLKj7fZaVtmze6tTwxLfCqgRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXFsLbZKKz6ukN7WNyw6QrDgkjKNakStAJXc1oM3VsZTP4HNulBrvlKWvIgKGuPjP
         p5q3PTBsIXonyNyyGyWSvfv5ga6FgxxftVuuK7C7Sy7LHLYqJLGH/HGxhUkNRUG4cN
         6KRDqTOjePoKZ+Et3RmL/UQC5CwcbfbDzKR4gVWa/xcZQruRHGN2+0FQYUkBiHCORa
         0tRq2ZXfnwegeV/l2iPDfiBOKV+uSpx3CMOp+Gn3pFAB1DfgKlo1ZDFDnsVFEHhA6Y
         vW83fqBHLDHB2THQk24Ne0RY/wuOpSsLErcnLiupXaG05FojayhNreA1Nx4ubvxWq5
         3SZf7hmd6E/zQzIcr306CKa1K2EL/oVkgw0tGKKrBLmE5xVgP87G3OeIFdHYEwFkGw
         rTNES+Sgih3LlpTwOHtM79g96sKLkJs/6qVsswc5bxIcHbRG4FwWfTljA0jyDdNI7/
         BrJ0oYydDq+0XDYYlWP5confc0fSfp0YhyUGNhHIBw5bNVv8pMsGchtPyRCYCry1h0
         klIpN8lAWBFnwxjnjVDjL48zEAK0XjdutkIe2pP+3sz7LFX9BvnmKr443lRRtxW86F
         TRmIf10IGM58UVslUa0577J9FLwI9Iuga6K0Nb1YpbVDWfGSO2uAO+tHBjfZluKegp
         a+kj1HfIe4ZvghZySYlUZYi0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5B8340E0177;
        Tue, 24 Oct 2023 20:19:18 +0000 (UTC)
Date:   Tue, 24 Oct 2023 22:19:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Kaplan, David" <David.Kaplan@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
References: <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018203747.GJZTBCG7mv5HL4w6CC@fat_crate.local>
 <20231019063527.iwgyioxi2gznnshp@treble>
 <20231019065928.mrvhtfaya22p2uzw@treble>
 <20231019141514.GCZTE58qPOvcJCiBp3@fat_crate.local>
 <SN6PR12MB2702AC3C27D25414FE4260F994D4A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231019143951.GEZTE/t/wECKBxMSjl@fat_crate.local>
 <20231019152051.4u5xwhopbdisy6zl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019152051.4u5xwhopbdisy6zl@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:20:51AM -0700, Josh Poimboeuf wrote:
> GCC doesn't read asm.  Even if it did that wouldn't fix things for
> callers of custom-ABI return-thunk-using functions.
> 
> The below seems to work.

Right, I guess we can do something like that. Linker is not happy here
about that symbol, tho:

ld: arch/x86/lib/retpoline.o:(.altinstr_replacement+0x95): undefined reference to `warn_thunk_thunk'
make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[1]: *** [/mnt/kernel/kernel/5th/linux/Makefile:1165: vmlinux] Error 2
make: *** [Makefile:234: __sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
