Return-Path: <linux-kernel+bounces-127122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A60894730
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723161C210C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0F55E73;
	Mon,  1 Apr 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmHtYV/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC11C2E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009889; cv=none; b=eX8W1TK3HOhuG66QT6/Oey28LKDA6Y0134Gys8a0Ni7onQo2wsjJ/RnpfwDp0T5YbXTuRZwtqkbZPkoZSCLFFAzmAwBf4TSfdKv/7roRgJD4CQ16dplnD1Q7EDQDZtnFgeLoKXQgeTJH45J54vGsEnj1j45tl10B11sHKAoX2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009889; c=relaxed/simple;
	bh=MaoU2+e052W7LkgXv/s8T29P15T7v1eYC19mi19a71M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDel7lkeP2Wa8//DcUg+AinrC4kpBPxF9n5im8MIK2/OCYvfzvR8eRluqaEGzsR+V9yvSTG3jysg9QAMXx7vN36+mKfJxMnTwlRtuPVx76ljKUeUmwuN3aqVuVsL6hG1C21jBRIIxUymAxmb/EFjV8EVUzMl2podjQl+JYbJkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmHtYV/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B558C433F1;
	Mon,  1 Apr 2024 22:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712009888;
	bh=MaoU2+e052W7LkgXv/s8T29P15T7v1eYC19mi19a71M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmHtYV/t8cbx6QYqCnHxfWl0FLqvr5exMfHz/LUs0N38z/9+ffcXRw5Gc8wjiw64G
	 ineIx0+DQCrQf396CHSQ6yRh5xspYL+ackHDYsEKUbLgoOiBVU0lMSP9FDp9cbsv1j
	 yHYnziwcNGyoZ3s1mxvAsEr/kZZq3oF8ki652MBRJyxsCNKO+7hW6nJlyOYwrlOBcL
	 Eksil+85UqAnmpeJbFSh16X0CQjVdvCSMqIffISCqIBMuoFd/NQ5He7g3YnxHJwAq3
	 QGGv0/ElwMA1eLHEaEMWj7d6djSeVODYt8ojo+ECS9xViiE9w/6cDu+sRPH1N/ar0/
	 10ykF+VDZs20A==
Date: Tue, 2 Apr 2024 00:18:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers/migration: Fix ignored event due to missing CPU
 update
Message-ID: <ZgsynV536q1L17IS@pavilion.home>
References: <20240401214859.11533-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401214859.11533-1-frederic@kernel.org>

Le Mon, Apr 01, 2024 at 11:48:59PM +0200, Frederic Weisbecker a écrit :
> When a group event is updated with its expiry unchanged but a different
> CPU, that target change may go unnoticed and the event may be propagated
> up with a stale CPU value. The following depicts a scenario that has
> been actually observed:
> 
>                        [GRP2:0]
>                    migrator = GRP1:1
>                    active   = GRP1:1
>                    nextevt  = TGRP1:0 (T0)
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator = NONE       [...]
>             active   = NONE
>             nextevt  = TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator = NONE
>       active   = NONE
>       nextevt  = T0
>       /         \
>     0 (T0)       1 (T1)
>     idle         idle
> 
> 0) The hierarchy has 3 levels. The left part (GRP1:0) is all idle,
> including CPU 0 and CPU 1 which have a timer each: T0 and T1. They have
> the same expiry value.
> 
>                        [GRP2:0]
>                    migrator = GRP1:1
>                    active   = GRP1:1
>                    nextevt  = KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator = NONE       [...]
>             active   = NONE
>             nextevt  = TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator = NONE
>       active   = NONE
>       nextevt  = T0
>       /         \
>     0 (T0)       1 (T1)
>     idle         idle
> 
> 1) The migrator in GRP1:1 handles remotely T0. The event is dequeued
> from the top and T0 executed.
> 
>                        [GRP2:0]
>                    migrator = GRP1:1
>                    active   = GRP1:1
>                    nextevt  = KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator = NONE       [...]
>             active   = NONE
>             nextevt  = TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator = NONE
>       active   = NONE
>       nextevt  = T1
>       /         \
>     0            1 (T1)
>     idle         idle
> 
> 2) The migrator in GRP1:1 fetches the next timer for CPU 0 and finds
> none. But it updates the events from its groups, starting with GRP0:0
> which now has T1 as its next event. So far so good.
> 
>                        [GRP2:0]
>                    migrator = GRP1:1
>                    active   = GRP1:1
>                    nextevt  = KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator = NONE       [...]
>             active   = NONE
>             nextevt  = TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator = NONE
>       active   = NONE
>       nextevt  = T1
>       /         \
>     0            1 (T1)
>     idle         idle
> 
> 3) The migrator in GRP1:1 proceeds upward and updates the events in
> GRP1:0. The child event TGRP0:0 is found queued with the same expiry
> as before. And therefore it is left unchanged. However the target CPU
> is not the same but that fact is ignored so TGRP0:0 still points to
> CPU 0 when it should point to CPU 1.
> 
>                        [GRP2:0]
>                    migrator = GRP1:1
>                    active   = GRP1:1
>                    nextevt  = TGRP1:0 (T0)
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator = NONE       [...]
>             active   = NONE
>             nextevt  = TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator = NONE
>       active   = NONE
>       nextevt  = T1
>       /         \
>     0            1 (T1)
>     idle         idle
> 
> 4) The propagation has reached the top level and TGRP1:0, having TGRP0:0
> as its first event, also wrongly points to CPU 0. TGRP1:0 is added to
> the top level group.
> 
>                        [GRP2:0]
>                    migrator = GRP1:1
>                    active   = GRP1:1
>                    nextevt  = KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator = NONE       [...]
>             active   = NONE
>             nextevt  = TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator = NONE
>       active   = NONE
>       nextevt  = T1
>       /         \
>     0            1 (T1)
>     idle         idle
> 
> 5) The migrator in GRP1:1 dequeues the next event in top level pointing
> to CPU 0. But since it actually doesn't see any real event in CPU 0, it
> early returns.
> 
> 6) T1 is left unhandled until either CPU 0 or CPU 1 wake up.
> 
> Some other bad scenario may involve trees with just two levels.
> 
> Fix this with checking the CPU, along with the expiry value before
> considering to early return while updating a queued event.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")

