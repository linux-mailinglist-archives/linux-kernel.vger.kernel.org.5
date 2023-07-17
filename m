Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036E755FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGQJqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGQJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:46:04 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB4BE;
        Mon, 17 Jul 2023 02:46:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 977BE100003;
        Mon, 17 Jul 2023 12:45:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 977BE100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689587159;
        bh=bU4ekr04U5x03pjQxh0crwXxvJQ0XcicbfzN4q2fJjQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=k8j3Ui0s8yZsItpF/sogZjPznCQFEmlvgu/6qwMPk4MCDALrJ2tahdhvqIYxmhbFX
         X7tn//u3xIjRTENi1TuFuGNGbUnBYVolqkjfiM5r9aY8l36NXbmYNnYduT69HxkZz1
         sDicmnHap/P2t6+Dd2hss76uv8/USEqyRB4TNeIfXorhi4tC3+34BmywBLDkZ+uazH
         H+jUhdwYMKhhcDCC597UkJ+md7txDPrWpZZSEKRu7sZBnpXb+oGP2ksZuSb3hWjqe5
         YKoIWj4dL0PJaIBT8NroSSZD21W8X/tkSH/vEcYEqd/RRRN8cgfVaPC4MHAf2ribOQ
         1L8dP5iM26UVQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 17 Jul 2023 12:45:59 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 12:45:59 +0300
Message-ID: <a172c764-1eef-835f-f237-8f78b4c6e877@sberdevices.ru>
Date:   Mon, 17 Jul 2023 12:41:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/3] iio: adc: meson: tune init sequence
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230715110654.6035-1-gnstark@sberdevices.ru>
 <20230716171134.43d05c45@jic23-huawei>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <20230716171134.43d05c45@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178645 [Jul 17 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/17 06:43:00 #21626526
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jonathan

Thanks for your review

On 7/16/23 19:11, Jonathan Cameron wrote:
> On Sat, 15 Jul 2023 14:05:57 +0300
> George Stark <gnstark@sberdevices.ru> wrote:
> 
>> This patch is a part of effort to support meson a1 SoC and make meson saradc driver
>> independent from vendor boot code initialization in common.
>>
>> Information was taken from vendor kernel 5.4, 4.19 and vendor uboot 2019.
>> Most of the bits are undocumented at all or it's not said how they affect measuring.
>>
>> All those bits are already initialized in bl* code and since kernel driver dosn't
>> rewrite or reset any registers but only changes some bits at init stage everything
>> works fine.
>>
>> Test procedure is rather simple - one can change those bits in runtime
>> (e.g. using devmem) and try to read channels (cat /sys/bus/platform/drivers/meson-saradc/.../iio:device0/*)
>> changing some of those bits leads to measure procedure errors or abnormal results.
>> Another test is build meson saradc as module, reset adc by reset bit, reload module
>> and compare measure results to those got before reset.
>>
>> George Stark (3):
>>    iio: adc: meson: init channels 0,1 input muxes
>>    iio: adc: meson: init internal continuous ring counter
>>    iio: adc: meson: init voltage control bits
>>
>>   drivers/iio/adc/meson_saradc.c | 73 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
> These look fine to me, but I'd like them to sit on list a little while
> on off chance anyone else has feedback on them.

I understand. I'd resend the patches in a week or more if there's no 
feedback.

If someone suggests tests so the community could trust the results I'll 
be happy to run them. I have odroid-c1, vim1, vim3 and a113l board.

> 
> Thanks,
> 
> Jonathan
> 
> 

-- 
Best regards
George
