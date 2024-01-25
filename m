Return-Path: <linux-kernel+bounces-38778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7783C5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2C81C22C55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17726EB73;
	Thu, 25 Jan 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bQbFZwvs"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD496EB43;
	Thu, 25 Jan 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194315; cv=none; b=D9JsZHCwZGtn2+1ihgUwo36kVI9umsFu19CHXp2t1Kpq4/gSIdrVbYkt/xNxEqYQM83bPVaeKkVqpq3pufmvMOd1TZ2W928t6lQCFCAUPo4IqxgsQAfKOi5hVs7vw7QM6EYgV4ekWAWHzn7N9NYJxYToFWIgdwH/jPvtA9oZMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194315; c=relaxed/simple;
	bh=nLmptd5vtjBBt5Sd8cMVl5TBxBzQ5i5Uf5uA4+C/h9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U8YTPRolkr/buVZA45UTO0KaLUuLIV+Kzl3tIvwmzaZREK25rgXC62qvk0Qa5RUhwgJ6yt5SA4r4uChObF4bx58nRwNKNTjpV3/6D4r8s7kNhLlV2BEOBT2kwLv8Rfys86Uvm5eW1bbvG3u6VcrQqfMpNx82XA1lTYlESW/boXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bQbFZwvs; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9ZLjS032503;
	Thu, 25 Jan 2024 15:51:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=OdOyBjIbGPWEnFAfgcVDEJsf51RApeBzKhFso3DoU6k=; b=bQ
	bFZwvsbEkM7FCjI4sthB7EdciMMV72Lznb/wSSFYgg/e0INQ1OxhDOcFb9dH6QGM
	s4LgUheLLYUU9lKfMF3hsPfjqAq1ezukvwYnmRA6OoKPNXlaV/41cYD6CHBypWpz
	6ZnCBqx0La/NMDVO6RGqFlZzBsfxCBDQ44XC4Mgy5ubQMSo5Gml+aIuYy2G4LW62
	8V6q05INn86RBrM3/xyQnhXzw+CIGuX5qmMwePg7YX4DQ8cLZ6Ub48Th6A+NvuYz
	1QqCu+q0E6rcHbRS8LHdmaZgigWNZmVxmFOo1cswQqZNJhGBAF24fMxh0zXG8Jdx
	OT3NWWBaLY7urdwM2X3w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vtmf9gkda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:51:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 804E810005D;
	Thu, 25 Jan 2024 15:51:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6829629BBC6;
	Thu, 25 Jan 2024 15:51:14 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 25 Jan
 2024 15:51:13 +0100
Message-ID: <07681e93-6bad-4438-91d6-fa74756c20bd@foss.st.com>
Date: Thu, 25 Jan 2024 15:51:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] Introduce STM32MP257 clock driver
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240111071536.659409-1-gabriel.fernandez@foss.st.com>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20240111071536.659409-1-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02

Hello Stephen,

Gentle reminder.

Thanks

Gabriel


On 1/11/24 08:15, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>
> v8:
>    - use .index of clk_parent_data struct to define a parent
>    - remove unnecessary dependency check with SCMI clock driver
>    - convert to platform device APIs
>    - convert to devm_of_clk_add_hw_provider()
>    - convert single value enum to a define
>
> v7: base on next-20231219
>    - These patches below are applied to clk-next:
>        clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
>        clk: stm32mp1: use stm32mp13 reset driver
>        dt-bindings: stm32: add clocks and reset binding for stm32mp25
>    - remove unnecessary includes
>    - migrate clock parents to struct clk_parent_data and remove
>      CLK_STM32_XXX() macros  to have a more readble code
>    - use platform device APIs (devm_of_iomap() instead of_iomap())
>    - move content of stm32mp25_rcc_init() to stm32mp25_rcc_clocks_probe()
>    - simply get_clock_deps()
>    - add const to stm32mp25_data struct
>    - remove ck_icn_p_serc clock (will be integrate later with security
>      management)
>
> v6:
>    - remove useless defines in drivers/clk/stm32/stm32mp25_rcc.h
>
> v5:
>    - Fix sparse warnings: was not declared. Should it be static?
>      drivers/clk/stm32/clk-stm32mp13.c:1516:29: symbol 'stm32mp13_reset_data'
>      drivers/clk/stm32/clk-stm32mp1.c:2148:29: symbol 'stm32mp1_reset_data'
>      drivers/clk/stm32/clk-stm32mp25.c:1003:5: symbol 'stm32mp25_cpt_gate'
>      drivers/clk/stm32/clk-stm32mp25.c:1005:29: symbol 'stm32mp25_clock_data'
>      drivers/clk/stm32/clk-stm32mp25.c:1011:29: symbol 'stm32mp25_reset_data'
>
> v4:
>    - use GPL-2.0-only OR BSD-2-Clause for clock and reset binding files
>    - use quotes ' for #clock-cells and #reset-cells in YAML documentation
>    - reset binding start now to 0 instead 1
>    - improve management of reset lines that are not managed
>
> v3:
>    - from Rob Herring change clock item description in YAML documentation
> v2:
>    - rework reset binding (use ID witch start from 0)
>    - rework reset driver to manage STM32MP13 / STM32MP15 / STM32MP25
>    - rework YAML documentation
>
> Gabriel Fernandez (3):
>    clk: stm32mp13: use platform device APIs
>    clk: stm32: introduce clocks for STM32MP257 platform
>    arm64: dts: st: add rcc support in stm32mp251
>
>   arch/arm64/boot/dts/st/stm32mp251.dtsi |  132 +-
>   drivers/clk/stm32/Kconfig              |    7 +
>   drivers/clk/stm32/Makefile             |    1 +
>   drivers/clk/stm32/clk-stm32-core.c     |   11 +-
>   drivers/clk/stm32/clk-stm32mp13.c      |   72 +-
>   drivers/clk/stm32/clk-stm32mp25.c      | 1876 ++++++++++++++++++++++++
>   drivers/clk/stm32/reset-stm32.c        |   59 +-
>   drivers/clk/stm32/reset-stm32.h        |    7 +
>   drivers/clk/stm32/stm32mp25_rcc.h      |  712 +++++++++
>   9 files changed, 2765 insertions(+), 112 deletions(-)
>   create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
>   create mode 100644 drivers/clk/stm32/stm32mp25_rcc.h
>

