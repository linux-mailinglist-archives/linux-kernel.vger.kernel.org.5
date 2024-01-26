Return-Path: <linux-kernel+bounces-39859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B69E83D6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B512939DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3215147E;
	Fri, 26 Jan 2024 08:58:51 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755915146A;
	Fri, 26 Jan 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259531; cv=none; b=bjm2IYTR1+ny92THo1r5E6Fb52Yb0Up2bQQ3S3vyk1Ecnv1KyxTbDpVUTNJSI4jnkOOkw9lLDNyVjTJ/claxSKXAVMYt4Px1q404yg5llUcEh65tva9tRZ+ZqneHsgKfFSwZ5yKYFp7NIyOYK6i/ST4EXFwb3u+WPVdpQeug4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259531; c=relaxed/simple;
	bh=f2Ea4tnTpi+RhTPJlVTJ67qgqs8LtHYD3YVA7bfKOpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv13k/xi6wkurdwHiiuIJj6m3M5QsbvtoVb4k4aR50zHwqCKFZeaoqYt29ZSDdgc4hk8GQPnVlROB4AXuP/T8PdQ9z9/QcwqsxSQraFEHe2HBGiBL7aWmHZQv3qxaCnFkjtKMVBziBz9PAY1EMpvWoa3R5mkP3/IHlt44HJjd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI2k-006EZY-27; Fri, 26 Jan 2024 16:58:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:58:46 +0800
Date: Fri, 26 Jan 2024 16:58:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - avoid memcpy() overflow warning
Message-ID: <ZbN0RkMLJ2NBKQ5v@gondor.apana.org.au>
References: <20240103162608.987145-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103162608.987145-1-arnd@kernel.org>

On Wed, Jan 03, 2024 at 05:26:02PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The use of array_size() leads gcc to assume the memcpy() can have a larger
> limit than actually possible, which triggers a string fortification warning:
> 
> In file included from include/linux/string.h:296,
>                  from include/linux/bitmap.h:12,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/sched.h:16,
>                  from include/linux/delay.h:23,
>                  from include/linux/iopoll.h:12,
>                  from drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c:3:
> In function 'fortify_memcpy_chk',
>     inlined from 'adf_gen4_init_thd2arb_map' at drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c:401:3:
> include/linux/fortify-string.h:579:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   579 |    __write_overflow_field(p_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/fortify-string.h:588:4: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   588 |    __read_overflow2_field(q_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add an explicit range check to avoid this.
> 
> Fixes: 5da6a2d5353e ("crypto: qat - generate dynamically arbiter mappings")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

