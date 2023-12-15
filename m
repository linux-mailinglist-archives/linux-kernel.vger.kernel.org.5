Return-Path: <linux-kernel+bounces-573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B5814320
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CAA1C22574
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAA134C2;
	Fri, 15 Dec 2023 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1tvHWAg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4212B99;
	Fri, 15 Dec 2023 08:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146A9C43397;
	Fri, 15 Dec 2023 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702627271;
	bh=fjWhoQ1988wnd5acXghZMLzc04rxWPNRdW0Fgl7C1wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1tvHWAgCX4gNdWFBOY1cAOwWTD9WGgvZlMsHGjWwU4XzKcOkULSz6LTpoho3klBa
	 O1dmWMvtGVqByOEMit3ysgy78WzN2rbbR8HQp9fb1Mk+uIt2z1CEhfwq+89d0HkRWQ
	 H0VdN5q4gz7RdoDbyAh5FOSgWOxdgvf4mUX4ZkONuH9HlLok6cq3UFiM8VR1a0+4G/
	 /QXlph0oH1nSLjM2NW5Hz40wcl+H9Y9sqPeM71AcSveQ5RMH1afEfTQ7CAbSbAh6V3
	 RPUIOSZ34QYEiSInI7kcWJ0ymhamsJlxCCFktIfFc2Wna7VSzN67vzPVTeEQUTJx6l
	 2V9dZRF9cyiog==
Date: Fri, 15 Dec 2023 08:01:04 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 2/3] net: hns3: dump more reg info based on
 ras mod
Message-ID: <20231215080104.GV5817@kernel.org>
References: <20231214141135.613485-1-shaojijie@huawei.com>
 <20231214141135.613485-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214141135.613485-3-shaojijie@huawei.com>

On Thu, Dec 14, 2023 at 10:11:34PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> Dump more reg info base on ras mod before reset, which is useful to
> analyze the ras error.
> 
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
> index 68b738affa66..45a783a50643 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
> @@ -5,6 +5,7 @@
>  #define __HCLGE_ERR_H
>  
>  #include "hclge_main.h"
> +#include "hclge_debugfs.h"

Hi Jijie Shao and Peiyang Wang,

hclge_debugfs.h defines a number of constants, such as hclge_dbg_tqp_reg.

With the above include added, these constants are now also defined
in files that include hclge_err.h. Which leads to them
being defined but unused in hclge_main.c.

At a glance, it seems that these constants are only used in hclge_debugfs.c.
Perhaps they could simply be moved there?

Flagged by gcc-13 W=1 allmodconfig builds.

>  #include "hnae3.h"
>  
>  #define HCLGE_MPF_RAS_INT_MIN_BD_NUM	10

...

