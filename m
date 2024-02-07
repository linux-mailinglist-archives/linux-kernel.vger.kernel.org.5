Return-Path: <linux-kernel+bounces-56723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1184CE16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B50B28D73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC27FBD3;
	Wed,  7 Feb 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pX3LTP6j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rd8/9nVM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A727FBAA;
	Wed,  7 Feb 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319866; cv=none; b=JxL3vXlDcnyiQXtzd8sZZj4CKTOFs5eb8iDodgM8YJHKavlTKiaDeAdBm2gOS7uxv/LRwq4mLgs6yNlcgqKmrxfIjAe3Dij5iW9fHhaBc+d8MCYm7Q966I7DJJ8b1Eu28+BDa8nOqT9EACw+sgc58b5wD+sXGW8syBx4YyxcBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319866; c=relaxed/simple;
	bh=eJeLndhWGRvAdTc5kciWtPegu1uaVizibVG6t8sSW7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7PPlaKe0sF5QCjEF/VsBpsEV9CaUr6y+aCD2grZA8vYCPN8DgUXLCOy7eG0RI1Sip1nfGTmUnWpEvyF67gCxeBq1mQj1cEdTvCefsS700BGKSQtc1pvJKfF4OcWo1SS9eaCRoROL+3T59EywIjWkzKH+SCX9tq5DqU3tTDKH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pX3LTP6j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rd8/9nVM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707319863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c04kwZUxrvzi0qvbSSBFwoEI3C7fipYQbJIv4qBO2mM=;
	b=pX3LTP6jV2sgdSLm1wYHtfx8ErZl1KpxVfPY9rb03KkNx8HshqzA+MQcD1oD+pi1+98JnT
	hukHm/rQE4T/Lr0aLnUxVqVvqkE0SolHJ/yHRTHKhMDUDtp0CvUlgAXyz3HCF10+FoOdYz
	IJEsyZlpaw3Vl+KUtMsDd3Ev5iCeIl3bNmEbHx0zde9t7+1gvIJ2x2N2xH0LzDgNQxSKj3
	9yTiqHI/Ds4eZBsIRW9Lgdb+gtmkus9yy91OC+l1pbflBSuHxvfOEsSJ+IJZmVXCyL3zmN
	TxDv/fPfWOpMNNhgZ4GKkOJlg/J7BeDb/iQCkcKbXsDjLp3f/uk2NESKg/0wFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707319863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c04kwZUxrvzi0qvbSSBFwoEI3C7fipYQbJIv4qBO2mM=;
	b=rd8/9nVMjgPNsldK9YDX7YWT5kRNdt7AE4DtqnZ0JUjYD/Rpywr6xjdjT/asiFcpRtTF+B
	CWRJeVKy5QeunoCw==
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
 subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com,
 lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v4 07/11] ice/ptp: remove convert_art_to_tsc()
In-Reply-To: <20240207060854.6524-8-lakshmi.sowjanya.d@intel.com>
References: <20240207060854.6524-1-lakshmi.sowjanya.d@intel.com>
 <20240207060854.6524-8-lakshmi.sowjanya.d@intel.com>
Date: Wed, 07 Feb 2024 16:31:02 +0100
Message-ID: <87bk8smguh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 07 2024 at 11:38, lakshmi sowjanya d. wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Remove convert_art_to_tsc() function call, Pass system clock cycles and
> clocksource ID as input to get_device_system_crosststamp().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 3b6605c8585e..104b3f7a7cfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2101,7 +2101,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
>  			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
>  			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
>  			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
> -			*system = convert_art_ns_to_tsc(hh_ts);
> +			system->cycles = hh_ts;

Fails to set the ID.

