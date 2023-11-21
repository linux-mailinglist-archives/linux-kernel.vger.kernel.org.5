Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09C7F30B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjKUO0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjKUO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:26:26 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662010D1;
        Tue, 21 Nov 2023 06:26:20 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A828561E5FE01;
        Tue, 21 Nov 2023 15:26:00 +0100 (CET)
Message-ID: <2bfe2311-27a6-46b5-8662-ba3cbb409f81@molgen.mpg.de>
Date:   Tue, 21 Nov 2023 15:25:59 +0100
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
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZVy5+AxnOZNmUZ15@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Heikki,


Thank you for your prompt reply.

Am 21.11.23 um 15:08 schrieb Heikki Krogerus:
> On Tue, Nov 21, 2023 at 12:50:43PM +0100, Paul Menzel wrote:

>> On the Dell XPS 13, BIOS 2.21.0 06/02/2022, with Debian sid/unstable and
>> Linux 6.5.10, when unplugging the (Dell) USB Type-C charger cable, Linux
>> logs the error below:
>>
>>      ucsi_acpi USBC000:00: ucsi_handle_connector_change: ACK failed (-110)
>>
>> As this is logged with level error, can this be somehow fixed?
>>
>>      drivers/usb/typec/ucsi/ucsi.c: dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
>>
>> Please find the output of `dmesg` attached.
> 
> Thanks. The firmware not reacting to the ACK command is weird, but I'm
> not sure if it's critical. Does the interface continue working after
> that? Do you see the partner devices appearing under /sys/class/typec/
> when you plug them, and disappearing when you unplug them?

```
$ LANG= grep . 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000\:001/*
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_max:0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_now:0
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/device: 
Is a directory
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/hwmon7: 
Is a directory
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/online:0
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/power: 
Is a directory
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/scope:System
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/subsystem: 
Is a directory
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/type:USB
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_NAME=ucsi-source-psy-USBC000:001
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_TYPE=USB
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_USB_TYPE=[C] 
PD PD_PPS
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_ONLINE=0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_VOLTAGE_MIN=5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_VOLTAGE_MAX=5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_VOLTAGE_NOW=5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_CURRENT_MAX=0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_CURRENT_NOW=0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_SCOPE=System
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/usb_type:[C] 
PD PD_PPS
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/voltage_max:5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/voltage_min:5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/voltage_now:5000000
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/wakeup49: 
Is a directory
```

Now I unplugged the device, and the error is *not* logged. (I had a USB 
Type-C port replicator plugged in during the day before.)

The directory is still there:

```
$ LANG= grep . 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000\:001/*
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_max:0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/current_now:0
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/device: 
Is a directory
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/hwmon7: 
Is a directory
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/online:0
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/power: 
Is a directory
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/scope:System
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/subsystem: 
Is a directory
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/type:USB
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_NAME=ucsi-source-psy-USBC000:001
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_TYPE=USB
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_USB_TYPE=[C] 
PD PD_PPS
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_ONLINE=0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_VOLTAGE_MIN=5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_VOLTAGE_MAX=5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_VOLTAGE_NOW=5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_CURRENT_MAX=0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_CURRENT_NOW=0
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/uevent:POWER_SUPPLY_SCOPE=System
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/usb_type:[C] 
PD PD_PPS
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/voltage_max:5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/voltage_min:5000000
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/voltage_now:5000000
grep: 
/sys/class/typec/port0/device/power_supply/ucsi-source-psy-USBC000:001/wakeup49: 
Is a directory
```

I guess, that is the wrong directory I look at though?

(I am going to monitor the logs over the next days.)


Kind regards,

Paul
```
