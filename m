Return-Path: <linux-kernel+bounces-131482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4989887A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FDA28A7B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5E8665A;
	Thu,  4 Apr 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xe85SSJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="49Cb+ZzD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D31E4A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235916; cv=none; b=SaQM75gHjCxtRrfoy24iDNVHCPucwzNIMhY4DpEmEnNG1oG8U7+zZ62jIgv2W8nozm18HAksEm370X4JMEewWTg1YdFUtCI0GKYM8pcYPpjfLGA9qdlqDz6zygZpZGgqYuvPL0DcmwFNKUnyC4ElO4QG4zpH1M9yFFczujNAAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235916; c=relaxed/simple;
	bh=R4d9+Tq2yuTymn2MJRI7oRSBN3ws9x0+B9iYO5ab3X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sh7GGusZHBTPTdxfRxZ6UQl+9+pb2B0FO2erqXs5+dV4U8KjTPrgn7Q1qMJWqEBzZyuAJ3Xh4MGoWS5Jw2ma8uxaE/vaaVOfOuNSyYem1zcdQb5SS65HQ3WaHxDepz7aLOmSI0STT/me96tfSzfRdDcAjvqHu4Brqxw+pkp2gGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xe85SSJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=49Cb+ZzD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712235913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9J5ctIKprExexRBqle5OJ6DAsejEIo1IBkZ/m315SM=;
	b=xe85SSJJyn0iRd+9iRsKrNguKKvLiRaMSYyIGo9kA4qLu3fJMoc3ObHW6VxdoC+VFfrAZi
	y8CZH3/n18yRay1D7nasonH76Vw3zcx2lcOf2iKAkJ256DpZ3gn4aTmnKpWyC3SWGnPX4o
	XgVnmT8DrxMj5uBcFvmDC1jXXaaNL3qEdCJLbd7T5kDBQLOlBbTbu1xuE2A8eUgB4n+BQ+
	SP1Zz4dL7VfwTB/qkvGKmNfOCOe7Wl7ltvrhspXfpwN4I2lfyR1tV5mZM2wRgF5Z0EjdQD
	FweDaHWM/FpjGqtdTw9Epb41CvJtr+Mi+alSvABVS+ceD9BZoqNicLCTVN2SMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712235913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v9J5ctIKprExexRBqle5OJ6DAsejEIo1IBkZ/m315SM=;
	b=49Cb+ZzDIUuj4tXYjuk9qn5NqHRDqq2IqANma049TM4DQNE0ADo/zG1g7G7tFSciO0eDD5
	50eMp9zAxy5VQODA==
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Laura Nao <laura.nao@collabora.com>, the
 arch/x86 maintainers <x86@kernel.org>
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <877chdb7tf.ffs@tglx>
References: <20240328094433.20737-1-laura.nao@collabora.com>
 <20240328115015.36646-1-laura.nao@collabora.com>
 <09d67d1d-2c65-4872-b38e-665eda154339@leemhuis.info> <877chdb7tf.ffs@tglx>
Date: Thu, 04 Apr 2024 15:05:13 +0200
Message-ID: <874jchb7na.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Thu, Apr 04 2024 at 15:01, Thomas Gleixner wrote:
> On Thu, Apr 04 2024 at 10:24, Linux regression tracking wrote:
>> On 28.03.24 12:50, Laura Nao wrote:
>>>>
>>>> I ran a manual bisection to track down the root cause for this
>>>> regression and landed on the c749ce
>>>> commit from this series:
>>>> https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/
>>
>> FWIW, that commit is c749ce393b8fe9 ("x86/cpu: Use common topology code
>> for AMD") from tglx that was part of the "x86/cpu: Rework topology
>> evaluation" series.

Can you please provide a boot dmesg from a 6.8 kernel and the output of
'cpuid' ?

Thanks,

        tglx

