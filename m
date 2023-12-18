Return-Path: <linux-kernel+bounces-3342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061E1816B39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3933C1C22A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB94156FD;
	Mon, 18 Dec 2023 10:32:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m12814.netease.com (mail-m12814.netease.com [103.209.128.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC814F7D;
	Mon, 18 Dec 2023 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.77.185] (unknown [121.32.254.148])
	by mail-m12741.qiye.163.com (Hmail) with ESMTPA id 47A809E0588;
	Mon, 18 Dec 2023 14:54:50 +0800 (CST)
Message-ID: <3ca71217-4291-45e4-9073-9e32c5177e29@sangfor.com.cn>
Date: Mon, 18 Dec 2023 14:54:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] i40e: fix use-after-free in i40e_aqc_add_filters()
Content-Language: en-US
To: Brett Creeley <bcreeley@amd.com>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: dinghui@sangfor.com.cn, zhudi2@huawei.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231213104912.16153-1-xiaoke@sangfor.com.cn>
 <0edc953a-0357-d054-d9a2-e9a86e90233d@amd.com>
From: "xiaoke@sangfor.com.cn" <xiaoke@sangfor.com.cn>
In-Reply-To: <0edc953a-0357-d054-d9a2-e9a86e90233d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGhlPVk4eQh8dQx9JShlOTFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSlVISVVJTk9VSk9DWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c7bb4b97cb214kuuu47a809e0588
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6Nxw4UTwxSioDKyhKDVEU
	SRowC01VSlVKTEtJQ0NJT0JKSU9MVTMWGhIXVQMSGhQQHjsIGhUcHRQJVRgUFlUYFUVZV1kSC1lB
	WUpJSlVISVVJTk9VSk9DWVdZCAFZQUlOSkI3Bg++

On 2023/12/16 1:16, Brett Creeley wrote:
> On 12/13/2023 2:49 AM, Ke Xiao wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c 
>> b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 1ab8dbe2d880..16b574d69843 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -108,11 +108,17 @@ static void netdev_hw_addr_refcnt(struct 
>> i40e_mac_filter *f,
>>                                    struct net_device *netdev, int delta)
>>   {
>>          struct netdev_hw_addr *ha;
>> +       struct netdev_hw_addr_list *ha_list;
> 
> Nit, needs to be in Reverse Christmas Tree (RCT) order.

Thanks, I will send the V2 to follow the rule.

