Return-Path: <linux-kernel+bounces-152750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18B8AC3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F51C21564
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DB18059;
	Mon, 22 Apr 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Jl4rwGSv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAE1802B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764340; cv=none; b=ki6qw2d8R0z74laFko+g1cyn7IzC8Gou42OYvUJusIFSX4pRz/1HbbbCp03JP+5p3dzwWFl7px2J0/tc60UlvEU6n92OHlUQs612PzcOus29+fIze7LuWA5LEyTWuMvtTFatvBEMiqEFGp/ab9a92XqRZH8j0/6PUepWmR3Bvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764340; c=relaxed/simple;
	bh=OhPq8lW0Gy2yU8/iRbyTPAJ8uG7regcnybwN/4U2CJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjAMtMrFJthpUWnYrXU1zz6Mtko2Bphdz2eyJ52HKNfSyIwZhPEy6E6DpCW5VcMEYFMb3Gc6n/zvh5chjoplOKVSAtkgHNiAQo/6jGA9dE0Cm4gFKJE2qEghzGyNyjbwWgqaxwPNT9+Cdo0iwi46kGWeRWq8oaB/f57toenh2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Jl4rwGSv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713764336;
	bh=G/aHh5doH7tvZjPRnwTkrCGV4ORMj01WDY46RGpRjdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jl4rwGSvyYZEL8vfNo6LWVlEY2KvjdbmHOClU3kUBuViu8mtWo9RUUDt7mloAKoCj
	 5lwpD1aEytFxTHdZhJ4rp0bNm+W1n1fHVvaCcpwH1z/A7dWahoxuvTWuKPpAL3Drwx
	 7bcuYrQkBedulrsAseLBI5/LHE1AgaCkOjWoj+SW2LsTWStm/+gN/EogiAIGIBLpva
	 ov0sgF8nbfDr3MF46MSUtq2PATHC86BTpHRB4e3FRgSf4yGikPYVbozIa41KSgSw/5
	 +L8he12z7SSKpxn5avmyQzrlYQ/b3W6n2HbyKLlfOz/zgIwwaLXsaaBAixc70UJMeD
	 4NnpMqPSy0aaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNDZS1QCmz4wyj;
	Mon, 22 Apr 2024 15:38:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/6] driver core: Add device_show_string() helper for
 sysfs attributes
In-Reply-To: <2e3eaaf2600bb55c0415c23ba301e809403a7aa2.1713608122.git.lukas@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
 <2e3eaaf2600bb55c0415c23ba301e809403a7aa2.1713608122.git.lukas@wunner.de>
Date: Mon, 22 Apr 2024 15:38:54 +1000
Message-ID: <87zftmj6s1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Wunner <lukas@wunner.de> writes:
> For drivers wishing to expose an unsigned long, int or bool at a static
> memory location in sysfs, the driver core provides ready-made helpers
> such as device_show_ulong() to be used as ->show() callback.
>
> Some drivers need to expose a string and so far they all provide their
> own ->show() implementation.  arch/powerpc/perf/hv-24x7.c went so far
> as to create a device_show_string() helper but kept it private.
>
> Make it public for reuse by other drivers.  The pattern seems to be
> sufficiently frequent to merit a public helper.
>
> Add a DEVICE_STRING_ATTR_RO() macro in line with the existing
> DEVICE_ULONG_ATTR() and similar macros to ease declaration of string
> attributes.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  arch/powerpc/perf/hv-24x7.c | 10 ----------
>  drivers/base/core.c         |  9 +++++++++
>  include/linux/device.h      | 15 +++++++++++++++
>  3 files changed, 24 insertions(+), 10 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

