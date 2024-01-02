Return-Path: <linux-kernel+bounces-13977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C18821662
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85E41C21040
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F4EC9;
	Tue,  2 Jan 2024 02:13:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C015C2;
	Tue,  2 Jan 2024 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VziwJm._1704161598;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VziwJm._1704161598)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 10:13:19 +0800
Date: Tue, 2 Jan 2024 10:13:17 +0800
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
Subject: Re: [PATCH 1/2] net/smc: Return directly after a failed kzalloc() in
 smc_fill_gid_list()
Message-ID: <ZZNxPadDoJ6gxRmb@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <f02303c3-5968-48c3-990b-be0be8a66521@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02303c3-5968-48c3-990b-be0be8a66521@web.de>

On Sun, Dec 31, 2023 at 03:58:15PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 15:15:19 +0100
> 
> The kfree() function was called in one case by
> the smc_fill_gid_list() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a call of the function "kzalloc" failed
> at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

LGTM, thank you.

Also please add net tag in subject and fixes tag in commit body.

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> ---
>  net/smc/af_smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 7fc2f3c6d248..a396a9977ba9 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1180,7 +1180,7 @@ void smc_fill_gid_list(struct smc_link_group *lgr,
> 
>  	alt_ini = kzalloc(sizeof(*alt_ini), GFP_KERNEL);
>  	if (!alt_ini)
> -		goto out;
> +		return;
> 
>  	alt_ini->vlan_id = lgr->vlan_id;
>  	alt_ini->check_smcrv2 = true;
> --
> 2.43.0

