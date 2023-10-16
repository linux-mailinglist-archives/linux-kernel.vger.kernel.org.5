Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABC7CB539
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjJPVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:22:29 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370CEA7;
        Mon, 16 Oct 2023 14:22:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88B70FF806;
        Mon, 16 Oct 2023 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697491345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mmINDpTwCAmUV8dD8J0BfvK4SwBpCRLkJ0C+AEu8wI=;
        b=RL0vrCkIKGAZwxV6uYhZHAVRTQmO9ReaEW3Vl4Ru5LwwV8Edezze6IutuIfGIOOeBxi3bK
        /qwysA4DD0gJgGAO0REtTdFzqHmsu49/TyKTSmzehh4sViV30BanApvE144lIKq6IEFuGi
        WNi4Hiif+q9Jrj/mxwfPP90Adsvao1/wkJ76JfPbN9Gj0gDe2hLeymq5aRRWOw+VJIqQ6p
        x5w4IHIjDPjIEiXxv52NeU62tLIEaqJij+JPdTxGrzSvqoyENSf8ZpTbU56UWKydMZV4hu
        0S0sb72ZYD1bghF+NAAB6znGXCXkrpCvB9i8p7QmsB6WpwMKAHdczac095Znug==
Message-ID: <74eac5f2-228b-4775-a101-53b2fdd5bf86@bootlin.com>
Date:   Mon, 16 Oct 2023 23:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: use vmm_table as array in wilc struct
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org
References: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
 <bb95048f-2540-4d42-abb2-3132d33cd6c3@quicinc.com>
Content-Language: en-US
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <bb95048f-2540-4d42-abb2-3132d33cd6c3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

On 10/16/23 17:26, Jeff Johnson wrote:
> On 10/16/2023 1:29 AM, Alexis Lothoré wrote:
>> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c
>> b/drivers/net/wireless/microchip/wilc1000/wlan.c
>> index 58bbf50081e4..e4113f2dfadf 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
>> @@ -1492,7 +1492,7 @@ int wilc_wlan_init(struct net_device *dev)
>>       }
>>         if (!wilc->vmm_table)
>> -        wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
>> +        wilc->vmm_table = kzalloc(WILC_VMM_TBL_SIZE * sizeof(u32), GFP_KERNEL);
> 
> this is probably OK since the values are constant, but kcalloc() is generally
> preferred

Ok, I can submit a new version with kcalloc. One thing that I do not understand
however is why checkpatch.pl remains silent on this one. I guess it should raise
the ALLOC_WITH_MULTIPLY warning here. I tried to dive into the script to
understand why, but I drowned in regexes (and Perl, with which I am not familiar
with). Could it be because of both sides being constant ?

Thanks,
Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

