Return-Path: <linux-kernel+bounces-108361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92D88099B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306BA284365
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB5101EC;
	Wed, 20 Mar 2024 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG08VNl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D8747F;
	Wed, 20 Mar 2024 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902020; cv=none; b=DtyO6wopjJ19xv1hh8NJb0+04Bt+q1qVa1d1phg4QgD1xh6L8r9r0ylurQ1iF1v+GxsuYW4sRdlkxBQPmEZnE9avgpSXqWfH70nK+yAif/5ze9FPzPM+pWdxMXhk+TBawpugUuaeLQJRkMJi05XirP4YEyRgmNTnGcev9nFvV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902020; c=relaxed/simple;
	bh=2t6d8gDRzuZpq+yMMML1q+OAI55X20t+wt2Sntx2oR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjX8AROA6xf3ih5ZJnQu1Zf71QvtjhL0yUlriy2McIBqX55Kw3XU33WtZ4XYFt5PlRsWlvy7bmvhD6sqd2sNs3CaA+y6XJx2lPIJj3+n3kjcBzbYvZwEzpn8tbEx5RvzyYaDPLMvcsx0wtjxU0CMdzXtQkmJXHsrxp6FETigYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG08VNl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82174C433C7;
	Wed, 20 Mar 2024 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710902020;
	bh=2t6d8gDRzuZpq+yMMML1q+OAI55X20t+wt2Sntx2oR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kG08VNl4d0tXIUE5tFBbtUno1t0gt2vYonqFX2DPEPsqNcemK7EOqxC8rBq/BpKFC
	 2ewe87JWlPuIPAn8tlPRIYcTyaICbi2GvwjFENQPtbkJzm+hZYPcXS9QR3gN+na9nm
	 uEKzR1hiW69KEuIGu2vVl8oqiHEnigB6qXiMSsvYNqVjAvHKxKpzzG3nGIrvFRWnM7
	 n02pslRwjW4MNaWUGBhj/h+rreisNFZCATmCn/ArgRGYToNs9gPjeAYWS3fI9laKI4
	 MUmZJK+Hylp/rZ6O0Wk8noC+Ef/BZDXr0TfIP2RgCSZVFcRRmCE72fyEdmcchsLZtM
	 xU2zZ9DXz7Rjw==
Date: Tue, 19 Mar 2024 19:33:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <20240319193338.068c2559@kernel.org>
In-Reply-To: <20240314120006.458580-1-herve.codina@bootlin.com>
References: <20240314120006.458580-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 13:00:06 +0100 Herve Codina wrote:
> The make htmldoc command failed with the following error
>   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
>   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> 
> Move the visual representation to a literal block.
> 
> Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-kernel/20240312153059.3ffde1b7@canb.auug.org.au/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

We took the offending commit via netdev, so I feel responsible. Please
LMK if anyone else is planning to apply this fix, otherwise we'll take
it and ship it to Linus on Thursday (19th).

