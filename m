Return-Path: <linux-kernel+bounces-49614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE21846CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D592859F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB7745F9;
	Fri,  2 Feb 2024 09:48:54 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11064182B5;
	Fri,  2 Feb 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867334; cv=none; b=nWLVF6IwKlg3MXkBYOTrZgR+qygrEATeJapf5tGZ+7iikrGCxto0bl8kbs76s+Jmkm7q8l+MkhsMMmguZCDYyTO4mamtkSAOtVR4T3bXHl7OKDG5Y4RO5x298z0h7uZooHRzLWFD+JK5QsY06CN8e4KMVaqulR/3u+U9RS6t29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867334; c=relaxed/simple;
	bh=NxwVlXQNaf6oC1kwNfeXy43EStLgElZO/E6ZQWQQG9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeKGh9jHGnyRxZHXK8sUHdQDKQlNVpB4mhzorQTpZ8Fr+3E366B75rEgePzXEpe74Sbiv+23KkBSGI5bA5PaV0YQfdI0ge6UcNEK8rasqVXBm9fvmp7Wlom7HjoAG4TofYgdr3RscAiKHVFRh0NzvcGPXl7tRbvJ/W1Av/F2mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVqAB-0092Oc-OW; Fri, 02 Feb 2024 17:48:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Feb 2024 17:49:01 +0800
Date: Fri, 2 Feb 2024 17:49:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, shenyang39@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/zip - Modify some data type and code
 cleanup
Message-ID: <Zby6jat2npUKMCx8@gondor.apana.org.au>
References: <20240127060850.183186-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127060850.183186-1-huangchenghai2@huawei.com>

On Sat, Jan 27, 2024 at 02:08:50PM +0800, Chenghai Huang wrote:
> From: Yang Shen <shenyang39@huawei.com>
> 
> Improve some inappropriate variable types to make variable expression more
> accurate.
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 29 +++++++++++--------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
> index 479ba8a1d6b5..b3e2b58ba7d7 100644
> --- a/drivers/crypto/hisilicon/zip/zip_main.c
> +++ b/drivers/crypto/hisilicon/zip/zip_main.c
> @@ -809,21 +809,20 @@ DEFINE_SHOW_ATTRIBUTE(hisi_zip_regs);
>  
>  static int hisi_zip_core_debug_init(struct hisi_qm *qm)
>  {
> -	u32 zip_core_num, zip_comp_core_num;
> +	u32 zip_core_num, zip_comp_core_num, i;
>  	struct device *dev = &qm->pdev->dev;
>  	struct debugfs_regset32 *regset;
>  	struct dentry *tmp_d;
>  	char buf[HZIP_BUF_SIZE];
> -	int i;
>  
>  	zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
>  	zip_comp_core_num = qm->cap_tables.dev_cap_table[ZIP_CLUSTER_COMP_NUM_CAP_IDX].cap_val;
>  
>  	for (i = 0; i < zip_core_num; i++) {
>  		if (i < zip_comp_core_num)
> -			scnprintf(buf, sizeof(buf), "comp_core%d", i);
> +			scnprintf(buf, sizeof(buf), "comp_core%u", i);
>  		else
> -			scnprintf(buf, sizeof(buf), "decomp_core%d",
> +			scnprintf(buf, sizeof(buf), "decomp_core%u",
>  				  i - zip_comp_core_num);
>  
>  		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);

What issues does this patch fix? This change appears to be
gratuitous.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

