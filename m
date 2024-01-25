Return-Path: <linux-kernel+bounces-38285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9883BD82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C3F2941EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E481CAB9;
	Thu, 25 Jan 2024 09:37:18 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E31CA8B;
	Thu, 25 Jan 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175437; cv=none; b=kp/ysHLP7f6fDHjFQJvRFOoIv8KNyBgKGZDywrYfjUqClCBKk6NXd9g1uOk3XzVtMqzR6VmNFqVgbpFuSg+oUkckF6W++Onn4Fqk5nBKu1gcBqIaSP6E3WaiRqZhKm1N8f6vm3v/c4Yk7KwQ2vgKMxxEwSMhrgXk4QJmPfM8CBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175437; c=relaxed/simple;
	bh=pANF+oLZHBkHSuW3uOERdFLcUTwaM+ZLvBfpRyEnK4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgVD6kq3DWi0j1bgEkQvOdosl8yxcT5twcWIqpVflxaJvXEzhINkzMMtOgZUWMnlmBEJXMUhkZ6fMclShZQoDAltWDORl8saiujFwh9Od1E0C0vciGFSaCYTGJMy7Q+aXdSgds0cTufnJXq6mhZXz2uWeazbRXHNRyakXxhPA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rSwAQ-005sJt-Kl; Thu, 25 Jan 2024 17:37:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Jan 2024 17:37:15 +0800
Date: Thu, 25 Jan 2024 17:37:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qi Tao <taoqi10@huawei.com>
Cc: davem@davemloft.net, liulongfang@huawei.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 3/4] crypto: hisilicon/sec2 - fix some cleanup issues
Message-ID: <ZbIry8M6yFUAr5oL@gondor.apana.org.au>
References: <20231229064421.16981-1-taoqi10@huawei.com>
 <20231229064421.16981-4-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229064421.16981-4-taoqi10@huawei.com>

On Fri, Dec 29, 2023 at 02:44:20PM +0800, Qi Tao wrote:
>
> @@ -1371,7 +1371,7 @@ static int sec_skcipher_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
>  	sec_sqe3->bd_param = cpu_to_le32(bd_param);
>  
>  	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
> -	sec_sqe3->tag = cpu_to_le64(req);
> +	sec_sqe3->tag = cpu_to_le64((unsigned long)(uintptr_t)req);

Please explain why you're casting twice.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

