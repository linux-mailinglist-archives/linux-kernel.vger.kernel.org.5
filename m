Return-Path: <linux-kernel+bounces-79376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03A862157
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA751C253F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFEE4A11;
	Sat, 24 Feb 2024 00:50:34 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6117C8;
	Sat, 24 Feb 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735833; cv=none; b=uNvH/ctve5HBzU6mS4aalwsfcgYXu8JP7BH7K+Q0rjejDw9/ZjYoUwvMJDXAVbm9tmEQowrCW1pQ3ipWQ10Mr+KbSAaAL9O40YRP4HRDeIojb3rmpvbHeYsLyyDlNQSriXsWgRgr7S2uIJV0BCjmdUe0IjpT+ynOshoE6S9j0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735833; c=relaxed/simple;
	bh=1Yx8JWtZT7NJ/ks9g6HxK/LqurKWFCidlnpb6hkrE10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZs44ZEmlGhapqM9+GRj0EzO0L449Qk62zfP0EzV089pqSVPWDdGDb7l7dMCKBoNXFlrsD71ssy3HqalPHA5uelUfwi75YBMxMB4CN2eHBgbjCGWRtC9lVDRxzzCFly0jPAOKWLKu3oXYw4XvHwWkZQR6YzUv0yeZ9iXHDTm3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rdgF6-00HDvZ-OA; Sat, 24 Feb 2024 08:50:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Feb 2024 08:50:31 +0800
Date: Sat, 24 Feb 2024 08:50:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Markas Rapoportas <markas.rapoportas@intel.com>,
	qat-linux@intel.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - uninitialized variable in
 adf_hb_error_inject_write()
Message-ID: <Zdk9V06gKW8EsH2k@gondor.apana.org.au>
References: <193d36b0-961a-4b66-b945-37988f157ebe@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193d36b0-961a-4b66-b945-37988f157ebe@moroto.mountain>

On Tue, Feb 13, 2024 at 09:09:41PM +0300, Dan Carpenter wrote:
> There are a few issues in this code.  If *ppos is non-zero then the
> first part of the buffer is not initialized.  We never initialize the
> last character of the buffer.  The return is not checked so it's
> possible that none of the buffer is initialized.
> 
> This is debugfs code which is root only and the impact of these bugs is
> very small.  However, it's still worth fixing.  To fix this:
> 1) Check that *ppos is zero.
> 2) Use copy_from_user() instead of simple_write_to_buffer().
> 3) Explicitly add a NUL terminator.
> 
> Fixes: e2b67859ab6e ("crypto: qat - add heartbeat error simulator")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  .../crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

