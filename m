Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8D800C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379033AbjLANnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379031AbjLANnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:43:21 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B8197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:43:25 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0C87410001F;
        Fri,  1 Dec 2023 16:43:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0C87410001F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701438202;
        bh=I///YC5UuvpU1J5S+D34Jkjcl6/vfhDloxYLvGmsz54=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=EUC+inW1T0gNlBbNphOO9e9PeUalgv+TBhaGjDcq8HFsWLi2x4NulAmprjnIS6TSt
         RUGmXSoPSqc533imRy/1BM4s3woClMB8GMqIs7VD/aouJVDf3p1cDpeyj6OabKj+IS
         T26ODVSPyEtHc8xXOYchYXVWTPwiQnb59h/HtT3iaVInZAmHSE22EV2wZTzVMmuqX4
         3QnZvSJjeKdPkahz1t+FibfyuQGML7s/0O0N9EnJFNluunDI/hvL5ULyurkjj7dv28
         D6DYuapbGJX0uU1gakDyRLTluQuO2y0FHaH3zSLT8+oApCJS+6NAb/SastAyDHfTMH
         a8KYJAlrj3UVg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  1 Dec 2023 16:43:21 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 16:43:21 +0300
Message-ID: <070c174c-057a-46de-ae8e-836e9e20eceb@salutedevices.com>
Date:   Fri, 1 Dec 2023 16:43:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] locking: introduce devm_mutex_init and
 devm_mutex_destroy
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Waiman Long <longman@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <boqun.feng@gmail.com>, <jic23@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <20231128000910.73784-1-gnstark@salutedevices.com>
 <cbd2705d-9d43-4822-9b5c-ea437a2ccca7@redhat.com>
 <ZWYW4nDZNAO7NADj@smile.fi.intel.com>
Content-Language: en-US
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <ZWYW4nDZNAO7NADj@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181768 [Dec 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/01 12:11:00 #22598706
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, Waiman

Thanks for the review.

I'll move the patch to the devm-helpers.h then.


On 11/28/23 19:35, Andy Shevchenko wrote:
> On Mon, Nov 27, 2023 at 08:55:18PM -0500, Waiman Long wrote:
>> On 11/27/23 19:09, George Stark wrote:
> 
> ...
> 
>> These APIs are specific to devres. I don't believe it is suitable to put
>> them into the generic mutex.h header file. All devres_* functions are
>> defined in include/linux/device.h which is probabably not included in
>> mutex.h. You may consider putting these APIs into device.h instead.
> 
> +1. We have include/linux/devm-helpers.h.
> 

-- 
Best regards
George
