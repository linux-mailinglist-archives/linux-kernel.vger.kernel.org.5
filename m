Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E174380C771
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjLKK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLKK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:57:16 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6559A;
        Mon, 11 Dec 2023 02:57:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyGZV2y_1702292234;
Received: from 30.221.130.53(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyGZV2y_1702292234)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 18:57:15 +0800
Message-ID: <64e8d13a-5811-774b-9e94-20ff747b1d0d@linux.alibaba.com>
Date:   Mon, 11 Dec 2023 18:57:13 +0800
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
 <4ad3a168-f506-fc21-582d-fe8764f404c0@linux.alibaba.com>
 <3b3b5b33-1088-47c3-8cbc-4079c6ff472e@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <3b3b5b33-1088-47c3-8cbc-4079c6ff472e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/11 17:47, Alexandra Winter wrote:
> 
> 
> On 09.12.23 03:50, Wen Gu wrote:
>>
>>
>> On 2023/12/8 15:40, Wen Gu wrote:
>>
>>> There is a large if-else block in smc_clc_send_confirm_accept() and it
>>> is better to split it into two sub-functions.
>>>
>>> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>    net/smc/smc_clc.c | 196 +++++++++++++++++++++++++++++++-----------------------
>>>    1 file changed, 114 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>>> index 0fcb035..52b4ea9 100644
>>> --- a/net/smc/smc_clc.c
>>> +++ b/net/smc/smc_clc.c
>>> @@ -998,6 +998,111 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>>>        return reason_code;
>>>    }
>>>    +static void smcd_clc_prep_confirm_accept(struct smc_connection *conn,
>>> +                struct smc_clc_msg_accept_confirm_v2 *clc_v2,
>>
>> checkpatch will complain 'Alignment should match open parenthesis' here.
>> But in order to make the length less than 80 columns, there seems to be
>> no other good way.
>>
>>> +                int first_contact, u8 version,
>>> +                u8 *eid, struct smc_init_info *ini,
>>> +                int *fce_len,
>>> +                struct smc_clc_first_contact_ext_v2x *fce_v2x,
>>> +                struct smc_clc_msg_trail *trl)
>>> +{
>> <...>
>>
>>> +
>>> +static void smcr_clc_prep_confirm_accept(struct smc_connection *conn,
>>> +                struct smc_clc_msg_accept_confirm_v2 *clc_v2,
>>
>> And here.
>>
>>> +                int first_contact, u8 version,
>>> +                u8 *eid, struct smc_init_info *ini,
>>> +                int *fce_len,
>>> +                struct smc_clc_first_contact_ext_v2x *fce_v2x,
>>> +                struct smc_clc_fce_gid_ext *gle,
>>> +                struct smc_clc_msg_trail *trl)
>>> +{
>> <...>
>>
> 
> 
> You could shorten the names of the functions

Thank you. I thought about that too, but I think shortening the name may
have an impact on the understanding.



I think the following may be another way out and checkpatch is happy:

+static void
+smcd_clc_prep_confirm_accept(struct smc_connection *conn,
+                             struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+                             int first_contact, u8 version,
+                             u8 *eid, struct smc_init_info *ini,
+                             int *fce_len,
+                             struct smc_clc_first_contact_ext_v2x *fce_v2x,
+                             struct smc_clc_msg_trail *trl)

and

+static void
+smcr_clc_prep_confirm_accept(struct smc_connection *conn,
+                             struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+                             int first_contact, u8 version,
+                             u8 *eid, struct smc_init_info *ini,
+                             int *fce_len,
+                             struct smc_clc_first_contact_ext_v2x *fce_v2x,
+                             struct smc_clc_fce_gid_ext *gle,
+                             struct smc_clc_msg_trail *trl)
