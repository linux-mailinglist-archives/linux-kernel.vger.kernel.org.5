Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0780C93F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjLKMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjLKMPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:15:36 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF711F;
        Mon, 11 Dec 2023 04:15:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyIPaKz_1702296927;
Received: from 30.221.130.53(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyIPaKz_1702296927)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 20:15:28 +0800
Message-ID: <9a6d57c0-f5b4-9b2c-dc5f-dc47d0518141@linux.alibaba.com>
Date:   Mon, 11 Dec 2023 20:15:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 2/9] net/smc: introduce sub-functions for
 smc_clc_send_confirm_accept()
To:     Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
 <ac3c0823-8705-4225-96c8-ed7bc55d1bfc@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ac3c0823-8705-4225-96c8-ed7bc55d1bfc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/11 18:43, Alexandra Winter wrote:
> 
> 
> On 08.12.23 08:40, Wen Gu wrote:
>> There is a large if-else block in smc_clc_send_confirm_accept() and it
>> is better to split it into two sub-functions.
>>
>> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> 
> Thank you very much Wen Gu for improving the codebase.
> 
I'm glad I could help.

> 
>>   net/smc/smc_clc.c | 196 +++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 114 insertions(+), 82 deletions(-)
>>
>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index 0fcb035..52b4ea9 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -998,6 +998,111 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>>   	return reason_code;
>>   }
>>   
>> +static void smcd_clc_prep_confirm_accept(struct smc_connection *conn,
>> +				struct smc_clc_msg_accept_confirm_v2 *clc_v2,
>> +				int first_contact, u8 version,
>> +				u8 *eid, struct smc_init_info *ini,
>> +				int *fce_len,
>> +				struct smc_clc_first_contact_ext_v2x *fce_v2x,
>> +				struct smc_clc_msg_trail *trl)
>> +{
>> +	struct smcd_dev *smcd = conn->lgr->smcd;
>> +	struct smc_clc_msg_accept_confirm *clc;
>> +	int len;
>> +
>> +	/* SMC-D specific settings */
>> +	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
> 
> Why is this cast neccessary? (Here as well as in smcr_clc_prep_confirm_accept
> and in smc_clc_send_confirm_accept)
> smc_clc_msg_accept_confirm_v2 has hdr and d0 as well.

I think the cast is to imply that v2 is an expansion of v1, or v1 is the base of v2.
So here using clc(v1) reperesents their common set.

If we use smc_clc_msg_accept_confirm_v2 for all, I think readers may be tempted to
check whether the hdr and d0 in 'smc_clc_msg_accept_confirm_v2' are also applicable to v1.

And there are settings below that are specific for v1. It may be confusing if we
change it like this:

if (version == SMC_V1) {
	clc_v2->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
} else {


> 
> IMO, it would be a nice seperate patch to get rid of the 2 type defs for
> smc_clc_msg_accept_confirm and smc_clc_msg_accept_confirm_v2
> and all the related casting anyhow.
> 

Do you mean to define only smc_clc_msg_accept_confirm_v2 or define with the name
of smc_clc_msg_accept_confirm but the contents of smc_clc_msg_accept_confirm_v2?

I have a different opinion on this, since I think the smc_clc_msg_accept_confirm
and smc_clc_msg_accept_confirm_v2 clearly shows the difference between v1 and
v2 messages and remind people what is currently working on. So I perfer to keep them.
Am I missing something?

> 
> 
>> +	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
>> +	       sizeof(SMCD_EYECATCHER));
>> +	clc->hdr.typev1 = SMC_TYPE_D;
>> +	clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
>> +	clc->d0.token = htonll(conn->rmb_desc->token);
>> +	clc->d0.dmbe_size = conn->rmbe_size_comp;
>> +	clc->d0.dmbe_idx = 0;
>> +	memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
>> +	if (version == SMC_V1) {
>> +		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
>> +	} else {
>> +		clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
>> +		if (eid && eid[0])
>> +			memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
>> +		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>> +		if (first_contact) {
>> +			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
>> +			len += *fce_len;
>> +		}
>> +		clc_v2->hdr.length = htons(len);
>> +	}
>> +	memcpy(trl->eyecatcher, SMCD_EYECATCHER,
>> +	       sizeof(SMCD_EYECATCHER));
>> +}
>> +
>> +static void smcr_clc_prep_confirm_accept(struct smc_connection *conn,
>> +				struct smc_clc_msg_accept_confirm_v2 *clc_v2,
>> +				int first_contact, u8 version,
>> +				u8 *eid, struct smc_init_info *ini,
>> +				int *fce_len,
>> +				struct smc_clc_first_contact_ext_v2x *fce_v2x,
>> +				struct smc_clc_fce_gid_ext *gle,
>> +				struct smc_clc_msg_trail *trl)
>> +{
>> +	struct smc_clc_msg_accept_confirm *clc;
>> +	struct smc_link *link = conn->lnk;
>> +	int len;
>> +
>> +	/* SMC-R specific settings */
>> +	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
> 
> Why is this cast neccessary?
> smc_clc_msg_accept_confirm_v2 has hdr and r0 as well.
> 
Similar thought as SMCD.

>> +	memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
>> +	       sizeof(SMC_EYECATCHER));
>> +	clc->hdr.typev1 = SMC_TYPE_R;
>> +	clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
> 
> ^^ this is overwritten below, so no need to set it here.
> 

Good catch! It will be removed. Thank you.

<...>
