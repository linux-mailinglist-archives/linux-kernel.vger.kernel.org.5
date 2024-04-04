Return-Path: <linux-kernel+bounces-132016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB6898EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A441C28E37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF113340E;
	Thu,  4 Apr 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkNAbNwI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cebbDBc2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246413119B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258080; cv=none; b=sp4g0apSrKPMvyh3b2CazzOxOJiMJig+gFaJpwIMs/oKgAwyZ50G2lPz+dRYAGi33ELoh+8HvuGYvIGqkggFfe+TecqhSF4I7ZbeB9dSuTs/O8sFXUGInYvq7JdX1VLCk/7idj49woQdpNXjnkCaGTVQtmLJpAI7pIH7TRBq63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258080; c=relaxed/simple;
	bh=sdHFK7p1/a+5/T/sb21+gerrRKafGvEpyELD4MFGT8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4PMT1F5QGhEgCQEVAG3x+o+Uy5nWhPTMJ5m3H7EdtnktfYiN0soLiZJcEhpg0djAFcvfNrYQ6dqMCMgiQFH0kGyyR1xLN8TnPQRsWhRO3p5YOG54NfW8MsK7MGgizDGYTvh2Gsiw+adD0/Ui5fWMLdZrGY+J+OXfi+XAO6cisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkNAbNwI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cebbDBc2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712258076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdHFK7p1/a+5/T/sb21+gerrRKafGvEpyELD4MFGT8k=;
	b=PkNAbNwIUX4hSRDn2xNu07YRkGmOpLupIOu+nFKJjrqbr9+BuGfLHQPbU5R/is3SLaif8p
	z52ObQw9aEEHXD5eVOGnhGDUo2ipoe371Ps8e3GyljezFiY9PeqMYysFyWRliB4vXWbL0W
	CCVM0YRVNoFRzSGwGXAvPH/8XrPgoKPCt6qxUo2TbDfEo8NivRK8jf00m82x8FKHnz3Fsx
	71MayRiegKqJ5tfMHrWXi5MMvfNU+OvM2q8jf03k4sdSNN/uwwCg/v5XaQ+QuggZ9G6D6H
	t150fJk1yHEBMlXq0xkVMwn+afGkGCcwWCvlDs7DhpQ13WmcMoCsxeEFG0mSHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712258076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdHFK7p1/a+5/T/sb21+gerrRKafGvEpyELD4MFGT8k=;
	b=cebbDBc2ozZVnH/omkxJ+XROFySaE4Dtr+8UPPokewxPb4wIAdZFYi/4aX1CFZT6QSrUoz
	68wJHGZtawl5CJBg==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <87plv59f45.ffs@tglx>
References: <874jchb7na.ffs@tglx>
 <20240404152317.464796-1-laura.nao@collabora.com> <87sf019kbd.ffs@tglx>
 <87plv59f45.ffs@tglx>
Date: Thu, 04 Apr 2024 21:14:35 +0200
Message-ID: <87frw19bz8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 04 2024 at 20:06, Thomas Gleixner wrote:
> On Thu, Apr 04 2024 at 18:14, Thomas Gleixner wrote:
>> Can you please provide 'cpuid -r' output too as 'cpuid' does a few
>> tweaks to the raw data and it's hard to match it back to the code.
>
> Don't bother. I think I figured it out.
>
> Can you please test the patch below?

Bah. Won't help. Let me dig deeper.

