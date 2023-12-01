Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D480024A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377257AbjLADtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FA5171F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701402555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IO8CL2qjeIUr0LsYwreVkjK8516DQtyOeewHK7H786o=;
        b=WGu4YqHA2ly7lIBRb5cmtWLi5WqsiTeGBSOgibj+nx4++AXyK7ZsEtv2GYNHC2kyyWjipB
        yfENv9zdCkglh41tmGkeQTVkU716gjXy1Imt0DaVvIn14xh4uR/2vgPO83XBmn2z/DmeoP
        bx0ooj+aQf6f1CAztnw2y3tD3Gym1HY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-J3pAifOCMduNUAJsFg6VKQ-1; Thu, 30 Nov 2023 22:49:13 -0500
X-MC-Unique: J3pAifOCMduNUAJsFg6VKQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-285bb0575d5so2164350a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701402552; x=1702007352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO8CL2qjeIUr0LsYwreVkjK8516DQtyOeewHK7H786o=;
        b=bweAaCH3FQexQzE0fcMc4hhzzbjCgL4siywXUf0kiCIMJ4AHQfOhxLw77zWjEHWQ7E
         c8vOUcTbFufxi4gRh0MfTL0s4vqWWOq+5hBimUwCaTveNYfimEk0mYIctzSFN7YzZ4pZ
         101VIPH/norHNOsXK0kGdC8DKQAp5PQ3H48ucYiI45oeAzyjAZfQdx6KH9utRWOL5pRH
         eNoz3Fjk/BrjKf3tqCGYgLj4mv7zfXQ0iRpE8XfnQJdbwld1kfWJCrvD1YexRDeiUst+
         9n1O5dLtrbpW4JUkQqDRGedxJP0IF7XRuRmnnj0L/Qk4q+Lz0e/UdP+1SXa48pl8NUut
         f31g==
X-Gm-Message-State: AOJu0YzSZrhgCUPG6uX+wTj06Uy8GCQrJUljlITFCl6eika7IJ4oBLtp
        z0oOhT0v3qJZsv3LTvcZTtRogEWENte1JOQ5qzDooL3LHVkcyIQfA710444My7rXb1bTofNlViT
        Erp+f7VYnKOy0hNU5T9brE2qU
X-Received: by 2002:a17:902:e80e:b0:1cf:daca:2b5e with SMTP id u14-20020a170902e80e00b001cfdaca2b5emr17322852plg.38.1701402552344;
        Thu, 30 Nov 2023 19:49:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVVbr2zUe8qqYTBkmHgB1fO8oP/OS0GFEHLzxacC4remFDnJNuIkfv1IWdcQ4cpeu8xrZWrg==
X-Received: by 2002:a17:902:e80e:b0:1cf:daca:2b5e with SMTP id u14-20020a170902e80e00b001cfdaca2b5emr17322834plg.38.1701402551963;
        Thu, 30 Nov 2023 19:49:11 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm2185691plf.217.2023.11.30.19.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:49:11 -0800 (PST)
Message-ID: <e0b38120-8b09-4695-974c-f3c3ef226f22@redhat.com>
Date:   Fri, 1 Dec 2023 14:49:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] drivers: base: Print a warning instead of panic()
 when register_cpu() fails
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3W-00CszU-GM@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r5R3W-00CszU-GM@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/23 00:44, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> loongarch, mips, parisc, riscv and sh all print a warning if
> register_cpu() returns an error. Architectures that use
> GENERIC_CPU_DEVICES call panic() instead.
> 
> Errors in this path indicate something is wrong with the firmware
> description of the platform, but the kernel is able to keep running.
> 
> Downgrade this to a warning to make it easier to debug this issue.
> 
> This will allow architectures that switching over to GENERIC_CPU_DEVICES
> to drop their warning, but keep the existing behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/base/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

