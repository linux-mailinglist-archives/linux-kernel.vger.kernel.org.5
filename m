Return-Path: <linux-kernel+bounces-111377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12173886B72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1621F2210F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6136E3F9D3;
	Fri, 22 Mar 2024 11:44:50 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852F7E6;
	Fri, 22 Mar 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107890; cv=none; b=D4uabmKCnkIaKZMdkypShA4UTH4HvVq/FIF+LUWMml/QVF0q32Qoj78IMYRgp7aH+naU+SJByQzbHoFS3rzNBY7oXEd4JUmFRYPSAbnlpDonoVl+CHgHtQa1MruvJ6/451CZ51eQVygOEwzYLX1v+3a8z8ah+lc3Bi/KcH3O6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107890; c=relaxed/simple;
	bh=Nf16gHegt7RFSlZ5m6gyIwYaJn5Q1p5AtJUL9MJfAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trdTrIkbwx7xgdLknQcUrspFaotGIJOYwhc6hIH2EZBMvsXijNIQjU2oS4DcBfCw64bPM7wycFS5zDcTRQ6Pk+XmMp2xSVusFKuHJUQ+YKCuQ5CmnbNZSAUJJSup/YwSMhU4Rwx5fMqKkZMMna1iL4Ez0Ghvl4JpLITZtfwrAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rndK6-009XMb-La; Fri, 22 Mar 2024 19:44:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Mar 2024 19:44:50 +0800
Date: Fri, 22 Mar 2024 19:44:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: iaa - Fix nr_cpus < nr_iaa case
Message-ID: <Zf1vMuXMF7mUuDAK@gondor.apana.org.au>
References: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
 <20240321210846.1307596-2-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321210846.1307596-2-tom.zanussi@linux.intel.com>

On Thu, Mar 21, 2024 at 04:08:45PM -0500, Tom Zanussi wrote:
> If nr_cpus < nr_iaa, the calculated cpus_per_iaa will be 0, which
> causes a divide-by-0 in rebalance_wq_table().
> 
> Make sure cpus_per_iaa is 1 in that case, and also in the nr_iaa == 0
> case, even though cpus_per_iaa is never used if nr_iaa == 0, for
> paranoia.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

