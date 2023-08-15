Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2877D407
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjHOUSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjHOUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:18:10 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1F1BE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:18:09 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A631D40E0196;
        Tue, 15 Aug 2023 20:18:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QkTEUdTaLDnL; Tue, 15 Aug 2023 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692130685; bh=OiJwsDo9OIpyTbSbSY3O6mZWFr15D/wM50aCasFB0Fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDktz93ajwrHAGBtQQaENMdJTtUvLpOLzhHTG/gHMTZR9tuSpxFZZz7d+zgV+khPl
         fGAwl07qXHwTai4omrlNb8ejbqvv1i3MwJH2vxRpPkmz9jGWV5uTY1EruiwP1nX3Ui
         HjHI0l0GihQDRRMgMMoamNVti+TJjcsu2Hep45l0ck5la6tsyMCzo2pFD6yf7azGnk
         IO7zHP8+1QxOyFxqYrhifdBol+Wfye8BkAgNH9ckVinJa1kfH9dvnGUugS+rQtMlXk
         oJH3bhujfN2QX8rNSFdfUXwgfgGGeOk55I6GNoPE0xbJImpzPhBaDJM92RUUX4bH80
         5H38CW4tEi3/MgT9vRwgyly5uzFBEuyWHZv6T9Nq0vUBF+IOQIkJmJjXdqT1GfQSWq
         MYyPMb227ggDAVAh9ZXbs+tXYqj7TPYa0uNFOUQlPykDcm3XvZWZjv0AL0YXmqKEui
         rYPe6nKQEmi0QK2W9POop3XDVeg85Xuk6SWn2/a+mW2jJGHuGMCwk79sJ3vHND1HCY
         IQKjj9Y53hsCiaxatJcIicw7pJx6YFe+Gq6lv82XjijP0aMUlypaxkJhwJA9P9jkFJ
         8dSlJUuWro2fLb3UlRwUv0NyPXeBql8reDPh3hFKv31IFX4Z/3I/kZre/F/8rGjO+n
         rWQCuJT3BHuztAE+foZhNjGE=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44E6F40E0140;
        Tue, 15 Aug 2023 20:18:00 +0000 (UTC)
Date:   Tue, 15 Aug 2023 22:17:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815195831.2opbgrznnpszaa32@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 12:58:31PM -0700, Josh Poimboeuf wrote:
> AFAICT, nowhere in the spec does it say the SRSO_NO bit won't get set by
> future (fixed) HW.  In fact I'd expect it will, similar to other *_NO
> flags.

I'm pretty sure it won't.

SRSO_NO is synthesized by the hypervisor *software*. Nothing else.

It is there so that you don't check microcode version in the guest which
is nearly impossible anyway.

> Regardless, here SRSO_NO seems to mean two different things: "reported
> safe by host (or HW)" and "not reported safe on Zen1/2 with SMT not
> possible".

Huh?

> Also, in this code, the SRSO_NO+SMT combo doesn't seem logically
> possible, as srso_show_state() only gets called if X86_BUG_SRSO is set,
> which only happens if SRSO_NO is not set by the HW/host in the first
> place.  So here, if boot_cpu_has(X86_FEATURE_SRSO_NO), it means SRSO_NO
> was manually set by srso_select_mitigation(), and SMT can't possibly be
> enabled.

Have you considered the case where Linux would set SRSO_NO when booting
on future hardware, which is fixed?

There SRSO_NO and SMT will very much be possible.

> Instead of piggybacking on SRSO_NO, which is confusing, why not just add
> a new mitigation type, like:

I had a separate mitigation defintion but then realized I don't need it
because, well, it is not really a mitigation - it is a case where the
machine is not affected.

For example, I have a Zen2 laptop here with SMT disabled in the hardware
which is also not affected.

And also, the rest of the SMT disabled cases in bugs.c do check
sched_smt_active() too, without having a separate mitigation.

That's why.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
