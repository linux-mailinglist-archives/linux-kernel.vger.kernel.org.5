Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE24762F57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjGZIKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjGZIKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446A6A61
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690358522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VZnODAdGbREQMbHOw1LLCZSQAoP+39Rk+Ko12t+I+Q=;
        b=I/AaxEKlsn/zAMeiPVfBZbWEE3hhL1m8GdzCi58/qwEaukD9Z8tEnFsLTjDuryvbZMcJim
        zyL5zgqTI1aAYh0FCJUVVGAOezgzjTzAfvixobv6JeOy0jiphuN10524rLqIFcuQynNdHy
        vyVquk8bCuxfoKeGBllHuxFIfss/EX4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-FVl0S0BoMyS_nSRyJ_h4Sg-1; Wed, 26 Jul 2023 04:01:59 -0400
X-MC-Unique: FVl0S0BoMyS_nSRyJ_h4Sg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355c9028so460994766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358518; x=1690963318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VZnODAdGbREQMbHOw1LLCZSQAoP+39Rk+Ko12t+I+Q=;
        b=NoR/g+eMOREXYcTz7jpgzLN0XaD1ZpA0n3QJgNGllSsvITBscilIQRm4/z79KVIyaO
         XPffWnkVM4EReuAItKMn7b8OkK1hft8uRzmuzBaWsdtqBthJ0b/LdUPVjJxYqFdkEhKu
         jsAlrohsXljD3APTuNgchU/7lf9sPwp77K6PvsyzXrPPjxoGIaepC78WMC2TvcWy6m/r
         SPqgMLW+8cMMzpdX3NAarEEFdx2gK0vbzQORi52GZ0eYhNy6bJJ77SAToCMLPEYswRx+
         nCFz2+/iNbue9RHJGGHLGGzfbu53XWv/4RWU2A3zswiH8MIJIR6kNNK48MBmQaaxaC/X
         j8yA==
X-Gm-Message-State: ABy/qLZcDtYgBVYsqlY2R7ElxecleoTHnLsulOPU/q8gB8PiG5Uf7JR5
        Z9vj0V79kYqoUX0iFRKrr+lICjV5rn/KQdBBnbr3uDNF1ZJlNgzMZF7cqX2xDMQzQqmgeNcRalH
        Rf5E8rilYEcZagipF5bIkkJWW
X-Received: by 2002:a17:906:101b:b0:99b:4378:a5ab with SMTP id 27-20020a170906101b00b0099b4378a5abmr1024260ejm.74.1690358518671;
        Wed, 26 Jul 2023 01:01:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGaeosLOMAlXgEYThSUVL//fAmSARS37vWr6pEmCAsmmqoXXrDLneG0WAUoE9rGveU9eAFc7g==
X-Received: by 2002:a17:906:101b:b0:99b:4378:a5ab with SMTP id 27-20020a170906101b00b0099b4378a5abmr1024241ejm.74.1690358518364;
        Wed, 26 Jul 2023 01:01:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709060a4200b00992ddf46e65sm9171546ejf.46.2023.07.26.01.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:01:57 -0700 (PDT)
Message-ID: <60c9f64f-d53b-72f2-5440-0eae18c9357d@redhat.com>
Date:   Wed, 26 Jul 2023 10:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: WMI probe failure when reprobing
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
 <d219e8b4-f57e-a546-3794-6f6bc7030e9e@redhat.com>
 <0062ade3-bff2-781f-0e31-ce3bdcf6942e@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0062ade3-bff2-781f-0e31-ce3bdcf6942e@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/25/23 20:01, Armin Wolf wrote:
> Am 25.07.23 um 17:07 schrieb Hans de Goede:
> 
>> Hi Armin,
>>
>> On 7/22/23 02:09, Armin Wolf wrote:
>>> Hello,
>>>
>>> i just noticed that under some circumstances, ACPI WMI devices might fail to reprobe
>>> when being manually unbound and later rebound.
>>> Example:
>>>
>>> 1. ACPI WMI device #1 binds and registers WMI device with GUID
>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>> being named "05901221-D566-11D1-B2F0-00A0C9062910".
>>> 2. ACPI WMI device #2 binds and registers WMI device with GUID
>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>> being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
>>> 3. ACPI WMI device #1 is manually unbound and later rebound,
>>> now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>> is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
>>> device naming depends on the number of GUIDs currently known to
>>> the WMI subsystem.
>>> 4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" already
>>> exists, causing the registration of the new WMI device to fail.
>>>
>>> I thought about some possible ways to solve this naming issue:
>>>
>>> - symlinks to simulate old WMI devices names, new WMI device names similar to "wmiX" with X being a global unique id
>>> - no symlinks, new WMI device names similar to "wmiX" with X being a global unique id
>>> - use global id instead of GUID number
>>>
>>> The first approach has full sysfs backward compatibility but i do not know how to create symlinks inside the "devices"
>>> directory. The second approach is the easiest and cleanest one, but provides no sysfs backward compatibility. The last
>>> approach provides only limited sysfs backward compatibility and only for programs which can handle "<GUID>-X" WMI device
>>> names.
>>>
>>> Currently, there is one single stable sysfs ABI entry concerning the WMI subsystem (for wmi-bmof), and two testing
>>> sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know of any userspace programs relying on these ABIs,
>>> but i suspect there might be a couple of scripts which might be affected.
>>>
>>> Which approach should i take to solve this problem?
>>
>> The standard approach to get reliable unique ids in the kernel is to use
>> something like this:
>>
>> #include <linux/idr.h>
>>
>> static DEFINE_MUTEX(ida_lock);
>>
>> struct guid_data {
>>     guid_t guid;
>>     struct ida ida;
>>     struct list_head list;
>> };
>>
>> int guid_init() {
>>     ida_init(&guid_data->ida);
>> }
>>
>> int wmi_create_device()
>> {
>>     int index;
>>     ...
>>     mutex_lock(&ida_lock);
>>     index = ida_alloc(&guid_data->ida, GFP_KERNEL);
>>     mutex_unlock(&ida_lock);
>>     if (index < 0)
>>         return index;
>>
>>     // store index for use on acpi_wmi_remove
>>     wmi_block->index = index;
>>     // use index to generate name, don't add -%d for index==0
>>     ...
>> }
>>
>> static void wmi_dev_release(struct device *dev)
>> {
>>          struct wmi_block *wblock = dev_to_wblock(dev);
>>
>>     mutex_lock(&ida_lock);
>>     ida_free(&guid_data->ida, wblock->index);
>>     mutex_unlock(&ida_lock);
>>          kfree(wblock);
>> }
>>
>>
>> This is going to need a linked-list of struct guid_data
>> structs and a new wmi_get_guid_data() function which
>> takes a new global mutex to protect the list and then
>> first walks that list looking for a guid match
>>
>> If nothing is found kzalloc a new struct, init
>> the ida struct and add it to the list before releasing
>> the mutex protecting the list.
>>
>> At the end of wmi_get_guid_data() return the found
>> or created struct guid_data or NULL on kzalloc error.
>>
>> And in wmi_create_device() and wmi_dev_release()
>> use this to get a struct_guid_data matching the wblock
>> GUID so that we have 1 ida struct per GUID.
>>
>> I would not worry about releasing the struct guid_data
>> if somehow the last wblock with that GUID disappears
>> chances are we are going to need it again soon and
>> the ida id-array will be empty then so we will start
>> with a clean-slate if we just re-use the old one
>> when a new wblock with the same GUID shows up again.
>>
>> ###
>>
>> Not the prettiest with the need to have a new linked
>> lists of structs to get a per GUID ida, but it nicely
>> matches how most subsystems do this so I think it is
>> best.
>>
>> I hope this small sketch of what a solution for this
>> could look like is useful.
>>
>> Regards,
>>
>> Hans
>>
> Would it be feasible to use the duplicate GUID allowlist instead?

Yes that is a good idea, if you make it non const you can just
store the ida struct there. You'll likely need to add some macro
to init the entries then which also inits the ida struct.

> Since the issue does only exists on GUIDs which can be duplicated, only WMI devices handling those
> need a unique id after the GUID, the rest keeps the classic WMI device name.

ack.

> This would also allow for individual WMI drivers to provide backwards compatibility in case userspace
> needs the old WMI device name for the WMI devices they control. If a WMI driver knows that userspace
> can handle the new WMI device name for his GUIDs, then they can just add them to the allowlist.

For backward compat I would still omit the "-%d" suffix for the wblock device which gets index 0, that should still be the same one as before.

Regards,

Hans


