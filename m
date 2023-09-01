Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86C78FC05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349081AbjIALB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjIALBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:01:25 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF2E42;
        Fri,  1 Sep 2023 04:01:22 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:6422:827f:d303:d108] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 381Axifq011181-381Axifr011181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 1 Sep 2023 18:59:44 +0800
Message-ID: <317b9482-d750-9093-e891-21f73feeac0c@hust.edu.cn>
Date:   Fri, 1 Sep 2023 18:59:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] ath9k: fix null-ptr-deref in ath_chanctx_event
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230901080701.1705649-1-dzm91@hust.edu.cn>
 <87y1hqtbtu.fsf@toke.dk>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87y1hqtbtu.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/1 18:41, 'Toke Høiland-Jørgensen' via HUST OS Kernel 
Contribution wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Smatch reports:
>>
>> ath_chanctx_event() error: we previously assumed 'vif' could be null
>>
>> The function ath_chanctx_event can be called with vif argument as NULL.
>> If vif is NULL, ath_dbg can trigger a null pointer dereference.
>>
>> Fix this by adding a null pointer check.
>>
>> Fixes: 878066e745b5 ("ath9k: Add more debug statements for channel context")
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   drivers/net/wireless/ath/ath9k/channel.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
>> index 571062f2e82a..e343c8962d14 100644
>> --- a/drivers/net/wireless/ath/ath9k/channel.c
>> +++ b/drivers/net/wireless/ath/ath9k/channel.c
>> @@ -576,7 +576,9 @@ void ath_chanctx_event(struct ath_softc *sc, struct ieee80211_vif *vif,
>>   		if (sc->sched.state != ATH_CHANCTX_STATE_WAIT_FOR_BEACON)
>>   			break;
>>   
>> -		ath_dbg(common, CHAN_CTX, "Preparing beacon for vif: %pM\n", vif->addr);
>> +		if (vif)
>> +			ath_dbg(common, CHAN_CTX,
>> +				"Preparing beacon for vif: %pM\n", vif->addr);
> Please don't send patches for static checker errors without actually
> checking if there is a valid bug. Which there isn't in this case.

Before sending this patch, I searched in the code, there are many call 
sites of ath_chanctx_event with argument vif as NULL.

Functions calling this function: ath_chanctx_event

   File      Function                   Line
0 beacon.c  ath9k_beacon_tasklet        459 ath_chanctx_event(sc, vif, 
ATH_CHANCTX_EVENT_BEACON_PREPARE);
1 channel.c ath_chanctx_check_active    321 ath_chanctx_event(sc, NULL,
2 channel.c ath_chanctx_beacon_sent_ev  781 ath_chanctx_event(sc, NULL, ev);
3 channel.c ath_chanctx_beacon_recv_ev  787 ath_chanctx_event(sc, NULL, ev);
4 channel.c ath_chanctx_timer          1054 ath_chanctx_event(sc, NULL, 
ATH_CHANCTX_EVENT_TSF_TIMER);
5 channel.c ath_chanctx_set_next       1321 ath_chanctx_event(sc, NULL, 
ATH_CHANCTX_EVENT_SWITCH);
6 channel.c ath9k_p2p_ps_timer         1566 ath_chanctx_event(sc, NULL, 
ATH_CHANCTX_EVENT_TSF_TIMER);
7 main.c    ath9k_sta_state            1671 ath_chanctx_event(sc, vif,
8 main.c    ath9k_remove_chanctx       2577 ath_chanctx_event(sc, NULL, 
ATH_CHANCTX_EVENT_UNASSIGN);
9 xmit.c    ath_tx_edma_tasklet        2749 ath_chanctx_event(sc, NULL,

This NULL parameters would cause some abnormal behaviors.

> Specifically, that branch of the switch statement dereferences the avp
> pointer, which will be NULL if 'vif' is. Meaning we will have crashed
> way before reaching this statement if vif is indeed NULL.
Yeah, you are right. However, no matter where or which variable causing 
the null-ptr-def crash, the crash is there.

I think this is unexpected.

Let me know if I make any mistakes

>
> -Toke
>
