Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81079750E60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjGLQYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjGLQXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:23:53 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF92D4C;
        Wed, 12 Jul 2023 09:23:16 -0700 (PDT)
Received: from [192.168.1.103] (178.176.76.110) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 12 Jul
 2023 19:22:55 +0300
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
To:     Guenter Roeck <linux@roeck-us.net>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        'John Paul Adrian Glaubitz' <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
 <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
 <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
 <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
 <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
 <c9483d7f-7f5f-dd29-2bba-5659a1dae7e0@gmail.com>
 <b02489c7-96de-b6ed-07b9-9ba423af34c6@roeck-us.net>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <acad1156-4e60-9315-1bbb-9b569d05b410@omp.ru>
Date:   Wed, 12 Jul 2023 19:22:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b02489c7-96de-b6ed-07b9-9ba423af34c6@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [178.176.76.110]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/12/2023 16:00:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 178587 [Jul 12 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 521 521 0c3391dd6036774f2e1052158c81e48587b96e95
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;git.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.76.110:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.76.110
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/12/2023 16:05:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/12/2023 2:02:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 6:38 PM, Guenter Roeck wrote:
[...]

>>>> Sent: 09 July 2023 00:13
>>> ....
>>>> Looking at arch/sh/boards/mach-r2d/irq.c, there is some IRQ translation going
>>>> on and maybe that's the part where we need to correct the offset by 16?
>>>
>>> Would it be less problematic to use (say) 16 for IRQ_0
>>> leaving IRQ_1+ as 1+ ?
>>
>>     I don't think so.
>>
>>> At least that would only cause issues for code that needed
>>> to use IRQ_0.
>>>
>>> (It has to be said that making IRQ 0 invalid seemed wrong
>>> to me. x86 (IBM PC) gets away with it because IRQ 0 is
>>> always assigned to platform specific hardware.)
>>
>>     Not only x86, IIRC.
>>     Have you seen the commit below?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce753ad1549cbe9ccaea4c06a1f5fa47432c8289
>>
> 
> Quoting:
> 
> using IRQ0 is considered invalid (according to Linus) outside the arch/ code
>                                                       ^^^^^^^^^^^^^^^^^^^^^^> The changes here were made _in_ the arch code. While there may be valid
> arguments for doing that, quoting the above commit as reason isn't really
> sufficient.

   It seems you still don't understand... The i8253 drivers using IRQ0 live in
the arch/{mips|x86}/kernel/ code, so they're allowed to claim IRQ0 via calling
request_irq() (MIPS still does it.  They are NOT the platform drivers we're
dealing with here...

> Guenter

MBR, Sergey
