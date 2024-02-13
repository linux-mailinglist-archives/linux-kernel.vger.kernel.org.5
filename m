Return-Path: <linux-kernel+bounces-63315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F12852D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922BA288CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63BE22EF4;
	Tue, 13 Feb 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lt1q5uIJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2zWZYr2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5A22638
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819078; cv=none; b=NbNGdrl7I/tNfom/HKJZ5tdyzeL0+GSLlquMTKbOk/wRt/uApVzr3km0q33TBq9Npz3HVYFHwIAr5ePXbZuSAtADlZcwe2cLn9jm7RuuN4zefHdpKls5E6NDVp71vu6UElRux7uuCDjvbksavm7M/oNHnHv/Mt/Z6diXeqQ4wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819078; c=relaxed/simple;
	bh=J3drZ6Qt2Ki6agqoK7iGolGZ4hbttdSpL6FPNcTPzJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aKUseJAMXLnGSsS7yGleZL3JLnMaJdhsy+o57RH/zfhSNshksfJe/HyIHeJCLDKWN0q/LyMCPiRTAkWFpByn9HZZNTeU7Al5dg28/H3DAeHb6p4+XS82gd7kX5hCv9VdDOUvzTv6QmeFcW3lo+bCGOG18rEAonR39v1FsgWx898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lt1q5uIJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2zWZYr2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707819075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3drZ6Qt2Ki6agqoK7iGolGZ4hbttdSpL6FPNcTPzJo=;
	b=Lt1q5uIJPs671qL/FXBSrQpIp8DA8Zyoa6CLjutT1jf5P9gpFgKvF0MiHGDtTOy0yw6UmX
	lIAcfNIzgV0b8Oozpyow7ZDjGUhvNuIjkkegacgeMNT6XwuodFtCG+oWVysirJrANH/Z+a
	kvcjtKI410WvufbTf/JrgOqUqRZKjNxVmr1bO8Mx4SF10IjwJvTTPNi6SZSCKJkpCrKzV9
	dTA6zQHoha46vPm3g+tUs38q0pqa4ADV7+zvCauJF8tHfQ7A3R4olcpgpe+rbSzu/jCkPq
	X4ppaNd8y1QXynlkNzOlVW9cc/71Mt2z6IkyUUYnt7biAYjGY/bxjHUT/yck6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707819075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3drZ6Qt2Ki6agqoK7iGolGZ4hbttdSpL6FPNcTPzJo=;
	b=s2zWZYr2MxLRyIKZUuRAyWk/VZiGRt1s2L9bw8M/0G7X9QDSSaNZUfwIfGalouOXQ/cpNH
	ebs3SoTLnN85UJDg==
To: Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org
Cc: xuqiang36@huawei.com, chenjun102@huawei.com
Subject: Re: [PATCH] irqchip/mbigen: Fix incorrect null pointer check
In-Reply-To: <20240129130003.18181-1-chenjun102@huawei.com>
References: <20240129130003.18181-1-chenjun102@huawei.com>
Date: Tue, 13 Feb 2024 11:11:14 +0100
Message-ID: <87zfw4hdx9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 29 2024 at 21:00, Chen Jun wrote:
> bus_get_dev_root(&platform_bus_type) always returns NULL.
> This makes mbigen_of_create_domain always return -ENODEV.
>
> Fixes: fea087fc291b ("irqchip/mbigen: move to use bus_get_dev_root()")

Amazing that it took 9 month to figure that out ...

