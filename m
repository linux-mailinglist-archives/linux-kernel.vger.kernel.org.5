Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD915775733
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjHIKku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHIKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:40:49 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7010F3;
        Wed,  9 Aug 2023 03:40:48 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5234f2c6c1dso1141296a12.1;
        Wed, 09 Aug 2023 03:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577647; x=1692182447;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvuJQXSSe40cX5NGFg9VHgGjEbwnqu6g+etQ9ZRA9zE=;
        b=HFiLVz/iAPrHEIm40lp1jz1+bWBSE6w3pT6iiH/C3Z7SuL2bYA0cGQVPNeY0ZJ/Z6W
         LawW1ox7MK1bwF9a3BKJOIBbCQJPtd3YS+/kLEhh8lyuioIhsd5rfKryda0kf8XxA0ib
         0zlnnl+GKiBtvTFdx1eXEknnp7R9GwdDEDvv58PwB20vlt7jXIoXwzck2p+Y5wDZXYbu
         3gnZ+hN+zkk4UHBz2FAFF+V0/ghN7NUoyPioJTfLAMw7ALk0szotupdFrgBw0AFK+i0w
         m6FUedPL7rOPdb+g8CAtdNruRmDPBZbNhD9zHu4z8mnl43+cPJzDFGFqGbOkPoEzBgaf
         cyfw==
X-Gm-Message-State: AOJu0Yz02eHor9G5qfhvT/LE5eJXl94psdHijJMIBbL0bblsoJotmfK1
        zr8+GET/wC1sfhbJY1bRrUI=
X-Google-Smtp-Source: AGHT+IGDSDK5w8O5A3SdecdKs9LGC7ETkSOUvMv8G6a5/4GTAq45utbrK+TufQQoNAicLfDDzLJG+A==
X-Received: by 2002:aa7:c0da:0:b0:522:2b24:cf6 with SMTP id j26-20020aa7c0da000000b005222b240cf6mr1437954edp.42.1691577646894;
        Wed, 09 Aug 2023 03:40:46 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402134500b005233647bc4csm4580155edw.59.2023.08.09.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:40:46 -0700 (PDT)
Message-ID: <83f73eda-829d-2657-9f10-8ccf78522e5a@kernel.org>
Date:   Wed, 9 Aug 2023 12:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     mickflemm@gmail.com, mcgrof@kernel.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230807201057.340371-1-mahmoudmatook.mm@gmail.com>
 <92a26f67-1b24-ea35-2f39-7c0b75027617@kernel.org>
 <20230808194258.ocxnmqwzqlr6jpe4@mmaatuq-HP-Laptop-15-dy2xxx>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] ath5k: fix WARNING opportunity for swap.
In-Reply-To: <20230808194258.ocxnmqwzqlr6jpe4@mmaatuq-HP-Laptop-15-dy2xxx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 08. 23, 21:42, Mahmoud Matook wrote:
> On 08/08, Jiri Slaby wrote:
> 
>> On 07. 08. 23, 22:10, Mahmoud Maatuq wrote:
>>> coccinielle reported the following:
>>> ./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()
>>
>>
>> OK, once again:
>> https://lore.kernel.org/all/0c3acbd4-6ab2-5cc5-6293-54e30093cce2@kernel.org/
> 
> 
> I had a look at the commit history, to see why the original developer
> didn't use sort() function, and name the array variable sort but found
> nothing.
> I have some doubts that he might did that intentionally, so not to call
> sort() function for such small array

It happens once in 10 s and in a work. No worries about that.

> and avoid the cost of context switching.

What context switching?

>>> diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
>>> index 5797ef9c73d7..f87eb684f223 100644
>>> --- a/drivers/net/wireless/ath/ath5k/phy.c
>>> +++ b/drivers/net/wireless/ath/ath5k/phy.c
>>> @@ -1562,16 +1562,13 @@ static s16
>>>    ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
>>>    {
>>>    	s16 sort[ATH5K_NF_CAL_HIST_MAX];
>>> -	s16 tmp;
>>>    	int i, j;
>>>    	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
>>>    	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
>>>    		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
>>>    			if (sort[j] > sort[j - 1]) {
>>> -				tmp = sort[j];
>>> -				sort[j] = sort[j - 1];
>>> -				sort[j - 1] = tmp;
>>> +				swap(sort[j], sort[j - 1]);
>>>    			}
>>>    		}
>>>    	}
>>
>> -- 
>> js
>> suse labs

-- 
js
suse labs

