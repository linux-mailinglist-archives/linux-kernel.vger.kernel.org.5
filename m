Return-Path: <linux-kernel+bounces-112481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26B887A59
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14E4B21547
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1835A0FA;
	Sat, 23 Mar 2024 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TG8xN/Lf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLDuLGbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F45CB5;
	Sat, 23 Mar 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226642; cv=none; b=CMGwuq1HDnQyqjkoAs773EW7mTvVltttILq5SyjW4UCw6L4BEQ95tjohVY7Q+IU1X95R75Tzm1fDlG6YS0yEIQzr27wdjjB4a9HC1aQCmmXjMTKyVZK56M93mWyQOAPmfjQBDxMvVG11n8XBhjCePGR4E/AGDKY3qCcVXw8dA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226642; c=relaxed/simple;
	bh=9OGV87C7lNe4Tm2I6F3pZZZwMrb6/RZRUSbGM5CS/+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsZ+WSJs+WOnVInvtmsrUQwEruzyvz6Sm0HWsDCUIJaYYeSjgUD0rauJLWWlOy/7jlGSS2+/DvIoesAJ4jCUXB3FSlLLKUtA9liPIlHSC1nhuh++tGahcScRU2sr34oAyU2l2QopQqtYasSNacO8HekyuJn0SzJ5rYUcbpRGKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TG8xN/Lf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLDuLGbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711226639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=498F8PEQ9wEXgdD7gmsVyIePv6lPN9KMgR9cake0cII=;
	b=TG8xN/LfoRRdGRKLPJytQ0WbpsaWMv0WrL4DXHc0QF2TG12Q+SQKz6wiObWgnnW0HcR/Ql
	F7NpwBCwlA2vJX8wi6bn4x4VVQlSM5xIJQKIHzRKU4I9+XuSiat0R7PfEeZifBlwk4bJAL
	yvEB7eWVJx7O4K4GgJ3YXt6yO//Uay0/EmyvWT4oESAp+K6tUUEXEQ0ZBxK2rsiVEj8bEV
	3Bzbt37hwIC0Ytzq/bSAlCawj2peBQWRNNvikh9Hcvrg0VIKo1H75ASOhVTq+sdlRR2Hkm
	sjgXecrKKsUDj5FuF+LpeihW7o64DPQnycD8y6KM3vUmurhroDmduosVLQYLHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711226639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=498F8PEQ9wEXgdD7gmsVyIePv6lPN9KMgR9cake0cII=;
	b=aLDuLGbKEM9RIsVsNKRqttDQtUs33o/e8HGUnEg3BejCTi8TFZVBG6mVCOBMb9MEViBHMg
	qYbmaaadEYPf6dDw==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv12 4/4] watchdog/softlockup: report the most frequent
 interrupts
In-Reply-To: <20240306125208.71803-5-yaoma@linux.alibaba.com>
References: <20240306125208.71803-1-yaoma@linux.alibaba.com>
 <20240306125208.71803-5-yaoma@linux.alibaba.com>
Date: Sat, 23 Mar 2024 21:43:58 +0100
Message-ID: <87zfuofzld.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 06 2024 at 20:52, Bitao Hu wrote:
> +	if (__this_cpu_read(snapshot_taken)) {
> +		for_each_active_irq(i) {
> +			count = kstat_get_irq_since_snapshot(i);
> +			tabulate_irq_count(irq_counts_sorted, i, count, NUM_HARDIRQ_REPORT);
> +		}
> +
> +		/*
> +		 * We do not want the "watchdog: " prefix on every line,
> +		 * hence we use "printk" instead of "pr_crit".
> +		 */

You are not providing any justification why the prefix is not
wanted. Just saying 'We do not want' does not cut it and who is 'We'. I
certainly not.

I really disagree because the prefixes are very useful for searching log
files. So not having it makes it harder to filter out for no reason.

Thanks,

        tglx

