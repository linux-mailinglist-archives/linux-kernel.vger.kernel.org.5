Return-Path: <linux-kernel+bounces-102476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6387B2A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D181C2265C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FE4D9FA;
	Wed, 13 Mar 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uyO/mUu3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03E225AF;
	Wed, 13 Mar 2024 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360731; cv=none; b=knbnzCY8VMT1+6hbzRejxNX5dc28qz+FsOg7CLeTXdPP9QSWY/jh4B8hmhED1rUq39c2g0ZPhScNxNqPfs9++cBgxazdcWYaJGOl4yCSLuNx3xWPDC2tCOlZTkWyMMKHdGDXoxjEEiNmrTzHYk8cJmPUfVJtKXP6KnmMV3ZcIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360731; c=relaxed/simple;
	bh=vxiSIG1jZQwlWtR6AV5q/3NgPvGpxmDe0qfJ03T7J/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugvHWAn7wYkK6pouxzkfDHXmb464PSxAVf8JEetUepNvw/PAZcoiD9fxDh9LooOnRkQUueyg0MbBmVzE7bvd9f059qzt90AoYDWvSiNuM0GTxFOH1o4LxpiYQeILcKHg/lRFfix6G+roN9lNF/b9TgnVHNdg+GDrLuDeKcPdhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uyO/mUu3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xp82gEIbZeLnmlswzlNrQpFNfajF/0oeJJd0n1Kue3M=; b=uyO/mUu37qErfYKSWEqKd3wmSq
	R92vQ0Yv/x3wGFeS61sdERP3c8R58AiQJcDKZWMDD2tYjU7aAfpuSODq8UsXekoI0N+bYq8lpWfoj
	5mZtGQ4mTrXRiz83cgieU7Sw/vfr469Fi6WdYPCEebdmgUvvXdQsJhMbOrBqKgYnW6CI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkUxr-00AGOu-Ik; Wed, 13 Mar 2024 21:12:39 +0100
Date: Wed, 13 Mar 2024 21:12:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.oasis-open.org,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"Ridoux, Julien" <ridouxj@amazon.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Message-ID: <04246331-e890-4c9a-95fb-9673580e6d30@lunn.ch>
References: <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <202403131118010e7ed5bf@mail.local>
 <dcd07f0b733a90ac3f3c43a4614967bbb3ef14ad.camel@infradead.org>
 <20240313125813ec78d5a9@mail.local>
 <96be7312f7bddaf06c690e082a8028fa8b511deb.camel@infradead.org>
 <202403131450547f373268@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403131450547f373268@mail.local>

> As long as it doesn't behave differently from the other RTC, I'm fine
> with this. This is important because I don't want to carry any special
> infrastructure for this driver or to have to special case this driver
> later on because it is incompatible with some evolution of the
> subsystem.

Maybe deliberately throw away all the sub-second accuracy when
accessing the time via the RTC API? That helps to make it look like an
RTC. And when doing the rounding, add a constant offset of 10ms to
emulate the virtual i2c bus it is hanging off, like most RTCs?

	  Andrew

