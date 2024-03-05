Return-Path: <linux-kernel+bounces-92286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20C871DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688782868BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2815676C;
	Tue,  5 Mar 2024 11:32:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592E54910;
	Tue,  5 Mar 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638363; cv=none; b=iumTygfy42Lz7J3QtmAL+0gK/eIfPhoxqDZNvu4SSgiQ+YxmdQnN74XT5Zyhiq1U2o2nsMZBpXMdMLHyriWrvySjmvfhZTycv/ljnqHlz6I+UCXwfN5DKHdQtG2c2VO3oD7IOfoyb0slAfXqX/R7EJJVXYP9VqN4r5JD9KOVtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638363; c=relaxed/simple;
	bh=bKHVK+OXGBs240XYEAacLsUkQ/bCj0REuSU/eEAptk0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eO6VKIjXasyiqtkL8Jd4Wh7Zc/m1m36PMQZmPfXo5gQ2m+xTGxxAk8Gf7Szl1z7tMfCfJ02bVOYHXF2uI8CGUGqzhw4PIQpnLfP9eHxkBH6wY4KijN5bNgi8zNAfgwdE6BxH4VMAiFJHTK7THfc3whgVaFVkml1UMvz1wisUD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tptf338WYzwPFD;
	Tue,  5 Mar 2024 19:30:19 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id DB44D1400C8;
	Tue,  5 Mar 2024 19:32:35 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 19:32:35 +0800
Message-ID: <c7d9818e-37ee-4b68-8241-2ef458a5ac82@huawei.com>
Date: Tue, 5 Mar 2024 19:32:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: hns: Use common error handling code in
 hns_mac_init()
To: Markus Elfring <Markus.Elfring@web.de>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>, Wojciech
 Drewek <wojciech.drewek@intel.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
	Yonglong Liu <liuyonglong@huawei.com>
References: <9a2e5053-07ec-4a11-bef4-7a8b0f80f740@web.de>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <9a2e5053-07ec-4a11-bef4-7a8b0f80f740@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Thanks,
Reviewed-by: Jijie Shao<shaojijie@huawei.com>

on 2024/3/1 23:04, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 15:48:25 +0100
>
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> index f75668c47935..a4919aad45b6 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> @@ -1094,22 +1094,21 @@ int hns_mac_init(struct dsaf_device *dsaf_dev)
>   	device_for_each_child_node(dsaf_dev->dev, child) {
>   		ret = fwnode_property_read_u32(child, "reg", &port_id);
>   		if (ret) {
> -			fwnode_handle_put(child);
>   			dev_err(dsaf_dev->dev,
>   				"get reg fail, ret=%d!\n", ret);
> -			return ret;
> +			goto put_fwnode;
>   		}
>   		if (port_id >= max_port_num) {
> -			fwnode_handle_put(child);
>   			dev_err(dsaf_dev->dev,
>   				"reg(%u) out of range!\n", port_id);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto put_fwnode;
>   		}
>   		mac_cb = devm_kzalloc(dsaf_dev->dev, sizeof(*mac_cb),
>   				      GFP_KERNEL);
>   		if (!mac_cb) {
> -			fwnode_handle_put(child);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto put_fwnode;
>   		}
>   		mac_cb->fw_port = child;
>   		mac_cb->mac_id = (u8)port_id;
> @@ -1148,6 +1147,10 @@ int hns_mac_init(struct dsaf_device *dsaf_dev)
>   	}
>
>   	return 0;
> +
> +put_fwnode:
> +	fwnode_handle_put(child);
> +	return ret;
>   }
>
>   void hns_mac_uninit(struct dsaf_device *dsaf_dev)
> --
> 2.44.0
>

