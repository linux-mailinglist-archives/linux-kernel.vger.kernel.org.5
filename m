Return-Path: <linux-kernel+bounces-25610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C182D37F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A8281660
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717820E6;
	Mon, 15 Jan 2024 03:50:08 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F44186A;
	Mon, 15 Jan 2024 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad3584cdeded4aa7aa35c29c9456ddfa-20240115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:30ae8a57-8a58-4796-9abd-fb1752245180,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:30ae8a57-8a58-4796-9abd-fb1752245180,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:c1d0292f-1ab8-4133-9780-81938111c800,B
	ulkID:240112233230SFMXI8SS,BulkQuantity:6,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: ad3584cdeded4aa7aa35c29c9456ddfa-20240115
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 530555269; Mon, 15 Jan 2024 11:02:14 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E7E4BE000EB9;
	Mon, 15 Jan 2024 11:02:13 +0800 (CST)
X-ns-mid: postfix-65A4A035-870995346
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id BCF8BE000EB9;
	Mon, 15 Jan 2024 11:02:10 +0800 (CST)
Message-ID: <b71c5e28-2dbe-48c8-ab92-e1dad9d6f2e4@kylinos.cn>
Date: Mon, 15 Jan 2024 11:02:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: Fix possible NULL pointer dereference
 issues caused by phy_attached_info_irq
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112095724.154197-1-chentao@kylinos.cn>
 <627c9558-04df-43a6-b6e4-a13f24a8bc1d@lunn.ch>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <627c9558-04df-43a6-b6e4-a13f24a8bc1d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

On 2024/1/12 23:32, Andrew Lunn wrote:
> On Fri, Jan 12, 2024 at 05:57:24PM +0800, Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
>>
>> Fixes: e27f178793de ("net: phy: Added IRQ print to phylink_bringup_phy()")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/net/phy/phy_device.c | 3 +++
>>   drivers/net/phy/phylink.c    | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 3611ea64875e..10fa99d957c0 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -1299,6 +1299,9 @@ void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
>>   	const char *unbound = phydev->drv ? "" : "[unbound] ";
>>   	char *irq_str = phy_attached_info_irq(phydev);
>>   
>> +	if (!irq_str)
>> +		return;
>> +
>>   	if (!fmt) {
>>   		phydev_info(phydev, ATTACHED_FMT "\n", unbound,
>>   			    phydev_name(phydev), irq_str);
> 
> This part looks O.K.
> 
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index ed0b4ccaa6a6..db0a545c9468 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -1884,6 +1884,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>>   	phy->phy_link_change = phylink_phy_change;
>>   
>>   	irq_str = phy_attached_info_irq(phy);
>> +	if (!irq_str)
>> +		return -ENOMEM;
> 
> Here, i would just skip the print and continue with the reset of the
> function. The print is just useful information, its not a big problem
> if its not printed. However, if this function does not complete, the
> network interface is likely to be dead.
Thanks for the reminder.
The second part doesn't look so perfect, can we just print an empty 
string when the irq_str is empty?

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1886,7 +1886,7 @@ static int phylink_bringup_phy(struct phylink *pl, 
struct phy_device *phy,
         irq_str = phy_attached_info_irq(phy);
         phylink_info(pl,
                      "PHY [%s] driver [%s] (irq=%s)\n",
-                    dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
+                    dev_name(&phy->mdio.dev), phy->drv->name, irq_str ? 
irq_str : "");
         kfree(irq_str);

> 
> 	Andrew
-- 
Thanks,
   Kunwu


