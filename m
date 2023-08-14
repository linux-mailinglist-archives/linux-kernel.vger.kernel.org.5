Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8120077AFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHNDLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjHNDKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:10:53 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B655A9B;
        Sun, 13 Aug 2023 20:10:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6E15824E27D;
        Mon, 14 Aug 2023 11:10:49 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 11:10:49 +0800
Received: from [192.168.125.128] (183.27.98.20) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 11:10:48 +0800
Message-ID: <cace0094-948b-a4e9-ab63-6fdfb9952b44@starfivetech.com>
Date:   Mon, 14 Aug 2023 11:06:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] clk: starfive: jh7110-sys: Set PLL0 rate to 1.5GHz
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230811033631.160912-1-xingyu.wu@starfivetech.com>
 <20230811-jiffy-nebula-a8ea5ef15eee@wendy>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230811-jiffy-nebula-a8ea5ef15eee@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/11 14:43, Conor Dooley wrote:
> On Fri, Aug 11, 2023 at 11:36:31AM +0800, Xingyu Wu wrote:
>> Set PLL0 rate to 1.5GHz.
> 
> Why are you doing that though?

Because the CPU frequency scaling is based on 1.5GHz rate on JH7110 SoC.
And now the PLL clock driver has been accepted and PLL0 is just 1GHz[1].
[1] https://github.com/starfive-tech/VisionFive2/issues/55

We should set the PLL0 rate to a correct rate (1.5GHz) and then
the CPUfreq will work normally.

Best regards,
Xingyu Wu

> 
> 
>> Change the parent of cpu_root clock
>> and the divider of cpu_core before setting.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>> 
>> Hi Stephen and Emil,
>> 
>> This patch sets PLL0 rate to 1.5GHz. In order not to affect the cpu 
>> operation, the cpu_root's parent clock should be changed first.
>> And the divider of the cpu_core clock should be set to 2 so they
>> won't crash when setting 1.5GHz without voltage regulation.
>> 
>> This patch is based on linux-next which has merge PLL driver on
>> StarFive JH7110 SoC.
>> 
>> Thanks,
>> Xingyu Wu

