Return-Path: <linux-kernel+bounces-38308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EB83BDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF7028B372
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C61D54B;
	Thu, 25 Jan 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcfQFFgA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11gTAjYI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBAA200AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175737; cv=none; b=CRzDPCThjSNfS3Kd8vf/YykbrYRQ/2ylS7eDplqzk9sTAJ7DafMMamL8rzGKQ3LaVKcvOevggyfn94QI82OJN6mBi8N64c0pUqk1MEhqJrNvvujJxnSKlGfaBZg/PGeQGyAkoUxNpf18UnGYPPsTYk+XPYl/dhrFAE2gVPAbJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175737; c=relaxed/simple;
	bh=NEumvqjxHP8WbO9/8fl6y31V1m91vIhF+/ycAMyh6NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YI03N6S2DSamIrR+qlMqo98j9TfowsjwfXEqrLs0HdSTo3ny7wkSQrMv+4f2Al0A5ghfpxoMNcceyEx1X2/d0+ht55ct9vJEQacay7mhLW0OEAF44x1D2DmB9TWnA3kX9FbIdAsDQCdqX2zwHetdJqU1kL+5Ser/LRfk5mkV+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcfQFFgA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11gTAjYI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEumvqjxHP8WbO9/8fl6y31V1m91vIhF+/ycAMyh6NY=;
	b=bcfQFFgAWTjag9qaPshXPXNlxhTDo/v8EwXv7/hxqWR6azO9RkiEjrbfnzSQenCFe5yUT5
	LAdCicqYA9+cf2VCRVjmRlqcDsGZUbHioZJK2/ozABzhr0DFq9pxE+0gMDUbv0IcYqUgbA
	MSJu1BPtIUIBao834GxSNtzpn4KJNV5ayDkxl7VeWPJ4xnhrqYGnyKRsHT6bKSC7Z1oAfW
	Kxwzy/T8/ZKO7D7NTiYnjd4U4PaDc2iUAW5nEzX47JlinrH9I6Qhc7SejVTeTKk8e/E26d
	4W/IhSqU8IaFAXBzMzk3RC94SHENVBJsr8SuigqgD6wBslFHxr340N7ThS/njQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NEumvqjxHP8WbO9/8fl6y31V1m91vIhF+/ycAMyh6NY=;
	b=11gTAjYI3wYRvsY05ioKbPnXKwLq0hwIVN+NAZ/AMc2A1Zx0UVKsfCYLjQwEliFVaBKM40
	mpjYpjJAxvlL16DA==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 13/15] tick: Split nohz and highres features from nohz_mode
In-Reply-To: <20240124170459.24850-14-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-14-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:42:13 +0100
Message-ID: <87h6j1iway.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:

> The nohz mode field tells about low resolution nohz mode or high
> resolution nohz mode but it doesn't tell about high resolution non-nohz
> mode.
>
> In order to retrieve the latter state, tick_cancel_sched_timer() must
> fiddle with struct hrtimer's internals to guess if the tick has been
> initialized in high resolution.
>
> Move instead the nohz mode field information into the tick flags and
> provide two new bits: one to know if the tick is in nohz mode and
> another one to know if the tick is in high resolution. The combination
> of those two flags provides all the needed informations to determine
> which of the three tick modes is running.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

