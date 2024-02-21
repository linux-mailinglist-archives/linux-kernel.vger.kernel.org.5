Return-Path: <linux-kernel+bounces-75158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8493085E3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0CC1C2273C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4283CB6;
	Wed, 21 Feb 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKF9hTRn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLHUGzek"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73E83A12;
	Wed, 21 Feb 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535067; cv=none; b=SEW6jGQhmOkTqSLa9xI9ikXaXRDBCPDPZxqQ3XF2YpDA66jiinLdQUKbIMebVmQFn2/V2iX9Ef1G2mckrS+EqtxdpLwijoJWEQmfWz1R0qwIpnIjbSFuqIEj5PxfqQq035RAPqp5kIM3CXKUHNykmteVqoU9afw1NSd9LTz4vHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535067; c=relaxed/simple;
	bh=I9BPIMQV8ivzAq2sUNXIWktFBAZhuoYcLn9hK+92n3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DX83b1WvCU1idgVqBLTwr+BqH5vBrmQBOsdE1Kdb08xi7hhyx3C96LNCw2WHKfcyuYGKf26LhCJeb16jDb9ID7vtREg+mZ/5/6foswpS20tdCYHxsTTkLozA5TypoTNNNlJFuv/fj86WKwBzDeyV+KAd5CbVREOssmrN0RFENwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKF9hTRn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLHUGzek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708535062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/2PXeUtYZN5Banhfqv2e+wEkrcm+AGTORes2hTmKPk=;
	b=kKF9hTRn/NdeRVN/fjSQ36SK7Zt7CiVyKGHrDJzYPqU0cXodAWIB/lUF9AjSYLYhDC5pHM
	VR++i0UzTHTD7IfjU2W0BA8BIpmXWPOOxssJfqsDArwrdX0FXqQNO79viSVqzcxO0uIddu
	jWKpkJlGMoatTw6CVsY7Py1oVOMmVpAU4sq0iWXsZ2aM1ewa1WNBJphhA/Ih7GtU74xcQs
	sogpPaxc9Endjt9XGRmJs+kJxrAUqCqvipRfyjWHFFV11pxFisAkrpzpCB0jUoUW5gg8/R
	qSSi9iXBJHCt36FSNo5la0FOTGGFSzfTf+T6ioISkGwD/wcyNeaoSjCNWDXTDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708535062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/2PXeUtYZN5Banhfqv2e+wEkrcm+AGTORes2hTmKPk=;
	b=rLHUGzek8UDGvurt1OgFa5LrZ4A+qJ29OC7ELGvQHxrIjqGY/PneNNgi5prXv4tdqQJbZh
	O/aOtUoeywd5CUCg==
To: Leonardo Bras <leobras@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
In-Reply-To: <87edd5hljz.ffs@tglx>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx>
 <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx>
Date: Wed, 21 Feb 2024 18:04:21 +0100
Message-ID: <87bk89hhpm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 16:41, Thomas Gleixner wrote:
> On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> But as I pointed out above the detection logic is flawed due to the
> unconditional accumulation. Can you give the uncompiled below a test
> ride with your scenario?

Bah. Ignore this. I misread the code completely. No idea where my brain
was.

This thing triggers only when there are 100K interrupts and 99.9k of
them unhandled. The 100k total resets the unhandled counts.

Though one thing which strikes me odd is that this actually triggers at
all because it needs 99.9k unhandled out of 100k total. That means on
average every thread handler invocation handles 1000 hardware interrupts
in one go. Is that even realistic?

Thanks,

        tglx



