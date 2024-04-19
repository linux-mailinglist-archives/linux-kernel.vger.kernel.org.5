Return-Path: <linux-kernel+bounces-151101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6898AA91E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D81F21B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF642ABC;
	Fri, 19 Apr 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqwFaBpA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B53F9C2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511521; cv=none; b=DgZt49IPZ4l9s4VbGVix37poNJ8GKwQtBbDDBOa+nJoqswWpxqWTzirl8dZVeZqRv04OpAIe1P4BT/PE4pMdCuyKGZvPRIb+vMMo6Zvyfni8n+fy77rrqkXpWw4ekPyED/wDGwqnMS4Yp2aPtqCKc8yySqjhEuMK1kmxWVv4UiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511521; c=relaxed/simple;
	bh=0A/OCsLVNcCr/k9A/CnjgLx1zKdQMydiJIwdPLolL2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeziAMo6laagQUoSomr1mYTprHBGZTNUea9MsvM8kcQtFFMWiHIMtS2naAav/b1H/roSkpyGv1uN3+z+QzPP/9rsijwA+gOkIBJ3/S0f4VtndXdWZem+iBAOF/M2pZgH6DRi9QKK54IMAeQt4h2Rr/oMLHSHdXfBBIJMFDUGvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqwFaBpA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713511518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYdsES1ehEjRm91dEIYItkD42nNySUH6HTDwijrWpSM=;
	b=HqwFaBpAUNvqAeO4gV8Ej8anQ1O5zFOcnBx8AyB4XIU2ePtrWQMz6J/A7McJX3aDHLciuG
	l6ixGvkA8FRCa9HoPPgEMpR499vIgSYqlrxL0JfKBqbRn2JndQShwTCKM3xERKHT5A1mrh
	830f9xsonV4uT+PLxd0m6snSws27uFM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-WdssuoyKM5qAH0wq5nMWAQ-1; Fri, 19 Apr 2024 03:25:16 -0400
X-MC-Unique: WdssuoyKM5qAH0wq5nMWAQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51895074307so1170413e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511515; x=1714116315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYdsES1ehEjRm91dEIYItkD42nNySUH6HTDwijrWpSM=;
        b=KgBNpyWFQp8GGQVNNOIIMGttVd++KMFCuDxNrcqounYPFoZApmVnH//lovLkXY8ppu
         KVw+y4Q9CtFk7HYQZAjx1QeqwFJ8BQNEnbtKllzFWtZkVXnI8IC0ovD+iQOO8NLPkOmy
         hf57as7SrNDGptHXujJzxne2fobtU+g8MsNmw5U1VZdaqHYU5LjUlS1M3Rbw8/0wDqEj
         db2U0lrPTgefn63la+xYvEr6LFyJ7nUX/Tmd4wDZstTEOz4B+pGlQt2GHEiJNDdS3BRQ
         YmmNSidusc81nr6PSPUNElQjXt+3+wCPwZf1dgAfhWaXSjAiHDEafjhbDzb5ppQJyQP5
         WoKw==
X-Forwarded-Encrypted: i=1; AJvYcCVwq9EzUc2sHnpcOB1JAupzA27rf3IdZ+7YvOGTPGP9JsIR8r+xFVhuM861vhW/9IcmEAhRYd5rlNdxkvaPMSjxOxjNXPW4sYBiZ62F
X-Gm-Message-State: AOJu0YzAzOWndW6ZDhsigo3ABFDp1z0vZRAeOmv8ZfJDF1zh1Nf3Kgi0
	PCSpXzJiw548RCW0a4lTuY6F/teUBCkCqwfccYdD7oLYqc99X8rB9y2TnjDajzg1scLI7Zb8WJY
	ZIzyVdw9X35cR40o9BFzoZxPtgfMAgGj01qtpRy+ZkuSCWdkwDZnzl2JZSt8EMA==
X-Received: by 2002:a05:6512:3f18:b0:518:6ee7:b988 with SMTP id y24-20020a0565123f1800b005186ee7b988mr820844lfa.55.1713511514835;
        Fri, 19 Apr 2024 00:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG59JxcGB3Oo+tRlSNoU2exg90akfDPJmIvxkiqzU+XP0dnaRZJE0OjdyFlU7n3tJZmEdhxcw==
X-Received: by 2002:a05:6512:3f18:b0:518:6ee7:b988 with SMTP id y24-20020a0565123f1800b005186ee7b988mr820826lfa.55.1713511514419;
        Fri, 19 Apr 2024 00:25:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090657d400b00a51b403e30esm1838719ejr.90.2024.04.19.00.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:25:13 -0700 (PDT)
Message-ID: <fa6430c7-85ed-4baf-91fe-b29e4bf39c4a@redhat.com>
Date: Fri, 19 Apr 2024 09:25:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mateusz Kaduk <mateusz.kaduk@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Tj <linux@iam.tj>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
References: <20240418171554.GA243364@bhelgaas>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240418171554.GA243364@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 4/18/24 7:15 PM, Bjorn Helgaas wrote:
> On Thu, Apr 18, 2024 at 10:14:21AM +0200, Hans de Goede wrote:
>> On 4/17/24 10:40 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Arul, Mateusz, Imcarneiro91, and Aman reported a regression caused by
>>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").  On the
>>> Lenovo Legion 9i laptop, that commit removes the area containing ECAM from
>>> E820, which means the early E820 validation started failing, which meant we
>>> didn't enable ECAM in the "early MCFG" path
>>>
>>> The lack of ECAM caused many ACPI methods to fail, resulting in the
>>> embedded controller, PS/2, audio, trackpad, and battery devices not being
>>> detected.  The _OSC method also failed, so Linux could not take control of
>>> the PCIe hotplug, PME, and AER features:
>>>
>>>   # pci_mmcfg_early_init()
>>>
>>>   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
>>>   PCI: not using ECAM ([mem 0xc0000000-0xce0fffff] not reserved)
>>>
>>>   ACPI Error: AE_ERROR, Returned by Handler for [PCI_Config] (20230628/evregion-300)
>>>   ACPI: Interpreter enabled
>>>   ACPI: Ignoring error and continuing table load
>>>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
>>>   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
>>>   ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0010)
>>>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
>>>   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
>>>   ...
>>>   ACPI Error: Aborting method \_SB.PC00._OSC due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
>>>   acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)
>>>
>>>   # pci_mmcfg_late_init()
>>>
>>>   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
>>>   PCI: [Firmware Info]: ECAM [mem 0xc0000000-0xce0fffff] not reserved in ACPI motherboard resources
>>>   PCI: ECAM [mem 0xc0000000-0xce0fffff] is EfiMemoryMappedIO; assuming valid
>>>   PCI: ECAM [mem 0xc0000000-0xce0fffff] reserved to work around lack of ACPI motherboard _CRS
>>>
>>> Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be reserved by a PNP0C02
>>> resource, but it need not be mentioned in E820, so we shouldn't look at
>>> E820 to validate the ECAM space described by MCFG.
>>>
>>> 946f2ee5c731 ("[PATCH] i386/x86-64: Check that MCFG points to an e820
>>> reserved area") added a sanity check of E820 to work around buggy MCFG
>>> tables, but that over-aggressive validation causes failures like this one.
>>>
>>> Keep the E820 validation check only for older BIOSes (pre-2016) so the
>>> buggy 2006-era machines don't break.  Skip the early E820 check for 2016
>>> and newer BIOSes.
>>
>> I know a fix for this has been long in the making so I don't want to throw
>> a spanner into the works, but I wonder why is the is_efi_mmio() check inside
>> the if (!early && !acpi_disabled) {} block (before this patch) ?
>>
>> is_efi_mmio() only relies on EFI memdescriptors and those are setup pretty
>> early. Assuming that the EFI memdescriptors are indeed setup before
>> pci_mmcfg_reserved(..., ..., early=true) gets called we could simply move
>> the is_efi_mmio(&cfg->res) outside (below) the if (!early && !acpi_disabled)
>> {} so that it always runs before the is_mmconf_reserved(e820__mapped_all, ...)
>> check.
>>
>> Looking at the dmesg above the is_efi_mmio() check does succeed, so this
>> should fix the issue without needing a BIOS year check ?
> 
> As far as I know there is no spec requirement that an area described
> by MCFG appear in either the E820 map or the EFI map.
> 
> I would like to get away from relying on these things that the spec
> doesn't require because they are so prone to breakage.
> 
> I would love to just get rid of this early usage of
> pci_mmcfg_reserved() completely; I'm just afraid of breaking some
> ancient 2006-era machine that still happens to be running.

Ok, yes if you want to move away from the early checks at all
then adding the BIOS year check makes sense.

With that clarified the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




