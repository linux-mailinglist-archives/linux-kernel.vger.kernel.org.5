Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7410D7E690C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjKILAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKILAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638C2590
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699527565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9U5ygdZjpdfSXw60j6OXFMXdIu25vL99MHEH+w5Ks4=;
        b=fn2sJl4eKsyZcVgsgkq/cR6Du/bNFyqVp+D4ASvb8GBtC6/mVCLbdOBAsvPk7/cvwIo5Cm
        dv1hpYJHBjmxY11X3Pu1TTOiJR+pLVtaH6fbLz/H+O3/IGyv/EU/c5lPL+XlJ9VALXIM6R
        Yzjf2xC8i4P6deUvd8wzyRc0OUTk85U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-AYFUVOJ2O1mzA22YbSBXvg-1; Thu, 09 Nov 2023 05:59:24 -0500
X-MC-Unique: AYFUVOJ2O1mzA22YbSBXvg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6bde07512bfso228116b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527562; x=1700132362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9U5ygdZjpdfSXw60j6OXFMXdIu25vL99MHEH+w5Ks4=;
        b=xOvX6uzSlh/jeTq7Zgozmk3IbA5Doc/X2ABnvdj3doD44156hjyfBXG5vEavTQbOHP
         ZpC/b05NwUZ9EyoX2gygTtG5u8dPHwDDJP/XqVqhk/XB0Q1Gd8Zoh/mw9jfHdEdcEk27
         dCnlpKvJWUswMZ39nj1ZOvh/TQL3KECXYt+jZHWA5lJZKBxHpUuB+pKVEluZP/lBGUu+
         Lv5lt+WhKdb1V6gYAoYuWgJDtty9KVVfSWYx66ec5Rn3OuSmpPspEAfkMmrHZe5gnPyK
         J7hh6qHSiVJsTr3E/GydpquvTo+p5+9V3HwBUak7/l45sD4bvEkWH3rsfpl/keVOvOr2
         0pCA==
X-Gm-Message-State: AOJu0YwSRCndF4wxnWdHs2y4gLLxNCTuEfy7ilWo6gaIdAzdUrGRt/dr
        DlFx2JQ9dFhzlPk4jKZVu2ulOTv4rnRkL3+3PvviBs9s+Tu3Ff9S5hTG7UY+R3cDFRE3IT+g/cl
        CIPa5ukZ5hWPfR1GkT89IOzvNnudfTRslV1I=
X-Received: by 2002:a05:6a20:8e14:b0:181:7d6d:c0ee with SMTP id y20-20020a056a208e1400b001817d6dc0eemr5336329pzj.0.1699527562373;
        Thu, 09 Nov 2023 02:59:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVGk/5hgPxq0+SsSph+84k4BFGhqdcMPg+KMAt0nXFoQGQf7FXvvQcKVOfijjQlbVGmLH/fA==
X-Received: by 2002:a05:6a20:8e14:b0:181:7d6d:c0ee with SMTP id y20-20020a056a208e1400b001817d6dc0eemr5336293pzj.0.1699527562066;
        Thu, 09 Nov 2023 02:59:22 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x16-20020aa793b0000000b006c344c9f8bfsm10417140pff.87.2023.11.09.02.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:59:21 -0800 (PST)
Message-ID: <6c27c39a-a851-52f5-1156-354487bb2821@redhat.com>
Date:   Thu, 9 Nov 2023 18:59:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 06/22] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
 <f00dd1cf-5b4c-38a8-a337-817d474d53d1@redhat.com>
 <ZUy0h/lc3QCPsuU8@shell.armlinux.org.uk>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZUy0h/lc3QCPsuU8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 18:29, Russell King (Oracle) wrote:
> On Thu, Nov 09, 2023 at 06:09:32PM +0800, Shaoqin Huang wrote:
>> Hi Russell,
>>
>> On 11/7/23 18:29, Russell King (Oracle) wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> Three of the five ACPI architectures create sysfs entries using
>>> register_cpu() for present CPUs, whereas arm64, riscv and all
>>> GENERIC_CPU_DEVICES do this for possible CPUs.
>>>
>>> Registering a CPU is what causes them to show up in sysfs.
>>>
>>> It makes very little sense to register all possible CPUs. Registering
>>> a CPU is what triggers the udev notifications allowing user-space to
>>> react to newly added CPUs.
>>>
>>> To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
>>> it to use for_each_present_cpu(). Making the ACPI architectures use
>>> GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
>>> cpu_register() logic, before moving it into the ACPI processor driver.
>>> When ACPI is disabled this work would be done by
>>> cpu_dev_register_generic().
>>
>> What do you actually mean about when ACPI is disabled this work would be
> 
> Firstly, please note that "you" is not appropriate here. This is James'
> commit message, not mine.
> 

Oh, Sorry for that.

>> done by cpu_dev_register_generic()? Is the work means register the cpu?
> 
> When ACPI is disabled _and_ CONFIG_GENERIC_CPU_DEVICES is enabled, then
> cpu_dev_register_generic() will call arch_register_cpu() for each present
> CPU after this commit, rather than for each _possible_ CPU (which is the
> actual code change here.)
> 
>> I'm not quite understand that, and how about when ACPI is enabled, which
>> function do this work?
> 
> This is what happens later in the series.
> 
> "drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden"
> adds a test for CONFIG_GENERIC_CPU_DEVICES, so this will only be used
> with architectures using GENERIC_CPU_DEVICES. Then in:
> 
> "ACPI: processor: Register all CPUs from acpi_processor_get_info()"
> which is not part of this series, this adds a call to arch_register_cpu()
> in the ACPI code, and disables this path via a test for !acpi_disabled.
> 
> Essentially, this path gets used to register the present CPUs when
> firmware (ACPI) isn't going to be registering the present CPUs.
> 
> I've changed this to:
> 
> "It makes very little sense to register all possible CPUs. Registering
> a CPU is what triggers the udev notifications allowing user-space to
> react to newly added CPUs.
> 
> "To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
> it to use for_each_present_cpu().
> 
> "Making the ACPI architectures use GENERIC_CPU_DEVICES is a pre-requisite
> step to centralise their register_cpu() logic, before moving it into the
> ACPI processor driver. When we add support for register CPUs from ACPI
> in a later patch, we will avoid registering CPUs in this path."
> 
> which I hope makes it clearer.
> 

Thanks for your great explanation. Change commit message to this makes 
me understand well.

Thanks,
Shaoqin

>>> After this change, openrisc and hexagon systems that use the max_cpus
>>> command line argument would not see the other CPUs present in sysfs.
>>> This should not be a problem as these CPUs can't bre brought online as
>>                                               ^ nit: can't be
> 
> Thanks, I'll fix that.
> 

