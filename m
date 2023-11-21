Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D77F2ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjKUKmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjKUKmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:42:03 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD5BA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:41:57 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6801140E01AD;
        Tue, 21 Nov 2023 10:41:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jJQ_0gGiUbgo; Tue, 21 Nov 2023 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700563313; bh=fnyEynF2/BGyDA25XTqaOcJ4byOQMi/06qF8BTjdMTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmZ03YN3Bk4BTZ129QzSuWxt2HZYte4jnM0ruwpxDFJudmwa/g46BbemJGgpb+uai
         R1XDSXjJPCIf5vMArV57Lm1rfgTFTuRNUNkDpOkk/7jDt5Hw25LRvA8AKdDUM69i9V
         0IWsqOPjUO6Ac4OH3kVZ21HcB08irjf7G6eEJZHxILsKSQVFPiSnbh1Jl4KoR/O1JP
         ZQzvSwHCdbs7Qw8wjOo7052IadPj/7u0VvrnHWK7wZkHfh/204bb6mV44sF6wn8+c0
         Co5UcyYjFDeyI0td7ax7HhlmnDEdj+m69G/lyj4/0hUS0hzPvW/O5Y9a05neUxKxvd
         R2kU6TLBSEbpzyVQODNAAnxaUr1jLc6ODk35wSb5feouUuBRZ4XSyO8TtoynHQeUtt
         xWSQYbowsf9V3itOETL0BI5/ondQK0n/3BroYCBs+QkRRrN/LaKIi0KJghZBw+dsVk
         Go1ReFuz5FfIJLeKilbKtFQ2EljGKPhinj4sNVWldCKBaFkz5+uqlHhquwyFyzSkqw
         OMnYT6WR9azSjyXILwAxxozcjnC3cQWrk8cwEzxFIulg+BQNrpvuq7Np/n3F4e4qOP
         hvleqS2Mj+f+I29nYt3w7/vA/mDFnUK7EL7wKyJUCBolq0jZtIRM4yOsXjEE0DoOVl
         b/pYg7c3qxAaM8Y6lBKuhtn4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2620E40E0031;
        Tue, 21 Nov 2023 10:41:50 +0000 (UTC)
Date:   Tue, 21 Nov 2023 11:41:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/13] x86/CPU/AMD: Move Zenbleed check to the Zen2 init
 function
Message-ID: <20231121104144.GAZVyJaJZDYyt1+aQ6@fat_crate.local>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-8-bp@alien8.de>
 <bae4d27d-5882-468d-a5bd-80b34c10dd80@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bae4d27d-5882-468d-a5bd-80b34c10dd80@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 02:53:54PM +0200, Nikolay Borisov wrote:
> nit:  If you initially introduced the zen-specific functions right after
> zenbleed_check you would have avoided the function move in this patch which
> would have reduced the overall diff.

Yap, done, good point.

And thanks for the review.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
