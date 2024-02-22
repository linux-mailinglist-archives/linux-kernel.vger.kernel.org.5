Return-Path: <linux-kernel+bounces-76622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C594285FA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652FBB2547B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB9134CFE;
	Thu, 22 Feb 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py5ERAeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3F133405
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609481; cv=none; b=bGi96DdHbYMnZMV+O1139PvEwpNIs5ORLrxxylGuOdds5lIV9Ea9KihSHUQ4CsaAQekGC4BcAFm2vN0KXHIDeHNtqBzOrpCPkgK5+dvNMc6XCcxNjSvr5mpKx4IetbjDyD7+yT6NIZhLDhE7sXzlKnEtlABNPgA81Hu/9vlQ4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609481; c=relaxed/simple;
	bh=w2qfdGrfppM5dIyrFpC5zXFmoAO1k86O5ZYuGpjYTfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa5qOOXxkVnM69vCzAdq5apsdz0UEsV9cUXoVhXZu8IbUIZRmpeY0qE2AMtzU2Cm6M0cbUjC08GMMTrSIEmqDNnvrEnO2/xfeUtH1XkgIhK7mPOYIPlkxPrThQ2ZPoFzG09IWD6R65+dnt8Q8WHoMl43WyFBkJNfhmhu35u8nxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py5ERAeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3F8C433C7;
	Thu, 22 Feb 2024 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708609480;
	bh=w2qfdGrfppM5dIyrFpC5zXFmoAO1k86O5ZYuGpjYTfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=py5ERAeOQ9x8NTqkTH9Tb4HaBMDCblpsGLn9tpNYRegbpEJE4gwxQDIf4ydNV5RGw
	 Uoz25MO6AlSEgRepy0STu9IJIcoyXkYFh0sR7nDSPA0jIFhoWNFK77Vc33o9RMya+U
	 PdyfAZYNb6MSWohHC8De7Z2dpo78cEpCKGcuAOOXSEVlxEARUpO+qetQ5TqLixrSBq
	 gK3IRTtCSOQJjYplg596Cdq/qwHOFqUT9ohYg1HWuJe36l4jGH/ncTv2QtmXX6DcSO
	 8MgAxBciXwbszdtUMgUtQShYiW7FB7ewz++c0OMqrphQ8Egmjzlzfr9MN9EOVq84EZ
	 5vp+f4+SZf/Xg==
Date: Thu, 22 Feb 2024 14:44:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH] timers/timer_migration: Fix memory barrier comment
Message-ID: <ZddPxV6yMN1X0rNs@localhost.localdomain>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240222133320.43780-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222133320.43780-1-anna-maria@linutronix.de>

Le Thu, Feb 22, 2024 at 02:33:20PM +0100, Anna-Maria Behnsen a écrit :
> Comment about the required memory barrier in tmigr_inactive_up() is not
> written properly. Rewrite it and add also new comments to the other memory
> barrier related places. Also make clear, why a memory barrier in
> tmigr_active_up() is not required.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

