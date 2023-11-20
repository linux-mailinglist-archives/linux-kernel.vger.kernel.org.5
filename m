Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606737F1FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:05:36 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0605D9;
        Mon, 20 Nov 2023 14:05:30 -0800 (PST)
Received: from [10.0.3.168] (unknown [93.240.169.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F02A61E5FE01;
        Mon, 20 Nov 2023 23:05:05 +0100 (CET)
Message-ID: <3489df64-0f8f-43e1-a05f-ccb145ff6d59@molgen.mpg.de>
Date:   Mon, 20 Nov 2023 23:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qualcomm Atheros QCA61x4 keeps drawing 0.85 W despite Bluetooth
 being disable in GNOME
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Jones <mike@mjones.io>,
        Rocky Liao <quic_rjliao@quicinc.com>
References: <d994bd71-8d8b-4b6a-855e-8ea5bfede3ca@molgen.mpg.de>
 <22494842-a785-4151-915d-6f3a677d96cb@molgen.mpg.de>
 <1f3cb0cc-4bb0-471f-a785-a5d237cd46a3@rowland.harvard.edu>
 <d63ebc5f-9b72-4457-949b-3e90883bd3c0@molgen.mpg.de>
 <d61ae9a8-2228-4af1-a5f0-912e7763fbd1@rowland.harvard.edu>
 <de236c7d-e265-452a-a60e-b10293a5b944@molgen.mpg.de>
 <41253614-764e-4e95-b052-a46bf5587c29@rowland.harvard.edu>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <41253614-764e-4e95-b052-a46bf5587c29@rowland.harvard.edu>
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

[Cc: +Rocky Liao as Qualcomm developer]

Dear Alan,


Thank you so much for continuous support in debugging this issue.

Am 20.11.23 um 19:10 schrieb Alan Stern:
> On Mon, Nov 20, 2023 at 08:52:19AM +0100, Paul Menzel wrote:

>> Am 20.11.23 um 03:26 schrieb Alan Stern:
>>> On Sun, Nov 19, 2023 at 11:09:32PM +0100, Paul Menzel wrote:
>>>> $ sudo modprobe btusb
>>>
>>>> $ grep . /sys/bus/usb/devices/1-3/power/*
>>>> /sys/bus/usb/devices/1-3/power/active_duration:119053224
>>>> /sys/bus/usb/devices/1-3/power/async:enabled
>>>> /sys/bus/usb/devices/1-3/power/autosuspend:2
>>>> /sys/bus/usb/devices/1-3/power/autosuspend_delay_ms:2000
>>>> /sys/bus/usb/devices/1-3/power/connected_duration:148065372
>>>> /sys/bus/usb/devices/1-3/power/control:auto
>>>> /sys/bus/usb/devices/1-3/power/level:auto
>>>> /sys/bus/usb/devices/1-3/power/persist:1
>>>> /sys/bus/usb/devices/1-3/power/runtime_active_kids:0
>>>> /sys/bus/usb/devices/1-3/power/runtime_active_time:119060567
>>>> /sys/bus/usb/devices/1-3/power/runtime_enabled:enabled
>>>> /sys/bus/usb/devices/1-3/power/runtime_status:active
>>>> /sys/bus/usb/devices/1-3/power/runtime_suspended_time:28831453
>>>> /sys/bus/usb/devices/1-3/power/runtime_usage:0
>>>> /sys/bus/usb/devices/1-3/power/wakeup:disabled
>>>> ```
>>>
>>> Hmmm.  It's not immediately clear why the device isn't being suspended.
>>> The btusb driver does support autosuspend.
>>>
>>> Can you also post the output from
>>>
>>> 	grep . /sys/bus/usb/devices/1-3:*/power/*
>>>
>>> with the driver module loaded?  I should have asked for it before.
>>
>> ```
>> $ sudo modprobe btusb
>> $ sudo dmesg | tail -9
>> [319747.390712] r8152 4-1.2:1.0 enx18dbf22dccf3: carrier on
>> [320256.946094] bluetooth hci0: firmware: direct-loading firmware qca/rampatch_usb_00000302.bin
>> [320256.949333] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
>> [320256.949349] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
>> [320256.949643] usbcore: registered new interface driver btusb
>> [320257.308935] bluetooth hci0: firmware: direct-loading firmware qca/nvm_usb_00000302.bin
>> [320257.309043] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>> [320257.336220] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
>> [320257.638188] Bluetooth: MGMT ver 1.22
>> $ /sbin/rfkill
>> ID TYPE      DEVICE    SOFT      HARD
>>   1 wlan      phy0   blocked unblocked
>>  28 bluetooth hci0   blocked unblocked
>> $ grep . /sys/bus/usb/devices/1-3:*/power/*
>> /sys/bus/usb/devices/1-3:1.0/power/async:enabled
>> /sys/bus/usb/devices/1-3:1.0/power/runtime_active_kids:0
>> /sys/bus/usb/devices/1-3:1.0/power/runtime_enabled:enabled
>> /sys/bus/usb/devices/1-3:1.0/power/runtime_status:suspended
>> /sys/bus/usb/devices/1-3:1.0/power/runtime_usage:0
>> /sys/bus/usb/devices/1-3:1.1/power/async:enabled
>> /sys/bus/usb/devices/1-3:1.1/power/runtime_active_kids:0
>> /sys/bus/usb/devices/1-3:1.1/power/runtime_enabled:enabled
>> /sys/bus/usb/devices/1-3:1.1/power/runtime_status:suspended
>> /sys/bus/usb/devices/1-3:1.1/power/runtime_usage:0
>> ```
> 
> Again, nothing out of the ordinary.  Maybe dynamic debugging will give
> us a clue.  Try doing this:
> 
> 	Unload the btusb module.
> 
> 	echo module usbcore +p >/sys/kernel/debug/dynamic_debug/control
> 
> 	Load the btusb module
> 
> 	Make sure that Bluetooth is turned off in Gnome
> 
> 	Wait a few seconds
> 
> 	echo module usbcore -p >/sys/kernel/debug/dynamic_debug/control
> 
> Then let's see what the dmesg log contains for that time period.


```
$ sudo modprobe -r btusb
$ sudo dmesg | tail -1
[340309.272439] usbcore: deregistering interface driver btusb
$ echo module usbcore +p | sudo tee /sys/kernel/debug/dynamic_debug/control
module usbcore +p
$ sudo modprobe btusb
$ /sbin/rfkill
ID TYPE      DEVICE      SOFT      HARD
  1 wlan      phy0   unblocked unblocked
36 bluetooth hci0     blocked unblocked
$ echo module usbcore -p | sudo tee /sys/kernel/debug/dynamic_debug/control
module usbcore -p
$ sudo modprobe -r btusb
$ sudo dmesg | tail -1
[340608.761313] usbcore: deregistering interface driver btusb
$ sudo dmesg
[…]
[340309.272439] usbcore: deregistering interface driver btusb
[340560.326182] xhci_hcd 0000:00:14.0: hcd_pci_runtime_resume: 0
[340560.326214] usb usb1: usb auto-resume
[340560.326258] hub 1-0:1.0: hub_resume
[340560.326381] usb usb1-port3: status 0107 change 0000
[340560.326418] usb usb1-port4: status 0107 change 0000
[340560.326451] usb usb1-port5: status 0507 change 0000
[340560.326650] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0000
[340560.326807] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0000
[340560.373988] usb 1-3: usb auto-resume
[340560.373998] hub 1-0:1.0: state 7 ports 12 chg 0000 evt 0008
[340560.441936] usb 1-3: Waited 0ms for CONNECT
[340560.441957] usb 1-3: finish reset-resume
[340560.570940] usb 1-3: reset full-speed USB device number 2 using xhci_hcd
[340560.721096] btusb 1-3:1.0: usb_probe_interface
[340560.721126] btusb 1-3:1.0: usb_probe_interface - got id
[340560.723193] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
[340560.728684] usbcore: registered new interface driver btusb
[340560.902021] Bluetooth: MGMT ver 1.22
[340608.761313] usbcore: deregistering interface driver btusb
```

So, unfortunately, nothing seems to be logged in the 48 seconds.

> Also, please post the output from "lsusb -v" for the Bluetooth device.

```
$ sudo lsusb -d 0cf3:e300 -v

Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4 
Bluetooth 4.0
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.01
   bDeviceClass          224 Wireless
   bDeviceSubClass         1 Radio Frequency
   bDeviceProtocol         1 Bluetooth
   bMaxPacketSize0        64
   idVendor           0x0cf3 Qualcomm Atheros Communications
   idProduct          0xe300 QCA61x4 Bluetooth 4.0
   bcdDevice            0.01
   iManufacturer           0
   iProduct                0
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength       0x00b1
     bNumInterfaces          2
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xe0
       Self Powered
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0000  1x 0 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0000  1x 0 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0009  1x 9 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0009  1x 9 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       2
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0011  1x 17 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0011  1x 17 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       3
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0019  1x 25 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0019  1x 25 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       4
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0021  1x 33 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0021  1x 33 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       5
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0031  1x 49 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0031  1x 49 bytes
         bInterval               1
Binary Object Store Descriptor:
   bLength                 5
   bDescriptorType        15
   wTotalLength       0x000c
   bNumDeviceCaps          1
   USB 2.0 Extension Device Capability:
     bLength                 7
     bDescriptorType        16
     bDevCapabilityType      2
     bmAttributes   0x00000002
       HIRD Link Power Management (LPM) Supported
Device Status:     0x0001
   Self Powered
```






Kind regards,

Paul


PS: Somewhere, I saw somebody post the output of `usb-devices` from 
usb-utils. So for the record:

```
$ usb-devices

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=12
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev=06.05
S:  Manufacturer=Linux 6.5.0-4-amd64 xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e300 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

T:  Bus=01 Lev=01 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04f3 ProdID=2234 Rev=11.11
S:  Manufacturer=ELAN
S:  Product=Touchscreen
C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=2ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms

T:  Bus=01 Lev=01 Prnt=03 Port=04 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0c45 ProdID=670c Rev=56.26
S:  Manufacturer=CN09GTFMLOG008C8B7FWA01
S:  Product=Integrated_Webcam_HD
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=00 Driver=uvcvideo
E:  Ad=83(I) Atr=03(Int.) MxPS=  16 Ivl=4ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 6
D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev=06.05
S:  Manufacturer=Linux 6.5.0-4-amd64 xhci-hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms
```

PPS: Looking through the commit log/history for 
`drivers/bluetooth/btusb.c`, I found commit 7ecacafc2406 (Bluetooth: 
btusb: Disable runtime suspend on Realtek devices) [1] authored on 
December 5th, 2019. This is for Realtek devices though, and not Qualcomm.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7ecacafc240638148567742cca41aa7144b4fe1e
