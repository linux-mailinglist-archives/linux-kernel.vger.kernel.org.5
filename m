Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E23802F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjLDJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjLDJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:57:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0579FB6;
        Mon,  4 Dec 2023 01:57:54 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B48JDHd002330;
        Mon, 4 Dec 2023 09:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1U8ANJ1MUuewKhfU6DLgDYvcVITnKtqeI7iFGTnw/yg=;
 b=WxF3YfsrnjWAi/VWD8o7qp4Yh+AcXTJkRLmOujZW50WrIdZx8lVA/qJvZEVB227zCGUg
 vMjfsDgo8bViwK0cCSsI5iI5jMyZo+6Ca47b4wWUaWbR0Mhp37hcQ/3/hBsf7ckHsCcu
 5DofRPaPITnaWn1Kf9bZ4Gh6X+UtyEpCWAIax7Y6O2XpL6IfETIA8IKO6oiXe1712HNZ
 pRnPek2PQlYHWUOV8lPQb0EmUEdGKmAi29tel1U7icp5PV8CVA2BnVBwahiX3hUo+Xh+
 /v/+Y1gJxM9Oaur1tvZ8V4rp42GMn8ZgkDaXBC6AQNQ6FfllSN8+dkbHrpil+8DVKUji ww== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqv673m66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 09:57:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B49vn0m022270
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 09:57:49 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 01:57:44 -0800
Message-ID: <4d85fda9-6e00-4bb4-b8a8-85c5e66635bf@quicinc.com>
Date:   Mon, 4 Dec 2023 17:57:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: Add lock to ensure the state atomization
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20231201152931.31161-1-quic_aiquny@quicinc.com>
 <6jlui5h7d2rs37sdvvwmii55mwhm5dzfo2m62hwt53mkx4z32a@aw5kcghe4bik>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <6jlui5h7d2rs37sdvvwmii55mwhm5dzfo2m62hwt53mkx4z32a@aw5kcghe4bik>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zRNDn3JTG5xlrNZ9DzuWwAXzZeJuZIBz
X-Proofpoint-GUID: zRNDn3JTG5xlrNZ9DzuWwAXzZeJuZIBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/2023 4:39 AM, Bjorn Andersson wrote:
> On Fri, Dec 01, 2023 at 11:29:31PM +0800, Maria Yu wrote:
>> Currently pinctrl_select_state is an export symbol and don't have
>> effective re-entrance protect design. And possible of pinctrl state
>> changed during pinctrl_commit_state handling. Add per pinctrl lock to
>> ensure the old state and new state transition atomization.
>> Move dev error print message right before old_state pinctrl_select_state
>> and out of lock protection to avoid console related driver call
>> pinctrl_select_state recursively.
> 
> I'm uncertain about the validity of having client code call this api in
> a racy manner. I'm likely just missing something here... It would be
> nice if this scenario was described in a little bit more detail.
Hi Bjorn,

we've got a customer dump that the real racy happened, and the system 
frequently have printk message like:
   "not freeing pin xx (xxx) as part of deactivating group xxx - it is
already used for some other setting".
Finally the system crashed after the flood log.

We've inform the customer to check their own client code which called 
this api, to have proper lock to avoid racy of per dev 
pinctrl_select_state call from customer driver end.
For example:
LOCK;
pinctrl_select_state();
gpio pulling;
udelay();
check state;
other hardware behaviors;
UNLOCK;

While it is still unnecessary the volatile re-load of p->state for the 
interation and so I upstream a patch like link[2].

while during the merge discussion, upstream maintainer suggest to have 
the lock issue fixed, instead of only READ_ONCE for the interation.
I think it is also make sense since although current in-tree driver have 
take care of each pinctrl_select_state call, since it is a export 
symbole and we've see the similar issue continuously (a year back ago 
also we've seen similar issue before[3]).

The whole serials discussion can be found link here:
[1] 
https://lore.kernel.org/lkml/e011b3e9-7c09-4214-8e9c-90e12c38bbaa@quicinc.com/
[2] 
https://lore.kernel.org/lkml/20231115102824.23727-1-quic_aiquny@quicinc.com/
[3] 
https://lore.kernel.org/lkml/20221027065408.36977-1-quic_aiquny@quicinc.com/

> 
> The recursive error print sounds like a distinct problem of its own,
> that warrants being introduced in a patch of its own. But as with the
> other part, I'm not able to spot a code path in the upstream kernel
> where this hppens, so please properly describe the scenario where
> touching the console would result back in another pinctrl_select_state().
For this part, I am thinking about a spin lock is introduced and have 
the error log out of the lock will be safer.
The current patch disable irq during the lock, and some console driver 
rely on interrupt to get tx dma/fifo ready.
Also console driver will be a pinctrl client, so avoid unnecessary 
recursive in theory.
Just incase some out of tree concole driver was able to use the 
pinctrl_select_state in console write related APIs as well.
> 
> Thanks,
> Bjorn
> 
>>
>> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   drivers/pinctrl/core.c | 11 +++++++++--
>>   drivers/pinctrl/core.h |  2 ++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
>> index f2977eb65522..a19c286bf82e 100644
>> --- a/drivers/pinctrl/core.c
>> +++ b/drivers/pinctrl/core.c
>> @@ -1066,6 +1066,7 @@ static struct pinctrl *create_pinctrl(struct device *dev,
>>   	p->dev = dev;
>>   	INIT_LIST_HEAD(&p->states);
>>   	INIT_LIST_HEAD(&p->dt_maps);
>> +	spin_lock_init(&p->lock);
>>   
>>   	ret = pinctrl_dt_to_map(p, pctldev);
>>   	if (ret < 0) {
>> @@ -1262,9 +1263,12 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
>>   static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>>   {
>>   	struct pinctrl_setting *setting, *setting2;
>> -	struct pinctrl_state *old_state = READ_ONCE(p->state);
>> +	struct pinctrl_state *old_state;
>>   	int ret;
>> +	unsigned long flags;
>>   
>> +	spin_lock_irqsave(&p->lock, flags);
>> +	old_state = p->state;
>>   	if (old_state) {
>>   		/*
>>   		 * For each pinmux setting in the old state, forget SW's record
>> @@ -1329,11 +1333,11 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>>   	}
>>   
>>   	p->state = state;
>> +	spin_unlock_irqrestore(&p->lock, flags);
>>   
>>   	return 0;
>>   
>>   unapply_new_state:
>> -	dev_err(p->dev, "Error applying setting, reverse things back\n");
>>   
>>   	list_for_each_entry(setting2, &state->settings, node) {
>>   		if (&setting2->node == &setting->node)
>> @@ -1349,6 +1353,9 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>>   			pinmux_disable_setting(setting2);
>>   	}
>>   
>> +	spin_unlock_irqrestore(&p->lock, flags);
>> +
>> +	dev_err(p->dev, "Error applying setting, reverse things back\n");
>>   	/* There's no infinite recursive loop here because p->state is NULL */
>>   	if (old_state)
>>   		pinctrl_select_state(p, old_state);
>> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
>> index 530370443c19..86fc41393f7b 100644
>> --- a/drivers/pinctrl/core.h
>> +++ b/drivers/pinctrl/core.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/list.h>
>>   #include <linux/mutex.h>
>>   #include <linux/radix-tree.h>
>> +#include <linux/spinlock.h>
>>   #include <linux/types.h>
>>   
>>   #include <linux/pinctrl/machine.h>
>> @@ -91,6 +92,7 @@ struct pinctrl {
>>   	struct pinctrl_state *state;
>>   	struct list_head dt_maps;
>>   	struct kref users;
>> +	spinlock_t lock;
>>   };
>>   
>>   /**
>>
>> base-commit: 994d5c58e50e91bb02c7be4a91d5186292a895c8
>> -- 
>> 2.17.1
>>
>>

-- 
Thx and BRs,
Aiqun(Maria) Yu

