Return-Path: <linux-kernel+bounces-25693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13182D4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741E11F2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532563B6;
	Mon, 15 Jan 2024 07:33:37 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB141D26B;
	Mon, 15 Jan 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1ebb06023fd549a6846b4547b4fa3ddd-20240115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:59943a68-9114-4ba3-a1e3-8f89d6ee0ae5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:59943a68-9114-4ba3-a1e3-8f89d6ee0ae5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:d046db82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240112233230SFMXI8SS,BulkQuantity:18,Recheck:0,SF:64|66|24|17|19|44|
	102,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,
	TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 1ebb06023fd549a6846b4547b4fa3ddd-20240115
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 294264333; Mon, 15 Jan 2024 15:28:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B15EAE000EB9;
	Mon, 15 Jan 2024 15:28:05 +0800 (CST)
X-ns-mid: postfix-65A4DE85-59623665
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id ACB00E000EB9;
	Mon, 15 Jan 2024 15:28:03 +0800 (CST)
Message-ID: <4127e24d-e78c-40da-80b7-96d3e789c489@kylinos.cn>
Date: Mon, 15 Jan 2024 15:28:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: Fix possible NULL pointer dereference
 issues caused by phy_attached_info_irq
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112095724.154197-1-chentao@kylinos.cn>
 <627c9558-04df-43a6-b6e4-a13f24a8bc1d@lunn.ch>
 <b71c5e28-2dbe-48c8-ab92-e1dad9d6f2e4@kylinos.cn>
 <bd80fc69-d334-4b69-8ba3-3b2b86e1fd84@lunn.ch>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <bd80fc69-d334-4b69-8ba3-3b2b86e1fd84@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/15 11:45, Andrew Lunn wrote:
>>> Here, i would just skip the print and continue with the reset of the
>>> function. The print is just useful information, its not a big problem
>>> if its not printed. However, if this function does not complete, the
>>> network interface is likely to be dead.
>> Thanks for the reminder.
>> The second part doesn't look so perfect, can we just print an empty string
>> when the irq_str is empty?
>>
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -1886,7 +1886,7 @@ static int phylink_bringup_phy(struct phylink *pl,
>> struct phy_device *phy,
>>          irq_str = phy_attached_info_irq(phy);
>>          phylink_info(pl,
>>                       "PHY [%s] driver [%s] (irq=%s)\n",
>> -                    dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
>> +                    dev_name(&phy->mdio.dev), phy->drv->name, irq_str ?
>> irq_str : "");
>>          kfree(irq_str);
> 
> That is O.K, or skip the whole phylink_info().
> 
>       Andrew

Thanks, I will update it in v2 patch. Personal view, print a msg is good 
for debug.
-- 
Thanks,
   Kunwu


