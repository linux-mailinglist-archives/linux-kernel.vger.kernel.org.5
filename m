Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39275BF15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGUGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGUGqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:46:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF11B4;
        Thu, 20 Jul 2023 23:46:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D267C7FD6;
        Fri, 21 Jul 2023 14:45:55 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 14:45:55 +0800
Received: from [192.168.125.128] (113.72.147.86) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 14:45:54 +0800
Message-ID: <8794c997-f371-70f8-2462-a6c677e7308c@starfivetech.com>
Date:   Fri, 21 Jul 2023 14:41:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 0/9] Add STG/ISP/VOUT clock and reset drivers for
 StarFive JH7110
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
 <20230720-enjoyment-gestation-adb8baa9aaf1@spud>
Content-Language: en-US
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230720-enjoyment-gestation-adb8baa9aaf1@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/21 0:32, Conor Dooley wrote:
> On Thu, Jul 13, 2023 at 07:38:53PM +0800, Xingyu Wu wrote:
>> This patch serises are base on the basic JH7110 SYSCRG/AONCRG
>> drivers and add new partial clock drivers and reset supports
>> about System-Top-Group(STG), Image-Signal-Process(ISP)
>> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC. These
>> clocks and resets could be used by DMA, VIN and Display modules.
>> 
>> Patches 1 and 2 are about the System-Top-Group clock and reset
>> generator(STGCRG) part. The first patch adds docunmentation to
>> describe STG bindings, and the second patch adds clock driver to
>> support STG clocks and resets as auxiliary device for JH7110.
>> 
>> Patches 3 and 4 are about the Image-Signal-Process clock and reset
>> gennerator(ISPCRG) part. The first patch adds docunmentation to
>> describe ISP bindings, and the second patch adds clock driver to
>> support ISP clocks and resets as auxiliary device for JH7110.
>> And ISP clocks should power on and enable the SYSCRG clocks first
>> before registering.
>> 
>> Patches 5 and 6 are about the Video-Output clock and reset
>> generator(VOUTCRG) part. The first patch adds docunmentation to
>> describe VOUT bindings, and the second patch adds clock driver to
>> support VOUT clocks and resets as auxiliary device for JH7110.
>> And VOUT clocks also should power on and enable the SYSCRG clocks
>> first before registering.
>> 
>> Patch 7 adds struct members to support STG/ISP/VOUT resets.

BTW, I found this patch is not in the linux-next or clk-next.
These STG/ISP/VOUT CRG drivers are 'incomplete' without this resets patch.
I don't know what your plans about this patch and I'm just curious on it.

> 
>> Patch 8 adds external clocks which ISP and VOUT clock driver need.
>> Patch 9 adds device node about STGCRG, ISPCRG and VOUTCRG to JH7110 dts.
> 
> b4 did not detect this correctly, but I picked these 2 up too.
> They should be in next tomorrow.

Thanks to you.

> 
> Please let your co-workers know that they should resend anything that I
> didn't sent a thanks email for today, as it failed to apply (eg DMA,
> eMMC).
> 

Okay, I'll let them know and resent these patches.

Best regards,
Xingyu Wu
