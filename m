Return-Path: <linux-kernel+bounces-79378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402E86215E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E980289C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440721FAA;
	Sat, 24 Feb 2024 00:52:16 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206617CE;
	Sat, 24 Feb 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735935; cv=none; b=WDiisF5EAg2vxqRbH5TM/rbyM1cnxNGSQFtSHE8czd5c0t8Ai1V2kJ8HmoZ6xJZv5tbFcvuosaDq24io2pDPvLvEntbRGNYI8m73lLws+KN+CloLPN8meM34POCpqKsJjBmtSVW+lQ3j+puJLOB8MEMouudIMQPxz/noUJY0tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735935; c=relaxed/simple;
	bh=izPR2qHsw4hP1YY9m0vGgtvLfcPnzfhd/W68YapNgPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJHMQ3I2DdoS0jTmW8OVjMMeHTHQlIutUkqA2PNeQl1eFCwry7j6FNw1ZSf/ZtnP47lhGdLan+Hm89zsF8+Lf4NkefzvxiQgYIrgU1gP5EKxm122P50+h4854Bx9zGcjJqVS0Dtbj4Vd7PRSnCsITlC32heftnj9nPHe7yidUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rdgGk-00HDzH-FI; Sat, 24 Feb 2024 08:51:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Feb 2024 08:52:13 +0800
Date: Sat, 24 Feb 2024 08:52:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kilian Zinnecker <kilian.zinnecker@mail.de>
Cc: Corentin Labbe <clabbe@baylibre.com>,
	"David S . Miller" <davem@davemloft.net>,
	Heiko Stuebner <heiko@sntech.de>, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: rockchip - fix to check return value
Message-ID: <Zdk9vc7OPEPcXA1/@gondor.apana.org.au>
References: <20240218221658.131043-1-kilian.zinnecker@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218221658.131043-1-kilian.zinnecker@mail.de>

On Sun, Feb 18, 2024 at 11:16:58PM +0100, Kilian Zinnecker wrote:
> crypto_engine_alloc_init may fail, e.g., as result of a fail of
> devm_kzalloc or kthread_create_worker. Other drivers (e.g.,
> amlogic-gxl-core.c, aspeed-acry.c, aspeed-hace.c, jr.c, etc.) check
> crypto_engine_alloc_init's return value and return -ENOMEM in case
> a NULL pointer is returned. This patch inserts a corresponding
> return value check to rk3288_crypto.c.
> 
> Signed-off-by: Kilian Zinnecker <kilian.zinnecker@mail.de>
> ---
>  drivers/crypto/rockchip/rk3288_crypto.c | 5 +++++
>  1 file changed, 5 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

