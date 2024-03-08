Return-Path: <linux-kernel+bounces-97527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75D876B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AC91C214D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD95BAE3;
	Fri,  8 Mar 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="gtuHcD/a"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8850A80;
	Fri,  8 Mar 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928119; cv=none; b=mmU+sRYH66nxqLat4Ygys7dljzv7x+rqQ/MhHF3qDqeum16jTDQh0HzDgzoCkLDOVnHnc5lAJQBarD7wyn9rPfiRm8IuVNMs5t3BnUnibrnTTGGIDlbXKIZN+3K+m8ZeQGWpsgCwvK+t+lJDCPa4SMKNi6DA1eIFmsrxbhmLL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928119; c=relaxed/simple;
	bh=5ytxsqFxTxwzlMrfzhQvGBhWVmRUCy3wGxkxC8SS2ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFPt95lKwoO2hl/dGgKjfhLL6Mhl1BL7IzdiYjEUYPKdTjbo+HC8MZL+d3jhlz54nLIB6ys2jbd8H12umZILLmnEI+wB1hqxRk+QiY/U+3hzLzhgYGFfEdF17lw9ySF8HvDgsqSaGOBLaQ4k6r3pPSPoxwd3BeD66EwlAH8UC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=gtuHcD/a; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Trxry32DKz683p;
	Fri,  8 Mar 2024 21:01:54 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Trxrl6p7Xz683j;
	Fri,  8 Mar 2024 21:01:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928114;
	bh=X3/rFw2DP5ULtZhyu5nw+e5CpPRD0KcFBiZwM7ZbUNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gtuHcD/acSa2BfxkLaRl860FgKnGSt9fSIaUbHuMCJH1lnikto+BSwmSMCOjwNYre
	 GszeJQfGs3MJkYdmi89LkLWbbrCg4P6OuCVNqA5N4NQiaROJLhVuZ/MpH1g0uvSSLe
	 kyRlWw1g1X2BuQ5zyoXvpcMPv8Oil0jco1v7ZE4U=
Message-ID: <9294db8b-5f25-4e3c-99fc-9ab9c7e09bba@gaisler.com>
Date: Fri, 8 Mar 2024 21:01:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] sparc32: Fix build with trapbase
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-2-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-2-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Fix the following build errors:
> irq_32.c:258:7: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]
> irq_32.c:271:14: error: assignment to 'struct tt_entry *' from incompatible pointer type 'struct tt_entry (*)[]
> 
> trapbase is a pointer to an array of tt_entry, but the code declared it
> as a pointer so the compiler see a single entry and not an array.
> Fix this by modifyinf the declaration to be an array, and modify all
> users to take the address of the first member.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  arch/sparc/kernel/irq_32.c   | 6 +++---
>  arch/sparc/kernel/kernel.h   | 8 ++++----
>  arch/sparc/kernel/kgdb_32.c  | 4 ++--
>  arch/sparc/kernel/leon_smp.c | 6 +++---
>  arch/sparc/kernel/setup_32.c | 4 ++--
>  5 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

