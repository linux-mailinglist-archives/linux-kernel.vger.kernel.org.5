Return-Path: <linux-kernel+bounces-83712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A6869D92
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378C8285E41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3C149DE6;
	Tue, 27 Feb 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUvVlJzc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UlmowWHr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FA14830F;
	Tue, 27 Feb 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054635; cv=none; b=qQsAvIfCIpHFfpQ9Z4D5/Ron2BKDEqxMun+mEjvuwEtDcWtvJjhrfCu4z0aIQo6adl9uW9qNUg2yrYLz0cS7yw1bf53F8wSLxU5g1idUm8SYBDZHwaYkDfdlVbcjeOGR+VvO+Mr+pC9joC3AHjIe/xN19tYi1x0GkzmqwBhmCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054635; c=relaxed/simple;
	bh=xlZyVCMWEBnGE08Ta5ctgjEj5TmCCEbtRLDLkzlk01o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4TRKJltlN+0hdyzyAEdQfwZduo8E9O6JUEbI0UwuIvHcooYX5KdWPhNd5+fRSjS44leH6MRExSTqaGG7r3aHJsZFl73PLggZ2v8h9CzAAEOEGx/y353rwsiSVC0iYgphGKwBqFrsSOlBzmtEX43bEfDuwXa4Faow3PRMmWbFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUvVlJzc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UlmowWHr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTtdD3Xrcr26050qG/wJhYNywK18VvSVk9OIhhpRR5U=;
	b=SUvVlJzcuaVjWbGSnWliEzygA3VxbmZ0H4NCvZ/rAZLBfErplr0sn7Jr3snH8lkQ0xqa8w
	6IbOmh8InLS8dLpo0QjO2O0PIKuuzX4C3qUE3EU31jwHLQwD5pFB4DBNJmCxtT3fEOf9Cp
	DJaSWMW8HlAP8ytXJioapKPuHQkoa1A8Gui/VIkge0XKV1SQNFg/pMh7UfpDbvoOlokI56
	wz5+oPh6eqvggEt1SchfB5TiKC2l7JTErf7k6b0rA9cYHRbD9wLC7KEeQ1Oj9+rBirKf/I
	cVJZ+44B6wFMYPyzb92qPHTxJlQIkZdHYYqbC5qWmSJAdGRBzw2ggVbAb3kHbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTtdD3Xrcr26050qG/wJhYNywK18VvSVk9OIhhpRR5U=;
	b=UlmowWHraF9oHUzTRAnyGgarSO+vqPI8Xl6VoKziX0/l+ZfNBqgcsQDmPcA8PEISLLhYJZ
	G8kvs+J8SdcNzxCA==
To: mikhail.v.gavrilov@gmail.com, Mathias Nyman
 <mathias.nyman@linux.intel.com>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, x86@kernel.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: This is the fourth time I've tried to find what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
In-Reply-To: <098670097a6fd59f3e254c5294882f3fa12e3c65.camel@gmail.com>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
 <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
 <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
 <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
 <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
 <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
 <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
 <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
 <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
 <acc2b877-4b42-fd4d-867b-603dae95d09d@linux.intel.com>
 <87r0gz9jxp.ffs@tglx>
 <098670097a6fd59f3e254c5294882f3fa12e3c65.camel@gmail.com>
Date: Tue, 27 Feb 2024 18:23:51 +0100
Message-ID: <87y1b595y0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 27 2024 at 22:08, mikhail.v.gavrilov@gmail.com wrote:
> On Mon, 2024-02-26 at 19:09 +0100, Thomas Gleixner wrote:
>> we don't have any information about the overall workload,
>
> During measurements nothing was running except iperf3

Ok.

> I don't know how else to help you. What information to provide.

If we want to understand why CPU0 is problematic, then you need to use
tracing to capture what's going on on CPU0 vs. other CPUs.

> About repeatability my "unlucky" scenario.
> I have two MSI MPG B650I EDGE WIFI motherboards and this problem
> happened both at the same time.

Sure. The probe order and the number of interrupts are probably exactly
the same. As the spreading algorithm is very basic, it will result in
exactly the same setup for both.

> It seems the problem has always been there, we just never noticed it.

Exactly.

Thanks,

        tglx

