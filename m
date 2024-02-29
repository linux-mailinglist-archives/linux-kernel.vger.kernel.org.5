Return-Path: <linux-kernel+bounces-86008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFB86BE66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99F91C22026
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C62E63C;
	Thu, 29 Feb 2024 01:40:53 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E7F364A0;
	Thu, 29 Feb 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170853; cv=none; b=KiipI1iRV9LZDgOUbOqQRX/w5ely5MpaMNEZ1P8EB7EDCu2a2z8jHwuq0XTN2sb2fDUSEop6C3M6yX2CNu9oWS7k9XTLCqwTr0KZsoVcQ986POT1SUM5Ckwn3UScDpuVnV3zrxiIIOpWQ4P9Q73M+blwqZ7zzxKvUXd/PEBkRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170853; c=relaxed/simple;
	bh=nxLgYYvyeeg9LYUFCJJQonETKqSUtAMJUsIcts+37+Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ09hSof25DlXvGVICZLPV/FIoRTuj6psurqOebNhO4U5rFCNQYsqGGZDWbgWUZ3ySDKBjjZhf+ZdrECdK/pwb3G2319CR927I0MPv4+Nt5qT2MkEeA5lfwUNAQTqdl8HtZku5U9v8fPFc3R+QJWDS0GKgsfs63YH4aoTHk9/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfVPL-001cx3-CX; Thu, 29 Feb 2024 09:40:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 29 Feb 2024 09:40:38 +0800
Date: Thu, 29 Feb 2024 09:40:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] crypto: sun8i-ce - Fix use after free in unprepare.
Message-ID: <Zd/glh3MItjCRDm3@gondor.apana.org.au>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
 <Zd76W98Ypq5uJmqm@gondor.apana.org.au>
 <Zd-blOvXjU4_t8p9@skv.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd-blOvXjU4_t8p9@skv.local>

On Wed, Feb 28, 2024 at 11:46:12PM +0300, Andrey Skvortsov wrote:
>
> You marked your rockchip fix for backport to stable releases.
>   Cc: <stable@vger.kernel.org>
> 
> I think it makes sense to do the same for the sun8i-ce fix as well. 

I already added the Cc tag.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

