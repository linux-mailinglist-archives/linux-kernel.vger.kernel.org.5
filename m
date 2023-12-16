Return-Path: <linux-kernel+bounces-1933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E40081560A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A5B243AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986001399;
	Sat, 16 Dec 2023 01:43:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8310F1;
	Sat, 16 Dec 2023 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SsTMs5dhtz29frc;
	Sat, 16 Dec 2023 09:41:45 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 920011400DA;
	Sat, 16 Dec 2023 09:42:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 16 Dec 2023 09:42:54 +0800
Message-ID: <ad6b7294-049b-475a-bd55-75f61d72d258@huawei.com>
Date: Sat, 16 Dec 2023 09:42:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <lanhao@huawei.com>,
	<wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 1/3] net: hns3: add command queue trace for
 hns3
To: Simon Horman <horms@kernel.org>
References: <20231214141135.613485-1-shaojijie@huawei.com>
 <20231214141135.613485-2-shaojijie@huawei.com>
 <20231214210434.GU5817@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231214210434.GU5817@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2023/12/15 5:04, Simon Horman wrote:
> On Thu, Dec 14, 2023 at 10:11:33PM +0800, Jijie Shao wrote:
>> From: Hao Lan <lanhao@huawei.com>
>> ...
>> @@ -470,10 +470,14 @@ static int hclge_comm_cmd_check_result(struct hclge_comm_hw *hw,
>>   int hclge_comm_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
>>   			int num)
>>   {
>> +	bool is_special = hclge_comm_is_special_opcode(desc->opcode);
>>   	struct hclge_comm_cmq_ring *csq = &hw->cmq.csq;
>>   	int ret;
>>   	int ntc;
> hclge_comm_is_special_opcode takes a u16 value as it's argument,
> but the type of desc->opcode is __le16. So perhaps this should be
> (completely untested!):
>
> 	struct hclge_comm_cmq_ring *csq = &hw->cmq.csq;
> 	bool is_special;
> 	...
>
> 	is_special = hclge_comm_is_special_opcode(le16_to_cpu(desc->opcode));
>
> Flagged by Sparse.

Thank you,
it will be fixed in v3

Jijie


