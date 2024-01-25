Return-Path: <linux-kernel+bounces-38788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B137F83C600
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AAFB24E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4901F7318F;
	Thu, 25 Jan 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W7J4Aj8j"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF36EB54;
	Thu, 25 Jan 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194845; cv=none; b=ZcT6dvDSY10AcTk/LpPXGnEn73vunHreU/16O28AXO8vX5dfwhcjyldbzbnIxAJD+LHaVjnF+eEKRuVcSH4d79lVNFer29AUY8siP2TLPiPIkZy4uSozgltP9rDQ42DJcHFZeokUkfaB7C9+kuViO9Sv+7WUoQw0g6LEKfXLBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194845; c=relaxed/simple;
	bh=pBmISwiuDHvWTZNjtbdX+o01/6GuunQ6rno2/95NOs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGc0Y+XZKHLcBMAPhK5yhrpVsYkA7FrFDN8Zv4tTxOyhGyomwSlaELeUeNbOjWMpxJfNy2H7FRwH1FCiB+r20bguEZGclwqJf2Lk/4rz3+poMWDLXy9/uTdiWoBla6r0g+1IoZ2PSSOfIruwCHUovaDVRog/8wGtJzzZaTlb78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W7J4Aj8j; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F1B027A98;
	Thu, 25 Jan 2024 15:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F1B027A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706194841; bh=19H+ohazVHtseGiYiVAg+hU89peX8rovYsg56MVemuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W7J4Aj8j1Qr/slt8R4Q1kt+tx8l4FGxwsZqSveb4K6Gpi2st9BOZlsrB3+NB41Hau
	 7nEIVQFtwdCFHMDPuE69Aig/Yf/VLTh1H//0mOpDL5z1FbKIetLRQ2mM7m5DN4XGCJ
	 Z6SrYLHHctQHSBRN8F326JPoBNxRPNywN9K/7nvh56+DUtaw8FHsMj9YC8Pj/0mUsQ
	 jYBKpwD7Vdqv1iNVlOV3n0JUPtKiH+XAcgRO+iAxs4+Gz8+kkBPFAI+aJ8vjaypAUU
	 rrLQvIX8nhDxgcwh5QZ75CwubwuI9CTp9VHfAHlGTvhAnMzfm2hvPPmJsYnF9rIiED
	 Ia1uGJWg7v/bw==
From: Jonathan Corbet <corbet@lwn.net>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] Documentation: Create a new folder for all timer
 internals
In-Reply-To: <87o7d9d7dd.fsf@somnus>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-7-anna-maria@linutronix.de>
 <8eac7bf0-86c5-43ef-99e0-0896c994184a@infradead.org>
 <87o7d9d7dd.fsf@somnus>
Date: Thu, 25 Jan 2024 08:00:40 -0700
Message-ID: <87plxpbgpz.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
> 4. Add a warning banner at the existing documentation and prepare
>    everything to get the timer documentation to the proper place and
>    create a place for timer documentation below the current structure.
>
> The benefit of 4. for me is, that there is this warning banner at the
> top. So this suggests the reader, that this has to be revisited before
> relying on it for 100%. This banner might also remind the original
> author/technically deep involved developer that this should be
> updated.

The best thing, of course, is to just fix all of the documentation and
make it perfect now :)

Failing that, the banners are fine IMO.  They mark possibly obsolete
docs, warning readers, and also just might, in an optimal world, inspire
somebody else to work to improve the situation.

I've thought for a while that we should have a standard warning or two
along these lines, like Wikipedia does, but of course haven't done
anything about it.

jon

