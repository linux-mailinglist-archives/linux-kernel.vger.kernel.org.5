Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EBF77B291
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjHNHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjHNHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:33:12 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9010E4;
        Mon, 14 Aug 2023 00:33:06 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7EB4F24E1ED;
        Mon, 14 Aug 2023 15:32:58 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 15:32:58 +0800
Received: from [192.168.125.128] (183.27.98.20) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 15:32:57 +0800
Message-ID: <e912d7a8-0a3b-913d-3583-b383b874077c@starfivetech.com>
Date:   Mon, 14 Aug 2023 15:28:14 +0800
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
 <cace0094-948b-a4e9-ab63-6fdfb9952b44@starfivetech.com>
 <20230814-relieving-brisket-9a8c38e817a4@wendy>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230814-relieving-brisket-9a8c38e817a4@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
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

On 2023/8/14 14:57, Conor Dooley wrote:
> On Mon, Aug 14, 2023 at 11:06:05AM +0800, Xingyu Wu wrote:
>> On 2023/8/11 14:43, Conor Dooley wrote:
>> > On Fri, Aug 11, 2023 at 11:36:31AM +0800, Xingyu Wu wrote:
>> >> Set PLL0 rate to 1.5GHz.
>> > 
>> > Why are you doing that though?
>> 
>> Because the CPU frequency scaling is based on 1.5GHz rate on JH7110 SoC.
>> And now the PLL clock driver has been accepted and PLL0 is just 1GHz[1].
>> [1] https://github.com/starfive-tech/VisionFive2/issues/55
>> 
>> We should set the PLL0 rate to a correct rate (1.5GHz) and then
>> the CPUfreq will work normally.
> 
> Please include an explanation in the commit message of the problem this
> is addressing.
> 
> Also, a Fixes: tag + reported-by?
> 

OK, I will add the explanation in next version as a fixes patch.

Thanks,
Xingyu Wu

>> > 
>> > 
>> >> Change the parent of cpu_root clock
>> >> and the divider of cpu_core before setting.
>> >> 
>> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> ---
>> >> 
>> >> Hi Stephen and Emil,
>> >> 
>> >> This patch sets PLL0 rate to 1.5GHz. In order not to affect the cpu 
>> >> operation, the cpu_root's parent clock should be changed first.
>> >> And the divider of the cpu_core clock should be set to 2 so they
>> >> won't crash when setting 1.5GHz without voltage regulation.
>> >> 
>> >> This patch is based on linux-next which has merge PLL driver on
>> >> StarFive JH7110 SoC.
>> >> 
>> >> Thanks,
>> >> Xingyu Wu
>> 

