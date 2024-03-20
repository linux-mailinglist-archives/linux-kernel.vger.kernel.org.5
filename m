Return-Path: <linux-kernel+bounces-108849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F385B8810DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCBF282525
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F323D984;
	Wed, 20 Mar 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KvlwfhtK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5S4OJ0Bq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD33FBA3;
	Wed, 20 Mar 2024 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933821; cv=none; b=tVay2u5krvbJsmeUA6dhHKRbYOh14OEQyA3r4DM0FgFAsoKkSy659OlYqpyrdPHqsceC82JtpievKb1TUNbQwtcgjm8R9kLOIg/ish0d1WrOE47U44PUc6Rh4t7H8tQlIT4fls19cdRtVRhq28jfw+H55Ixef9xUngDg2QKLTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933821; c=relaxed/simple;
	bh=0aPMYZqS1U/faF5yL5h5SYsSJK/wGQpWX/DtVL7hT4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXScvIj/GXTYot5E0rwnK1//GGNen4NXtVfjoUeBbtbJGCSlddf806uGx+rh5Id53tfVc+/N7ys+3vc87SM9PuBCGkHjsgGIoCkbrjE7NW9T4/NN7zLqRFrvuv7FML23YIY0XvvoKZl7auninnsBrVsoJdwxbYwFvMuVxqIKIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KvlwfhtK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5S4OJ0Bq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710933818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTym/nC5xD61zbRK5hpctTKsJawMwlPvb8OVQ2E/Od4=;
	b=KvlwfhtKxgD4GRV4La6sGDGFZr+2/2uQrcTfqM3vprppbQRBkL/TLG6IXU/hXtuEdKTRWU
	8j62Nfc078Ao9H36UHuTIm9El2GoZ0LbJ4UnXyyIh2KtBC0/qwC14k1SmTqRP/f177mK7B
	DlIuApaSsLAFcCx09fnG5xqcxZf/lewP6w/aPQFYdFLQkKbMHzXVPSVQTwD4g380A5a0nR
	bohRu65iUTWfJXh2G9qDlxCeLHYbtn/1RxX6elSI50rVI25EjfOaq1jApa+jCL4PJS35ME
	6FOW71TXq+emFfTlbaT2VVOyWI/HQuDjjudpJRADjjmMZ+Gw/YNJKYhb0SCrew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710933818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aTym/nC5xD61zbRK5hpctTKsJawMwlPvb8OVQ2E/Od4=;
	b=5S4OJ0Bqq8GLmgf1t47z3Wr7Pn74Q0Z8hp6uTTCi/CglQBez4Y7PgP+9Y8m7R18/ZWh6QO
	7N63F1Og9OVrh6Aw==
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
Subject: Re: [PATCH v5 01/11] x86/tsc: Add base clock properties in
 clocksource structure
In-Reply-To: <20240319130547.4195-2-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-2-lakshmi.sowjanya.d@intel.com>
Date: Wed, 20 Mar 2024 12:23:37 +0100
Message-ID: <875xxhi1ty.ffs@tglx>
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
> Add base clock hardware abstraction in clocksource structure.
>
> Add clocksource ID for x86 ART(Always Running Timer).

This change log tells the WHAT but not the WHY. You have to add context
and explanation WHY this change is required and why it makes sense.

Also I think this should be ordered differently:

  1) Add the clocksource_base struct and provide the infrastructure in
     get_device_system_crosststamp()

  2) Make TSC/ART use it

  3) Add the realtime muck

Thanks,

        tglx

