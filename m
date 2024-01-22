Return-Path: <linux-kernel+bounces-33105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E299B83649D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF3FB257ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D733D0B6;
	Mon, 22 Jan 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbsAgugJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74B3CF7C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930993; cv=none; b=a1acgAZekfAJQS9O/QxotjGKzgL+yuVHpCpBcAsT1B4ZPly3VzCIavSzqUuwVE8p5VeBrjf0s56BCCML3kClb6R8B2eelINgAxok2sejb36c2lcoBAuFPHvvSMaIjBA8ZcPLG1chKDJ5QaZTw6y3k0W6YkOy0keaW2CqC6x5Rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930993; c=relaxed/simple;
	bh=6Z8MTof0aijXO3FlKk1VgUZVHQNPMxGPnaHFOh9M2DM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=JIYjv8uVEm8y6xIAnyvghFYr2C1Q67VJJNYK/zN+72TQiqhUpq7ofRM4bCVAgM2s2jEuV+iHEQyi1kDiQOx0JkejJoWAPP1zFbsPqUzo5x2uEYoYrTmLCDvVU8i3epIkuy4odUd1+nzbHehpYfmVx/q8mPGVVBy30xq3ipxj2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbsAgugJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705930990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm05vtFJz6C1MRHFDEJ+QgrtImKj2pXIVFR7juPcnoQ=;
	b=AbsAgugJ7RWZN+yFPt6TVdQKa9cH7nXWRgsQ9f3GRkfQp2u/+dJa3AB1TMW55Tirp9R0Xm
	NtOkC3D7CbpgKVmrrP6aPpBb5gHJCc3XPoiCMQzaIOn9yaTgoj8KIth8Rk5Um/R03PSE+U
	GF6Oh6mneL73g2gesJvBEloV8gze6k8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0hl0Wc1OPc2SuhD6lFtD9g-1; Mon, 22 Jan 2024 08:43:08 -0500
X-MC-Unique: 0hl0Wc1OPc2SuhD6lFtD9g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e5f548313so28530835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705930987; x=1706535787;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hm05vtFJz6C1MRHFDEJ+QgrtImKj2pXIVFR7juPcnoQ=;
        b=aemPd6wjlNeWs99xuaBQq0A/HYKa2ngTqada7xORl+n3ssmH7KL9VirWQWdXfjcW7J
         /xNzGNeTiCI0Uxqlhgm2FoW5RdH2H7lz2QDzEsWO6XBspxw/I/SV2wDOX2qxow0F8J8u
         uz9iqnoNstKjfVdQp7gyFFZpmjXxne4gAHRMWMMaerd3twwrHKR45pPUPmKhqPD9dYXX
         yA/7asuWOyzzfx+a2wiives/nIWyYoOpPhjUrLK3+GlcTxvNgzLoreh4c8IOU6FA/O0b
         a2tE1xqGDcg7m6f7cxK8TOdtSG0TSWaVkTolhfP5AJTc6bXxLwJP2tBbweh0djN6TqrE
         kvtQ==
X-Gm-Message-State: AOJu0YxeJdoBIEry/9ub7W0f2mg7rElv+xj5MRV/hjgN/5ytHVI/APsI
	HB6v6OClsy7aBCR5Cc4YmNWGue5BHImX00GcBrexrrrO0u/POmgMTrubyY0UWuTMZys+mCaFQHu
	Wmj0BIkQNUp24w6eqLBfB0QwZBXFLKPD2F/r2+pAQRUzEyHAz/42YJZvTAcrt0Q==
X-Received: by 2002:a05:600c:2991:b0:40e:5496:281 with SMTP id r17-20020a05600c299100b0040e54960281mr2367055wmd.67.1705930987485;
        Mon, 22 Jan 2024 05:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBjufMAwCjjBbigsvKysfHmzef2ySdfMYb2Bf52L/eKzNLuX8VX8/k7MZlVuc+pjxt6AB8qQ==
X-Received: by 2002:a05:600c:2991:b0:40e:5496:281 with SMTP id r17-20020a05600c299100b0040e54960281mr2367040wmd.67.1705930987119;
        Mon, 22 Jan 2024 05:43:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n5-20020a056402434500b00559c6000835sm7496700edc.5.2024.01.22.05.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:43:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------3AfAKs2b0Kmg9oZsVXU3SqQo"
Message-ID: <dde1bdfe-7877-41bd-b233-03bcdba0e2de@redhat.com>
Date: Mon, 22 Jan 2024 14:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
Content-Language: en-US, nl
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
 <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
 <0b30c88a-6f0c-447f-a08e-29a2a0256c1b@molgen.mpg.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0b30c88a-6f0c-447f-a08e-29a2a0256c1b@molgen.mpg.de>

This is a multi-part message in MIME format.
--------------3AfAKs2b0Kmg9oZsVXU3SqQo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

On 1/21/24 15:26, Paul Menzel wrote:
> Dear Hans,
> 
> 
> As always thank you very much for taking the time to reply.
> 
> 
> Am 20.01.24 um 21:26 schrieb Hans de Goede:
> 
>> On 1/18/24 13:57, Paul Menzel wrote:
>>> #regzbot introduced v6.6.11..v6.7
> 
>>> There seems to be a regression in Linux 6.7 on the Dell XPS 13 9360 (Intel i7-7500U).
>>>
>>>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>
>>> The PS/2 keyboard goes missing after S3 resume¹. The problem does not happen with Linux 6.6.11.
>>
>> Thank you for reporting this.
>>
>> Can you try adding "i8042.dumbkbd=1" to your kernel commandline?
>>
>> This should at least lead to the device not disappearing from
>>
>> "sudo libinput list-devices"
>>
>> The next question is if the keyboard will still actually
>> work after suspend/resume with "i8042.dumbkbd=1". If it
>> stays in the list, but no longer works then there is
>> a problem with the i8042 controller; or interrupt
>> delivery to the i8042 controller.
>>
>> If "i8042.dumbkbd=1" somehow fully fixes things, then I guess
>> my atkbd driver fix for other laptop keyboards is somehow
>> causing issues for yours.
> 
> Just a quick feedback, that booting with `i8042.dumbkbd=1` seems to fix the issue.
> 
>> If "i8042.dumbkbd=1" fully fixes things, can you try building
>> your own 6.7.0 kernel with commit 936e4d49ecbc:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=936e4d49ecbc8c404790504386e1422b599dec39
>>
>> reverted?
> 
> I am going to try that as soon as possible.

Assuming this was not some one time glitch with 6.7.0,
I have prepared a patch hopefully fixing this (1) as well
as a follow up fix to address another potential issue which
I have noticed.

Can you please give a 6.7.0 (2) kernel with the 2 attached
patches added a try ?

I know building kernels can be a bit of work / takes time,
sorry. If you are short on time I would prefer testing these 2
patches and see if they fix things over trying a plain revert.

Regards,

Hans



1) Assuming it is caused by this commit in the first place,
which seems likely

2) 6.8-rc1 has a follow up patch which is squashed into the
first patch here, so these patches will only apply cleanly
to 6.7.0 .





>>>      [    1.435071] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>>>      [    1.435409] i8042: Warning: Keylock active
>>>      [    1.437624] serio: i8042 KBD port at 0x60,0x64 irq 1
>>>      [    1.437631] serio: i8042 AUX port at 0x60,0x64 irq 12
>>>      […]
>>>      [    1.439743] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
>>>
>>>      $ sudo libinput list-devices
>>>      […]
>>>      Device:           AT Translated Set 2 keyboard
>>>      Kernel:           /dev/input/event0
>>>      Group:            15
>>>      Seat:             seat0, default
>>>      Capabilities:     keyboard
>>>      Tap-to-click:     n/a
>>>      Tap-and-drag:     n/a
>>>      Tap drag lock:    n/a
>>>      Left-handed:      n/a
>>>      Nat.scrolling:    n/a
>>>      Middle emulation: n/a
>>>      Calibration:      n/a
>>>      Scroll methods:   none
>>>      Click methods:    none
>>>      Disable-w-typing: n/a
>>>      Disable-w-trackpointing: n/a
>>>      Accel profiles:   n/a
>>>      Rotation:         0.0
>>>
>>> `libinput list-devices` does not list the device after resuming
>>> from S3. Some of the function keys, like brightness and airplane
>>> mode keys, still work, as the events are probably transmitted over
>>> the embedded controller or some other mechanism. An external USB
>>> keyboard also still works.
>>>
>>> I haven’t had time to further analyze this, but wanted to report
>>> it. No idea
>>>
>>>
>>> Kind regards,
>>>
>>> Paul
>>>
>>>
>>> ¹ s2idle is not working correctly on the device, in the sense, that
>>> energy usage is very high in that state, and the full battery is at
>>> 20 % after leaving it for eight hours.
> 

--------------3AfAKs2b0Kmg9oZsVXU3SqQo
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Input-atkbd-Skip-ATKBD_CMD_SETLEDS-when-skipping-ATK.patch"
Content-Disposition: attachment;
 filename*0="0001-Input-atkbd-Skip-ATKBD_CMD_SETLEDS-when-skipping-ATK.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwNjdmODllMzQyNjQ2MTdkZDIyYjBjYjg1MGM3OTk2YzkzMTUyY2QxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUdWUsIDE2IEphbiAyMDI0IDIxOjQzOjI1ICswMTAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIElucHV0OiBhdGtiZCAtIFNraXAgQVRLQkRfQ01EX1NFVExFRFMgd2hlbiBz
a2lwcGluZwogQVRLQkRfQ01EX0dFVElECgpBZnRlciBjb21taXQgOTM2ZTRkNDllY2JjICgi
SW5wdXQ6IGF0a2JkIC0gc2tpcCBBVEtCRF9DTURfR0VUSUQgaW4KdHJhbnNsYXRlZCBtb2Rl
IikgdGhlIGtleWJvYXJkIG9uIGEgRGVsbCBYUFMgMTMgOTM2MCBoYXMgc3RvcHBlZAp3b3Jr
aW5nIGFmdGVyIGEgc3VzcGVuZC9yZXN1bWUuCgpUaGUgcHJvYmxlbSBhcHBlYXJzIHRvIGJl
IHRoYXQgYXRrYmRfcHJvYmUoKSBmYWlscyB3aGVuIGNhbGxlZApmcm9tIGF0a2JkX3JlY29u
bmVjdCgpIG9uIHJlc3VtZSwgd2hpY2ggb24gc3lzdGVtcyB3aGVyZQpBVEtCRF9DTURfR0VU
SUQgaXMgc2tpcHBlZCBjYW4gb25seSBoYXBwZW4gYnkgQVRLQkRfQ01EX1NFVExFRFMKZmFp
bGluZy4gQVRLQkRfQ01EX1NFVExFRFMgZmFpbGluZyBiZWNhdXNlIEFUS0JEX0NNRF9HRVRJ
RCB3YXMKc2tpcHBlZCBpcyB3ZWlyZCwgYnV0IGFwcGFyZW50bHkgdGhhdCBpcyB3aGF0IGlz
IGhhcHBlbmluZy4KCkZpeCB0aGlzIGJ5IGFsc28gc2tpcHBpbmcgQVRLQkRfQ01EX1NFVExF
RFMgd2hlbiBza2lwcGluZwpBVEtCRF9DTURfR0VUSUQuCgpGaXhlczogOTM2ZTRkNDllY2Jj
ICgiSW5wdXQ6IGF0a2JkIC0gc2tpcCBBVEtCRF9DTURfR0VUSUQgaW4gdHJhbnNsYXRlZCBt
b2RlIikKUmVwb3J0ZWQtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
CkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW5wdXQvMGFhNGE2MWYt
YzkzOS00NmZlLWE1NzItMDgwMjJlODkzMWM3QG1vbGdlbi5tcGcuZGUvCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRl
QHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9hdGtiZC5jIHwgMTUg
KysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2Jk
LmMgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2JkLmMKaW5kZXggNzg2ZjAwZjZiN2Zk
Li5jMjI5YmQ2YjNmN2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvYXRr
YmQuYworKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2JkLmMKQEAgLTc5MSw5ICs3
OTEsOSBAQCBzdGF0aWMgYm9vbCBhdGtiZF9pc19wb3J0YWJsZV9kZXZpY2Uodm9pZCkKICAq
IG5vdCB3b3JrLiBTbyBpbiB0aGlzIGNhc2Ugc2ltcGx5IGFzc3VtZSBhIGtleWJvYXJkIGlz
IGNvbm5lY3RlZCB0byBhdm9pZAogICogY29uZnVzaW5nIHNvbWUgbGFwdG9wIGtleWJvYXJk
cy4KICAqCi0gKiBTa2lwcGluZyBBVEtCRF9DTURfR0VUSUQgZW5kcyB1cCB1c2luZyBhIGZh
a2Uga2V5Ym9hcmQgaWQuIFVzaW5nIGEgZmFrZSBpZCBpcwotICogb2sgaW4gdHJhbnNsYXRl
ZCBtb2RlLCBvbmx5IGF0a2JkX3NlbGVjdF9zZXQoKSBjaGVja3MgYXRrYmQtPmlkIGFuZCBp
bgotICogdHJhbnNsYXRlZCBtb2RlIHRoYXQgaXMgYSBuby1vcC4KKyAqIFNraXBwaW5nIEFU
S0JEX0NNRF9HRVRJRCBlbmRzIHVwIHVzaW5nIGEgZmFrZSBrZXlib2FyZCBpZC4gVXNpbmcg
dGhlIHN0YW5kYXJkCisgKiAweGFiODMgaWQgaXMgb2sgaW4gdHJhbnNsYXRlZCBtb2RlLCBv
bmx5IGF0a2JkX3NlbGVjdF9zZXQoKSBjaGVja3MgYXRrYmQtPmlkCisgKiBhbmQgaW4gdHJh
bnNsYXRlZCBtb2RlIHRoYXQgaXMgYSBuby1vcC4KICAqLwogc3RhdGljIGJvb2wgYXRrYmRf
c2tpcF9nZXRpZChzdHJ1Y3QgYXRrYmQgKmF0a2JkKQogewpAQCAtODI0LDYgKzgyNCwxMSBA
QCBzdGF0aWMgaW50IGF0a2JkX3Byb2JlKHN0cnVjdCBhdGtiZCAqYXRrYmQpCiAJCQkJICJr
ZXlib2FyZCByZXNldCBmYWlsZWQgb24gJXNcbiIsCiAJCQkJIHBzMmRldi0+c2VyaW8tPnBo
eXMpOwogCisJaWYgKGF0a2JkX3NraXBfZ2V0aWQoYXRrYmQpKSB7CisJCWF0a2JkLT5pZCA9
IDB4YWI4MzsKKwkJcmV0dXJuIDA7CisJfQorCiAvKgogICogVGhlbiB3ZSBjaGVjayB0aGUg
a2V5Ym9hcmQgSUQuIFdlIHNob3VsZCBnZXQgMHhhYjgzIHVuZGVyIG5vcm1hbCBjb25kaXRp
b25zLgogICogU29tZSBrZXlib2FyZHMgcmVwb3J0IGRpZmZlcmVudCB2YWx1ZXMsIGJ1dCB0
aGUgZmlyc3QgYnl0ZSBpcyBhbHdheXMgMHhhYiBvcgpAQCAtODMyLDEwICs4MzcsMTAgQEAg
c3RhdGljIGludCBhdGtiZF9wcm9iZShzdHJ1Y3QgYXRrYmQgKmF0a2JkKQogICovCiAKIAlw
YXJhbVswXSA9IHBhcmFtWzFdID0gMHhhNTsJLyogaW5pdGlhbGl6ZSB3aXRoIGludmFsaWQg
dmFsdWVzICovCi0JaWYgKGF0a2JkX3NraXBfZ2V0aWQoYXRrYmQpIHx8IHBzMl9jb21tYW5k
KHBzMmRldiwgcGFyYW0sIEFUS0JEX0NNRF9HRVRJRCkpIHsKKwlpZiAocHMyX2NvbW1hbmQo
cHMyZGV2LCBwYXJhbSwgQVRLQkRfQ01EX0dFVElEKSkgewogCiAvKgotICogSWYgdGhlIGdl
dCBJRCBjb21tYW5kIHdhcyBza2lwcGVkIG9yIGZhaWxlZCwgd2UgY2hlY2sgaWYgd2UgY2Fu
IGF0IGxlYXN0IHNldAorICogSWYgdGhlIGdldCBJRCBjb21tYW5kIGZhaWxlZCwgd2UgY2hl
Y2sgaWYgd2UgY2FuIGF0IGxlYXN0IHNldAogICogdGhlIExFRHMgb24gdGhlIGtleWJvYXJk
LiBUaGlzIHNob3VsZCB3b3JrIG9uIGV2ZXJ5IGtleWJvYXJkIG91dCB0aGVyZS4KICAqIEl0
IGFsc28gdHVybnMgdGhlIExFRHMgb2ZmLCB3aGljaCB3ZSB3YW50IGFueXdheS4KICAqLwot
LSAKMi40My4wCgo=
--------------3AfAKs2b0Kmg9oZsVXU3SqQo
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-Input-atkbd-Do-not-skip-atkbd_deactivate-when-skippi.patch"
Content-Disposition: attachment;
 filename*0="0002-Input-atkbd-Do-not-skip-atkbd_deactivate-when-skippi.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiYjY0MzViYWVhNTJmNjZlN2FhY2E0MzUyMGJkYjFmNzFhMTgxYTVlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBNb24sIDIyIEphbiAyMDI0IDE0OjMyOjE2ICswMTAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIElucHV0OiBhdGtiZCAtIERvIG5vdCBza2lwIGF0a2JkX2RlYWN0aXZhdGUo
KSB3aGVuCiBza2lwcGluZyBBVEtCRF9DTURfR0VUSUQKCkFmdGVyIGNvbW1pdCA5MzZlNGQ0
OWVjYmMgKCJJbnB1dDogYXRrYmQgLSBza2lwIEFUS0JEX0NNRF9HRVRJRCBpbgp0cmFuc2xh
dGVkIG1vZGUiKSBub3Qgb25seSB0aGUgZ2V0aWQgY29tbWFuZCBpcyBza2lwcGVkLCBidXQg
YWxzbwp0aGUgZGUtYWN0aXZhdGluZyBvZiB0aGUga2V5Ym9hcmQgYXQgdGhlIGVuZCBvZiBh
dGtiZF9wcm9iZSgpLCBwb3RlbnRpYWxseQpyZS1pbnRyb2R1Y2luZyB0aGUgcHJvYmxlbSBm
aXhlZCBieSBjb21taXQgYmUyZDdlNDIzM2E0ICgiSW5wdXQ6IGF0a2JkIC0KZml4IG11bHRp
LWJ5dGUgc2NhbmNvZGUgaGFuZGxpbmcgb24gcmVjb25uZWN0IikuCgpNYWtlIHN1cmUgbXVs
dGktYnl0ZSBzY2FuY29kZSBoYW5kbGluZyBvbiByZWNvbm5lY3QgaXMgc3RpbGwgaGFuZGxl
ZApjb3JyZWN0bHkgYnkgbm90IHNraXBwaW5nIHRoZSBhdGtiZF9kZWFjdGl2YXRlKCkgY2Fs
bC4KCkZpeGVzOiA5MzZlNGQ0OWVjYmMgKCJJbnB1dDogYXRrYmQgLSBza2lwIEFUS0JEX0NN
RF9HRVRJRCBpbiB0cmFuc2xhdGVkIG1vZGUiKQpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdv
ZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
YXRrYmQuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9hdGtiZC5j
IGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9hdGtiZC5jCmluZGV4IGMyMjliZDZiM2Y3Zi4u
N2Y2N2Y5ZjI5NDZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2F0a2Jk
LmMKKysrIGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9hdGtiZC5jCkBAIC04MjYsNyArODI2
LDcgQEAgc3RhdGljIGludCBhdGtiZF9wcm9iZShzdHJ1Y3QgYXRrYmQgKmF0a2JkKQogCiAJ
aWYgKGF0a2JkX3NraXBfZ2V0aWQoYXRrYmQpKSB7CiAJCWF0a2JkLT5pZCA9IDB4YWI4MzsK
LQkJcmV0dXJuIDA7CisJCWdvdG8gZGVhY3RpdmF0ZV9rYmQ7CiAJfQogCiAvKgpAQCAtODYz
LDYgKzg2Myw3IEBAIHN0YXRpYyBpbnQgYXRrYmRfcHJvYmUoc3RydWN0IGF0a2JkICphdGti
ZCkKIAkJcmV0dXJuIC0xOwogCX0KIAorZGVhY3RpdmF0ZV9rYmQ6CiAvKgogICogTWFrZSBz
dXJlIG5vdGhpbmcgaXMgY29taW5nIGZyb20gdGhlIGtleWJvYXJkIGFuZCBkaXN0dXJicyBv
dXIKICAqIGludGVybmFsIHN0YXRlLgotLSAKMi40My4wCgo=

--------------3AfAKs2b0Kmg9oZsVXU3SqQo--


