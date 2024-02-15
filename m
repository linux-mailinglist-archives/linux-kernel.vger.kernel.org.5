Return-Path: <linux-kernel+bounces-66392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60E855C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA281C29FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18D13AF8;
	Thu, 15 Feb 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="rMfofK/4"
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0B14286
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984603; cv=none; b=OEeJazssbkkRZ0YtEWK8FhQLhzpy2+nGzlo72GOF6sCUEDK7JrvY8p3oBQxbsMUPCDtG2aEpbT8RPHpqSIWyj9alUZl/75DgYXXFbVKYYMoGtnt/8t4Kwn9W41Nvh5HgV245/fnGpkV7kxJMfgLCSazrd6X6lz0H3uTQHdJTgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984603; c=relaxed/simple;
	bh=oMloioHiqzolpC8BrGlsCGRh5jYANxyAMFV8ZGoH6u4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mspi/jGibn9vpFjNbLsig+jF5QqnqhTecSs48UKVFERf329sJlPyrBpNPHkK8I0T6QhaoqwrEnsASWN7DUSvN1iJAmFcHj+J+d97IPUvgcTsNT+02Qy3tzBP6KNDZjGmFVdL6lUVvvdqAuocMvKtxAbzZlzmCpighU4CZzz0+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=rMfofK/4; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=kiAiXK+yoKzyPMDFH1nthKH5uSY0ZMKoR36YEkDCLGw=;
	b=rMfofK/4B9BFHNnqOMtUksFJFEF0WyNI4weobZi2m5EJ4vgg+feyHk6BJSYI72YAOqLN9k5ogD7X0
	 Wl7b3QD7QLHwAbQWTKgisMPK1bhUnKtZ6frM6Fmamq06cp53tpisrZJCf3BET/MN2aaFbRRCFAjOtY
	 XhYgNJ+5/HmY89VxcOf4JoOpRdm8Ll2lhojgJO3AGtjSdsGham0gQxcpk9z/TKvc967/qbbUI7cmLj
	 NsfPU6zhdfkGh0ASBY0R/mkOyEWfxOqJfSyrB+xerC0LDt1UXGLBvbOq27rrZFbBdkLdnAUeQ+ZXNW
	 CE87IE9q69VJD6lbrKegjR0kRyXuESg==
X-MSG-ID: 9886104d-cbd9-11ee-a384-005056817704
Date: Thu, 15 Feb 2024 09:09:52 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 13/15] auxdisplay: ht16k33: Use buffer from struct
 linedisp
Message-ID: <20240215090952.68c7d3bc@ERD993>
In-Reply-To: <20240212170423.2860895-14-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
	<20240212170423.2860895-14-andriy.shevchenko@linux.intel.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 19:01:46 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> struct linedips embedds a small buffer for the string that we may reuse.
> Update the driver accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/auxdisplay/ht16k33.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index b104f08252dd..08cc05b9d216 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c

Acked-by: Robin van der Gracht <robin@protonic.nl>

