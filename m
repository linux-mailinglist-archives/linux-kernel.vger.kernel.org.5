Return-Path: <linux-kernel+bounces-152276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89ED8ABBC2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56E628159C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006120B3D;
	Sat, 20 Apr 2024 13:33:06 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6F20309;
	Sat, 20 Apr 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713619985; cv=none; b=dO1cd16IyLApROrVU6vOAaWA3FRk1dDMY/fhrnUlferAWtK+YUpb4266BJyV7N0uw/IOr2VTiXjpDMrQKT3ZkAeDAzy1E4DE1gCBUr+p+fCv/uXczxJjNHOLQaLMQhbI72hcU/7R7eo9P275Sdyt9hETPcfz5aSRrObKO+t8rGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713619985; c=relaxed/simple;
	bh=PEcDp8I3M8Yr7iDTgjFDbNrl9L5ce/gSH/kcCCvROGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVjoi7r9RMkxDtx+JDPnGNfYMogiu4kqKXFt70Vst6m0knba6VLeSUfZaHOVvpuwMnIjr/pGI36LBn/AEUmxUFO+uMARNICCv1xQtQGMFhGSwAem8W66hGXfaZyk+bk+y7FOLfTCmcGQRrEgGUrvUGG0zmtWSuHPvAp7FJQ2fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id CAECE8333C;
	Sat, 20 Apr 2024 15:32:59 +0200 (CEST)
Message-ID: <eb221864-0044-4ea5-bbee-7545d10cb130@skole.hr>
Date: Sat, 20 Apr 2024 15:32:56 +0200
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
 <de4c56a8-488d-4cdb-9d6c-e9d6e63b22b9@skole.hr>
 <58b23157c088cb4774d579cc8700de85.sboyd@kernel.org>
 <3287993.aeNJFYEL58@radijator>
 <d7ff7dd609cd1b9a50e5ffa882d05b90.sboyd@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <d7ff7dd609cd1b9a50e5ffa882d05b90.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/20/24 00:24, Stephen Boyd wrote:
> Quoting Duje Mihanović (2024-04-19 07:31:14)
>> On Friday, April 12, 2024 4:57:09 AM GMT+2 Stephen Boyd wrote:
>>> Quoting Duje Mihanović (2024-04-11 03:15:34)
>>>
>>>> On 4/11/2024 10:00 AM, Stephen Boyd wrote:
>>>>> Is there a reason this file can't be a platform driver?
>>>>
>>>> Not that I know of, I did it like this only because the other in-tree
>>>> MMP clk drivers do so. I guess the initialization should look like any
>>>> of the qcom GCC drivers then?
>>>
>>> Yes.
>>
>> With the entire clock driver code in one file this is quite messy as I also
>> needed to add module_init and module_exit functions to (un)register each
>> platform driver, presumably because the module_platform_driver macro doesn't
>> work with multiple platform drivers in one module. If I split up the driver
>> code for each clock controller block into its own file (such as clk-of-
>> pxa1908-apbc.c) as I believe is the best option, should the commits be split
>> up accordingly as well?
> 
> Sure. Why is 'of' in the name? Maybe that is unnecessary?

That seems to be a historical leftover from when Marvell was just adding 
DT support to the ARM32 MMP SoCs which Rob followed along with in the 
PXA1928 clk driver and so have I. Should I drop it then as Marvell has 
in the PXA1908 vendor kernel?

Regards,
--
Duje


