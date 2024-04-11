Return-Path: <linux-kernel+bounces-140236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F108A0F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC7E1C217B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85599146D46;
	Thu, 11 Apr 2024 10:23:16 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFE13FD94;
	Thu, 11 Apr 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830996; cv=none; b=rAC6aAeBw3P8DbzClt7OoyTHyYEBUwtVikKlGXKtj2LiqLXa3x+QQusnlo929XOrf9rgoGHVMWlXOd6AqiNgXGD4mPqXGz5qwPvOhaaXrE98wphjRA9sCJcGQs/nI/0qh8t2LT+4EsLy/HzQeOt82A5IQm3mrHkVXQ/RNrsUNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830996; c=relaxed/simple;
	bh=o3uBh7P8788b0SPX+S0so494+ke+vXw80SwMiOnWzOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMwz/PbHtDilDG7nPF6R15OhmqJ7XQz03ubHWY0QY4LGbXmRpXN8Ew+HWAnALjMp4G/uG4xb5WXpN3VstzGmcZFoizOFnyBU8ng+YIF5ArKZjVaxg7aoEkgdVYwlP/1W7J1kG6gSXsK7c+xxJfNXB/FOkRZmKNEb62ReIkjeNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 60B5B8673B;
	Thu, 11 Apr 2024 12:15:37 +0200 (CEST)
Message-ID: <de4c56a8-488d-4cdb-9d6c-e9d6e63b22b9@skole.hr>
Date: Thu, 11 Apr 2024 12:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/9] clk: mmp: Add Marvell PXA1908 clock driver
To: Stephen Boyd <sboyd@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Haojian Zhuang <haojian.zhuang@linaro.org>, Kees Cook
 <keescook@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring
 <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>,
 Will Deacon <will@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
 <20240402-pxa1908-lkml-v9-5-25a003e83c6f@skole.hr>
 <3838e4684f98e1ce3818bfb6983844bc.sboyd@kernel.org>
Content-Language: en-CA
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <3838e4684f98e1ce3818bfb6983844bc.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/2024 10:00 AM, Stephen Boyd wrote:
> Quoting Duje Mihanović (2024-04-02 13:55:41)
>> diff --git a/drivers/clk/mmp/clk-of-pxa1908.c b/drivers/clk/mmp/clk-of-pxa1908.c
>> new file mode 100644
>> index 000000000000..6f1f6e25a718
>> --- /dev/null
>> +++ b/drivers/clk/mmp/clk-of-pxa1908.c
>> @@ -0,0 +1,328 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
> [...]
>> +static void __init pxa1908_apbc_clk_init(struct device_node *np)
>> +{
>> +       struct pxa1908_clk_unit *pxa_unit;
>> +
>> +       pxa_unit = kzalloc(sizeof(*pxa_unit), GFP_KERNEL);
>> +       if (!pxa_unit)
>> +               return;
>> +
>> +       pxa_unit->apbc_base = of_iomap(np, 0);
>> +       if (!pxa_unit->apbc_base) {
>> +               pr_err("failed to map apbc registers\n");
>> +               kfree(pxa_unit);
>> +               return;
>> +       }
>> +
>> +       mmp_clk_init(np, &pxa_unit->unit, APBC_NR_CLKS);
>> +
>> +       pxa1908_apb_periph_clk_init(pxa_unit);
>> +}
>> +CLK_OF_DECLARE(pxa1908_apbc, "marvell,pxa1908-apbc", pxa1908_apbc_clk_init);
> 
> Is there a reason this file can't be a platform driver?

Not that I know of, I did it like this only because the other in-tree 
MMP clk drivers do so. I guess the initialization should look like any 
of the qcom GCC drivers then?

While at it, do you think the other MMP clk drivers could use a conversion?

Regards,
-- 
Duje



