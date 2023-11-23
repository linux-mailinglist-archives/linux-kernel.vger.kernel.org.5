Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0657F607E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjKWNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjKWNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:40:01 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413311A8;
        Thu, 23 Nov 2023 05:40:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vx-bD91_1700746802;
Received: from 30.221.129.10(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vx-bD91_1700746802)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 21:40:03 +0800
Message-ID: <80014d58-48b0-928f-cc0c-dcfaa75e5975@linux.alibaba.com>
Date:   Thu, 23 Nov 2023 21:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 5/7] net/smc: compatible with 128-bits extend GID
 of virtual ISM device
To:     Simon Horman <horms@kernel.org>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
 <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
 <20231122190725.GB6731@kernel.org>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231122190725.GB6731@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/23 03:07, Simon Horman wrote:

> On Sun, Nov 19, 2023 at 09:57:55PM +0800, Wen Gu wrote:
>> According to virtual ISM support feature defined by SMCv2.1, GIDs of
>> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
>> long. So some adaptation work is required. And note that the GIDs of
>> existing platform firmware ISM devices still remain 64-bits long.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> 
> ...
> 
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> 
> ...
> 
>> @@ -1522,7 +1527,10 @@ void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid, unsigned short vlan)
>>   	/* run common cleanup function and build free list */
>>   	spin_lock_bh(&dev->lgr_lock);
>>   	list_for_each_entry_safe(lgr, l, &dev->lgr_list, list) {
>> -		if ((!peer_gid || lgr->peer_gid == peer_gid) &&
>> +		if ((!peer_gid->gid ||
> 
> Hi Wen Gu,
> 
> Previously this condition assumed that peer could be NULL,
> and that is still the case in the next condition, a few lines down.
> But with this patch peer is unconditionally dereferenced here.
> 
> As flagged by Smatch.
> 

Hi Simon,

Good catch!

Previously the peer_gid is an u64 type variable and it will be checked if it is 0.

With this patch, peer_gid is an struct smcd_gid type pointer and the function that
calls smc_smcd_terminate will make sure it is not NULL. So it is safe here.

But there is indeed a problem here, see below.

>> +		     (lgr->peer_gid.gid == peer_gid->gid &&
>> +		      !smc_ism_is_virtual(dev) ? 1 :
>> +		      lgr->peer_gid.gid_ext == peer_gid->gid_ext)) &&
>>   		    (vlan == VLAN_VID_MASK || lgr->vlan_id == vlan)) {
>>   			if (peer_gid) /* peer triggered termination */

This if condition should be 'if (peer_gid->gid)'

I will fix this in the next version. Thank you very much.

Regards,
Wen Gu

>>   				lgr->peer_shutdown = 1;
> 
> ...
