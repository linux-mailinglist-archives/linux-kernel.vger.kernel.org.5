Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343AE7EB6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjKNTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKNTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:23:47 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95696FB;
        Tue, 14 Nov 2023 11:23:43 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DCEA440E018F;
        Tue, 14 Nov 2023 19:23:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nxOVEvKxnXQi; Tue, 14 Nov 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699989818; bh=9DUPwmxmZUVmPS/P37KJn65M2sh/+Gd6LIFKTA6w0Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhbAG0uU8wqQyx5OrvGVl2RjU0fJkob8NkFsAR64SjVppoIjyxfZ8My9w4ZL8YqSl
         JjwtRuaFHJRi7SH/PYzPVWRyruFYiscK15+YlvAw4e/S+SP0Rt5wYOrIyhr+yo+fP7
         yO+rnnhOTLZvPe0W/LfBJsZJC2Oh7EwiRIsTocRdPrUqL/nSATCM7GGzsH7giwKAZa
         ASZCM1c4BL2c4j+r/c8+Vg3tY22C+wye1RLd40GqdwQ8vFY+eehwbx7pp6rIa0dHIN
         2WHhwTeiS2OIk36i98PrGOZnN8VYivfvw9B3dUCN96hUuf0DicTBJQLfOTx0TMl+jX
         EoUct4o0WjjHhQhbfIvUOwUQwkSNFm7I0GXipjtH2aHGXhZfquvPgFnQex94NyArOK
         yWd7pq7S6LnQe1IBqRBEv8odhN6TdMnOKpZG5l+cKNyMRIbkm1wuqEQ/sebSTmSZvQ
         iXyeoglNoxw2nDVz2Fb2QU31boGt52Bn+gpc0P+/tpe0ky84HfTM+1UdjPFF7Gsz9m
         1cew78d8XMjGWA+eUNCpCNgzBIO4hTeuj3vxPhcHhAS/YWqJJHJjEcOXBMVkH1ij3z
         +zkE2jF4wPriDJvOs2aAkm1uGTLCaIkYn4uiFhzv7xzEtkgFTNe4F7L0aK940Dx7KT
         raIftZIjoYqTwRb/E+Vud7Wk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55D5540E0171;
        Tue, 14 Nov 2023 19:23:30 +0000 (UTC)
Date:   Tue, 14 Nov 2023 20:23:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTa37L2nlnbok8dz@agluck-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:14:04AM -0700, Tony Luck wrote:
> I want to track whether each bank is in storm mode, or not. But there's
> no indication when a CMCI is delivered which bank was the source. Code
> just has to scan all the banks, and might find more than one with an
> error. While no bank is in polling mode, there isn't a set time interval
> between scanning banks.

Well, if no bank is in *storm* polling mode - I presume you mean that
when you say "polling mode" - then we have the default polling interval
of machine_check_poll() of INITIAL_CHECK_INTERVAL, i.e., 5 mins, I'd
say.

> A scan is just triggered when a CMCI happens. So it's non-trivial to
> compute a rate. Would require saving a timestamp for every logged
> error.

So what I'm trying to establish first is, what our entry vectors into
the storm code are.

1. You can enter storm tracking when you poll normally. I.e.,
   machine_check_poll() each 5 mins once.

   mce_track_storm() tracks history only for MCI_STATUS_VAL=1b CEs, which
   is what I was wondering. It is hidden a bit down in that function.

2. As a result of a CMCI interrupt. That will call machine_check_poll()
   too and go down the same path.

So that flow should be called out in the commit message so that the big
picture is clear - how we're doing that storm tracking.

Now, what is protecting this against concurrent runs of
machine_check_poll()? Imagine the timer fires and a CMCI happens at the
same time and on the same core.

> In a simple case there's just one bank responsible for a ton of CMCI.
> No need for complexity here, the count of interrupts from that bank will
> hit a threshold and a storm is declared.

Right.

> But more complex scenarois are possible. Other banks may trigger small
> numbers of CMCI. Not enough to call it a storm.  Or multiple banks may
> be screaming together.
> 
> By tracking both the hits and misses in each bank, I end up with a
> bitmap history for the past 64 polls. If there are enough "1" bits in
> that bitmap to meet the threshold, then declare a storm for that
> bank.

Yap, I only want to be crystal clear on the flow and the entry points.

> I need to stare at this again to refresh my memory of what's going on
> here. This code may need pulling apart into a routine that is used for
> systems with no CMCI (or have CMCI disabled). Then the whole "divide the
> poll interval by two" when you see an error and double the interval
> when you don't see an error makes sense.
> 
> For systems with CMCI ... I think just polling a one second interval
> until the storm is over makes sense.

Ok.

> These are only used in threshold.c now. What's the point of them
> being in internal.h. That's for defintiones shared by multiple
> mcs/*.c files. Isn't it? But will move there if you still want this.

Structs hidden in .c files looks weird but ok.

> Ideally the new CPU would inherit the precise state of the previous
> owner of this bank. But there's no easy way to track that as the bank
> is abanoned by the CPU going offline, and there is a free-for-all with
> remaining CPUs racing to claim ownership. It is known that this bank
> was in storm mode (because the threshold in the CTL2 bank register is
> set to CMCI_STORM_THRESHOLD).
> 
> I went with "worst case" to make sure the new CPU didn't prematurely
> declare an end to the storm.
> 
> I'll add a comment in mce_inherit_storm() to explain this.

Yap, exactly.

> Like this?
> 
> #define NUM_HISTORY_BITS (sizeof(u64) * BITS_PER_BYTE)
> 
> 	if (shift < NUM_HISTORY_BITS)

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
