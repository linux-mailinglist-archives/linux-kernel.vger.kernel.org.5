Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0248D761CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGYPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGYPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A22128
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690297670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNkAEDZVZvxUR8T546/ZSrhkNJAUNtW/hfcbCqkIquo=;
        b=RVmPDOwYYOAcWynqh1TUFk0bVjQ41Ve638JjLJ1G7FLloSOqgml0H5ZiqTgrYr6T8G1wi/
        likEg1WKxBxZpgYMsmUiFk0XPgov0+McAE1lZ/fuDES6jn04f/SUQmminnMHIr+hH1Nyus
        /VNKyh6sQ9dg9+8jfCpIujlIoMDWR5Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-p3esoWE0NESHITQ1PVjwFA-1; Tue, 25 Jul 2023 11:07:48 -0400
X-MC-Unique: p3esoWE0NESHITQ1PVjwFA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993e73a4c4fso448888766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297667; x=1690902467;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNkAEDZVZvxUR8T546/ZSrhkNJAUNtW/hfcbCqkIquo=;
        b=Vi2VACv1t+KFu0RYv7W6FcXk3fjwmqozhe+D1lBhx33RTNdz+T3suwyCrsdRgGuxkc
         waYkcmoYR4LQbTsa/XjZv5siHJv/GUePyNt9meyZb3MW9uxAhKFIZFP8bEhA2aJ+msyu
         vr1yBNRXWQ7X4qecBDgs0t4U6uDOAtEpKcLaq4W2A3WCYO1uXYwjjJHQDHezx+Ndd7CT
         MTjGGkyTVXxKcvu6kXC19JnZ2hryQ+Gv3gJXtT+7RA7nKqlOJNv6ydKQy5MvnI1np8He
         9FbaNTkZolDDkO7r5uWo6jc2vYaZIzITbKWwhaBIvDZAhIQQUZOIgzSLcRk19gM9xmqF
         T+JA==
X-Gm-Message-State: ABy/qLYcsWFZ/6F3wHI4Kpy9xRComHHjS7dFa9KPGhsW2rDx/BYaTsM/
        Av55RSR8+g37b4Mnfe5sORs2RFdRamqQeWzxmyaR/lN8msKglKatB98i/vmlnvFu8V+suq3uRKk
        fSJFJVoiXfo7Ly+OwhX3Vr1Sn
X-Received: by 2002:a17:906:cc58:b0:994:292c:5f1e with SMTP id mm24-20020a170906cc5800b00994292c5f1emr11625279ejb.29.1690297667193;
        Tue, 25 Jul 2023 08:07:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEw5cb03g00tewc+fDYC5mUWl7khQF2KmFn6CT1iXjmGxjS9Z22dll5RnSJI08ENJhpra9zTw==
X-Received: by 2002:a17:906:cc58:b0:994:292c:5f1e with SMTP id mm24-20020a170906cc5800b00994292c5f1emr11625263ejb.29.1690297666892;
        Tue, 25 Jul 2023 08:07:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090633cc00b0099275c59bc9sm8268991eja.33.2023.07.25.08.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:07:46 -0700 (PDT)
Message-ID: <d219e8b4-f57e-a546-3794-6f6bc7030e9e@redhat.com>
Date:   Tue, 25 Jul 2023 17:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: WMI probe failure when reprobing
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 7/22/23 02:09, Armin Wolf wrote:
> Hello,
> 
> i just noticed that under some circumstances, ACPI WMI devices might fail to reprobe
> when being manually unbound and later rebound.
> Example:
> 
> 1. ACPI WMI device #1 binds and registers WMI device with GUID
> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
> being named "05901221-D566-11D1-B2F0-00A0C9062910".
> 2. ACPI WMI device #2 binds and registers WMI device with GUID
> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
> being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
> 3. ACPI WMI device #1 is manually unbound and later rebound,
> now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
> device naming depends on the number of GUIDs currently known to
> the WMI subsystem.
> 4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" already
> exists, causing the registration of the new WMI device to fail.
> 
> I thought about some possible ways to solve this naming issue:
> 
> - symlinks to simulate old WMI devices names, new WMI device names similar to "wmiX" with X being a global unique id
> - no symlinks, new WMI device names similar to "wmiX" with X being a global unique id
> - use global id instead of GUID number
> 
> The first approach has full sysfs backward compatibility but i do not know how to create symlinks inside the "devices"
> directory. The second approach is the easiest and cleanest one, but provides no sysfs backward compatibility. The last
> approach provides only limited sysfs backward compatibility and only for programs which can handle "<GUID>-X" WMI device
> names.
> 
> Currently, there is one single stable sysfs ABI entry concerning the WMI subsystem (for wmi-bmof), and two testing
> sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know of any userspace programs relying on these ABIs,
> but i suspect there might be a couple of scripts which might be affected.
> 
> Which approach should i take to solve this problem?


The standard approach to get reliable unique ids in the kernel is to use
something like this:

#include <linux/idr.h>

static DEFINE_MUTEX(ida_lock);

struct guid_data {
	guid_t guid;
	struct ida ida;
	struct list_head list;
};

int guid_init() {
	ida_init(&guid_data->ida);
}

int wmi_create_device()
{
	int index;
	...
	mutex_lock(&ida_lock);
	index = ida_alloc(&guid_data->ida, GFP_KERNEL);
	mutex_unlock(&ida_lock);
	if (index < 0)
		return index;

	// store index for use on acpi_wmi_remove
	wmi_block->index = index;
	// use index to generate name, don't add -%d for index==0
	...
}

static void wmi_dev_release(struct device *dev)
{
        struct wmi_block *wblock = dev_to_wblock(dev);

	mutex_lock(&ida_lock);
	ida_free(&guid_data->ida, wblock->index);
	mutex_unlock(&ida_lock);	
        kfree(wblock);
}


This is going to need a linked-list of struct guid_data
structs and a new wmi_get_guid_data() function which
takes a new global mutex to protect the list and then
first walks that list looking for a guid match

If nothing is found kzalloc a new struct, init
the ida struct and add it to the list before releasing
the mutex protecting the list.

At the end of wmi_get_guid_data() return the found
or created struct guid_data or NULL on kzalloc error.

And in wmi_create_device() and wmi_dev_release()
use this to get a struct_guid_data matching the wblock
GUID so that we have 1 ida struct per GUID.

I would not worry about releasing the struct guid_data
if somehow the last wblock with that GUID disappears
chances are we are going to need it again soon and
the ida id-array will be empty then so we will start
with a clean-slate if we just re-use the old one
when a new wblock with the same GUID shows up again.

###

Not the prettiest with the need to have a new linked
lists of structs to get a per GUID ida, but it nicely
matches how most subsystems do this so I think it is
best.

I hope this small sketch of what a solution for this
could look like is useful.

Regards,

Hans



