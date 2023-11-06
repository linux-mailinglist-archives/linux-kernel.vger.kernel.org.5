Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED0A7E1B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjKFH1C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 02:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKFH1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:27:01 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183C112;
        Sun,  5 Nov 2023 23:26:57 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id BC38A24DE73;
        Mon,  6 Nov 2023 15:26:48 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Nov
 2023 15:26:48 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Nov
 2023 15:26:47 +0800
Message-ID: <6b57eb4b-241f-4530-b639-5a2e2c55cfd3@starfivetech.com>
Date:   Mon, 6 Nov 2023 15:26:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] pwm: opencores: Add PWM driver support
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
 <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
 <7d64ea1d-b573-4a69-ba0c-4cbfab638c5e@starfivetech.com>
 <20231102113016.jgsh7jru6vjv4vsp@pengutronix.de>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20231102113016.jgsh7jru6vjv4vsp@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/2 19:30, Uwe Kleine-König wrote:
> Hello William,
> 
> On Wed, Nov 01, 2023 at 10:22:44AM +0800, William Qiu wrote:
>> 
>> 
>> On 2023/10/20 19:25, Uwe Kleine-König wrote:
>> >> +	void __iomem *base = pwm->data->get_ch_base ?
>> >> +			     pwm->data->get_ch_base(pwm->regs, dev->hwpwm) : pwm->regs;
>> >> +	u32 period_data, duty_data, ctrl_data;
>> >> +
>> >> +	period_data = readl(REG_OCPWM_LRC(base));
>> >> +	duty_data = readl(REG_OCPWM_HRC(base));
>> >> +	ctrl_data = readl(REG_OCPWM_CTRL(base));
>> >> +
>> >> +	state->period = DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC, pwm->clk_rate);
>> >> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_SEC, pwm->clk_rate);
>> > 
>> > Please test your driver with PWM_DEBUG enabled. The rounding is wrong
>> > here.
>> 
>> The conclusion after checking is: when the period or duty_cycle value set
>> by the user is not divisible (1000000000/49.5M), there will be an error.
>> This error is due to hardware accuracy. So why is rounding is wrong?
>> rockchip also has a similar implementation drivers/pwm/ pwm-rockchip.c
> 
> I fail to follow. Where is an error?
> 
> The general policy (for new drivers at least) is to implement the
> biggest period possible not bigger than the requested period. That means
> that .apply must round down and to make .apply ∘ .get_state idempotent
> .get_state must round up to match.
> 
> Assuming a clkrate of 49500000 Hz the actual period for REG_OCPWM_LRC =
> 400 is 8080.808ns and for REG_OCPWM_LRC = 401 is 8101.010.
> 
> So with REG_OCPWM_LRC = 401 .get_state should report state.period = 8102
> [ns] because if you call .apply with .period = 8101 [ns] you're supposed
> to use REG_OCPWM_LRC = 400.
> 
> Rounding using DIV_ROUND_CLOSEST doesn't give consistent behaviour in
> some cases. Consider a PWM that can implement the following periods (and
> none in between):
> 
> 	20.1 ns
> 	20.4 ns
> 	21.7 ns
> 
> With round-to-nearest a request to configure 21 ns will yield 20.4 ns.
> If you call .get_state there the driver will return 20 ns. However
> configuring 20 ns results in a period of 20.1 ns.
> 
> With rounding as requested above you get a consistent behaviour. After
> .apply_state(period=21) .get_state() returns period=21.
> 
> Best regards
> Uwe
> 
I see, then we'll use DIV_ROUND_DOWN_ULL for .apply() and DIV_ROUND_UP_ULL
for .get_state().
Thank you for your answer.

Best regards,
William
