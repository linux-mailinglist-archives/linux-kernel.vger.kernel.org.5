Return-Path: <linux-kernel+bounces-68953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115B858259
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EA71F26102
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8D12FF6B;
	Fri, 16 Feb 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TuGPUb0P"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925B12CDA0;
	Fri, 16 Feb 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100644; cv=none; b=Miz36FgzUXwkC469tz5nNN2vpTx57XGL9vt2XbaxOKf/Zr08mLVtO2t4aFC4GLNFfNWdcEP6/327iyxetmwbIBwa+DZIyjlr/TLd74CUoNzKz5Ev+a9U6hulKZCbMTtTy4razYyYlf3iGxtj37UcXTiEFhbvMWjgTl15wuFC6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100644; c=relaxed/simple;
	bh=Rfy5t+Ke97W7RYMJt/erJUa1+/Vwj2VdUC6H8BztsRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1UJpQhZBR4Y3L8/HpsdQBHQcIpiGGYWtOVok69M2dGjj+8ni2NWTuZKXBkK5PJq4g5hWzCK1Vu/Mh6prdyvvNVGDJ1VE/ug4fOuWZjb/99rktRr4Y3zUDKMfjynut+ovwGexdBuURvH+KC2CCoDU0MYAp20+wgg5MtgEjndwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TuGPUb0P; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tby1D3DQ6z681W;
	Fri, 16 Feb 2024 17:24:00 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tby1110Yhz681q;
	Fri, 16 Feb 2024 17:23:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708100640;
	bh=Cni14qWVF5Qo6yP1IoU8PFubchx+rq7qZRzJfHnvpQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TuGPUb0P7sFMjY7wydvc6Z9EnfErmRkHqJTvj6wzzPD2AMRdoPwYnmpphOaMjXf8F
	 5CJJShVpg8H/BKZjnw6uZnO5OSNsqeWQ2TtJsMUJvo9so4j9MFJlQ+NFCOXgShy2Te
	 J46TtXVqS8Frkam9F35ZRgRTDx8RBjp8gPWxNx08=
Message-ID: <cf77fdf5-3121-4910-96da-9392ba7e53d3@gaisler.com>
Date: Fri, 16 Feb 2024 17:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sparc: vDSO: fix return value of __setup handler
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Igor Zhbanov <izh1979@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Nick Alcock <nick.alcock@oracle.com>, Sam Ravnborg <sam@ravnborg.org>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20240211052808.22635-1-rdunlap@infradead.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240211052808.22635-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-11 06:28, Randy Dunlap wrote:
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) argument or environment
> strings. Also, error return codes don't mean anything to
> obsolete_checksetup() -- only non-zero (usually 1) or zero.
> So return 1 from vdso_setup().
> 
> Fixes: 9a08862a5d2e ("vDSO for sparc")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <izh1979@gmail.com>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Nick Alcock <nick.alcock@oracle.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andreas Larsson <andreas@gaisler.com>

Applied to my for-next branch.

Thanks,
Andreas

