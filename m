Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847C77DC55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbjHPIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243037AbjHPIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:32:37 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02132D46
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:31:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8354640E0197;
        Wed, 16 Aug 2023 08:31:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WBva0_lvLKsA; Wed, 16 Aug 2023 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692174667; bh=nbfLx2nhUGG35klVyE4vBqaarRvQbhi+exD6zbNU93E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bou1jTKAGwwgE47jpxNJaj5zxxAKyd+/911Xxgl12kFRo9xWhYjS4xP5xOG1aLeTm
         pcsN7j5RzG1yWsd3UFEFKSF3bpNvdlsXJykvB9KLu8e6oP62STswzIJ5OxpEgJubCv
         KTbcy3BJBy55epS1sA2PYlHnwKPG83Zn3DSPqGuP8J1IIaVsnnAZJ5iMDlfB6Qiqh3
         Et6srnILODwLEYD25BP58YP6IPo0/Xjreo20jjV4CiG4aKLxdz/ecj6+lerZF2bUbw
         FvZVlRntJh6yKyDJXx2n9E+kPly8zxs2XxyIYm3f3U5cPu+0HWQpgHCw4QV4b24NW2
         a+RNZ5AzBpMXOii4tzcM9dlJh2bRXsBZYc1YTJ5bNJPdGP4E5mi8lQpLdXOgz83/MV
         W8B4uQ5TG/rKaTVSrh2Lo/NAtNMSaj6WZZUb3wJ89o9rqC3cKW1NRol/ZxWPLpuWeJ
         yz6ofKGfbp9j/Vsd/kH8tds7Z1FXszYu9Jr+Fj+RketAyAVGzlCrDUr5J43Sv4HEYm
         RpJMQKzVpmK4YobUYXdBpiJ87bsSaU9/UmbjRYMavc9JRSzNFjqUGQ3gCfslCwsqWt
         93fXFFokp5qNdb3HWAJaRwn0pGOg7oTwNTMbqcr4XTghh+RT+PHbPi3nBlCNF31UC4
         IvIVS5B6IitZ21ECornsUpfQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0272E40E0145;
        Wed, 16 Aug 2023 08:31:01 +0000 (UTC)
Date:   Wed, 16 Aug 2023 10:30:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815212751.xhsyn7iwj2gwpuk5@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:27:51PM -0700, Josh Poimboeuf wrote:
> How is that relevant to my comment?  The bug bit still wouldn't get set
> and srso_show_state() still wouldn't be called.

Lemme explain how I see this working - it might help us get on the right
track. And for comparison you can look at X86_FEATURE_BTC_NO too.

* Something has set X86_FEATURE_SRSO_NO - hw or sw doesn't matter
- because the machine is not affected. X86_BUG_SRSO doesn't get set and
  the mitigation detection is skipped. All good.

* Nothing has set X86_FEATURE_SRSO_NO, mitigation detection runs and
find that the kernel runs on a Zen1/2 with SMT disabled - we set
X86_FEATURE_SRSO_NO.

* Now X86_FEATURE_SRSO_NO is passed in by KVM to the guest and the above
dance repeats.

Now you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
