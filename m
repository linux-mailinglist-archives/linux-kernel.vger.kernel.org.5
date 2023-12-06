Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86737806900
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjLFH42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:56:27 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B848C137;
        Tue,  5 Dec 2023 23:56:31 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1E94B12005F;
        Wed,  6 Dec 2023 10:56:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1E94B12005F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701849388;
        bh=e7c8v/WrjHQFAGsJXPoq69/Fub9nJ6uQRy39mFR7K28=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=W9XFWD2MfZEmwFRFfldVybmWLuKxfgDzZ05VOtdLqGSSUXH1jAuPoxAgAOLgNjGPH
         nhEj8ZaFtinF/JNmECSXPbOs+U2KC6Q6b4Zd+K6uqKM2BZKz3WQILGXaVZ7ufZa+4X
         dEshMaAgQgH5Y1TLtp/iG2Foh6PG4N7gfaWrcWpm7zn3HRpVdPDIEwJW5c72WVjpOG
         d+p73GBrcSGnhL6kdEyx2b6HAoaBZeAUxWnfNdd6S6oJ8bcso9JmpQIkkQn/NzylOL
         zWlESR1oxUp97I48ne0tTDC6kmtyz1Yqnw9e9gUyG+oihFC7K3e0N00koKFakrjkUb
         U4OP4Kc7aImKA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  6 Dec 2023 10:56:27 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 10:56:27 +0300
Message-ID: <48ea90f9-922d-4a03-86da-cbb5aa9908b6@salutedevices.com>
Date:   Wed, 6 Dec 2023 10:56:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <jic23@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com>
 <CAHp75Vc=GAnzwhWQTifLzw8OA7Lb35hrJCDxK-RkgZnX8JmfOg@mail.gmail.com>
From:   George Stark <gnstark@salutedevices.com>
In-Reply-To: <CAHp75Vc=GAnzwhWQTifLzw8OA7Lb35hrJCDxK-RkgZnX8JmfOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181885 [Dec 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/06 04:36:00 #22617353
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

Thanks for the review.

On 12/4/23 21:11, Andy Shevchenko wrote:
> On Mon, Dec 4, 2023 at 8:07 PM George Stark <gnstark@salutedevices.com> wrote:
>>
>> Using of devm API leads to certain order of releasing resources.
>> So all dependent resources which are not devm-wrapped should be deleted
>> with respect to devm-release order. Mutex is one of such objects that
>> often is bound to other resources and has no own devm wrapping.
>> Since mutex_destroy() actually does nothing in non-debug builds
>> frequently calling mutex_destroy() is just ignored which is safe for now
>> but wrong formally and can lead to a problem if mutex_destroy() is
>> extended so introduce devm_mutex_init().
> 
> ...
> 
> Do you need to include mutex.h?
It's already included in linux/device.h which is included in 
devm-helpers. Should I include mutex.h explicitly?

> 
> ...
> 
>> +/**
>> + * devm_mutex_init - Resource-managed mutex initialization
>> + * @dev:       Device which lifetime work is bound to
>> + * @lock:      Pointer to a mutex
>> + *
>> + * Initialize mutex which is automatically destroyed when driver is detached.
> 
> the driver
> 
> Have you run scripts/kernel-doc -v -Wall -none ... against this file?
> I'm pretty sure it will complain.
It does with warning "No description found for return value". Fixed

> 
>> + */
> 
> 

-- 
Best regards
George
