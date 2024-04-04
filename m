Return-Path: <linux-kernel+bounces-132276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A7899259
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A3D1F2199D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCD13C69D;
	Thu,  4 Apr 2024 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PBv8xy6x"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424216FE1A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275143; cv=none; b=DtEYGYJTeEHh50UlgPWhPTqA6W8vOhXSFuUsNj4K62a9T/H+ivb7Y2K1bUqVtEfZM8lqcpM+eBig2W6Kd6C078A2oLYZo7VtcUb+Zsboealup0Wyu6ScWjh1R0f0r5kfnZVDD87ysJ5YI/OlPJnT+EFlpLwRzQQRVJdKkamFk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275143; c=relaxed/simple;
	bh=wxz1iF4ORS761UxYvf38/XE0YTpsZcHG13BX3FPg1SE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i2a7g/odxGo9ic6QjeMh5nhBK2wJc+X0eOw4ipn3Cw2gqk3kU27AARP7O+DNON2CYexgrp/xlECE+2l0Ia1itVBHdIoSZkv7x8rCfniPtkYUgekrAaSLVOz+dH/O/oEYo7Q2mNwTAeg/hysnFj2QKwo7bwmKBf+ya/qzOqZDdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PBv8xy6x; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712275139;
	bh=wxz1iF4ORS761UxYvf38/XE0YTpsZcHG13BX3FPg1SE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PBv8xy6x6U+tozk/3ZBB4B/IhowisYGZXGi+khtUJ5c8k2AtxDr3S+spZkCdpliLo
	 N0lzxnMITtTjMsEcMud8YG1kMegImVUNpVpBoePsKuT6XnfV+sVdf1hXATeivHCC90
	 soSoR0cQYq3EEcEB4GygMi8pcuQGu1+Ott3VcrNEUQRavstX8wltWC5PzCFVxki7hF
	 PE8dqgoCsVDEFoL+DzNSkOWHtmERiPbeUm3+nuC3UL7760bITg6GUUlIFxNPoZsxir
	 dSnHOn4Qf5vaMg3jFx+HLnERfEMfhlqmgCrZYPT/oSnD06Leay3ia3K7LqKwfWTOHX
	 jEhkzE1mI1PBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9dr335M9z4wc9;
	Fri,  5 Apr 2024 10:58:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring
 <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Anatolij Gustschin <agust@denx.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
In-Reply-To: <Zg0yTnTswS2je9VG@smile.fi.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
 <Zg0yTnTswS2je9VG@smile.fi.intel.com>
Date: Fri, 05 Apr 2024 10:58:55 +1100
Message-ID: <871q7k8ytc.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> On Wed, Mar 13, 2024 at 03:56:45PM +0200, Andy Shevchenko wrote:
>> of_gpio.h is deprecated and subject to remove.
>> The driver doesn't use it directly, replace it
>> with what is really being used.
>
> Any comments on this?

No comment :)

I'll take it for 6.10, or do you want me to sneak it in as a fix for 6.9?

cheers

