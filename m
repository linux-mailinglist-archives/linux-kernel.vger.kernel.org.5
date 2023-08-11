Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE2778509
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjHKBmT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHKBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:42:17 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03A5196;
        Thu, 10 Aug 2023 18:42:16 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0B0CB24E17F;
        Fri, 11 Aug 2023 09:42:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Aug
 2023 09:42:06 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 11 Aug
 2023 09:42:04 +0800
Message-ID: <2bf16511-b57b-0981-a19b-c04c8c34ce87@starfivetech.com>
Date:   Fri, 11 Aug 2023 09:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [-next v1 0/1] Fix StarFive JH7110 gmac TCP RX speed issue
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230810074646.19076-1-samin.guo@starfivetech.com>
 <20230810-cresting-talon-51a6c31da4f8@spud>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <20230810-cresting-talon-51a6c31da4f8@spud>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 23:37:13, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Thu, 10 Aug 2023 15:46:45 +0800, Samin Guo wrote:
>> This patch fixes the StarFive JH7110 gmac TCP RX slow issue. And it has been
>> tested on VisionFive 2.
>>
>> Here is the result of the test (iperf3):
>>
>>   Before:
>>       # iperf3 -s
>>       -----------------------------------------------------------
>>       Server listening on 5201 (test #1)
>>       -----------------------------------------------------------
>>       Accepted connection from 192.168.1.4, port 47604
>>       [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47612
>>       [ ID] Interval           Transfer     Bitrate
>>       [  5]   0.00-1.00   sec  36.3 MBytes   305 Mbits/sec
>>       [  5]   1.00-2.00   sec  35.6 MBytes   299 Mbits/sec
>>       [  5]   2.00-3.00   sec  36.5 MBytes   306 Mbits/sec
>>       [  5]   3.00-4.00   sec  36.5 MBytes   306 Mbits/sec
>>       [  5]   4.00-5.00   sec  35.7 MBytes   300 Mbits/sec
>>       [  5]   5.00-6.00   sec  35.4 MBytes   297 Mbits/sec
>>       [  5]   6.00-7.00   sec  37.1 MBytes   311 Mbits/sec
>>       [  5]   7.00-8.00   sec  35.6 MBytes   298 Mbits/sec
>>       [  5]   8.00-9.00   sec  36.4 MBytes   305 Mbits/sec
>>       [  5]   9.00-10.00  sec  36.3 MBytes   304 Mbits/sec
>>       - - - - - - - - - - - - - - - - - - - - - - - - -
>>       [ ID] Interval           Transfer     Bitrate
>>       [  5]   0.00-10.00  sec   361 MBytes   303 Mbits/sec        receiver
>>
>> [...]
> 
> Applied to riscv-dt-for-next with the conversion to decimal, thanks!
> 
> [1/1] riscv: dts: starfive: jh7110: Fix GMAC configuration
>       https://git.kernel.org/conor/c/1273f7e96a70
> 
> Thanks,
> Conor.

Hi Conor，

Thank a lot for for merging into the next branch so promptly！
 
Best regards,
Samin
