Return-Path: <linux-kernel+bounces-142152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E378A2826
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF41C23B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2114D5A5;
	Fri, 12 Apr 2024 07:33:24 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6724487BE;
	Fri, 12 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907203; cv=none; b=K1rg1ksonl5d5zA/AsQg9/4o4MdANKRVs37VCK8P2gG8pPakBSEMNqWfIOL4TnKK1e7rXKg55YQNEzB6Q8MyaHjJ+Rt5Guwr6sgsyfWf/OaZU/jHRwCfjBQxL7/tKYWWGqGNxXkICR9wOFFAl5kjhqlaaaiCF7IznfBR1ssbQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907203; c=relaxed/simple;
	bh=8L+OryCbKP9r+tCHZ0z5HF44GuDDMOxG3k1lKMO40MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwselLbzGtSUZYfOn9I3wk6nAUsUGr3lfG+ArvxFuNUgsBkXiFG5NDbQQmpxJYXVcHzqT/fVWMQoNf+ryx95yCWoqEI1MxbP+kRmSNMZuRl+A475vV/lV1DNdXRjB2AXDZomR3b7W+24Ow8TgvrFY1jBamChryq5vIlJZmY1vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBPR-000lsI-9l; Fri, 12 Apr 2024 15:33:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:33:34 +0800
Date: Fri, 12 Apr 2024 15:33:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, fanghao11@huawei.com,
	liulongfang@huawei.com, shenyang39@huawei.com,
	songzhiqi1@huawei.com, qianweili@huawei.com,
	liushangbin@hisilicon.com, linwenkai6@hisilicon.com,
	taoqi10@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 0/9] crypto: hisilicon - Optimize and fix some driver
 processes
Message-ID: <ZhjjzpefaFy8FJrZ@gondor.apana.org.au>
References: <20240407080000.673435-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407080000.673435-1-huangchenghai2@huawei.com>

On Sun, Apr 07, 2024 at 03:59:51PM +0800, Chenghai Huang wrote:
> This patch series is mainly used to fix and optimize some
> problems of hisilicon.
> 
> v1 -> v2
> - fixed codecheck warnings about unused variable
>   | Reported-by: kernel test robot <lkp@intel.com>
>   | Closes: https://lore.kernel.org/oe-kbuild-all/202404040616.cF0Pvb9M-lkp@intel.com/
> 
> Chenghai Huang (9):
>   crypto: hisilicon/sec - Add the condition for configuring the sriov
>     function
>   crypto: hisilicon/debugfs - Fix debugfs uninit process issue
>   crypto: hisilicon/sgl - Delete redundant parameter verification
>   crypto: hisilicon/debugfs - Fix the processing logic issue in the
>     debugfs creation
>   crypto: hisilicon/qm - Add the default processing branch
>   crypto: hisilicon - Adjust debugfs creation and release order
>   crypto: hisilicon/sec - Fix memory leak for sec resource release
>   crypto: hisilicon/debugfs - Resolve the problem of applying for
>     redundant space in sq dump
>   crypto: hisilicon/qm - Add the err memory release process to qm uninit
> 
>  drivers/crypto/hisilicon/debugfs.c         | 38 +++++++++++++++-------
>  drivers/crypto/hisilicon/hpre/hpre_main.c  | 21 ++++++------
>  drivers/crypto/hisilicon/qm.c              |  8 ++---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c |  4 ++-
>  drivers/crypto/hisilicon/sec2/sec_main.c   | 26 +++++++--------
>  drivers/crypto/hisilicon/sgl.c             |  5 +--
>  drivers/crypto/hisilicon/zip/zip_main.c    | 24 +++++++-------
>  7 files changed, 68 insertions(+), 58 deletions(-)
> 
> -- 
> 2.30.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

