Return-Path: <linux-kernel+bounces-20542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1682806C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC2B283661
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9DB21A11;
	Tue,  9 Jan 2024 08:19:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D213ACF;
	Tue,  9 Jan 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T8P3G0dKYzsVs2;
	Tue,  9 Jan 2024 16:19:06 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 28AF8140136;
	Tue,  9 Jan 2024 16:19:49 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 16:19:48 +0800
Message-ID: <00e5d6e2-168c-4887-8b6d-8498ebaafe6d@huawei.com>
Date: Tue, 9 Jan 2024 16:19:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
	<lanhao@huawei.com>, <wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 net-next 4/4] net: hns3: support dump pfc frame
 statistics in tx timeout log
To: Jiri Pirko <jiri@resnulli.us>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
 <20240105010119.2619873-5-shaojijie@huawei.com> <ZZfSJoEsoXceI_2q@nanopsycho>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZZfSJoEsoXceI_2q@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/1/5 17:55, Jiri Pirko wrote:
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> @@ -2871,8 +2871,10 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
>> 		struct hns3_mac_stats mac_stats;
>>
>> 		h->ae_algo->ops->get_mac_stats(h, &mac_stats);
>> -		netdev_info(ndev, "tx_pause_cnt: %llu, rx_pause_cnt: %llu\n",
>> -			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt);
>> +		netdev_info(ndev,
>> +			    "tx_pause_cnt: %llu, rx_pause_cnt: %llu, tx_pfc_cnt: %llu, rx_pfc_cnt: %llu\n",
>> +			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt,
>> +			    mac_stats.tx_pfc_cnt, mac_stats.rx_pfc_cnt);
> Don't we have a better way to expose this? I mean, whenever there is a
> patch that extends the amount of text written in dmesg, it smells.
> We should rather reduce it.
>
In fact, we include this part of the statistics in the ethtool -S 
statistics. However, if tx timeout occurs,the driver performs a reset 
attempt to recover it. And the statistics are cleared after the reset. 
Therefore, pfc statistics are added to tx timeout log to determine the 
timeout cause.



