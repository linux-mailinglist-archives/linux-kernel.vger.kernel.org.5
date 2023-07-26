Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E1763304
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGZKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGZKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7BD97
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690365586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVOyTWwN9Q13QCx/JfIvmmBuDC7RYEzHX3a/Q1Fgmgw=;
        b=Qiqpgm4qxgI9Opni/fL4UhXdnal31QDzQekb1fCGP2/BFjVGyugdpOWumsHZkGBNYr64N7
        mXxKH9wGuZosR4kGEM97jsC9eG1JB70W/rDN+Uc+8vt7nw1ubiamdLaYnW5+EuyfdOVy17
        tLkmn5C4uqrLnMtm9/RKQkW1KckCZI0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-OMja6vkMNAu49GEVJ64LIA-1; Wed, 26 Jul 2023 05:59:45 -0400
X-MC-Unique: OMja6vkMNAu49GEVJ64LIA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bc711a20eso34619966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690365584; x=1690970384;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVOyTWwN9Q13QCx/JfIvmmBuDC7RYEzHX3a/Q1Fgmgw=;
        b=UpTia0TEnJvaULmGvqiK/bPUgmQZkxYzckIXhhpVFvF3JnFaAFMjjyba2SIROuQMmZ
         iPoLrcu5wDjsshdDvApkV6t/CJs0et4GyVAFVT5PFZk7vsNwbOHX4UIfWjrpsKjVloGQ
         wbV2M9K7fvGnqGggn134wO9lg4wrsh2S/ugsBUB8q9XDn8imp4vTzI+0JPMI/1TM0pvI
         hXIPUUkRSaDaaGv1ojN1RAiLRuRff3hDanlFFbAJWYgpEHVLxXKJL91MIWWaAYzOx+D7
         7nPuZflyskplgLINAJ7VpuPRiYkHFedtf4+kEm/yEGDmerCR4eLmB0aoJOaQSbIImGhi
         TYzw==
X-Gm-Message-State: ABy/qLbDuwIvt/ZihTZV2vHVstPjOe9gWNqkzg6YbR3EjfY7Ypl8El5Y
        X21maVtpxHlLbZVAl4H/Afw4g67F1LchtbadK5DUIP7UoCWXlHMwt4lM0//vn8mKdJZA8gbA2Sw
        FNKlCj3TA7M5/tyt4Tem6rvom
X-Received: by 2002:aa7:d8cb:0:b0:522:37da:7920 with SMTP id k11-20020aa7d8cb000000b0052237da7920mr1138487eds.12.1690365584077;
        Wed, 26 Jul 2023 02:59:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyirKI2xSuG9WU6w/oGg3yovawmkV8Hf6hUImstOr4dH/ALyBUvER0Pc/p9FtBDew1evoWUQ==
X-Received: by 2002:aa7:d8cb:0:b0:522:37da:7920 with SMTP id k11-20020aa7d8cb000000b0052237da7920mr1138479eds.12.1690365583707;
        Wed, 26 Jul 2023 02:59:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c26-20020aa7df1a000000b005222dd0b2fbsm3653670edy.92.2023.07.26.02.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:59:42 -0700 (PDT)
Message-ID: <85a51904-7598-b3cb-2fe1-b6da3626500c@redhat.com>
Date:   Wed, 26 Jul 2023 11:59:42 +0200
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
 <60c9f64f-d53b-72f2-5440-0eae18c9357d@redhat.com>
 <70ee1a69-e78a-108a-d2e7-3b6637d79fef@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <70ee1a69-e78a-108a-d2e7-3b6637d79fef@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

On 7/26/23 11:35, Armin Wolf wrote:
> Am 26.07.23 um 10:01 schrieb Hans de Goede:
> 
>> Hi,
>>
>> On 7/25/23 20:01, Armin Wolf wrote:
>>> Am 25.07.23 um 17:07 schrieb Hans de Goede:
>>>
>>>> Hi Armin,
>>>>
>>>> On 7/22/23 02:09, Armin Wolf wrote:
>>>>> Hello,
>>>>>
>>>>> i just noticed that under some circumstances, ACPI WMI devices might fail to reprobe
>>>>> when being manually unbound and later rebound.
>>>>> Example:
>>>>>
>>>>> 1. ACPI WMI device #1 binds and registers WMI device with GUID
>>>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>>>> being named "05901221-D566-11D1-B2F0-00A0C9062910".
>>>>> 2. ACPI WMI device #2 binds and registers WMI device with GUID
>>>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>>>> being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
>>>>> 3. ACPI WMI device #1 is manually unbound and later rebound,
>>>>> now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>>>> is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
>>>>> device naming depends on the number of GUIDs currently known to
>>>>> the WMI subsystem.
>>>>> 4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" already
>>>>> exists, causing the registration of the new WMI device to fail.
>>>>>
>>>>> I thought about some possible ways to solve this naming issue:
>>>>>
>>>>> - symlinks to simulate old WMI devices names, new WMI device names similar to "wmiX" with X being a global unique id
>>>>> - no symlinks, new WMI device names similar to "wmiX" with X being a global unique id
>>>>> - use global id instead of GUID number
>>>>>
>>>>> The first approach has full sysfs backward compatibility but i do not know how to create symlinks inside the "devices"
>>>>> directory. The second approach is the easiest and cleanest one, but provides no sysfs backward compatibility. The last
>>>>> approach provides only limited sysfs backward compatibility and only for programs which can handle "<GUID>-X" WMI device
>>>>> names.
>>>>>
>>>>> Currently, there is one single stable sysfs ABI entry concerning the WMI subsystem (for wmi-bmof), and two testing
>>>>> sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know of any userspace programs relying on these ABIs,
>>>>> but i suspect there might be a couple of scripts which might be affected.
>>>>>
>>>>> Which approach should i take to solve this problem?
>>>> The standard approach to get reliable unique ids in the kernel is to use
>>>> something like this:
>>>>
>>>> #include <linux/idr.h>
>>>>
>>>> static DEFINE_MUTEX(ida_lock);
>>>>
>>>> struct guid_data {
>>>>      guid_t guid;
>>>>      struct ida ida;
>>>>      struct list_head list;
>>>> };
>>>>
>>>> int guid_init() {
>>>>      ida_init(&guid_data->ida);
>>>> }
>>>>
>>>> int wmi_create_device()
>>>> {
>>>>      int index;
>>>>      ...
>>>>      mutex_lock(&ida_lock);
>>>>      index = ida_alloc(&guid_data->ida, GFP_KERNEL);
>>>>      mutex_unlock(&ida_lock);
>>>>      if (index < 0)
>>>>          return index;
>>>>
>>>>      // store index for use on acpi_wmi_remove
>>>>      wmi_block->index = index;
>>>>      // use index to generate name, don't add -%d for index==0
>>>>      ...
>>>> }
>>>>
>>>> static void wmi_dev_release(struct device *dev)
>>>> {
>>>>           struct wmi_block *wblock = dev_to_wblock(dev);
>>>>
>>>>      mutex_lock(&ida_lock);
>>>>      ida_free(&guid_data->ida, wblock->index);
>>>>      mutex_unlock(&ida_lock);
>>>>           kfree(wblock);
>>>> }
>>>>
>>>>
>>>> This is going to need a linked-list of struct guid_data
>>>> structs and a new wmi_get_guid_data() function which
>>>> takes a new global mutex to protect the list and then
>>>> first walks that list looking for a guid match
>>>>
>>>> If nothing is found kzalloc a new struct, init
>>>> the ida struct and add it to the list before releasing
>>>> the mutex protecting the list.
>>>>
>>>> At the end of wmi_get_guid_data() return the found
>>>> or created struct guid_data or NULL on kzalloc error.
>>>>
>>>> And in wmi_create_device() and wmi_dev_release()
>>>> use this to get a struct_guid_data matching the wblock
>>>> GUID so that we have 1 ida struct per GUID.
>>>>
>>>> I would not worry about releasing the struct guid_data
>>>> if somehow the last wblock with that GUID disappears
>>>> chances are we are going to need it again soon and
>>>> the ida id-array will be empty then so we will start
>>>> with a clean-slate if we just re-use the old one
>>>> when a new wblock with the same GUID shows up again.
>>>>
>>>> ###
>>>>
>>>> Not the prettiest with the need to have a new linked
>>>> lists of structs to get a per GUID ida, but it nicely
>>>> matches how most subsystems do this so I think it is
>>>> best.
>>>>
>>>> I hope this small sketch of what a solution for this
>>>> could look like is useful.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>> Would it be feasible to use the duplicate GUID allowlist instead?
>> Yes that is a good idea, if you make it non const you can just
>> store the ida struct there. You'll likely need to add some macro
>> to init the entries then which also inits the ida struct.
>>
>>> Since the issue does only exists on GUIDs which can be duplicated, only WMI devices handling those
>>> need a unique id after the GUID, the rest keeps the classic WMI device name.
>> ack.
>>
>>> This would also allow for individual WMI drivers to provide backwards compatibility in case userspace
>>> needs the old WMI device name for the WMI devices they control. If a WMI driver knows that userspace
>>> can handle the new WMI device name for his GUIDs, then they can just add them to the allowlist.
>> For backward compat I would still omit the "-%d" suffix for the wblock device which gets index 0, that should still be the same one as before.
>>
>> Regards,
>>
>> Hans
>>
>>
> There might be a misunderstanding here, i meant to propose to avoid this one-ida-for-each-guid thing and instead
> change the WMI device naming depending on whether the GUID is inside the allowlist:
> 
> - WMI driver cannot handle duplicate GUIDs and userspace requires old WMI device naming -> GUID not in allowlist, old WMI device name
> - WMI driver cannot handle duplicate GUIDs and userspace does not require old WMI device naming -> GUID not in allowlist, old WMI device name
> - WMI driver can handle duplicate GUIDs and userspace does require old WMI device naming -> GUID not in allowlist, old WMI device name
> - WMI driver can handle duplicate GUIDs and userspace does not require old WMI device naming -> GUID in allowlist, new WMI device name
> 
> The old WMI device name would be a simple GUID, while the new WMI device name would consist of the GUID and an unique id, which is always present.
> This would allow us to avoid another list of GUIDs while making sure that backwards compatibility for userspace is preserved.
> 
> This approach is simpler and faster than the list-based approach, and it would allow us to turn the allowlist into and denylist in the future.
> What do you think of this approach?

This means that as soon as a new GUID gets added to the allow-list, because it turns out 1 laptop model has 2 wblocks with the same GUID, that we then change the sysfs path for the wmi device also for all the other laptop models which only have the GUID once. Which may very well cause issues for userspace. So I'm not really a fan of this approach.

But I do like the idea of using the allow-list to see if we need an ida at all (since we don't need the index for GUIDs not on the allow list). So we can then change the allow-list from an array of strings with allowed GUIDs to an array of structs with a guid_t + an ida struct in there.

Then we can also use GUID_INIT() to directly fill a guid_t in the allow-list saving us the guid_parse() call which is currently done to check entries on the allow-list.

GUID_INIT should then probably be wrapped in a new macro e.g.

#define ALLOW_GUID(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)	{ \
	.guid = GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7), \
	.ida = IDR_INIT(ERROR), \
	}

ok so that won't work, the ERROR above needs to be the .ida member, but I'm pretty
sure that writing:

	.ida = IDR_INIT(.ida),

is not allowed (worth a shot though I guess).

So I think we would need something slightly more involved like this:

struct wmi_allow_guid {
	struct guid_t guid;
	struct ida ida;
};

#define ALLOW_GUID(index, a, b, c, d0, d1, d2, d3, d4, d5, d6, d7) \
	[index] = { \
		.guid = GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7), \
		.ida = IDR_INIT(allow_duplicates[index].ida), \
	}

struct wmi_allow_guid allow_duplicates[] = {
	ALLOW_GUID(0, a, b, c, d0, d1, d2, d3, d4, d5, d6, d7),
	ALLOW_GUID(1, a, b, c, d0, d1, d2, d3, d4, d5, d6, d7),
};

Regards,

Hans


