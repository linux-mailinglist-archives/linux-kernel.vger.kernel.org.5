Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EB7AE07C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjIYUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjIYUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:55:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80010F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:54:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ksbTqNdzdvU2mksbTqP3zl; Mon, 25 Sep 2023 22:54:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695675291;
        bh=7qzOKZEryNuTAMV520/DOS4D/U+CE50T2S4n3ISZSPo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=S9UC5lCekptgVAY6BUwXIbKLDF7xRd4t1vPiN8652emUmFC9CEym9eMfg7KM8VWst
         20V41WgNpcHSCzp5WPp1Uc8fa0ziB+cnRcW0OnEpG5Hanavu1DaHor70axUQzHUR7h
         zCKj8EYeWktjzreF8o5yNVpPGOtMvEZpsJFZcea2pxZ3TE+S+DnTK/dNe9dgA5J2lZ
         c4r6vFbbHKdCiNbwp4vUjED+SIBi2NkU004OS7SVTqJ4hiAsjywiVcZ7/eWKEspCjl
         4Qme0V0WvWTj/szLUXO1I44oQHB4Azg6ZFZOmWMTiPuFaxQ89kxhdDRRgux+ISUgmi
         YRDvdZWPb49PQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 Sep 2023 22:54:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <b3be8653-ea3f-bc3a-c38e-e3ec290695ea@wanadoo.fr>
Date:   Mon, 25 Sep 2023 22:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wireless 1/2] ath: dfs_pattern_detector: Fix a memory
 initialization issue
Content-Language: fr, en-CA
To:     quic_jjohnson@quicinc.com
Cc:     christophe.jaillet@wanadoo.fr, kernel-janitors@vger.kernel.org,
        kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, quic_kvalo@quicinc.com
References: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
 <c82d9d47-9c4b-4af9-a1e8-7c975b53fe30@quicinc.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c82d9d47-9c4b-4af9-a1e8-7c975b53fe30@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/09/2023 à 20:46, Jeff Johnson a écrit :
> On 9/23/2023 11:57 PM, Christophe JAILLET wrote:
>> If an error occurs and channel_detector_exit() is called, it relies on
>> entries of the 'detectors' array to be NULL.
>> Otherwise, it may access to un-initialized memory.
>>
>> Fix it and initialize the memory, as what was done before the commit in
>> Fixes.
>>
>> Fixes: a063b650ce5d ("ath: dfs_pattern_detector: Avoid open coded 
>> arithmetic in memory allocation")
>> Signed-off-by: Christophe JAILLET 
>> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
>> ---
>> Patch #1/2 is a fix, for for wireless.
>> Patch #2/2 is for wireless-next I guess, but depnds on #1
>>
>> Not sure if we can mix different target in the same serie. Let me know.
>>
>> BTW, sorry for messing up things with a063b650ce5d :(
>> ---
>>   drivers/net/wireless/ath/dfs_pattern_detector.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c 
>> b/drivers/net/wireless/ath/dfs_pattern_detector.c
>> index 27f4d74a41c8..2788a1b06c17 100644
>> --- a/drivers/net/wireless/ath/dfs_pattern_detector.c
>> +++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
>> @@ -206,7 +206,7 @@ channel_detector_create(struct 
>> dfs_pattern_detector *dpd, u16 freq)
>>       INIT_LIST_HEAD(&cd->head);
>>       cd->freq = freq;
>> -    cd->detectors = kmalloc_array(dpd->num_radar_types,
>> +    cd->detectors = kcalloc(dpd->num_radar_types,
>>                         sizeof(*cd->detectors), GFP_ATOMIC);
> 
> nit: align descendant on (

Agreed, but as the code is removed in patch 2/2, I thought that having a 
smaller diff was a better option.

Let me know if I should resend the serie.

CJ

> 
>>       if (cd->detectors == NULL)
>>           goto fail;
> 
> 

