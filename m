Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953B37CB53B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjJPVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJPVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:22:38 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4583AB;
        Mon, 16 Oct 2023 14:22:34 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id A569D100002;
        Tue, 17 Oct 2023 00:22:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A569D100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697491350;
        bh=tE5YoBnt+11PUnXEmb2Dc+agDamwbenbeeGvKIFi5A4=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=a4PBneFVUNr4GSufpFhR9VLKkcuA+Qd49KGJBxmmsLvzRBVyFjFJnnZr4N7z1AmgX
         glGrFBHF95BAk563w3x7sv+w7CowE0vxneqq0v3M2ISOKgmFjjD1w9a26lmbWx0djb
         P+MtN60OEmr4cvPDn47Aox3TjSi/GNEsSSAeLmqfCuYdKgJFRzPtqNujCkXS1czQpN
         rsKClAh+XTv/8a7iIJXY2L63qP7vVJR2viJt3nVJHi/v3HG4tB5WLLkfn3DWZBxsiV
         H6EqOOrpqEtIGfGpbTH3ZKAiaMumekIjparEqVrgqewxBWf2TjhI64vU4J6ERBIFpT
         CheH9ZAcD9hYA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 17 Oct 2023 00:22:30 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 00:22:30 +0300
Message-ID: <49b1d68c-2f16-2efd-ae24-2e2bd95a094b@salutedevices.com>
Date:   Tue, 17 Oct 2023 00:22:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 09/11] leds: aw200xx: improve autodim calculation
 method
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-10-ddrokosov@salutedevices.com>
 <CAHp75VcntHXe31H8C9GcGhc+HRA-gZjtD=uibMMYN-FS254RJw@mail.gmail.com>
 <20231009131808.lzri7z2nvcmkfuu3@CAB-WSD-L081021>
 <20231009140225.gj7vkmmio5xfvtnk@CAB-WSD-L081021>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <20231009140225.gj7vkmmio5xfvtnk@CAB-WSD-L081021>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180654 [Oct 16 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/16 20:05:00 #22203970
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 17:02, Dmitry Rokosov wrote:
> On Mon, Oct 09, 2023 at 04:18:08PM +0300, Dmitry Rokosov wrote:
>> On Fri, Oct 06, 2023 at 09:03:47PM +0300, Andy Shevchenko wrote:
>>> On Fri, Oct 6, 2023 at 7:05 PM Dmitry Rokosov
>>> <ddrokosov@salutedevices.com> wrote:
>>>>
>>>> From: George Stark <gnstark@salutedevices.com>
>>>>
>>>> use DIV_ROUND_UP instead of coarse div
>>>
>>> Please, respect English grammar and punctuation.
>>> Refer to macros and functions as func() (note the parentheses).
>>>
>>> ...
>>>
>>>>   #define AW200XX_REG_DIM2FADE(x) ((x) + 1)
>>>> +#define AW200XX_REG_FADE2DIM(fade) \
>>>> +       DIV_ROUND_UP((fade) * AW200XX_DIM_MAX, AW200XX_FADE_MAX)
>>>
>>> Have you checked if the overflow is _now_ possible (compiling on
>>> 32-bit platforms as well)?
>>
>> I suppose we shouldn't carry on about overflow here because the value of
>> fade cannot exceed 255, and DIM_MAX is set at 63
>>
>> You can find maximum values of fade and dim in the aw200xx driver
>> header:
>>
>> #define AW200XX_DIM_MAX                  (BIT(6) - 1)
>> #define AW200XX_FADE_MAX                 (BIT(8) - 1)
> 
> I agree that checking if the fade is not greater than FADE_MAX will not
> be excessive. The LED subsystem is capable of sending brightness levels
> higher than 255
> 

Probably we should set max_brightness to AW200XX_FADE_MAX in 
led_classdev when adding leds.

-- 
Best regards
George
