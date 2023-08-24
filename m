Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33C0786C18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbjHXJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjHXJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:35:52 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9E10DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:35:49 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 4CE60120003;
        Thu, 24 Aug 2023 12:35:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4CE60120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692869747;
        bh=NHDNbRQIlPTKyaRRc+wW6R4gs+0+yGK7A4phKQJ1MWA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=VZDiEolif31ql1D4sRsRyUHIACUkUpeoABHCWHVEbcPhk+0oMrydGfJlNthwcTaa0
         OrVMhNKDpbN27dEWxHdDqPgvXuP2SSdQqTfMxavLm0Co/IJ2SflVQMl2oYlpO3SwGS
         UqcNpTPu0xaNIp9y5l+qK3VwUw3CUUUewAt8fHA4Y0jpzSqUV/W73c+D5361Q/oxWU
         enAEsK2tafLwGMcZaRysKoEo3X0MdxUy+O5THNrny8A9i2ldrgraE64fuHVfWi3OGH
         juwx9EUfSb0bPkLua5WuVQiJhnvhekKHyACprfy1Z5ksvZl8ntJn2d8oJTc0VRA4oK
         v9RUU3BDw7uSg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 24 Aug 2023 12:35:47 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 12:35:39 +0300
Message-ID: <ccf3099f-0e10-a87c-be83-4a414f01dca7@sberdevices.ru>
Date:   Thu, 24 Aug 2023 12:35:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
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
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <20230823133956.0a505a20@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179420 [Aug 24 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 527 527 5bb611be2ca2baa31d984ccbf4ef4415504fc308, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/24 05:32:00 #21694618
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.08.2023 14:39, Miquel Raynal wrote:
> Hi Martin,
> 
> mmkurbanov@sberdevices.ru wrote on Wed, 23 Aug 2023 14:33:57 +0300:
> 
>> Hi Miquel,
>>
>> On 23.08.2023 11:41, Miquel Raynal wrote:
>>> Hi Martin,
>>>
>>> I don't think the four bytes have any "bad block specific" meaning. In
>>> practice, the datasheet states:
>>>
>>> 	Value programmed for bad block at the first byte of spare
>>> 	area: 00h
>>>
>>> So only the first byte is used to mark the block bad, the rest is
>>> probably marked "reserved" for simplicity. I believe we should keep the
>>> current layout because it would otherwise break users for no real
>>> reason.  
>>
>> I agree with you that this can break the work of users who use OOB.
>> However, I believe it would be more appropriate to use an offset of 4,
>> as the micron chip can use all 4 bytes for additional data about the
>> bad block. So, there is a non-zero probability of losing OOB data in
>> the reserved area (2 bytes) when the hardware chip attempts to mark
>> the block as bad.
> 
> Is this really a process the chip can do? Aren't bad blocks factory
> marked only?

Actually, there is my understanding, I’m not sure exactly.

-- 
Best Regards,
Martin Kurbanov
