Return-Path: <linux-kernel+bounces-103112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F887BB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4962E2847CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7246E617;
	Thu, 14 Mar 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q0Td9r92";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVDSoewy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778506BB37;
	Thu, 14 Mar 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411729; cv=none; b=NI+SyEQ///fxdMPwhuDJzr4u2v7NJzaERUHLmFcUCsIpjNARtFnPFS3gIMmmbBHzYMaCnL8946n4i0oZ4UG3+OzYgTdHreMOr99gcAP8fB88A6dKIwd7Ywv7SPkYqso1PE3crZg6FOqhANr6XMejgaM7AezGv3ey1IPG7CYx9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411729; c=relaxed/simple;
	bh=1W+h1GqxXgOrrG99ZPrDvoA6zLpNgyRNT1se9nehkzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WwOSqZmiOnqg+QaAaFDAR7gVmliXg8jKAY2Sag1XxpV+F374pJTXEwwIJnDTG8QJCCYH9eeRBJ0rygHH3qPRuF0/oYIyWJfBEUmuXBXEYzSUHxq9W1X98WanKFK2ovJ8sO8rhgGASCzy36T/Kw0UvOt+ENBiVMJngJ3/7EsDRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q0Td9r92; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KVDSoewy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710411725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1W+h1GqxXgOrrG99ZPrDvoA6zLpNgyRNT1se9nehkzo=;
	b=q0Td9r9210fJGk/PUWAQUs5Pa8uhqh04NdZ3wWMc30egCrkyyYGBcTDgJ099kkGmmhekIc
	1f19Nr4NFDipIN8lJyICxO0RWOIQFayk++p4aGoBzUAgYLatrFRyaeFHAacIHU/88s1Gh0
	eJB0oWHWytojJjFNfO0hXb3zJ/W5EasdlQs9ro85Ofqr9lNePuqTXzdPAjpwUmIZZK5sIa
	3C/e9HN1m+2RbB9wCnERfl9fPjUOZF4wYNBvzYU1cmgL1OtU571pG9g1Og+NHxU/FAIHnd
	Lc2Dhn/EgTz3EPgwBrsev4pbvswMWWLtqKfa8lKjA3xhi89c1pHgXYLXRMSATQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710411725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1W+h1GqxXgOrrG99ZPrDvoA6zLpNgyRNT1se9nehkzo=;
	b=KVDSoewy1R+7GEICR/m8T5A5RGMBbl6QBsJc3/2CLK+dfXK8n9Pkoj2BqnK/JSd9XwjQLy
	CguijQrXvksFOjCw==
To: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org,
 enlin.mu@unisoc.com, enlinmu@gmail.com
Cc: linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
In-Reply-To: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
Date: Thu, 14 Mar 2024 11:22:05 +0100
Message-ID: <87cyrxm7ua.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
>
> On the Arm platform,arch_timer may occur irq strom,
> By using the next_timer of hrtimer_cpu_base, it is
> possible to quickly locate abnormal timers.
> As it is an out of tree modules,the function needs
> to be exproted.

No. We are not exporting for out of tree code.

