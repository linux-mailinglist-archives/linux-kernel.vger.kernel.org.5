Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682EC79198E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbjIDOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjIDOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:21:07 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3879CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:21:02 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E4924100006;
        Mon,  4 Sep 2023 17:21:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E4924100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1693837260;
        bh=K5PBNaEmVwQgh+6nGxCDIICD8oocRdp+hUWhXTnxwNc=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
        b=WFvefeOXqRQ1KVlw/NKqBA5QtXZ8OJWV0iXBX+N6MJgdiIhYS62bo8C4j8ALDzkiv
         +1gvdehgu5frKMYrEUr+/1i2B1iQvR3DHehb9B7/s1FWzspU4jTKfLrBpinsap8m3f
         jPKnGvTafSfb7Vmh2Fw/YYUtN/oyTCljJbA/fhCx9oFfKnvK/n8ntZj/VETE9GMA1r
         s5Q3gfoDhZK3DQV6n8EOPrrLHp9R26u7S+VfhAi75JZzCYEUZjcuaVyXAVZv73A4cG
         JcrLgEGmlT4zMzFd4vbgjpR5r+Jlqm35ndSx3cS6UlWB2bvbZYtMj0LK3qimaffSvD
         AXNeBo6YuhCJg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  4 Sep 2023 17:21:00 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 4 Sep 2023 17:20:59 +0300
Message-ID: <90a53eda-bbeb-dffa-0f90-6fd229f555e6@sberdevices.ru>
Date:   Mon, 4 Sep 2023 17:20:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
 <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
 <20230822153556.630e65b9@xps-13>
 <01925ff8-1d19-a729-429a-89866fad319f@sberdevices.ru>
 <20230823104143.760cc5bc@xps-13>
 <f873d775-cda9-302d-a651-0113c7c7dc84@sberdevices.ru>
 <20230823133956.0a505a20@xps-13>
 <ccf3099f-0e10-a87c-be83-4a414f01dca7@sberdevices.ru>
Content-Language: en-US
In-Reply-To: <ccf3099f-0e10-a87c-be83-4a414f01dca7@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179629 [Sep 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 529 529 a773548e495283fecef97c3e587259fde2135fef, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/04 08:01:00 #21789634
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 24.08.2023 12:35, Martin Kurbanov wrote:
> 
> 
> On 23.08.2023 14:39, Miquel Raynal wrote:
>> Hi Martin,
>>
>> mmkurbanov@sberdevices.ru wrote on Wed, 23 Aug 2023 14:33:57 +0300:
>>
>>> Hi Miquel,
>>>
>>> On 23.08.2023 11:41, Miquel Raynal wrote:
>>>> Hi Martin,
>>>>
>>>> I don't think the four bytes have any "bad block specific" meaning. In
>>>> practice, the datasheet states:
>>>>
>>>> 	Value programmed for bad block at the first byte of spare
>>>> 	area: 00h
>>>>
>>>> So only the first byte is used to mark the block bad, the rest is
>>>> probably marked "reserved" for simplicity. I believe we should keep the
>>>> current layout because it would otherwise break users for no real
>>>> reason.  
>>>
>>> I agree with you that this can break the work of users who use OOB.
>>> However, I believe it would be more appropriate to use an offset of 4,
>>> as the micron chip can use all 4 bytes for additional data about the
>>> bad block. So, there is a non-zero probability of losing OOB data in
>>> the reserved area (2 bytes) when the hardware chip attempts to mark
>>> the block as bad.
>>
>> Is this really a process the chip can do? Aren't bad blocks factory
>> marked only?
> 
> Actually, there is my understanding, I’m not sure exactly.

I tested with an offset of 2, no read/write errors were detected
(including read/write to OOB). But I don't have a flash chip with
factory bad blocks yet, when I find such a flash, I will report the
results.
Do I need to send the v3 of the patch with only first commit ("correct
bitmask for ecc status")?

-- 
Best Regards,
Martin Kurbanov
