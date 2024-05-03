Return-Path: <linux-kernel+bounces-167519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809378BAABE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF511C215D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6A01509B7;
	Fri,  3 May 2024 10:31:17 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8C2AD02;
	Fri,  3 May 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732277; cv=none; b=NlkoxWwEU0HMEygeT9ItdvHdMNEp8l8yMW8zF9DwyvvIY3YAi4QlDedURDhcePu/b2ynf9WmZQCnVUAXOluVlOyrsUsVviiJgJEB0TfKi4tWbldi4P9K/0mZSIGvYh+LiDsbuMLYzdew3T8T2KVG/w0xvgzeH2jnQ0V1KY5VSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732277; c=relaxed/simple;
	bh=6AYkgxrwSkcmi+C/w8z7/QWz4EAoBp+7V4Et2BTlEg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaEOu4Rn6qY2zown+Oqhifb9D09xxmOY1522L6VYvWOiGX4tq4/3iNYy0BV9o1BgTd576F06bx2wwNATu6880qkpvDoDHoz5Mk476pXKQPzrfaLuaa7pj/Mvz4NuLjT9O2m5BmuhX5y0E+/KYTQ/8N7E1T8U1QDuk/tNXYmEJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s2qBo-009v7u-2Y;
	Fri, 03 May 2024 18:30:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 May 2024 18:30:53 +0800
Date: Fri, 3 May 2024 18:30:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Stefan Berger <stefanb@linux.ibm.com>,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from reading
 too many bytes
Message-ID: <ZjS83WIPglXiUH3n@gondor.apana.org.au>
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
 <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org>
 <Zi8UXS1MD5V58dnN@wunner.de>
 <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>

On Mon, Apr 29, 2024 at 01:14:15PM +0300, Jarkko Sakkinen wrote:
> 
> Yeah, sure, that would be even better, or even memzero_explicit()?

memzero_explicit should only be used for stack memory.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

