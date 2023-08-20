Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7F781CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjHTGb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHTGbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:31:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF821221
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:24:33 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id XbrRqhueC7qfuXbrRqufiJ; Sun, 20 Aug 2023 08:24:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692512671;
        bh=BVJEPI0bU+i+PXyy1ybvXbIzpm7dFFrxg1n6imDgDOw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZOBP6PzLjvyAAJR3FMzWYkuFPvU4TtfdFXb+zgyiinEELoN4q4r/Kl3gP3JY20+XF
         MiIpgt+oC22o6qjncOTmuKtbCJzy4Un8oAkbKI07toKw7cykOkbCuPmHTxCg7ox6l1
         HFrSaa5eSKGXIFxqtrAv15qWaxpT4D1amB2TP4D7K2nX01vn6xIMjGgNanoA7bUW5z
         G+eHXgSrEOEy0mbVhjPUTeuPGi08+FZ/mtPuHXSDnsAKnCsSACcVvnPQLBET0qV3TN
         tsNm9LYf+Cu/EeH9k63UeqhTfFo38//7k23a0UEfEUCEUwv4Xpwaa27bYSS28KCtAV
         6Jeu7xwrGZXEA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 08:24:31 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1298f205-813f-9b6d-b7e4-4debe69d16ec@wanadoo.fr>
Date:   Sun, 20 Aug 2023 08:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] power: supply: rt9467: Fix rt9467_run_aicl()
Content-Language: fr
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
References: <2ed01020fa8a135c36dbaa871095ded47d926507.1676464968.git.christophe.jaillet@wanadoo.fr>
 <20230217055122.GA5502@linuxcarl2.richtek.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230217055122.GA5502@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/02/2023 à 06:51, ChiYuan Huang a écrit :
> Hi, Christophe:
> On Wed, Feb 15, 2023 at 01:43:04PM +0100, Christophe JAILLET wrote:
>> It is spurious to bail-out on a wait_for_completion_timeout() call that
>> does NOT timeout.
>>
>> Reverse the logic to return -ETIMEDOUT instead, in case of tiemout.
>>
> Thanks. It's really our coding issue.
> 
> Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

Hi,

polite reminder.

This patch is still not in -next.

CJ

>> Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>>
>> This is spurious, because if I'm right, it means that it does not work!
>> Testing on a real hardware is really welcomed.
>> ---
>>   drivers/power/supply/rt9467-charger.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
>> index 96ad0d7d3af4..bb737fd1cca6 100644
>> --- a/drivers/power/supply/rt9467-charger.c
>> +++ b/drivers/power/supply/rt9467-charger.c
>> @@ -598,8 +598,8 @@ static int rt9467_run_aicl(struct rt9467_chg_data *data)
>>   
>>   	reinit_completion(&data->aicl_done);
>>   	ret = wait_for_completion_timeout(&data->aicl_done, msecs_to_jiffies(3500));
>> -	if (ret)
>> -		return ret;
>> +	if (ret == 0)
>> +		return -ETIMEDOUT;
>>   
>>   	ret = rt9467_get_value_from_ranges(data, F_IAICR, RT9467_RANGE_IAICR, &aicr_get);
>>   	if (ret) {
>> -- 
>> 2.34.1
>>
> 

