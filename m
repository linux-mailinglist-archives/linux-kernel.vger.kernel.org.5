Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2675736B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGRFvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRFvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:51:40 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89341E55;
        Mon, 17 Jul 2023 22:51:37 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id F3C1324E280;
        Tue, 18 Jul 2023 13:51:26 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 13:51:27 +0800
Received: from [192.168.125.128] (113.72.147.86) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 13:51:25 +0800
Message-ID: <4e4dea7f-639b-71aa-5a47-95ce14d7f1ed@starfivetech.com>
Date:   Tue, 18 Jul 2023 13:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 0/7] Add PLL clocks driver and syscon for StarFive
 JH7110 SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230717023040.78860-1-xingyu.wu@starfivetech.com>
 <20230717-easel-pessimist-5b7c4e5bed0a@spud>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230717-easel-pessimist-5b7c4e5bed0a@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/18 2:14, Conor Dooley wrote:
> Hey Xingyu,
> 
> On Mon, Jul 17, 2023 at 10:30:33AM +0800, Xingyu Wu wrote:
>> This patch serises are to add PLL clocks driver and providers by writing
>> and reading syscon registers for the StarFive JH7110 RISC-V SoC. And add 
>> documentation and nodes to describe StarFive System Controller(syscon)
>> Registers. This patch serises are based on Linux 6.4.
>> 
>> PLLs are high speed, low jitter frequency synthesizers in JH7110.
>> Each PLL clock works in integer mode or fraction mode by some dividers,
>> and the dividers are set in several syscon registers.
>> The formula for calculating frequency is: 
>> Fvco = Fref * (NI + NF) / M / Q1
>> 
>> The first patch adds docunmentation to describe PLL clock bindings,
>> and the second patch adds documentation to decribe syscon registers.
>> The patch 3 modifies the SYSCRG bindings and adds PLL clock inputs.
>> The patch 4 adds driver to support PLL clocks for JH7110.
>> The patch 5 modifies the system clock driver and can select the PLL clock
>> source from PLL clocks driver. And the patch 6 adds the 
>> stg/sys/aon syscon nodes for JH7110 SoC. The last patch modifies the 
>> syscrg node in JH7110 dts file.
> 
> Just FYI, I have picked up the binding & clock portions of this series
> and your other one adding the stg syscon. I've pushed them out here for
> the test robots to have a look:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=clk-starfive
> 
> If that passes, my plan is to send Stephen a PR for the lot, later this
> week.
> 

Great. Thank you for everything.

Best regards,
Xingyu Wu

