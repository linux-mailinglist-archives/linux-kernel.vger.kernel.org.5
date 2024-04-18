Return-Path: <linux-kernel+bounces-150294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E9E8A9CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4B4287932
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF0616D4E5;
	Thu, 18 Apr 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fvbI6H5q"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A73616D4C8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450035; cv=none; b=T1QiTOYVZtY52wcWmzFxwCjPtJN0SxrdQuxnWtJVhRKvRV0SwAIJjgYWuN4DRfGMAveXoG0/UW7PfW/QgVBa3NDtWFKaTqJ9sqP9/Bn4dS2bXbufPshQ0fxT8BJQNDlAKnT1eFGbTdV8L/zatlw58sZVwc34pzpfFnn9RpdLxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450035; c=relaxed/simple;
	bh=gAa7Kq1mYFyz8jqtnXVIe79COqi9Rf6W5LHAFGe3mjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqLqzQplSBvE39ZPPB4koGqNqLbmUGjx9sBJrMaAiy/cmsaTIZ+mmkfPovkg9cq+jJ0+5TLESATx9wVmhYeHBMI/jjxbhUjCLEeCjFZeNO5lXLA/VebfwDHv0on3sX0BuySBd/yM7vwlkNuRfrBB8e4KwoTOy7yw8RU4ERtHMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fvbI6H5q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9581F3F8E6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713450030;
	bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=fvbI6H5qEJyOKKXg7sMdwyQPj8Pgv4iI0ilE1qO82dS3NLZ2XpSkWx54aE5Sm1wwh
	 CB3WJHpsMQgwi0J3tejoQZBN1jjxZoKSfsNYMbr27uICGeNPvvW4JPXo9zOVf5gsYw
	 eyRYqYhx70tqGGf8nIGsObMKkyUM7k9z7knHs3UdsLTbwlnZmqC5D9oGlB7KvJv8Lf
	 sCcHI+U5QK8eZu17sBn0DjuB1IIuEMSY1kPKQWiu0ENJWCsesAB5hykLd4rAELmVox
	 0YYN+xKE8werAeh+OJUR0hB6YRRq8X8wUOQi+/QzQyy4FgRDziNpwmRB2Kd0nWJtGI
	 rNZOqDfGkKf8A==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416a844695dso5565025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450029; x=1714054829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
        b=f3K9KdL0xsuIc9A1iqnQKAZSY8cADrL7QhfPJYqTb9tlLAJtZXYbvxdLKUC7TcfXKB
         PQxr1GU4COSskxHUOfnwktBp/sWbDNARAi3EMWWAr8yU+G3MLZI4sCyIaJIzFR9WVlXk
         SRtU7a4HIcRqdRs9Yd28zZgf5LVlRFwz/XECWlkpyooYGqbmaDSHXultkoyR3zTwMJJu
         EIp3ByyVlvMeSMmtBbZ9NocgRLLVt/+hTgF2hS0dJW0OoqHJyxzYFPZkFKzTi70EOoKr
         7vHt6HpevjEw88pQ52P4eBIZl+Q4gkeaST07wG1SXV1GpwgXOC7vJ2g9poAwD1/jWQIi
         eZ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWVuVsxdbHt7eG3Hdqvdidiu+UYxVMQ/p7n2KNRevFyN9FSeRfcumwNMkBvziGXTLRDN86QuWNhnH0ZOiwtLR7WfXjrBNvhrqabEJSg
X-Gm-Message-State: AOJu0Yw8C1WZf8wZAxe9sdJ+Z1lD2NTw81YUNXnNyb4LEoyFa588jEZM
	GY7Ic0RpE47wStQ00wCksyP5ULDLP/WIMtJCY5v8qKUhZ0+Mwj2zjT/lE89h/S08mUhvyp480G5
	8tQJwNIOt0T3HkLZvKNuk/lbO8FZ2ZcM5hYFCy0E0rYyA8eSiCLcwJFamYhE+hS0tDOmkLNzyCH
	0ePA==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340895wmq.40.1713450029735;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT2UI5195uUHY+LxtGsmAza41kuNxu3PsqfU28U6vm2gIhE1ZKzhOvItctvv3fW1IYrvOjmg==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340875wmq.40.1713450029353;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
Received: from [192.168.123.126] (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00416b163e52bsm6658726wmq.14.2024.04.18.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:20:28 -0700 (PDT)
Message-ID: <ef065a0e-1996-4ca2-b6f0-3a152edd3540@canonical.com>
Date: Thu, 18 Apr 2024 16:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>,
 Robert Moore <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Andrei Warkentin <andrei.warkentin@intel.com>, Marc Zyngier
 <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
 <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.04.24 15:58, Sunil V L wrote:
> Hi Björn,
> 
> This is cool!. I was not aware that u-boot also supports ACPI on
> RISC-V. Many thanks!
> 
> Thanks,
> Sunil

For RISC-V and ARM we have

* pass-through for QEMU ACPI tables
* pass-through for QEMU SMBIOS tables
* generation of SMBIOS tables

Generation of ACPI tables in U-Boot has up now only been implemented for 
x86 but would be feasible for RISC-V boards too.

Cf. https://docs.u-boot.org/en/latest/board/emulation/acpi.html

Best regards

Heinrich

