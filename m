Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4057F094B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjKSWJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKSWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:09:53 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B45136;
        Sun, 19 Nov 2023 14:09:48 -0800 (PST)
Received: from [192.168.0.183] (ip5f5af02c.dynamic.kabel-deutschland.de [95.90.240.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 49BFE61E5FE01;
        Sun, 19 Nov 2023 23:09:33 +0100 (CET)
Message-ID: <d63ebc5f-9b72-4457-949b-3e90883bd3c0@molgen.mpg.de>
Date:   Sun, 19 Nov 2023 23:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qualcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
 <22494842-a785-4151-915d-6f3a677d96cb@molgen.mpg.de>
 <1f3cb0cc-4bb0-471f-a785-a5d237cd46a3@rowland.harvard.edu>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1f3cb0cc-4bb0-471f-a785-a5d237cd46a3@rowland.harvard.edu>
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

Dear Alan,


Thank you very much for your quick response.

Am 19.11.23 um 16:43 schrieb Alan Stern:
> On Sun, Nov 19, 2023 at 02:42:58PM +0100, Paul Menzel wrote:

>> On the Dell XPS 13 9360 from 2016, BIOS 2.21.0 06/02/2022, with Debian
>> sid/unstable and Debian’s Linux 6.5.10 kernel, I am trying to extend the
>> run-time with battery, at under 50 % of it’s original capacity, and I am
>> using PowerTOP 2.15.
> 
>> Although radio/wireless devices are turned off in GNOME, PowerTOP shows the
>> Bluetooth device drawing 0.85 W of energy:
>>
>>      848 mW    100.0%   Device         USB device: usb-device-0cf3-e300
>>
>>      $ lsusb -d 0cf3:e300
>>      Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4 Bluetooth 4.0
> 
>> After unloading the module `btusb`, the entry disappears from the PowerTOP
>> list after a while.
>>
>>      usbcore: deregistering interface driver btusb
>>
>> Auto-suspend was enabled for the device. (Though it shouldn’t have mattered
>> as it was disabled in GNOME?)
> 
> Enabling autosuspend means that the device _may_ go into runtime suspend
> when it's not being used.  Whether it _will_ do so depends on the driver
> (btusb in this case).

Thank you for the clarification.

>> Anyways, have you heard of such an issue? Can I provide more information, to
>> get it to not use any energy while being disable in GNOME?
> 
> What is the output from
> 
> 	grep . /sys/bus/usb/devices/1-3/power/*
> 
> both with and without the btusb module loaded?

```
$ sudo modprobe btusb
$ sudo dmesg | tail -10
[313699.136637] wlp58s0: Limiting TX power to 17 dBm as advertised by 
00:f6:63:af:fa:4f
[314037.905400] WARNING! power/level is deprecated; use power/control 
instead
[314065.418431] usbcore: registered new interface driver btusb
[314065.421509] bluetooth hci0: firmware: direct-loading firmware 
qca/rampatch_usb_00000302.bin
[314065.423852] Bluetooth: hci0: using rampatch file: 
qca/rampatch_usb_00000302.bin
[314065.423865] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, 
firmware rome 0x302 build 0x111
[314065.791131] bluetooth hci0: firmware: direct-loading firmware 
qca/nvm_usb_00000302.bin
[314065.791228] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[314065.823499] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
[314066.117644] Bluetooth: MGMT ver 1.22
$ grep . /sys/bus/usb/devices/1-3/power/*
/sys/bus/usb/devices/1-3/power/active_duration:119053224
/sys/bus/usb/devices/1-3/power/async:enabled
/sys/bus/usb/devices/1-3/power/autosuspend:2
/sys/bus/usb/devices/1-3/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/1-3/power/connected_duration:148065372
/sys/bus/usb/devices/1-3/power/control:auto
/sys/bus/usb/devices/1-3/power/level:auto
/sys/bus/usb/devices/1-3/power/persist:1
/sys/bus/usb/devices/1-3/power/runtime_active_kids:0
/sys/bus/usb/devices/1-3/power/runtime_active_time:119060567
/sys/bus/usb/devices/1-3/power/runtime_enabled:enabled
/sys/bus/usb/devices/1-3/power/runtime_status:active
/sys/bus/usb/devices/1-3/power/runtime_suspended_time:28831453
/sys/bus/usb/devices/1-3/power/runtime_usage:0
/sys/bus/usb/devices/1-3/power/wakeup:disabled
```

```
$ sudo modprobe -r btusb
$ sudo dmesg | tail -1
[314106.155163] usbcore: deregistering interface driver btusb
$ grep . /sys/bus/usb/devices/1-3/power/*
/sys/bus/usb/devices/1-3/power/active_duration:119072176
/sys/bus/usb/devices/1-3/power/async:enabled
/sys/bus/usb/devices/1-3/power/autosuspend:2
/sys/bus/usb/devices/1-3/power/autosuspend_delay_ms:2000
/sys/bus/usb/devices/1-3/power/connected_duration:148320980
/sys/bus/usb/devices/1-3/power/control:auto
/sys/bus/usb/devices/1-3/power/level:auto
/sys/bus/usb/devices/1-3/power/persist:1
/sys/bus/usb/devices/1-3/power/runtime_active_kids:0
/sys/bus/usb/devices/1-3/power/runtime_active_time:119079518
/sys/bus/usb/devices/1-3/power/runtime_enabled:enabled
/sys/bus/usb/devices/1-3/power/runtime_status:suspended
/sys/bus/usb/devices/1-3/power/runtime_suspended_time:29068110
/sys/bus/usb/devices/1-3/power/runtime_usage:0
/sys/bus/usb/devices/1-3/power/wakeup:disabled
```


Kind regards,

Paul


>> $ lsusb -t
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
>>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 10000M
>>          |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
>>      |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/5p, 480M
>>          |__ Port 1: Dev 3, If 0, Class=Human Interface Device,
>> Driver=usbhid, 12M
>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 5000M
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/12p, 480M
>>      |__ Port 3: Dev 2, If 0, Class=Wireless, Driver=, 12M
>>      |__ Port 3: Dev 2, If 1, Class=Wireless, Driver=, 12M
>>      |__ Port 4: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>>      |__ Port 5: Dev 4, If 0, Class=Video, Driver=uvcvideo, 480M
>>      |__ Port 5: Dev 4, If 1, Class=Video, Driver=uvcvideo, 480M
>> ```
