Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03A17F5EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjKWMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbjKWMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:22:34 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B051BE;
        Thu, 23 Nov 2023 04:22:39 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B520561E5FE04;
        Thu, 23 Nov 2023 13:22:16 +0100 (CET)
Message-ID: <6288389c-59cb-4eb4-bbe6-163413db7b7e@molgen.mpg.de>
Date:   Thu, 23 Nov 2023 13:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unplugging USB-C charger cable causes `ucsi_acpi USBC000:00:
 ucsi_handle_connector_change: ACK failed (-110)`
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <b2466bc2-b62c-4328-94a4-b60af4135ba7@molgen.mpg.de>
 <ZVy5+AxnOZNmUZ15@kuha.fi.intel.com>
 <2bfe2311-27a6-46b5-8662-ba3cbb409f81@molgen.mpg.de>
 <ZV3CTg03IPnZTVL0@kuha.fi.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZV3CTg03IPnZTVL0@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Heikki,


Am 22.11.23 um 09:56 schrieb Heikki Krogerus:
> On Tue, Nov 21, 2023 at 03:25:59PM +0100, Paul Menzel wrote:

>> Am 21.11.23 um 15:08 schrieb Heikki Krogerus:
>>> On Tue, Nov 21, 2023 at 12:50:43PM +0100, Paul Menzel wrote:
>>
>>>> On the Dell XPS 13, BIOS 2.21.0 06/02/2022, with Debian sid/unstable and
>>>> Linux 6.5.10, when unplugging the (Dell) USB Type-C charger cable, Linux
>>>> logs the error below:
>>>>
>>>>       ucsi_acpi USBC000:00: ucsi_handle_connector_change: ACK failed (-110)
>>>>
>>>> As this is logged with level error, can this be somehow fixed?
>>>>
>>>>       drivers/usb/typec/ucsi/ucsi.c: dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
>>>>
>>>> Please find the output of `dmesg` attached.
>>>
>>> Thanks. The firmware not reacting to the ACK command is weird, but I'm
>>> not sure if it's critical. Does the interface continue working after
>>> that? Do you see the partner devices appearing under /sys/class/typec/
>>> when you plug them, and disappearing when you unplug them?
>>
>> ```
>> $ LANG= grep . /sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000\:001/*
>> /sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_max:0
>> /sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_now:0

[…]

>> ```
>>
>> Now I unplugged the device, and the error is *not* logged. (I had a USB
>> Type-C port replicator plugged in during the day before.)
>>
>> The directory is still there:
>>
>> ```
>> $ LANG= grep . /sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000\:001/*
>> /sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_max:0
>> /sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_now:0

[…]

>> ```
>>
>> I guess, that is the wrong directory I look at though?
>>
>> (I am going to monitor the logs over the next days.)
> 
> Just list what you have in /sys/class/typec/ before and after plugging
> a device to the port:
> 
>          ls /sys/class/typec/

Sorry, here you go:

With charger:

     $ ls /sys/class/typec/
     port0  port0-partner

After unplugging the charger:

     $ LANG= ls /sys/class/typec/
     port0

By the way, Linux logs the ucsi_handle_connector_change line around five 
second after unplugging the USB Type-C charger cable.


Kind regards,

Paul


PS: In the logs since October 30th, I see the three distinct lines below:

1.  ucsi_acpi USBC000:00: failed to re-enable notifications (-110)
2.  ucsi_acpi USBC000:00: GET_CONNECTOR_STATUS failed (-110)
3.  ucsi_acpi USBC000:00: ucsi_handle_connector_change: ACK failed (-110)

Is it documented somewhere what -100 means?
