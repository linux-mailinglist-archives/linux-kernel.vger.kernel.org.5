Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E807B6955
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjJCMrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:47:19 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637891;
        Tue,  3 Oct 2023 05:47:14 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CFEBA100007;
        Tue,  3 Oct 2023 15:47:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CFEBA100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1696337230;
        bh=/WnGfwCh7HXbbHZcZiPkpNdYkHbP4G9AgWQIHB0A3+s=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=UmO/eb65HGSvpvMFWZkoWnvqwcCh3Hvm4r47Lb6Nh47/fA7JSjHhbhA8t1AoGR7fM
         prWhv66oQDpC7UN2sxmlB2bWVlWVf3t3J1QUUjZNhR+vtsm9VT+eqSJchsOsqVdUAF
         bWXsjuxKNEMnxHpeW9y/QntlC+sFiGFJzOU9BCK+oJGsKaVmU5GSGPmc6XwzVofv7U
         qYNv6FGPOjBfEIpPJV8PPJRsvR5/F9lD7yNU270H48HlR/7Kjt86RVVLeGmTS5+hWo
         L6aqbgHQ0+LkordfcGAtqLX9/PYj7p0unplRElE7UJw6WUmIY61aU0tbXYslsd0pfH
         838Yf0epIxZ7A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  3 Oct 2023 15:47:09 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 3 Oct 2023 15:47:08 +0300
Message-ID: <8ef7ff71-08e1-b0af-483d-e7cf3cc5efea@sberdevices.ru>
Date:   Tue, 3 Oct 2023 15:47:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] iio: adc: meson: improve error logging at probe
 stage
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230721102413.255726-1-gnstark@sberdevices.ru>
 <20230721102413.255726-3-gnstark@sberdevices.ru>
 <ZLphZzO20QW+t1m/@smile.fi.intel.com> <20230722181559.02c8362c@jic23-huawei>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <20230722181559.02c8362c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180317 [Oct 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_smtp_not_equal_from}, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/03 10:12:00 #22029534
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan

It seems like you haven't had time for this patch yet. Should I fix it 
myself or just be more patient?

On 7/22/23 20:15, Jonathan Cameron wrote:
> On Fri, 21 Jul 2023 13:43:51 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Fri, Jul 21, 2023 at 01:23:09PM +0300, George Stark wrote:
>>> Add log messages for errors that may occur at probe stage
>>
>> the probe
> 
> British English - excellent ! :) (I argue this one far too often in
> specification committees :)
> 
> 
>>
>> stage.
>>
> 
> I can tidy this up, but the patch will be a while anyway given the fix
> needs to work it's way into the upstream for my togreg branch (and I need
> to have send a pull request for togreg as well).
> 
> Jonathan
> 

-- 
Best regards
George
