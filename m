Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF77A7998
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjITKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:46:11 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DECF8;
        Wed, 20 Sep 2023 03:45:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07524619|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0665893-0.00179403-0.931617;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.UjzWuGe_1695206747;
Received: from 192.168.220.129(mailfrom:michael@allwinnertech.com fp:SMTPD_---.UjzWuGe_1695206747)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 18:45:49 +0800
Message-ID: <56e26444-f289-d017-6225-24658e81ab84@allwinnertech.com>
Date:   Wed, 20 Sep 2023 18:45:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] usb:typec:tcpm:support double Rp to Vbus cable as sink
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230914003154.27977-1-michael@allwinnertech.com>
 <ZQgm/Lb4iZtWrWbs@kuha.fi.intel.com>
 <c52acbd0-e8e3-83e7-d87b-939b47aa39c1@roeck-us.net>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <c52acbd0-e8e3-83e7-d87b-939b47aa39c1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/18 22:22, Guenter Roeck wrote:
> On 9/18/23 03:31, Heikki Krogerus wrote:
>> On Thu, Sep 14, 2023 at 08:31:54AM +0800, Michael Wu wrote:
>>> The USB Type-C Cable and Connector Specification defines the wire
>>> connections for the USB Type-C to USB 2.0 Standard-A cable assembly
>>> (Release 2.2, Chapter 3.5.2).
>>> The Notes says that Pin A5 (CC) of the USB Type-C plug shall be 
>>> connected
>>> to Vbus through a resister Rp.
>>> However, there is a large amount of such double Rp connected to Vbus
>>> non-standard cables which produced by UGREEN circulating on the 
>>> market, and
>>> it can affects the normal operations of the state machine easily,
>>> especially to CC1 and CC2 be pulled up at the same time.
>>> In fact, we can regard those cables as sink to avoid abnormal state.
>>>
>>> Message as follow:
>>> [   58.900212] VBUS on
>>> [   59.265433] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, 
>>> connected]
>>> [   62.623308] CC1: 3 -> 0, CC2: 3 -> 0 [state TOGGLING, polarity 0, 
>>> disconnected]
>>> [   62.625006] VBUS off
>>> [   62.625012] VBUS VSAFE0V
>>>
>>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>>> ---
>>>   drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c 
>>> b/drivers/usb/typec/tcpm/tcpm.c
>>> index d962f67c95ae6..beb7143128667 100644
>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>> @@ -519,7 +519,8 @@ static const char * const pd_rev[] = {
>>>   #define tcpm_port_is_sink(port) \
>>>       ((tcpm_cc_is_sink((port)->cc1) && 
>>> !tcpm_cc_is_sink((port)->cc2)) || \
>>> -     (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)))
>>> +     (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)) 
>>> || \
>>> +     (tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2)))
>>>   #define tcpm_cc_is_source(cc) ((cc) == TYPEC_CC_RD)
>>>   #define tcpm_cc_is_audio(cc) ((cc) == TYPEC_CC_RA)
>>
>> This look OK to me, but I would still like to wait for comments from
>> Guenter - just in case.
>>
> 
> Look at the conditions. Reordered, we end up with
>      (tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) ||
>      (tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2))
> which simplifies to
>      tcpm_cc_is_sink((port)->cc1)
> making the complete expression
>      tcpm_cc_is_sink((port)->cc1) ||
>      (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1))
> which simplifies further to
>      tcpm_cc_is_sink((port)->cc1) || tcpm_cc_is_sink((port)->cc2)
> 
> The simplified expression doesn't conflict with other detections, so I am
> ok with it. It might be worthwhile adding a comment to the code, though,
> explaining the reason
> Guenter
> 
>> thanks,
>>
Dear Guenter,

I have modified it according to your opinion, and resend it as patch 
v2[1]. Please review.

[1] 
https://lore.kernel.org/all/20230920063030.66312-1-michael@allwinnertech.com/

-- 
Regards,
Michael Wu
