Return-Path: <linux-kernel+bounces-38275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8883BD6E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED571F2E6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8041D54F;
	Thu, 25 Jan 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWqyS+7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jMBJe3Au"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B81D545
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175167; cv=none; b=pC01+uErVpjicaZcXm+Vy0QfUnBBMsNecfqiXb+DTRa9gsjwYDSYSjOaEHwWTpW95UnmVJ6C850UmFGSyf4gCZGrQoIUCcCRqMVATbtsVUCGst45JxOkRW0OYeeNEezGbAtI9ekEJQ1zGq2LEl2oMuR2oc75GnmmvhPFGAN93RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175167; c=relaxed/simple;
	bh=WGDfHNslx8zcw0A6UsiaJdMQn7h7y4HEDVCXKa7XYoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKjueHhHfNE915E76KTiCevHldvu6pC68lN2aYphdsVWy5aBEbrRR9cf/w4NVOSAqISszoRfyABIiv22qVFzy9KnlpWR6Y0159XShtSVaspSpzDsEfGJPhMneETKFpcloaYvDxDpkuYfrupo1eAFiwJ92so83rd689fz0D4lzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWqyS+7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jMBJe3Au; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGDfHNslx8zcw0A6UsiaJdMQn7h7y4HEDVCXKa7XYoM=;
	b=hWqyS+7an2XdKU4u5ak2aG6QM4X8hsAxGPCGnzMBaW4ZFWQgHuv8Zq4bTzBWDNt4nS3lGt
	8is+zTMU2BqW/02MRU5Zf7310me7N+OkoJkb89NvLgDrah5R5iP7S/j44A28o/1C+HUToA
	OzYyqAd3e4mwakLs8X08gd0qVmHVJl1KcaDa991CCiycXAr5OJXXoGK3IzqFs+t5L2d175
	DRbes53gJQhP6LSvN4hoX9Voan8ZxlvpQPfRBf4EVgLK5C6pmBs6/TfACIY2OVntnWhySB
	GKIfC+wx+FeMyS5Pg/KeVQiLiyIKaZ1ghrnkjguq5cwOFR/KYHPkO3+Ys5qEKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGDfHNslx8zcw0A6UsiaJdMQn7h7y4HEDVCXKa7XYoM=;
	b=jMBJe3Au3SaDKihl2pMBAbWvOo02CF31OYqvfxXnoJm1euvL1qEnQW/v2wPToAFP8G6cw/
	7mqLpD1Uz4XqwUCA==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/15] tick: Remove useless oneshot ifdeffery
In-Reply-To: <20240124170459.24850-4-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-4-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:32:43 +0100
Message-ID: <87bk99kbb8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:

> tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
> only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
> the related ifdeferry in this file is needless and can be removed.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

