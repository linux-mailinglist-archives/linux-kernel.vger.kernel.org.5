Return-Path: <linux-kernel+bounces-157687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A748B149C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FD11C224FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B057D156881;
	Wed, 24 Apr 2024 20:32:36 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC415665C;
	Wed, 24 Apr 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990756; cv=none; b=YL113ddPN+s0emQ1Jk1Sr/YwhldBfv5PzmWy2oV/0TX8tnrjoH4YmgKvakSebVsylBZCdsdf72jhy8dOxyS6GXEA4s0pS/iDLWUviCMvp+DB33G39YMZnjAbV0ZgU1LfB8PgRh0YUwBL/w9mXUlkRjTODc4WyjhxbbzBpzY1/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990756; c=relaxed/simple;
	bh=SMmWu0O4kiOeIE8+kMaBKKvSrZyE8uK+V6ffxp7Bn5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+7AgTPokbpQjO3yj5JuCLidXIXHrXXUVHNktb9YPmJNNeUQEaYyCkl44n5cn/rmJBjZBtBnlViSE8AgSEW2AsH2KVo/oy1r5uOnj87DbP9Y0Ei7BxWQKkQGY8NKuSkI/N5V3PeO4hF5cXUgZmHGnPJFCT6Rs8PngheIOs7FXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D3D3240002;
	Wed, 24 Apr 2024 20:32:29 +0000 (UTC)
Message-ID: <41835766-b7d7-4f81-aca7-4a8136ba9971@ghiti.fr>
Date: Wed, 24 Apr 2024 22:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Content-Language: en-US
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240410033148.213991-1-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Xingyu,

On 10/04/2024 05:31, Xingyu Wu wrote:
> This patch is to add the notifier for PLL0 clock and set the PLL0 rate
> to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
>
> The first patch is to add the notifier for PLL0 clock. Setting the PLL0
> rate need the son clock (cpu_root) to switch its parent clock to OSC
> clock and switch it back after setting PLL0 rate. It need to use the
> cpu_root clock from SYSCRG and register the notifier in the SYSCRG
> driver.
>
> The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
> 1.5GHz to fix the problem about the lower rate of CPUfreq on the
> visionfive board. The cpu_core clock rate is set to 500MHz first to
> ensure that the cpu frequency will not suddenly become high and the cpu
> voltage is not enough to cause a crash when the PLL0 is set to 1.5GHz.
> The cpu voltage and frequency are then adjusted together by CPUfreq.
>
> Changes since v3:
> - Added the notifier for PLL0 clock.
> - Set cpu_core rate in DTS
>
> v3: https://lore.kernel.org/all/20240402090920.11627-1-xingyu.wu@starfivetech.com/
>
> Changes since v2:
> - Made the steps into the process into the process of setting PLL0 rate
>
> v2: https://lore.kernel.org/all/20230821152915.208366-1-xingyu.wu@starfivetech.com/
>
> Changes since v1:
> - Added the fixes tag in the commit.
>
> v1: https://lore.kernel.org/all/20230811033631.160912-1-xingyu.wu@starfivetech.com/
>
> Xingyu Wu (2):
>    clk: starfive: jh7110-sys: Add notifier for PLL clock
>    riscv: dts: starfive: visionfive-2: Fix lower rate of CPUfreq by
>      setting PLL0 rate to 1.5GHz
>
>   .../jh7110-starfive-visionfive-2.dtsi         |  6 ++++
>   .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++++++++++++++++-
>   drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 ++
>   3 files changed, 38 insertions(+), 1 deletion(-)


I only took a quick look so I'm not sure: does patch 2 depend on patch 
1? In that case, I think the Fixes tag should be applied to both patches.

And as this is a fix, will you respin a new version soon for 6.9?

Thanks,

Alex


