Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C317A27DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjIOUPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbjIOUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:14:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E22D54
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:20 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hFCkqXJoa7mcChFCkqXu8c; Fri, 15 Sep 2023 22:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694808859;
        bh=PoS7/ryl/5McXZDkIPKpx2zauZQLIVxE9S5FLgRsCK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GRFNTkx7ZqEUl44R3xrKxuYLDEVqxSd99/ZnnoxEpEmIWFIx9RToclTFKeBC602iu
         t45ZYCPtawIcr8nDLaBTbYSHCu+mKreiK+DUpBCas53OjgBtbZFGDgG6AjiFxwbYFn
         TKhML+HS4Ox4qCtWZxzwyggDZUQ8vFrPx0IJS7UE0MALCgs4tPjAa70d2bSXAK9x3R
         BgZERq1P8liXzPP5s+TaA/qiYZwK2eww0U+wcpvgx31anQcq+RB27ULs2igXZ1D+Wt
         puMoy+ES42lN+Ne+2VbCp9oJBtBhoQKFXVTFvzhaAd/eu360hLvFbtggw0zolCEFAZ
         Q9PWH2Kj6OK2Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Sep 2023 22:14:19 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d083215e-e9bf-860d-6d04-d919a9b90752@wanadoo.fr>
Date:   Fri, 15 Sep 2023 22:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] HID: nvidia-shield: Fix the error handling path of
 shield_probe()
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
 <87msxns3nv.fsf@nvidia.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <87msxns3nv.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/09/2023 à 20:16, Rahul Rameshbabu a écrit :
> Hi Christophe,
> 
> On Sat, 26 Aug, 2023 19:42:16 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>> This serie fixes some missing clean-up function calls in the error handling of
>> the probe.
>>
>> Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
>> patches)
>>
>> Patch 3 is a proposal to be more future proof.
>>
>>
>> *Note*: I'm not 100% sure that the order of the functions is the best one in
>> thunderstrike_destroy(), but it is the way it was.
>>
>> My personal preference would be to undo things in reverse order they are
>> allocated, such as:
>> 	led_classdev_unregister(&ts->led_dev);
>> 	power_supply_unregister(ts->base.battery_dev.psy);
>> 	if (ts->haptics_dev)
>> 		input_unregister_device(ts->haptics_dev);
>> 	ida_free(&thunderstrike_ida, ts->id);
>> This order was explicitly chnaged by 3ab196f88237, so, as I can't test the
>> changes on a real harware, I've left it as-is.
>>
>> Christophe JAILLET (3):
>>    HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
>>      probe error handling path
>>    HID: nvidia-shield: Fix some missing function calls() in the probe
>>      error handling path
>>    HID: nvidia-shield: Introduce thunderstrike_destroy()
>>
>>   drivers/hid/hid-nvidia-shield.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> I was wondering if you have time to address the comments in this
> submission. If not, I can re-spin the patches with the needed changes in
> upcoming days.

I can send an update tomorrow, but I'm only working with -next, so 
should using for-6.6/nvidia (as said in your comment in #1/3) be a must 
have, then it would be more convenient for me if you make the changes by 
yourself.

CJ

> 
> --
> Thanks,
> 
> Rahul Rameshbabu
> 

