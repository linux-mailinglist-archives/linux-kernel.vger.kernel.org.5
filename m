Return-Path: <linux-kernel+bounces-141828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD58A23FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAC52818EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B4125D5;
	Fri, 12 Apr 2024 02:55:48 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E4EAE4;
	Fri, 12 Apr 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890547; cv=none; b=OAyttlyeeQRbAOsK03fiQyv11P769G2ext6pLqTzMPziSWkrG279nyWfIEjAcaI9BGirtmi6fktmgp1vFfGB/OhLzpH73KWzBMu7tivnN0NUwzJR3D/UEokT1sShBAQTihp3So4YmXpyj34vasdajlUh8cz+tXFPBsLwOl0x0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890547; c=relaxed/simple;
	bh=XNCGNyHwYRCwwpANiBlvWrPXTAHWMfZsAYPVTFtFQSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc6oi79AaB94csqmipIWkfvZ+660EHhbFpl3p0T7maeb+dF72qxH7qN49wEJBw1HJnd3XhvR8U2AJwFaZV+77dGRuhx32XhiUwc2EaV0gSp+TSA8TVzDOtC2+SkCRzMM25QbtXbOXaUOkeBapguN2BT8b/r/kfENVqFHwSjda+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rv74j-000gmk-Pq; Fri, 12 Apr 2024 10:55:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 10:55:55 +0800
Date: Fri, 12 Apr 2024 10:55:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hailey Mothershead <hailmo@amazon.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: ecdh - zeroize crpytographic keys after use
Message-ID: <Zhiiu0GCySQ9OxrH@gondor.apana.org.au>
References: <20240411235157.19801-1-hailmo@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411235157.19801-1-hailmo@amazon.com>

On Thu, Apr 11, 2024 at 11:51:56PM +0000, Hailey Mothershead wrote:
>
> @@ -111,7 +113,7 @@ static int ecdh_compute_value(struct kpp_request *req)
>  free_all:
>  	kfree_sensitive(shared_secret);
>  free_pubkey:
> -	kfree(public_key);
> +	kfree_sensitive(public_key);

It makes no sense to zero the public key.  Nack.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

