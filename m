Return-Path: <linux-kernel+bounces-136610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24389D622
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA29D285F00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5304380C11;
	Tue,  9 Apr 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yUJNjNeK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RudeqC4D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BC8004F;
	Tue,  9 Apr 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656718; cv=none; b=Tj+nnyQVusnGWRNpgmu+U+0WJblWge8sG6wUpzbfX6X6YEiDqLhq+Qnv6lml0lc5iANrf1ILf5VNvIHjMcJzAqz2pekFBqMAkRMoru8QoFkq3h63HJanyFIi/ERp0np9XbWfy6sedXqk9xWD3t0Gie8RIwDJTJEsxn2+sSTI8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656718; c=relaxed/simple;
	bh=TDWicARIPMuMDq2ra9wZntrVl26yeJtNleDsR89JkN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHrRECpUkFfY7O+Gg+UHd6DzKZJbI698cwnWnzbwz2mO3RgkvjPBKyOSmWreNRna7FRxfgl6FPtgi83g9rH9sbxPzKxfiLvQVlpTDqJDvKyOMePmxiqQBvHVxCXsJ166BqpKHWbHFjD6qRNGKGqPzFr2Krbd0OxwYNIUFVN9hRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yUJNjNeK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RudeqC4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712656715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKspgdo2jemqpn3T00b+Xa65C9dMoGtY4Dq7FXO0Tyg=;
	b=yUJNjNeKDiThpVYIfc/hToqHg6dkX3L/HoTYvzbPfhlp1m8uKGs2XlnA7L8y5fI5N4cOFQ
	dQ32nytZ/3UjhNV3dbTOO3Jfj16arUKQd3ugTeQbmVrxaxteUt94atCZh9WNssL7HPPxr3
	pCn1ZaCza7yC716aaOz0E9ElJsPiAsyL6aSGwchk4R4+heV6rolxLRbt3rqpDlNbHV0Zsg
	LM1od7FRSc1KMmptgN9TzUpAkmHkOtD8w6Z/GiQIOQr0nIuvqpNqMb/4UrsnnroGwkCm8s
	MZ283Al2wq+ZdOXvpPy3OWQoVsoJT3sajNpnJ3c4lnq/exiGmnSga1uqUzT3tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712656715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qKspgdo2jemqpn3T00b+Xa65C9dMoGtY4Dq7FXO0Tyg=;
	b=RudeqC4DlrksEdfkH3Xkz8ONgur7Wdpdnh1N4nAB5MWJHlWx6HGF7wJP3MPuxDdcYmBaf0
	oxZPsIOLB3/qZhBw==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv12 1/4] genirq: Provide a snapshot mechanism for
 interrupt statistics
In-Reply-To: <20240306125208.71803-2-yaoma@linux.alibaba.com>
References: <20240306125208.71803-1-yaoma@linux.alibaba.com>
 <20240306125208.71803-2-yaoma@linux.alibaba.com>
Date: Tue, 09 Apr 2024 11:58:34 +0200
Message-ID: <87frvu7t85.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 06 2024 at 20:52, Bitao Hu wrote:
> The soft lockup detector lacks a mechanism to identify interrupt storms
> as root cause of a lockup. To enable this the detector needs a
> mechanism to snapshot the interrupt count statistics on a CPU when the
> detector observes a potential lockup scenario and compare that against
> the interrupt count when it warns about the lockup later on. The number
> of interrupts in that period give a hint whether the lockup might be
> caused by an interrupt storm.
>
> Instead of having extra storage in the lockup detector and accessing
> the internals of the interrupt descriptor directly, convert the per CPU
> irq_desc::kstat_irq member to a data structure which contains the
> counter plus a snapshot member and provide interfaces to take a
> snapshot of all interrupts on the current CPU and to retrieve the delta
> of a specific interrupt later on.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> Reviewed-by: Liu Song <liusong@linux.alibaba.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

This does not apply anymore.

Also can you please split this apart to convert kstat_irqs to a struct
with just the count in it and then add the snapshot mechanics on top.

Thanks,

        tglx


