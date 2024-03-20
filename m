Return-Path: <linux-kernel+bounces-108672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A91880E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67F11C21F38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B238FB6;
	Wed, 20 Mar 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJrqTKNZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w9LPUVSn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4FF38DF1;
	Wed, 20 Mar 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925515; cv=none; b=QfJc8y5ksb3S1CPE5TsTx/mEiKNKDKsELqKun2zRbM6JYXtu/mKGNx3KuHl/TqWwp0vav2Tt2W2gE31VHq0mqe2vMhaT2dL71Fsutfqqd4D9eOptEsbN13Nsa8mRA+1CjYyWXcY/wt+IxSawDNF8QOZp2PItnT8e28etF3u7/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925515; c=relaxed/simple;
	bh=jcweIEVrLjSiAQH2YQmKzpWiAWYsJTWIU0WruLIe1tM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQeVbn7E7TKh2Pv9JpP+GocketgERqhAR4ptTi5x3FwY72953ND6bVfV3luqildu5jCHhPCf8JIihq/hGBgVpMpVmzwnf5QUUU2NU2hYGkFn7degrk5FuHgBpzOTNKtH7iGKGVD+0/6uvn5SwnL5yym5mLmXTzABJOxdyKoXc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJrqTKNZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w9LPUVSn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710925082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRcilOnoG00Xd9ZBl8vbC1B8/UbTJ4JQWlnZMkShF20=;
	b=lJrqTKNZJzbXIloq7vkcTpKM3IpecIwhY3X8bHpDHUoW9tQjyLlwodgkXSkPY/3krQcZz4
	sYpxJvMirtFu+kwpd4wQGWlcs5iWhxLzmv6hXRxoPwY2lkTGu9Y9HGbva+gcx+KAMqFxcl
	wfBfBxuuDCRseO7cwRXDY4RAmUTYcqhanxwMfjX6GjicqPt9tdkAEkQGbkGKYmqTQPRg8l
	eJc/08GaBnqaNjlP7HkvR2AWHF/mSxDoW+4tx5Om04s+DVvmypLtTigP8PIW3Dti1+EXkE
	CSyplP/mJUpNebfBzOFlDRix4fwPZrDe+JIsb/pnMffbWomAoYnMFljNlKJHxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710925082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRcilOnoG00Xd9ZBl8vbC1B8/UbTJ4JQWlnZMkShF20=;
	b=w9LPUVSnBpV4WqkZ7gdKKmre24ROkVyHYWNALbSBbxnzKgiisuiiW4zTrwBz3UZ85YIahO
	CZnD8jw+yQgXzrDA==
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Linus Torvalds
 <torvalds@linuxfoundation.org>, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
Date: Wed, 20 Mar 2024 09:58:01 +0100
Message-ID: <87bk79i8km.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 09:17, Guenter Roeck wrote:
> I don't know the code well enough to determine what is wrong.
> Please let me know what I can do to help debugging the problem.

Could you provide me the config and the qemu command line?

Thanks,

        tglx

