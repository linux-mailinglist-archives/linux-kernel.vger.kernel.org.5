Return-Path: <linux-kernel+bounces-32073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED683560A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496541F22188
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA11374ED;
	Sun, 21 Jan 2024 14:27:25 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70F374CC;
	Sun, 21 Jan 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847245; cv=none; b=rnGh3Dw+3/Kg3jU4bdsC8t0X2Hfi0IQSfBbWwWE11M1UaC55OCo4n0Sze0NYomm/grlM/satOrCTpHE89Kzc8ytV0LsEZeuubxMW6b2aHLZUIAtDF1Q9DunaMevapgs9muP6d4RiNKCtPzD0Mmtr8tj/lFIc7NZsIESRMaD2O9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847245; c=relaxed/simple;
	bh=byIuojKAOQGpVvzM2HJOE6Kj44p/u4i6v+81soekYrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmHG7WdQiwQQwZ7vKR9ATBP+4pCTkDhzDeNdYDxkuBjjQcY0Sne/I5cd1U3k4Wd5/lxrKwi+K0RAAlXw/x18CBev+aaKYFbN2YIO0407PV9ncIlA13i0pI297XSIThpg/FdFBDUJ7rj/aHbbdI4pCGYvaPCM/+ksMC8V5697vuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.34.139] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 30E5461E5FE01;
	Sun, 21 Jan 2024 15:26:50 +0100 (CET)
Message-ID: <0b30c88a-6f0c-447f-a08e-29a2a0256c1b@molgen.mpg.de>
Date: Sun, 21 Jan 2024 15:26:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hans,


As always thank you very much for taking the time to reply.


Am 20.01.24 um 21:26 schrieb Hans de Goede:

> On 1/18/24 13:57, Paul Menzel wrote:
>> #regzbot introduced v6.6.11..v6.7

>> There seems to be a regression in Linux 6.7 on the Dell XPS 13 9360 (Intel i7-7500U).
>>
>>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>
>> The PS/2 keyboard goes missing after S3 resume¹. The problem does not happen with Linux 6.6.11.
> 
> Thank you for reporting this.
> 
> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
> 
> This should at least lead to the device not disappearing from
> 
> "sudo libinput list-devices"
> 
> The next question is if the keyboard will still actually
> work after suspend/resume with "i8042.dumbkbd=1". If it
> stays in the list, but no longer works then there is
> a problem with the i8042 controller; or interrupt
> delivery to the i8042 controller.
> 
> If "i8042.dumbkbd=1" somehow fully fixes things, then I guess
> my atkbd driver fix for other laptop keyboards is somehow
> causing issues for yours.

Just a quick feedback, that booting with `i8042.dumbkbd=1` seems to fix 
the issue.

> If "i8042.dumbkbd=1" fully fixes things, can you try building
> your own 6.7.0 kernel with commit 936e4d49ecbc:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=936e4d49ecbc8c404790504386e1422b599dec39
> 
> reverted?

I am going to try that as soon as possible.


Kind regards,

Paul


>>      [    1.435071] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>>      [    1.435409] i8042: Warning: Keylock active
>>      [    1.437624] serio: i8042 KBD port at 0x60,0x64 irq 1
>>      [    1.437631] serio: i8042 AUX port at 0x60,0x64 irq 12
>>      […]
>>      [    1.439743] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
>>
>>      $ sudo libinput list-devices
>>      […]
>>      Device:           AT Translated Set 2 keyboard
>>      Kernel:           /dev/input/event0
>>      Group:            15
>>      Seat:             seat0, default
>>      Capabilities:     keyboard
>>      Tap-to-click:     n/a
>>      Tap-and-drag:     n/a
>>      Tap drag lock:    n/a
>>      Left-handed:      n/a
>>      Nat.scrolling:    n/a
>>      Middle emulation: n/a
>>      Calibration:      n/a
>>      Scroll methods:   none
>>      Click methods:    none
>>      Disable-w-typing: n/a
>>      Disable-w-trackpointing: n/a
>>      Accel profiles:   n/a
>>      Rotation:         0.0
>>
>> `libinput list-devices` does not list the device after resuming
>> from S3. Some of the function keys, like brightness and airplane
>> mode keys, still work, as the events are probably transmitted over
>> the embedded controller or some other mechanism. An external USB
>> keyboard also still works.
>> 
>> I haven’t had time to further analyze this, but wanted to report
>> it. No idea
>> 
>> 
>> Kind regards,
>> 
>> Paul
>> 
>> 
>> ¹ s2idle is not working correctly on the device, in the sense, that
>> energy usage is very high in that state, and the full battery is at
>> 20 % after leaving it for eight hours.

