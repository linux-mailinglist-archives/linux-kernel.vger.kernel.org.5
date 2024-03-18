Return-Path: <linux-kernel+bounces-106633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28487F139
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029681C21812
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37258AD9;
	Mon, 18 Mar 2024 20:35:56 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF95823E;
	Mon, 18 Mar 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794155; cv=none; b=fLLiJLiZcG99ZOantUJ8jmqjXObYDzE1nSTD22IeYOzATAFKymSTQ62/eGLqZOsnUrvbctD2MS+J/BEO0vLCysRENYPZsHiV57p3WKYOIZObU84bx5fgdD+KFfxMOx0Gj8szZ6xhEc5McGc+apqdcvztsOFybJkqAVR49SEx6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794155; c=relaxed/simple;
	bh=LTrlYGiDWbmiAPcVZXDPnbLX7y9tzRYIsFoAoMLA1VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8/9TijRLiMzjn2jsf/KssRIcubWyBoI1yc4ceKcu0C44Yu72UcFDh0pGS5GKUUxrzTcdYX6UsKFOMiTVWhUVLKw5Q2VHEYh5LbFKGm5fsLF5Y8Vx82JaDvYdtB0o3i+uKyHEAUYJOEmzj+3M8AkJTHVTLu8XlHmsXmAPilP6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3638E2800BD88;
	Mon, 18 Mar 2024 21:35:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1BF9B5912B0; Mon, 18 Mar 2024 21:35:48 +0100 (CET)
Date: Mon, 18 Mar 2024 21:35:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br, bbhushan2@marvell.com,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 02/13] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <ZfilpAf4UE2T3lXn@wunner.de>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-3-stefanb@linux.vnet.ibm.com>
 <CZX5LR621YXT.A2MGGVPKINOG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZX5LR621YXT.A2MGGVPKINOG@kernel.org>

On Mon, Mar 18, 2024 at 10:21:20PM +0200, Jarkko Sakkinen wrote:
> On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> >
> > For NIST P192/256/384 the public key's x and y parameters could be copied
> > directly from a given array since both parameters filled 'ndigits' of
> 
> We "could" do various things but a commit message should describe the
> gain or motivation of doing something, even if you think it should be
> obvious.

"could" is past participle of the verb "can".  We were able to copy
directly but no longer can due to the odd key size of P521.

Thanks,

Lukas

