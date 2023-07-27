Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745A765053
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjG0JxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjG0JxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0B9C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690451543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=do+1XQ4XtuaJ5dTD1s4r7DH6OWn683D2dxF2fQV74s4=;
        b=gy1Dq8YCIu+4w2aQo7KKi4w2aDh7Siv7WhcHDjlSU01t8fL94J2t7jNJdGSI3mvbDXJ9IK
        oxu4bEPSbtmVxG6krzvTqDcFUbq/gpR65jtKqfy96FeuTuUTCwCh6eLfgszrxHA9VOv1sk
        TopMgRoURwHM4uE1EEA+BFhHMGUhNl8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-zkybDLQzM4GQw-1yU-UIMw-1; Thu, 27 Jul 2023 05:52:21 -0400
X-MC-Unique: zkybDLQzM4GQw-1yU-UIMw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe0800f960so779869e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690451539; x=1691056339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=do+1XQ4XtuaJ5dTD1s4r7DH6OWn683D2dxF2fQV74s4=;
        b=LeIgLLPPlEaWeiZF6kKPCGgUq+VEjuAy0rPLZ4GiHVyoSRLIBFee7tlAlXCPTwQVYh
         rftvySJFzvv5TLlW0Qco1RD8HPG97AHn7Ha8c+DXheulSU43OFqXXinfZGACWEC9bKcj
         LVdOfm3jHv/00DR1tdxEg+AOI/C5kWQf4EmdJtQgCqR7X1aoEkNzJ1ZOCIErENcTfFbB
         UcqFrDRUnROW3eNpwbbMEr/urmYQUW2KKLNydrsUmiARvAVQmnSCklL/fCRzhSQ4RUhi
         ADdInpvPmEId/6ZalSLD4p/CRiqvNZUYUo5OFCDSwvz18bXun3sYoC+x6x3OD38CHNFS
         6eGQ==
X-Gm-Message-State: ABy/qLYAK1ZDe2cIwyZdznM6LAkgXTAHscpBNn54FXjhUep72fNFuEnz
        sA9hymeyY8Tacg3dAKHMFVmyaNWHBNgx/LUdUSiFNtVR4UuNlfO673o68wdKMm1isQ5b9p4mUb9
        7q4/vBdRx32mWMgwNtwah2ikr
X-Received: by 2002:ac2:58fb:0:b0:4fa:6d62:9219 with SMTP id v27-20020ac258fb000000b004fa6d629219mr1338487lfo.62.1690451539699;
        Thu, 27 Jul 2023 02:52:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJ/eGPBhLAqWIqlahW0bh9+SgNxedHbs2vmptxN14TdlSE0ZUHKbuNVdVqNuo7/CavtrHqWg==
X-Received: by 2002:ac2:58fb:0:b0:4fa:6d62:9219 with SMTP id v27-20020ac258fb000000b004fa6d629219mr1338472lfo.62.1690451539355;
        Thu, 27 Jul 2023 02:52:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7db93000000b0051e1660a34esm445825edt.51.2023.07.27.02.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:52:18 -0700 (PDT)
Message-ID: <75da106c-3f00-7be9-d4d5-c83f1e1664bb@redhat.com>
Date:   Thu, 27 Jul 2023 11:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: scan: Create platform device for CS35L56
Content-Language: en-US, nl
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, rafael@kernel.org,
        lenb@kernel.org, markgross@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <20230726112759.18814-1-rf@opensource.cirrus.com>
 <33cdbf63-8fe4-da7e-5d36-6e63fe303b24@redhat.com>
 <42399566-2d25-e888-7226-05a86767b644@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <42399566-2d25-e888-7226-05a86767b644@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/27/23 11:48, Richard Fitzgerald wrote:
> On 26/7/23 15:13, Hans de Goede wrote:
>> Hi Richard,
>>
>> On 7/26/23 13:27, Richard Fitzgerald wrote:
>>> From: Simon Trimmer <simont@opensource.cirrus.com>
>>>
>>> The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
>>> is used in multiples, and can be connected either to I2C or SPI.
>>>
>>> There will be multiple instances under the same Device() node. Add it
>>> to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
>>> driver.
>>>
>>> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> I have 1 other serial-multi-instantiate.c patches in my fixes branch (see below) and since this just adds new hw-ids I think this can go upstream through my fixes branch too.
>>
>> Rafael, do you agree with me taking this upstream as a 6.5 fix? And if yes may I have your ack for that ?
>>
>> About that 1 patch, that adds a new IRQ type: IRQ_RESOURCE_AUTO and I wonder if this patch should not use that same new type right from the start:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/agit/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=676b7c5ecab36274442887ceadd6dee8248a244f
>>
> 
> Link doesn't work, but I think you mean:
> https://lore.kernel.org/platform-driver-x86/b9f81a5b-0511-9950-5a20-9e6cbd92d085@redhat.com/T/#t

Right an "a" (probably from ctrl + a) snuk in there, correct link:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=676b7c5ecab36274442887ceadd6dee8248a244f

Which is indeed the same patch as you linked.

> I'll send a V2 of this CS35L56 patch to use the new IRQ_RESOURCE_AUTO.

Thanks.

Regards,

Hans




