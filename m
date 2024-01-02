Return-Path: <linux-kernel+bounces-13978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4582166B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E151F217B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB2ED4;
	Tue,  2 Jan 2024 02:19:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD4A38;
	Tue,  2 Jan 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vzj5iao_1704161982;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vzj5iao_1704161982)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 10:19:43 +0800
Date: Tue, 2 Jan 2024 10:19:41 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net/smc: Improve exception handling in
 smc_llc_cli_add_link_invite()
Message-ID: <ZZNyvTdnTz2Usd4j@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <5253e660-6b66-4775-ae2f-06f5a1d40be5@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5253e660-6b66-4775-ae2f-06f5a1d40be5@web.de>

On Sun, Dec 31, 2023 at 04:00:22PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 15:42:07 +0100
> 
> The kfree() function was called in some cases by
> the smc_llc_cli_add_link_invite() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> * Thus use another label.
> 
> * Merge two if statements.
> 
> * Omit an initialisation (for the variable "ini")
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thank you, LGTM. Also net and Fixes tags are needed.

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>  net/smc/smc_llc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 018ce8133b02..2ff24a7feb26 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1163,23 +1163,21 @@ static void smc_llc_cli_add_link_invite(struct smc_link *link,
>  					struct smc_llc_qentry *qentry)
>  {
>  	struct smc_link_group *lgr = smc_get_lgr(link);
> -	struct smc_init_info *ini = NULL;
> +	struct smc_init_info *ini;
> 
>  	if (lgr->smc_version == SMC_V2) {
>  		smc_llc_send_request_add_link(link);
> -		goto out;
> +		goto free_qentry;
>  	}
> 
>  	if (lgr->type == SMC_LGR_SYMMETRIC ||
> -	    lgr->type == SMC_LGR_ASYMMETRIC_PEER)
> -		goto out;
> -
> -	if (lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
> -		goto out;
> +	    lgr->type == SMC_LGR_ASYMMETRIC_PEER ||
> +	    lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
> +		goto free_qentry;
> 
>  	ini = kzalloc(sizeof(*ini), GFP_KERNEL);
>  	if (!ini)
> -		goto out;
> +		goto free_qentry;
> 
>  	ini->vlan_id = lgr->vlan_id;
>  	smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
> @@ -1190,6 +1188,7 @@ static void smc_llc_cli_add_link_invite(struct smc_link *link,
>  			      ini->ib_gid, NULL, SMC_LLC_REQ);
>  out:
>  	kfree(ini);
> +free_qentry:
>  	kfree(qentry);
>  }
> 
> --
> 2.43.0

