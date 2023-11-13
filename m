Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10DF7E9619
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjKMEVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKMEVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:21:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838B10FA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699849267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jFv0/+ZJ8QcMT7pXMYPj0XHvwSazMYJli5PQ5trCgZ4=;
        b=Qaj4AD4NWKE02XqzY43tk91B/sswBOd2Iaa7CDvvK9RX7AJq6iKzrFnwVIBmoCyKqZLQz+
        iQAbrTX7p+hqX6eL5R3MIcF9l/AKF2VilS19989CxMIBVXslNvJ17EDHqxOwWenmcIaLJ7
        ONvZksy4WMM+D70tOPh9kCnWn9VobPU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-Cf3Y3nVvP1iX_o0rZ890EA-1; Sun, 12 Nov 2023 23:21:04 -0500
X-MC-Unique: Cf3Y3nVvP1iX_o0rZ890EA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-da03390793fso4810903276.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849264; x=1700454064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFv0/+ZJ8QcMT7pXMYPj0XHvwSazMYJli5PQ5trCgZ4=;
        b=QRD/dsllF8d0z0FjG/tyq6qdiM06DElTJjpGsSUJz1r5pph45EcX91Fsu4RZ94pwVS
         13LyN7FMdz/kIrCyPxHB5qTk+qvO6Si2ZCKOqbx028GgLKBMksgpYeWCD8+FYoELc3ZZ
         MKtUyCAn80WQSFVCqIEkFf7MevG7KDMgWv1BzjJ3P3OuMIV9c1O1hVE9/KokdxrUdBKr
         5kyVSShr1eGROqW6nth93NbURlaZPJ1ruOkVC4QIYNnMrKz5fma0atxEncRWX5qO4Smg
         m2xV2snxTDm2KeFkOkAhzYKf76AvkWvN5vYCk888DvJtXerHiVxcJvd8JpUbWbS0CTKX
         XdBg==
X-Gm-Message-State: AOJu0YyfrPAI8Mn6rLHhMtAmAvze4psng7b78YYoO0v10BLWFEn52ehl
        Y3mRDyJtykWBmggW3fmH5yQNRyiXdwBYUcGEo8a6rYdfHE3mJCeC0RE4RMcyjtfNvn8YcBbdOUE
        z7xyIPFfHkkY0XASO5sHpbaLE
X-Received: by 2002:a05:6902:1547:b0:d43:a84f:a6aa with SMTP id r7-20020a056902154700b00d43a84fa6aamr5454597ybu.39.1699849264126;
        Sun, 12 Nov 2023 20:21:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuE/Omh7ETDkhtAEC+3zelpWf91MkxxlfVCO0FA1pnNxNCnMWL4q2N7gIaAN7fVOCOVWdIYg==
X-Received: by 2002:a05:6902:1547:b0:d43:a84f:a6aa with SMTP id r7-20020a056902154700b00d43a84fa6aamr5454579ybu.39.1699849263873;
        Sun, 12 Nov 2023 20:21:03 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:21:03 -0800 (PST)
Message-ID: <227771fa-1f22-4b9d-81f5-709f4f0c68c9@redhat.com>
Date:   Mon, 13 Nov 2023 14:20:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/22] LoongArch: Switch over to GENERIC_CPU_DEVICES
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
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMB-00CTyJ-08@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMB-00CTyJ-08@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 20:30, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> This allows topology_init() to be removed.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> This is a subtle change. Originally:
> - on boot, topology_init() would have marked present CPUs that
>    io_master() is true for as hotplug-incapable.
> - if a CPU is hotplugged that is an io_master(), it can later be
>    hot-unplugged.
> 
> The new behaviour is that any CPU that io_master() is true for will
> now always be marked as hotplug-incapable, thus even if it was
> hotplugged, it can no longer be hot-unplugged.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   * Explain the change in behaviour in the patch description
>     (highlighted by Jonathan Cameron - thanks.) Add note about
>     initialisation order change.
> ---
>   arch/loongarch/Kconfig           |  1 +
>   arch/loongarch/kernel/topology.c | 29 ++---------------------------
>   2 files changed, 3 insertions(+), 27 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

