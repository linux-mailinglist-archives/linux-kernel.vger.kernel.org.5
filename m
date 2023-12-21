Return-Path: <linux-kernel+bounces-7737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5457881AC72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B871C23411
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD624683;
	Thu, 21 Dec 2023 01:58:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AE3D86;
	Thu, 21 Dec 2023 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3DCDF7FFC;
	Thu, 21 Dec 2023 09:58:32 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 09:58:32 +0800
Received: from [192.168.125.131] (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 09:58:31 +0800
Message-ID: <ec9f653d-7078-4efc-b1b6-bbd7a74a1c18@starfivetech.com>
Date: Thu, 21 Dec 2023 09:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] clocksource: Add JH7110 timer driver
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Walker Chen
	<walker.chen@starfivetech.com>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor@kernel.org>
References: <20231219145402.7879-1-xingyu.wu@starfivetech.com>
 <20231219145402.7879-3-xingyu.wu@starfivetech.com>
 <CAJM55Z_X9b=TJt7343kQ68ndN1MvH-rFM9hyEZMJRvQnOk72Yg@mail.gmail.com>
Content-Language: en-US
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z_X9b=TJt7343kQ68ndN1MvH-rFM9hyEZMJRvQnOk72Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag

On 2023/12/20 21:59, Emil Renner Berthing wrote:
> Xingyu Wu wrote:
>> Add timer driver for the StarFive JH7110 SoC and select it by
>> CONFIG_SOC_STARFIVE.
>>
>> This timer has four free-running and independent 32-bit counters.
>> Each channel(counter) can trigger an interrupt when timeout even
>> CPU is sleeping. So this timer is used as global timer and register
>> clockevent for each CPU core after riscv-timer registration on the
>> StarFive JH7110 SoC.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  MAINTAINERS                        |   7 +
>>  arch/riscv/Kconfig.socs            |   1 +
>>  drivers/clocksource/Kconfig        |   9 +
>>  drivers/clocksource/Makefile       |   1 +
>>  drivers/clocksource/timer-jh7110.c | 360 +++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h         |   1 +
>>  6 files changed, 379 insertions(+)
>>  create mode 100644 drivers/clocksource/timer-jh7110.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9104430e148e..fe0e803606a5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20617,6 +20617,13 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
>>  F:	sound/soc/starfive/jh7110_tdm.c
>>
>> +STARFIVE JH7110 TIMER DRIVER
>> +M:	Samin Guo <samin.guo@starfivetech.com>
> 
> Last time I sent a mail to samin.guo@starfivetech.com it bounced. Was that just
> a temporary error?
> 
> /Emil

Oh, This email has been deactivated and I don't have his other personal email.
I had dropped it in the driver but forget it here.
Will fix.

Thanks,
Xingyu Wu

> 
>> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
>> +F:	drivers/clocksource/timer-jh7110.c
>> +
>>  STARFIVE JH71X0 CLOCK DRIVERS
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>  M:	Hal Feng <hal.feng@starfivetech.com>


