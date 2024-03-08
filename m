Return-Path: <linux-kernel+bounces-97526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B9876B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D844A1C20FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9625B5B6;
	Fri,  8 Mar 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="BBLfivyn"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1185A7B1;
	Fri,  8 Mar 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928072; cv=none; b=U4tt847MZKsuoJcQLFZXSnKctfToXO5bHldD/3N4fk8D16I4x3cU+PWvVH0rwUjEJqYIAR1sR9+ZvPF81bbtc/1LEjH/7j/O3PGNShTVBYwgnjLztlcO359nJYPmg/oQCPscwTlT8NkhgnT1a5LdblSlOrFGW9c3EVUPRhlrfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928072; c=relaxed/simple;
	bh=ZwZD3ZA3QydybU1Prb/XLPX5HQcBxy0XFC9FO6xiZiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKEYpCfD+tAtmwmw1MwFB1iJPaFKIRBvzwGYjyPbACE4P4o6XE9oPLI0iKakDLkEk/2DEC24LTz2pf/50PXRTDFyUuPdF9y+KvMtYtZluHf0gMCo7KLbM2TOYnFDybMHJILqm5qewy1Au/M8pUpqiHGpcG750cV++rDMKy9om1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=BBLfivyn; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Trxqs0wB7z6846;
	Fri,  8 Mar 2024 21:00:57 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Trxqf6rbMz6832;
	Fri,  8 Mar 2024 21:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928057;
	bh=yOqRQi6xejXs6u9D48RVVEbkVVuZ0GBOyKmn59Beq60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BBLfivynwPjCgNmdrspxPfQTeN5a7MEWfOAgs1i95IUsnF/ohCkT+0AI9QJzc/2wk
	 Ofxx6qbqDSaHGb9QK57HNhZN+pNBw/D7b0ybsuoURoUnd8x/H3yQY375vVi2pG33Qh
	 fdCcT83XLh82z09MXTjIzxRd/Nz1dJvSRlrp/loE=
Message-ID: <e574cf05-c3cd-4b67-891d-d03da1dfa084@gaisler.com>
Date: Fri, 8 Mar 2024 21:00:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] sparc32: Use generic cmpdi2/ucmpdi2 variants
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-1-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-1-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Use the generic variants - the implementation is the same.
> As a nice side-effect fix the following warnings:
> 
> cmpdi2.c: warning: no previous prototype for '__cmpdi2' [-Wmissing-prototypes]
> ucmpdi2.c: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Tested-by: Maciej W. Rozycki <macro@orcam.me.uk> # build-tested
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> ---
>  arch/sparc/Kconfig       |  2 ++
>  arch/sparc/lib/Makefile  |  4 ++--
>  arch/sparc/lib/cmpdi2.c  | 28 ----------------------------
>  arch/sparc/lib/ucmpdi2.c | 20 --------------------
>  4 files changed, 4 insertions(+), 50 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

