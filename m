Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB77801D05
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjLBNUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:20:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7676F3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701523245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZttw52m3Y5BO6pRmTs4fgflOUqVdmw26+ZPrsBdZjU=;
        b=bjOVjawIBqzxU6JsrOG0JHx1OyThriw5SmPTEmKFJlJ39mY2R6dx/4qRCivFbastMfmQbx
        ELzm325C9Erv2U6FtjOT8QG7b2xOA/pVvePvOPuznyHGGUTjA0QA1Verax18MJ5w8pQLpV
        GEho2jgMncYTJOjzhdVfqeqCuaVrmdA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-I0Twm4L0MFiTaeJmgoKsag-1; Sat, 02 Dec 2023 08:20:43 -0500
X-MC-Unique: I0Twm4L0MFiTaeJmgoKsag-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b39377136so21361595e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 05:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701523242; x=1702128042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZttw52m3Y5BO6pRmTs4fgflOUqVdmw26+ZPrsBdZjU=;
        b=IKpkBZmmK+3U78GD/ReQmfGzepRuMnqEimtKO5yRPoAuZMJhhWfm8vfdjxqBPhwUi7
         lANfaWGI+HKFB/OC/DZbLafCD/iG8jmrr2xOjGyZn/FeF3NfVTMcD5h+0c4p/eyGxF6e
         es9SiLtUA9XpV8QTwFvmt5uNVQ3VqI6NivDdtbctH8r3+BEIxyHOdKY2PyWapR+dSEuz
         uQFjcMg12DA5PWosM2ziCI/hwA4eCn4CU6dC9sVVTPxG81zZV/w6oynndiEczkntC04S
         n1108xd8Nj7P6p94HEsLHa7P06XTpUzksfbTGC7H3Dl75dQlUw7eQMGySZmuoFYoBm4c
         0AAQ==
X-Gm-Message-State: AOJu0YwyIVHRMSIq6KPVIAZFm+Mmm74KagJS0A1SWyh1PKPIqFXenygU
        /Vsv3cViX2AT/ndixWDQww/Az4AIx2OkrSc6mH5aB2bXuVTmHl1ioutq4FukpWd34dx5kRTfPvF
        DzLRz25pEo+FoKx0R9i/bT0IM
X-Received: by 2002:a05:600c:4f11:b0:40b:5e21:ec2d with SMTP id l17-20020a05600c4f1100b0040b5e21ec2dmr1121575wmq.95.1701523242234;
        Sat, 02 Dec 2023 05:20:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLltLfkoO5OH2qY5+ren3SKxd2ZTe11cQhLH7Sg7oQT2aEydS/UK0AWu4SPL2rbaimjc+NaA==
X-Received: by 2002:a05:600c:4f11:b0:40b:5e21:ec2d with SMTP id l17-20020a05600c4f1100b0040b5e21ec2dmr1121569wmq.95.1701523241891;
        Sat, 02 Dec 2023 05:20:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fd22-20020a056402389600b0054c21d1fda7sm1932805edb.1.2023.12.02.05.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 05:20:41 -0800 (PST)
Message-ID: <b9319272-5e29-4de6-8921-fdac474e421f@redhat.com>
Date:   Sat, 2 Dec 2023 14:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] ACPI: acpi_video: Replace acpi_driver with
 platform_driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
 <20231025111806.2416524-5-michal.wilczynski@intel.com>
 <CAJZ5v0h2G6i0qXvSyFJeC4zsML3yxGZvUt-nUPs2Z3iHEM845A@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0h2G6i0qXvSyFJeC4zsML3yxGZvUt-nUPs2Z3iHEM845A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/23 15:19, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Wed, Oct 25, 2023 at 2:35 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>>
>> The acpi_video driver uses struct acpi_driver to register itself while it
>> would be more logically consistent to use struct platform_driver for this
>> purpose, because the corresponding platform device is present and the
>> role of struct acpi_device is to amend the other bus types. ACPI devices
>> are not meant to be used as proper representation of hardware entities,
>> but to collect information on those hardware entities provided by the
>> platform firmware.
>>
>> Use struct platform_driver for registering the acpi_video driver.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> 
> Do you have any particular concerns regarding this change?  For
> example, are there any setups that can break because of it?

I have just given this a quick test spin and on most hw
it actually causes the apci_video driver to not bind
anymore *at all* which will cause a bunch of brokenness
all over the place.

The problem is that the physical-node for which the 
/sys/bus/acpi/devices/LNXVIDEO:00 fwnode / acpi-companion node 
is the companion normally is the GPU, which is a PCI
device so no /sys/bus/platform/devices/LNXVIDEO:00
device is instantiated for the new "video" platform driver
to bind to.

While I appreciate the efforts being done to clean up
the ACPI subsystem I must also say that this makes me
question how well all these convert to platform driver
patches are tested ?

Almost all modern x86 hw has a /sys/bus/acpi/devices/LNXVIDEO:00
device, so this can be tested almost everywhere and this should
have been caught during testing by a test as simple as:

1. "ls /sys/bus/platform/devices/LNXVIDEO:00" and notice this
does not exist and/or:
2. "ls /sys/bus/platform/drivers/video/" and notice it has not
bound to anything where before this change the acpi_video
module would have bound to /sys/bus/acpi/devices/LNXVIDEO:00

Also the "Video Bus" input/evdev device is now gone
from "sudo evtest" which is a third quick way to see this
now all no longer works.

One possible way to solve this is to treat LNXVIDEO devices
specially and always create a platform_device for them.

This will also require some changes to the modalias
and driver-matching code because normally acpi:xxxx
modaliases are only used / matched when the platform_device
is the first physical node, where as I think
the platform_device will end up being the second physical
node now.

One last remark, assuming we find a way to solve this,
then IMHO the .name field in the driver:

>> +static struct platform_driver acpi_video_bus = {
>> +       .probe = acpi_video_bus_probe,
>> +       .remove_new = acpi_video_bus_remove,
>> +       .driver = {
>> +               .name = "video",
>> +               .acpi_match_table = video_device_ids,
>> +       },
>>  };

MUST not be just "video" platform devices <-> drivers  also get
matched by dev_name() so if anyone now creates a platform_device
named "video" then the platform_bus will now bind this driver
to it. "acpi_video", matching the .c filename (but not the module
name for historical reasons) would be better IMHO.

Regards,

Hans


