Return-Path: <linux-kernel+bounces-108855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B4C8810F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9162CB20EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B03DB8C;
	Wed, 20 Mar 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A5Ce6O1t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6AbpP4Vo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A363D541;
	Wed, 20 Mar 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934151; cv=none; b=B/7C4mGHtuWVKt2NlMNKeqsaTjGdY0SRa+7CBHEHpYCgeKiQzr1z/bqXqBXE9s6LuTcthkJOIW5ZU9SLed1QzIwss31Nve8jMUmXyebTEJigJvMkovopxefFrwSUebe0pPPx9a85jZSc8ppyKxqtn4IObehKawbaXACJJRTYpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934151; c=relaxed/simple;
	bh=M4qZDfeqdgUN7WwW07gOdPYTQ8hzgSGfC9I8vI9ySrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pbhkvagy/oJmYgSZmasExGQ9maLGZ8bcSz4GP2dDbaGsnUoRq7Ge1pmjweSXeG0+sV3Er0Gu/Lu2LOkcuewY1crcqFe26by1hU2soyAG5cEtSEw/dS21c965fJtp5A5XGI39XGaco6P8Ql7PN1ypaJpPitK7fL2ZPSNwipQhdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A5Ce6O1t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6AbpP4Vo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710934148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M4qZDfeqdgUN7WwW07gOdPYTQ8hzgSGfC9I8vI9ySrQ=;
	b=A5Ce6O1tFxISLyNmqEAZsC9uJLadVd1q3mUS3sjqQ4msM7jFzzl79ffArFw+5Hvx0kNO4o
	QPnJExm9F+pf/ZrruBvzkEquNVkyZyRDxIecapw+UAPWH/+V2hQpvbUDKl15gbqoABhlLq
	+hzuxBEzbsujR4jnk2Xfpjk2IIDQrFPFhY3aJ/ktQsASuYS0VGsAHjQEG679MbXA6/b4xn
	9tIuH8P88GR6nzKxlWTRKd7EA/eXU5YGpVs/to5qzFuAqQxJsrrbPRHiNqjnMjs5T9vJ5b
	suCc3kbrUVmlBwGHnJLosTvbfQ780/i9scNqwwYj7kDawAUignheWsMht8MaTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710934148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M4qZDfeqdgUN7WwW07gOdPYTQ8hzgSGfC9I8vI9ySrQ=;
	b=6AbpP4VorMVdt2xHPU/GrukrmO9bQSz9DqdX8PyH0teQhWqnYHp1IKhd40ae9cWC2jPdLz
	UraY84+UL0kipbCg==
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
 subramanian.mohan@intel.com, basavaraj.goudar@intel.com,
 thejesh.reddy.t.r@intel.com, lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v5 02/11] timekeeping: Add function to convert realtime
 to base clock
In-Reply-To: <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
Date: Wed, 20 Mar 2024 12:29:07 +0100
Message-ID: <8734sli1ks.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 19 2024 at 18:35, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> PPS(Pulse Per Second) generates signals in realtime, but Timed IO
> hardware understands time in base clock reference. Add an interface,
> ktime_real_to_base_clock() to convert realtime to base clock.
>
> Convert the base clock to the system clock using convert_base_to_cs() in
> get_device_system_crosststamp().

This really is doing two unrelated things. ktime_real_to_base_clock()
has absolutely nothing to do with the clocksource_base related changes
to get_device_system_crosststamp()

