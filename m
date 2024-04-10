Return-Path: <linux-kernel+bounces-139361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACAB8A01E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ED32884FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A14184101;
	Wed, 10 Apr 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwHViD6I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNxLVhfT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CA1836E0;
	Wed, 10 Apr 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784048; cv=none; b=ohQeQS6ggrSH4r+FVqBQyKsSf2JO5AF4GpzrY1rjEpD1M9QCo5dbtBaV5fL6grJvpqe+7PAprMdrlKwGlSWhtxKEHTm/tGgIQs+s09iZ7aOrY4a8e5z7wtRAPpocVrluXGdrI8uM7066gINgHx8V/oWL9PJIN1rvX1cTJxCJNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784048; c=relaxed/simple;
	bh=yZahjj479XacXe+rCfUPbnex64OHH7QkFDRhj0D3+IY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIlPaWxQ7Vx2uACWdB9wwuWwqaes+yeai+j/Rp//Cg7j3+7Fe9/Wh0PpH9HQekdawCASodRGBg1fRBUfY0gAlRxOMYAuw+8XpVFLt7qCw4gqBF6lpy3kuyfs4cIOZZmVIM+wPX7Nto5Lwa78/0t2I7JJQPy1qt4mUc3Jho/yb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwHViD6I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNxLVhfT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712784045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ekiFLA/bmLDiyq+3gVUA+kaAF0OcFabHDmCSx7h2A=;
	b=FwHViD6IqUH6Dt4mypFv+cxXod1xbN1HB4zKr64xGYPMeUgzzfMUVoJ3kvd+VB2CvQpdqb
	fHo+D2Hfhz+bnR9R4itTegQZbQC9gWjqfNAP97Llf0WXcwoDD5xaImLbrPk+rqf6FjuFyB
	fHpeCmy15bhH+oQNJH7DqekBYuMT//0O0aXrqBfHWIoAPFByXVaF9lHZVB2LgJDfSvlr0O
	xM9V1b7QNSNIm8LxQB3w5XPt/I8/WZ58t03zkl9PF+P+kz8pp+8somxMWj8WR2dOCLhV3k
	9zeaX8Ie/CHyXq55h5LUCieWmzP0hClz+gEEztT1OutcdXmqjLFiHcEhoESLog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712784045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ekiFLA/bmLDiyq+3gVUA+kaAF0OcFabHDmCSx7h2A=;
	b=TNxLVhfTSGEjRdOUAJEdbT0v1iAfoxcexXJbxNXc0RJ2rOoS0urv9iS637SyXee84icb4A
	v2DWCNmgXp4sKaDg==
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, subramanian.mohan@intel.com,
 thejesh.reddy.t.r@intel.com, lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v6 01/11] x86/tsc: Add base clock properties in
 clocksource structure
In-Reply-To: <20240410114828.25581-2-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-2-lakshmi.sowjanya.d@intel.com>
Date: Wed, 10 Apr 2024 23:20:44 +0200
Message-ID: <87frvs3oer.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Add base clock hardware abstraction in clocksource structure.
>
> Add clocksource ID for x86 ART(Always Running Timer). The newly added
> clocksource ID and conversion parameters are used to convert time in a
> clocksource domain to base clock and vice versa.
>
> Convert the base clock to the system clock using convert_base_to_cs() in
> get_device_system_crosststamp().

In https://lore.kernel.org/all/875xxhi1ty.ffs@tglx I asked you to
provide a change log which explains the WHY and not the WHAT. The new
change log still fails to explain WHY this change is needed and which
problem it is trying to solve.

I further asked you to do:

    1) Add the clocksource_base struct and provide the infrastructure in
       get_device_system_crosststamp()

    2) Make TSC/ART use it

But this still does #1 and #2 in one go.

If you don't understand my review comments, then please ask. If you
disagree with them then please tell me and argue with me.

Just ignoring them is not an option.

Thanks,

        tglx

