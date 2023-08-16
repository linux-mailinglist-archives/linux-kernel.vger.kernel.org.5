Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4877E99A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjHPTY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbjHPTY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:24:28 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45461FCE;
        Wed, 16 Aug 2023 12:24:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1706240E0193;
        Wed, 16 Aug 2023 19:24:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4uDNsU_7N1mE; Wed, 16 Aug 2023 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692213863; bh=kWCMNXNC+b+d4lKUIGbGSVb7+WbXyP3FVVhE4xWxZOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce1V+inLjqNAFaYi+CNmHmvDKtqvcocwEEZfD/0ZIahf+91pRriquLRRqPJsFnLbU
         olBc9Dd/pYcYufuO1wOSnarmuAUN06bUdBdzctnSonzhJhrMRLGSAeu56nH10Wcbyd
         KstUUq/EmCx/xWDHrYxbV7aO5pLiHe6K9OULGUbnerEULYsv14hJRJ3NSoHuwlCV0Y
         nJKr7bCzMDzDX97Ave2KThpb2eYJG9PBOL8cd12FoaUOTeBk0T3VhNSyl3doVTGtmu
         rTkXvxgYpEnVlxXhudgDFoqw/Tsb/qzJ5gTwTDc8qSk5OIq0u/NMSFSlKUPLPKX4WB
         lhrVIWxwabdOmzO11opzD2nMOFZgqxdGzpk+SLKexyEAL5gpS35laPUK2uvtarx5IG
         VYrTWpVeWhJ7xzelNBG71W8dQ2/0/DZxToKcPVApwHVwBDI50OU5zp4DJaalEay4hT
         5XWuddHI23yo57Q6Bilu0DJKFzBy+QekiDPwCtvZ7GWtqmcJfZxuAzh08ZkerB+kSX
         vZXtoViUMZAjiy4HjXRj4PuWH2dDD3vouUTMm2tvfAtrow9ZGK02za5M+U0yBHpDCb
         9fc8Vuu8CEkShHroALdsU2MmS96QAIXCQNsBZsZq1ptnIO3U3VtKrEzMnT9CH6WV0v
         2Mmop8jBCWrwRvsw7LN06N1w=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77CAB40E0140;
        Wed, 16 Aug 2023 19:24:18 +0000 (UTC)
Date:   Wed, 16 Aug 2023 21:24:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816192413.GPZN0iXRRpOGKVMm47@fat_crate.local>
References: <20230814121148.842775684@infradead.org>
 <169217251663.27769.14430226618442726061.tip-bot2@tip-bot2>
 <20230816185839.GA3843691@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816185839.GA3843691@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:58:39AM -0700, Nathan Chancellor wrote:
> but it obviously gets fixed by commit a3fd3ac0a605 ("x86/cpu: Rename
> srso_(.*)_alias to srso_alias_\1") so it is probably fine. I only
> noticed it because I cherry-picked the first five changes to my patched
> -next tree.

Gah, and I meant to merge that hunk into the right one when fixing the
32-bit builds.

So how did you trigger it? You do builds of every patch? Because that's
the !CONFIG_CPU_SRSO case.

Oh well, lemme rebase and fix it.

Thx for letting me know.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
