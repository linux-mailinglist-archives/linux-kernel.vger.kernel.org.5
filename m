Return-Path: <linux-kernel+bounces-77480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F368605EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B249B22A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DC18B15;
	Thu, 22 Feb 2024 23:00:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954817BD3;
	Thu, 22 Feb 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708642806; cv=none; b=NZyqxBr5iJOqrpq4h8cpXdGw7lyEYWwUAjJrJrvSaZ+wG0gP3GJ061WvUTFmXJX7mr+fc7bnwJNkJzDWLDJthO/8AeJ4q5dsTfu1m5OdG6+cv5SyEMeTsl1Ebf1jrwQixj3OSDnb+GeNssyqPYcNqvDxxQu2o9uzvgeVDwNGLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708642806; c=relaxed/simple;
	bh=OEjFAKIuJA3qH4FAQOSySl87ZHAyj2jyASYFVZY0SMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJIdZSILNs+YabN6KGB74ZoMu2WHfdixNgfHhvlYPTl/D50qXLbNN1byIVZbEnWEvIYUsrhrOE5hX5lIfcOuUiNq8H9/Etf1vEb1GvH2w17N6z1nSAIy5LGnGBhpOIl1V2SyZMFre/coWTaF5Jrd18zj6cGAYsfar1ybvgGZat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD8EDA7;
	Thu, 22 Feb 2024 15:00:42 -0800 (PST)
Received: from [10.57.10.154] (unknown [10.57.10.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19E2F3F766;
	Thu, 22 Feb 2024 15:00:00 -0800 (PST)
Message-ID: <27ad9614-e3de-4965-9f4e-865bc541eb4c@arm.com>
Date: Thu, 22 Feb 2024 22:59:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/25] genirq/irqdomain: Remove the param count
 restriction from select()
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan
 <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-3-apatel@ventanamicro.com>
 <e42b76a9-fc5f-4ab7-96a2-629261a9c983@arm.com> <87edd4a2fo.wl-maz@kernel.org>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <87edd4a2fo.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/02/2024 16:28, Marc Zyngier wrote:
> On Thu, 22 Feb 2024 13:01:32 +0000,
> Aishwarya TCV <aishwarya.tcv@arm.com> wrote:
>>
>>
>>
>> On 27/01/2024 16:17, Anup Patel wrote:
>>> From: Thomas Gleixner <tglx@linutronix.de>
>>>
>>> Now that the GIC-v3 callback can handle invocation with a fwspec parameter
>>> count of 0 lift the restriction in the core code and invoke select()
>>> unconditionally when the domain provides it.
>>>
>>> Preparatory change for per device MSI domains.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> ---
>>
>> Hi Thomas/Anup
>>
>> Currently when booting the kernel against next-master(next-20240222)
>> with Arm64 on Qualcomm boards RB5/DB845C, the kernel is resulting in
>> boot failures for our CI. I can send the full logs if required. Most
>> other boards seem to be fine.
>>
>> A bisect (full log below) identified this patch as introducing the
>> failure. Bisected it on the tag "next-20240220" at repo
>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>
>> This works fine on Linux v6.8-rc5
> 
> Can you please try [1]?
> 
> 	M.
> 
> [1] https://lore.kernel.org/linux-kernel/20240220114731.1898534-1-maz@kernel.org
> 

With the patch[1] applied on next-master(next-20240222), successfully
tested booting the kernel with Arm64 on Qualcomm boards RB5/DB845C.
Confirming that the patch is resolving the boot issue on RB5/DB845C

Thanks
Aishwarya

