Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9037A5800
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjISDwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjISDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA08FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695095508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8rJDvUqOXwqZuoo1W57hjmHySlMvZ2epmiMYH9qiJQ=;
        b=PACxhpoAibkm8pCtRlEDCKD/Z/Qwax0BNXQCW+TRj2KpX9j9aUX7lHdvmUH3qBk7qqUxYR
        J+sSO789xW69eNcMxsYAG9/YL2/UphO4FA6xpRWxY5cBpyyCy0CE9TlurjX9GVM9N+NhI3
        EAsm0VbU0QrFrDrwHj34GQ/IQxnk3+s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-WpYNb0sfP2GjOjb4wTT4Cw-1; Mon, 18 Sep 2023 23:51:46 -0400
X-MC-Unique: WpYNb0sfP2GjOjb4wTT4Cw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-274c4e3da1aso1515347a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095506; x=1695700306;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8rJDvUqOXwqZuoo1W57hjmHySlMvZ2epmiMYH9qiJQ=;
        b=LbMyTNtWmGgjZf5YA/h+naIJk9Cvs77++EwgWu21XEgCGMaScO1d83ObgwGIGOARjU
         YxxyHp/bt1TXDypSxdcVy8NXkijGY9fmKW6iNB1jL0ikQVzsvE7i9dQKqSAKlK6TbP9A
         2iFs2HHYFof1zW25Mm/C8gwYWnSsVIUSxXDyW6lpSTIs3IDO+4HEMolwMQ5U+bosPx+M
         3toMx4i1lUE8GlKQ/Z0pfFqCV5an0ZT3idwOfyp9rubInVncH/iVxrXfx4Ie2yRu0pfV
         0ZxKRPgfLGA8uChgt1PtmqAe/Aj42QsUK5BechtnnPF/zO0FYsBqHixfyi8hom+r7IwE
         HSIQ==
X-Gm-Message-State: AOJu0YwMUWoxo9J/oSXZsCdPSR3JMvJ0E4RGzB3l8/X09pUGHzfejsLn
        byUNG4iMWIkm0P3TxfK0k5l092msHMqxM8AcFtv9ClditBJFXn5xtKbXk8eaDBN3Itk8xdtc9fk
        GmJRtSEiIaR80RXIkyjUIbNHi
X-Received: by 2002:a17:90b:393:b0:274:655f:123a with SMTP id ga19-20020a17090b039300b00274655f123amr8825722pjb.17.1695095505872;
        Mon, 18 Sep 2023 20:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg0kbAirHQhF0f0R4Sjz7foDaanW0mDe+I8wg3s4HDKIw22zzaFMTZTEDJCKk2e/bcWdSB1Q==
X-Received: by 2002:a17:90b:393:b0:274:655f:123a with SMTP id ga19-20020a17090b039300b00274655f123amr8825704pjb.17.1695095505561;
        Mon, 18 Sep 2023 20:51:45 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id x34-20020a17090a6c2500b002684b837d88sm8566963pjj.14.2023.09.18.20.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 20:51:44 -0700 (PDT)
Message-ID: <0743752e-fd7a-c0b6-a193-196aef12b2a3@redhat.com>
Date:   Tue, 19 Sep 2023 13:51:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 29/35] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Content-Language: en-US
From:   Gavin Shan <gshan@redhat.com>
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-30-james.morse@arm.com>
 <31fa3aa7-c12c-3eb7-e9d2-5967a735ac78@redhat.com>
In-Reply-To: <31fa3aa7-c12c-3eb7-e9d2-5967a735ac78@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 13:39, Gavin Shan wrote:
> 
> On 9/14/23 02:38, James Morse wrote:
>> gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
>> It should only count the number of enabled redistributors, but it
>> also tries to sanity check the GICC entry, currently returning an
>> error if the Enabled bit is set, but the gicr_base_address is zero.
>>
>> Adding support for the online-capable bit to the sanity check
>> complicates it, for no benefit. The existing check implicitly
>> depends on gic_acpi_count_gicr_regions() previous failing to find
>> any GICR regions (as it is valid to have gicr_base_address of zero if
>> the redistributors are described via a GICR entry).
>>
>> Instead of complicating the check, remove it. Failures that happen
>> at this point cause the irqchip not to register, meaning no irqs
>> can be requested. The kernel grinds to a panic() pretty quickly.
>>
>> Without the check, MADT tables that exhibit this problem are still
>> caught by gic_populate_rdist(), which helpfully also prints what
>> went wrong:
>> | CPU4: mpidr 100 has no re-distributor!
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
> 
> With below nits resolved:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 72d3cdebdad1..0f54811262eb 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -2415,21 +2415,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>>       /*
>>        * If GICC is enabled and has valid gicr base address, then it means
>> -     * GICR base is presented via GICC
>> +     * GICR base is presented via GICC. The redistributor is only known to
>> +     * be accessible if the GICC is marked as enabled. If this bit is not
>> +     * set, we'd need to add the redistributor at runtime, which isn't
>> +     * supported.
>>        */
>> -    if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
>> +    if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
>>           acpi_data.enabled_rdists++;
>> -        return 0;
>> -    }
> 
>      if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> 

Please ignore this since acpi_gicc_is_usable() is changed to cover
the bit ACPI_MADT_GICC_CPU_CAPABLE in next patch, which means
"(gicc->flags & ACPI_MADT_ENABLED)" is needed here.

> 
>> -    /*
>> -     * It's perfectly valid firmware can pass disabled GICC entry, driver
>> -     * should not treat as errors, skip the entry instead of probe fail.
>> -     */
>> -    if (!acpi_gicc_is_usable(gicc))
>> -        return 0;
>> -
>> -    return -ENODEV;
>> +    return 0;
>>   }
>>   static int __init gic_acpi_count_gicr_regions(void)

Thanks,
Gavin

