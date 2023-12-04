Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1234B804074
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjLDU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjLDUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F6F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701720807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qN1XS3PUQh/SNdnH3l3+prVnbHkxP15eE1jftD1eXYs=;
        b=gMQdTPELRHCp8KBHdKHPtae0uEMXvDesTJskt0BO/sFvrJcZpxxr2hIVl6vFLu84tdt8QG
        s5tlR9lB3w0YJBEan07dn8YaGVOU/ojfcgmjKN8ZO5BKh8z60utDD0hCsJT4C+Yym18ZVH
        +RCP2uVkk1MENW7ysEXnzvqmAcON57s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-0k4R4J1OMve4BtuwY7CMSA-1; Mon, 04 Dec 2023 15:13:26 -0500
X-MC-Unique: 0k4R4J1OMve4BtuwY7CMSA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1b466b0d24so100015266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720804; x=1702325604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qN1XS3PUQh/SNdnH3l3+prVnbHkxP15eE1jftD1eXYs=;
        b=AzFK3AFi6bS5ZA1yLIciKTv7n5aqddNGvRUKYa8mwZWHQYtvLzMIxFUvWcrNmA7b0A
         fBzIWSYmayMPw5BfXpkrqRqNw/3KGdGLdMbSRdB/Gv3EEivzfx7QoPnli243DFyEYOC8
         dC6QLa0GlwvVtQbquRjtA1cCSFEGWggOgoTOoc13q4E0GSmpMtfpp5hkgRRS3vy+xJaz
         ZYwqHtjJ5l5WFD94Weqb2q7y7Vgvtgw+5rw2RXH1Su5NRlmELlrjRhgV1SIFqlODj+QF
         08Naif9TfsCPnVV63ZoLdGbZ/IiFcvm8LVeD4A6Yf3gzzEnKvMZwM68UMX0qh7OkGqVA
         Uy4A==
X-Gm-Message-State: AOJu0Yy9lOMNZt/C0AxSuj8az+EdMaDlqGRDF+RI6JPQpWN6plZhEWyB
        hBkL+Vlrrk1JYwCQfupWqU9KE9TxQ5qq+p7BKdv+Z37tjv5ZHTytK4lNpGHk5dof/ZkQhEUGmxp
        TSnDdJLUGd4p6CBYweEu4K/38uqUNpgD3
X-Received: by 2002:a17:906:f208:b0:a19:a1ba:bac1 with SMTP id gt8-20020a170906f20800b00a19a1babac1mr1760283ejb.103.1701720804520;
        Mon, 04 Dec 2023 12:13:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG12sa5b7+OknahXWvg9yd0qj58CQVbsVs+TZzhIj6nsfRZSX/F6rgqg/YLanQEjq6/MLCeEw==
X-Received: by 2002:a17:906:f208:b0:a19:a1ba:bac1 with SMTP id gt8-20020a170906f20800b00a19a1babac1mr1760277ejb.103.1701720804225;
        Mon, 04 Dec 2023 12:13:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170906f9c800b009fe1dd221a3sm5614430ejb.92.2023.12.04.12.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 12:13:23 -0800 (PST)
Message-ID: <f7c8db7e-0b2a-4afc-96c6-da5baddf696e@redhat.com>
Date:   Mon, 4 Dec 2023 21:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 01/20] platform/x86/intel/vsec: Fix xa_alloc memory
 leak
Content-Language: en-US, nl
To:     david.e.box@linux.intel.com,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
 <20231129222132.2331261-2-david.e.box@linux.intel.com>
 <5c21230-1176-4168-f31f-a0c1f1713ca8@linux.intel.com>
 <f2a3bab9-296c-43a1-9b7e-944c5044feaf@redhat.com>
 <198aadd7a91152393ec56d421fa042d30378af40.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <198aadd7a91152393ec56d421fa042d30378af40.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 20:57, David E. Box wrote:
> Hi Hans,
> 
> On Mon, 2023-12-04 at 14:51 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/30/23 12:02, Ilpo Järvinen wrote:
>>> On Wed, 29 Nov 2023, David E. Box wrote:
>>>
>>>> Commit 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery
>>>> support to Intel PMT") added an xarray to track the list of vsec devices
>>>> to
>>>> be recovered after a PCI error. But it did not provide cleanup for the
>>>> list
>>>> leading to a memory leak that was caught by kmemleak.  Do xa_alloc()
>>>> before
>>>> devm_add_action_or_reset() so that the list may be cleaned up with
>>>> xa_erase() in the release function.
>>>>
>>>> Fixes: 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery
>>>> support to Intel PMT")
>>>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>>>> ---
>>>>
>>>> V6 - Move xa_alloc() before ida_alloc() to reduce mutex use during error
>>>>      recovery.
>>>>    - Fix return value after id_alloc() fail
>>>>    - Add Fixes tag
>>>>    - Add more detail to changelog
>>>>
>>>> V5 - New patch
>>>>
>>>>  drivers/platform/x86/intel/vsec.c | 24 ++++++++++++++----------
>>>>  drivers/platform/x86/intel/vsec.h |  1 +
>>>>  2 files changed, 15 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/vsec.c
>>>> b/drivers/platform/x86/intel/vsec.c
>>>> index c1f9e4471b28..2d568466b4e2 100644
>>>> --- a/drivers/platform/x86/intel/vsec.c
>>>> +++ b/drivers/platform/x86/intel/vsec.c
>>>> @@ -120,6 +120,8 @@ static void intel_vsec_dev_release(struct device *dev)
>>>>  {
>>>>         struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
>>>>  
>>>> +       xa_erase(&auxdev_array, intel_vsec_dev->id);
>>>> +
>>>>         mutex_lock(&vsec_ida_lock);
>>>>         ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
>>>>         mutex_unlock(&vsec_ida_lock);
>>>> @@ -135,19 +137,27 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct
>>>> device *parent,
>>>>         struct auxiliary_device *auxdev = &intel_vsec_dev->auxdev;
>>>>         int ret, id;
>>>>  
>>>> -       mutex_lock(&vsec_ida_lock);
>>>> -       ret = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
>>>> -       mutex_unlock(&vsec_ida_lock);
>>>> +       ret = xa_alloc(&auxdev_array, &intel_vsec_dev->id, intel_vsec_dev,
>>>> +                      PMT_XA_LIMIT, GFP_KERNEL);
>>>>         if (ret < 0) {
>>>>                 kfree(intel_vsec_dev->resource);
>>>>                 kfree(intel_vsec_dev);
>>>>                 return ret;
>>>>         }
>>>>  
>>>> +       mutex_lock(&vsec_ida_lock);
>>>> +       id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
>>>> +       mutex_unlock(&vsec_ida_lock);
>>>> +       if (id < 0) {
>>>> +               kfree(intel_vsec_dev->resource);
>>>> +               kfree(intel_vsec_dev);
>>>> +               return id;
>>>
>>> Thanks, this looks much better this way around but it is missing 
>>> xa_alloc() rollback now that the order is reversed.
>>>
>>> Once that is fixed,
>>>
>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> I have fixed this up, adding the missing:
>>
>>         xa_erase(&auxdev_array, intel_vsec_dev->id);
>>
>> to this error-exit path while merging this.
> 
> Thanks. Does that include the rest of the series which was all reviewed by Ilpo?

Yes the entire series has been merged into the pdx86/review-hans
branch now.

Regards,

Hans


