Return-Path: <linux-kernel+bounces-39808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560E383D651
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F0E1C26FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E52377C;
	Fri, 26 Jan 2024 08:55:42 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639592263C;
	Fri, 26 Jan 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259341; cv=none; b=HWYW6Z+5ozEzh2gOcXlDWjxjVjU7K93XCGfPylDsui5Pd9O6TYBbos8r1JAAwXQB9ptRC/oXM6IV5q0GGP1vWcQ6FVjpvRc+cHIXmV8y5R6p4UDX+3lhXO39DSxKdScbGnzGjfuxz8rsL9u2ZHgyCwx6J/0LGoYeRruMdR5UnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259341; c=relaxed/simple;
	bh=YWuyFj1LWoUEo8gZuJhqmKZRCyglpZ4AVYuFv8OugUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTvnk74zF0yT3Q59xjW7DIv45RrDqFiJNLfuX1E7THS7JV8c/fa6eJNFIniGlEmBYfF0zlq0uva+uUbW1gQAE2vTvh1n14KdcmJRbN4mSGAvMc/eFWssyi2k6qPAFxJN61lDnIFeqrpyHNKK0EsrcQfc+9c5OYWMAdhXswwPc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTHzV-006ETz-47; Fri, 26 Jan 2024 16:55:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:55:25 +0800
Date: Fri, 26 Jan 2024 16:55:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel test robot <lkp@intel.com>, virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Gonglei <arei.gonglei@huawei.com>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH v2] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Message-ID: <ZbNzfR5wzrKarP4h@gondor.apana.org.au>
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
 <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>

On Tue, Dec 26, 2023 at 11:12:23AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 26 Dec 2023 11:00:20 +0100
> 
> The kfree() function was called in up to two cases by the
> __virtio_crypto_akcipher_do_req() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> * Adjust jump targets.
> 
> * Delete two initialisations which became unnecessary
>   with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> v2:
> A typo was fixed for the delimiter of a label.
> 
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

