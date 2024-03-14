Return-Path: <linux-kernel+bounces-103209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30787BC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2FA1F2215C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC166F077;
	Thu, 14 Mar 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHhSGuJ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdeWtq1a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C516CDB5;
	Thu, 14 Mar 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417567; cv=none; b=a4tZlKwRkReUpYmBPjXt5ZzyCUYxjoDm5ue3CK6Uv75Q/rkobmXi7Gjl/YjWsVEHuvxCUgTNzDdNj3J68IThPmVJo7QYPmZK1JEgEMQY4t4FPQr0CzC3+DGK3NOFhwqOlz+UK9mJB6EtF62pzWe8D8zX7bhavnug2OYKDc5xThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417567; c=relaxed/simple;
	bh=wQwLX5+joQVY/m52drETTB0dGlfxt5LT0ob6q9kKAlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VKrra1J1RMT4zdszuUZvrVV+muAJ43zUmaJZdVAr/R7wVkK/1hL9LCdvt3tzmNzUVLkGC5khbssX/M9nEnAu/oIJOKyjpKOtBdVs4zQErfG/5ohrvKHPf5hC7ke1NtxYW7rnFGqFuIc8w+qr7ZFHq/6EH3ALfBgQNmvZp75WwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHhSGuJ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdeWtq1a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710417563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQwLX5+joQVY/m52drETTB0dGlfxt5LT0ob6q9kKAlI=;
	b=DHhSGuJ+8KCXSw7X2523QenpsCZ7mXPH/H1HQ6qU/KlhLuGfjxDfXEUTWBXdsHmRNwA9vT
	4y7V/QvhsQum10C7a8n+sYALDKwtjRCephX7Mc1xN/qbJGTHhJV97TEKJ1EDeeLW4H25Jz
	HCaTxqEPj0mSo4Oaxf0eh7zhCcavMqagYHdGTZopHPh42+i2YUj+tPvh3L/4geLxbMI5zc
	2QOKu9UxgbnydN1V8JXHm7EUOfOGboSkeV4q7Pixn5kjT2PZWe2uHsvZQ5UKspDdRQLGeW
	09Ico1OzR7/5N7FrejS+clhIywW68zpqPEmobPukp9WB/WFLSmNk6IRXak1M7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710417563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQwLX5+joQVY/m52drETTB0dGlfxt5LT0ob6q9kKAlI=;
	b=RdeWtq1aQOXVaoLQFxXLgobT9t7lVTMhsFcevWw2nDxIg5NlBykRLyUr54ZHtH1Kmm3W84
	6Z4mLqoQRpLHw2Aw==
To: Enlin Mu <enlinmu@gmail.com>
Cc: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org,
 enlin.mu@unisoc.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
In-Reply-To: <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <87cyrxm7ua.ffs@tglx>
 <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
Date: Thu, 14 Mar 2024 12:59:23 +0100
Message-ID: <877ci5m3c4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14 2024 at 18:45, Enlin Mu wrote:
> Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:22=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
>> > From: Enlin Mu <enlin.mu@unisoc.com>
>> >
>> > On the Arm platform,arch_timer may occur irq strom,
>> > By using the next_timer of hrtimer_cpu_base, it is
>> > possible to quickly locate abnormal timers.
>> > As it is an out of tree modules,the function needs
>> > to be exproted.
>>
>> No. We are not exporting for out of tree code.
> Can you explain it?

Exporting functions or variables requires an in tree usecase.


