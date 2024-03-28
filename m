Return-Path: <linux-kernel+bounces-122804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF988FD91
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497711C2248C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D47E0EA;
	Thu, 28 Mar 2024 10:57:04 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28A535A4;
	Thu, 28 Mar 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623424; cv=none; b=D3m4JyTxFNl7Y8m4NsB0t8UT9G7fvgHcFxMsoq9Yk9QJXEi8cmApTHRjA2xRdlDmSc+4nbU2hZXbDnauKbCavb4Q4N5BLfBBDv0XxbKaOeKINE6MiZd2Z6aDosY7SdvB7s8Rk0NIJjc6UxQ68lHTZTEPxt8zXzsw2xpgDEImIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623424; c=relaxed/simple;
	bh=Kp3dCIxp0BhfM5qsnnXlLRqZvQvUKbpAPfnOn5BdD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFnyWNJ2HWpX/Fp4OaG95il7nrwSZlbSnlgSRp2yF3ivbavgjtXw9EYa4ws9NLJVCNx7WFRApRUuP2tZCxiXdPzM3sEiK5Rz/GHFTHfQhJPHwkIxNLpRiKC3UligztTQ3Yn+iE+sB08JLCwauclXOReC+lac6bYJfNXtqKTR8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnRF-00C8UK-39; Thu, 28 Mar 2024 18:56:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:57:09 +0800
Date: Thu, 28 Mar 2024 18:57:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: davem@davemloft.net, jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: iaa: Fix some errors in IAA documentation
Message-ID: <ZgVNBQ6RDFdxdpSc@gondor.apana.org.au>
References: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
 <20240321210846.1307596-3-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321210846.1307596-3-tom.zanussi@linux.intel.com>

On Thu, Mar 21, 2024 at 04:08:46PM -0500, Tom Zanussi wrote:
> From: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> This cleans up the following issues I ran into when trying to use the
> scripts and commands in the iaa-crypto.rst document.
> 
> - Fix incorrect arguments being passed to accel-config
>   config-wq.
>     - Replace --device_name with --driver-name.
>     - Replace --driver_name with --driver-name.
>     - Replace --size with --wq-size.
>     - Add missing --priority argument.
> - Add missing accel-config config-engine command after the
>   config-wq commands.
> - Fix wq name passed to accel-config config-wq.
> - Add rmmod/modprobe of iaa_crypto to script that disables,
>   then enables all devices and workqueues to avoid enable-wq
>   failing with -EEXIST when trying to register to compression
>   algorithm.
> - Fix device name in cases where iaa was used instead of iax.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  .../driver-api/crypto/iaa/iaa-crypto.rst      | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

