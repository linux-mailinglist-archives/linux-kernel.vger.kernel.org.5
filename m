Return-Path: <linux-kernel+bounces-65367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6A854BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA341C211F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDB5B04F;
	Wed, 14 Feb 2024 14:53:21 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECE5C8F1;
	Wed, 14 Feb 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922401; cv=none; b=De2cMMMrJPpuiDJHQnzJlxez98vG1EwwBs0GkETnBKmQK0Thhfw/tFVZq0pTk74tc68Hfno42mpjVenbC6whZV0iDnmNjxxMkUl7aASJXHgYaB+htWQUJyUqDOBX+V3WyYeP56PR7/dYMjgaAced7hYyeNF3PMEnDyR7mP/OQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922401; c=relaxed/simple;
	bh=CnINJSzWv8aFX5WeNVfIdrzwVom0EkVwTbltIwE9rO8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YSjs06e67rcPl9YcdXR6VdU31s1Qyf1uNNiSZcqSpyhqkuxzb87TLju2TibR6OU/t+P0FsBInaKrkoQRZ5JgcWsTxvRuB93HdfalFJjiWJVxOrjDAxclo7i60HoDByui6YaEKptdz2FQJ6Qk0fCHFgAdmEDgdPs2Pns4km1u2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aea4b.dynamic.kabel-deutschland.de [95.90.234.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DE63961E5FE01;
	Wed, 14 Feb 2024 15:53:03 +0100 (CET)
Message-ID: <a18994c5-6584-403f-8754-b9db43c1f6fa@molgen.mpg.de>
Date: Wed, 14 Feb 2024 15:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Warning! Unlikely big volume range (=9234), cval->res is probably
 wrong. (Dell XPS 13 9360 and Plantronics Blackwire 315.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On the Dell XPS 13 9360, plugging in a USB headset, I saw the warning 
below the first time since using the devices since December 2023.

```
$ sudo dmesg | grep -e "DMI:" -e "Linux version" -e microcode
[    0.000000] Linux version 6.8.0-rc4 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0, 
GNU ld (GNU Binutils for Debian) 2.42) #20 SMP PREEMPT_DYNAMIC Mon Feb 
12 09:40:49 CET 2024
[    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
[    0.386024] microcode: Current revision: 0x000000f4
[    0.386026] microcode: Updated early from: 0x000000f0
[…]
[88628.500854] usb 1-2: new full-speed USB device number 11 using xhci_hcd
[88628.723620] usb 1-2: New USB device found, idVendor=047f, 
idProduct=c037, bcdDevice= 1.45
[88628.723627] usb 1-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[88628.723629] usb 1-2: Product: Plantronics Blackwire 315.1
[88628.723631] usb 1-2: Manufacturer: Plantronics
[88628.723633] usb 1-2: SerialNumber: F3D422B734B3EC4CAF12EA236AFCB5EA
[88628.794126] input: Plantronics Plantronics Blackwire 315.1 Consumer 
Control as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input67
[88628.853158] input: Plantronics Plantronics Blackwire 315.1 as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input68
[88628.853253] input: Plantronics Plantronics Blackwire 315.1 as 
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input69
[88628.853428] hid-generic 0003:047F:C037.000F: input,hiddev1,hidraw2: 
USB HID v1.11 Device [Plantronics Plantronics Blackwire 315.1] on 
usb-0000:00:14.0-2/input3
[88628.853447] probe of 0003:047F:C037.000F returned 0 after 59756 usecs
[88628.853463] probe of 1-2:1.3 returned 0 after 127842 usecs
[88628.853491] probe of 1-2 returned 0 after 129625 usecs
[88628.892691] calling  alsa_rawmidi_init+0x0/0xff0 [snd_rawmidi] @ 117168
[88628.892707] initcall alsa_rawmidi_init+0x0/0xff0 [snd_rawmidi] 
returned 0 after 1 usecs
[88628.964882] calling  usb_audio_driver_init+0x0/0xff0 [snd_usb_audio] 
@ 117168
[88629.840845] usb 1-2: Warning! Unlikely big volume range (=9234), 
cval->res is probably wrong.
[88629.840850] usb 1-2: [11] FU [Sidetone Playback Volume] ch = 1, val = 
0/9234/1
[88630.401192] probe of 1-2:1.0 returned 0 after 1436245 usecs
[88630.401216] usbcore: registered new interface driver snd-usb-audio
[88630.401219] initcall usb_audio_driver_init+0x0/0xff0 [snd_usb_audio] 
returned 0 after 1436302 usecs
[89546.685992] usb 1-2: USB disconnect, device number 11
```

(`/sbin/alsa-info` [1])

I am unable to reproduce this. Is that a problem with the headset, the 
laptop or something else?

Looking at the archive of Linux messages archive of *Hardware for Linux* 
[1], the message shows up quite often.


Kind regards,

Paul


[1]: https://alsa-project.org/db/?f=3dc36e15c0cd57e299a119fb0b5b1ad6ed78e898
[2]: https://github.com/linuxhw/Dmesg

