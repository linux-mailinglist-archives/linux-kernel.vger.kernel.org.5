Return-Path: <linux-kernel+bounces-84738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6B86AAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8542840EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7432E635;
	Wed, 28 Feb 2024 09:07:32 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C62E62B;
	Wed, 28 Feb 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111251; cv=none; b=nI80afoBlPv/jQa2vYv+9OIJl1IETw7PqaH9j9DXZcMgnZQFvtnEoB0tOwIkL8rsgXbWwYiNMnjCLQsaXBmAURq9lGuhXi0ougWjHJlJf0DnSzZakgwL+dF62s/5aS0LnkbVPHWRng+f3BD08hEtedOe6tYo0sAc+phTY1Rob4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111251; c=relaxed/simple;
	bh=NrDvZZF70DEoKM4j6lrIR6okJ6e68t2DzMezctdcIX8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8ZR4OXtH/1wUuyXHxf2UH75cI9zsO4uMwTZ+cYk1Z9XcdiZrNuVQ3LP+CheMgaZcx0OcgsO1WKtBX+HhL+lRsp1cNNpbBE+FwSIopAKcldr6/MkyMlhewSLzhx4sVrZ1SoBBG/fk1r+TkiqgsxbTXIjgHde6aoAJ2WSjYvkSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfFu4-001C6p-RG; Wed, 28 Feb 2024 17:07:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Feb 2024 17:07:19 +0800
Date: Wed, 28 Feb 2024 17:07:19 +0800
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
Message-ID: <Zd73xxYHxFJWKyxq@gondor.apana.org.au>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
 <Zd0LKrryWNs15zxi@skv.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd0LKrryWNs15zxi@skv.local>

On Tue, Feb 27, 2024 at 01:05:30AM +0300, Andrey Skvortsov wrote:
>
> And potentially rk3288_crypto driver is affected by the similar
> problem.

Indeed, and there is one more in sun8i-ce.  I'll send out patches
for them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

