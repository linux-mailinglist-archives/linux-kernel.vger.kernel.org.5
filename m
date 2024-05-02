Return-Path: <linux-kernel+bounces-166042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323498B9524
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877DFB2173C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8036224D7;
	Thu,  2 May 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtQGw/LL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649B1CD31;
	Thu,  2 May 2024 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634354; cv=none; b=Z2n7fuDzeEsFDRGCUoue8LRQZSqoCzylp5hxsPOcP98/oLlkN3CVr74JtzBupDxla2l/5Ir2JSadrVGfOVZ44Pz5IS6waeXSds0+OY/PqqzndAkMsszEEaJ8p6JdfAPbwKNXc9B6uLVYSLzm9dyx+wbCGZEakC8u1+s2LsxwmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634354; c=relaxed/simple;
	bh=zALCxj2dHl0R1ke1uEMhAsdh4MJrggXSzHoN73Ahv2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnzmExubvKwW4E2Lk3036mixYKTa+MHiSvBgFapWgzZwIzluMh+JuXJV7+nDdoYdOrY6mnx0I1wKNE5KubEkLf735MZCl/AepidhZtFpQ9Kc9YHU10t8RzNUZKmCLHhvF1MnmJClNG3KlsRLPaZZbEQ0oTws1KazzzAW5VkZ9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtQGw/LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4720C113CC;
	Thu,  2 May 2024 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714634353;
	bh=zALCxj2dHl0R1ke1uEMhAsdh4MJrggXSzHoN73Ahv2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtQGw/LL6N92zholDO0yvdVLq9E/E8yKefM8ynrnE43UROhtlCKWbayZHrcn9PLT3
	 UYY8170XWK752rJh8QdjoSTx5FMzlDI7Sdsz/AMhdyyEvGcGKW8vS5IF0XIbASds5Y
	 aXK8dF9sJpjftkpNuSaA+W2Ev6BkI6+vjXO9Sg09qhf3n6KbVGQB3kHETuYjTrwYe3
	 g4xNknVopV4U8x/MavnAu6OJRRPC8yuMx4bnE/AfjKUIYkCLJXluVpM8tKDaI1/2VO
	 bDhNJn/9YfUkSImCxu0o56YHT0pS/ZZSI79EQ0QlG6Ay/CEuXh5DnV5l2SQFeKhAxt
	 sf6mPD9TmephQ==
Date: Thu, 2 May 2024 08:19:08 +0100
From: Lee Jones <lee@kernel.org>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Ben Greear <greearb@candelatech.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
Message-ID: <20240502071908.GB5338@google.com>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
 <20240411070718.GD6194@google.com>
 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
 <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
 <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
 <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>

On Tue, 23 Apr 2024, Linux regression tracking (Thorsten Leemhuis) wrote:

> On 23.04.24 11:06, Johannes Berg wrote:
> > On Tue, 2024-04-23 at 11:00 +0200, Linux regression tracking (Thorsten
> > Leemhuis) wrote:
> >> On 16.04.24 08:17, Johannes Berg wrote:
> >>> On Mon, 2024-04-15 at 13:37 -0700, Ben Greear wrote:
> >>>>
> >>>> Johannes, you had another suggestion: changing iwlwifi's request_module() to request_module_nowait() in
> >>>> iwl_req_fw_callback()
> >>>>
> >>>> Is that still best thing to try in your opinion?
> >>>
> >>> I guess so, I don't have any better ideas so far anyway ...
> >>
> >> [adding the iwlwifi maintainer; thread starts here:
> >> https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
> >>
> >> ]
> >>
> >> Johannes, Miri, what's the status wrt to this regression? From here
> >> things look somewhat stalled -- but maybe there was progress and I just
> >> missed it.
> > 
> > What do you want? It got bisected to an LED merge, but you ping _us_?
> > Way to go ...
> 
> Sorry, to me it sounded a bit like you had an idea for a fix and were
> going to give it a try -- similar to how the maintainers for a r8169
> driver and the igc driver provided fixes for bugs recent LED changes
> exposed.
> 
> But sure, you are right, in the end some LED change seems to have cause
> this, so the duty to fix it lies in that field. Therefore:
> 
> Lee, what's the status here to get this fixed before the final?

No idea.  Did you send a fix?

-- 
Lee Jones [李琼斯]

