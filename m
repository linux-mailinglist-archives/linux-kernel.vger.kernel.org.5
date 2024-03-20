Return-Path: <linux-kernel+bounces-108253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470E88086C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289631C222AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B867E8;
	Wed, 20 Mar 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="I81Z0psl"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994B622;
	Wed, 20 Mar 2024 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710893563; cv=none; b=Th8mFZ4FKl65+4VmXm7FQsxOG3c1k4qAouo5uSdVbJvCpJHkI/AJSQSQfIzUkIoZI8v1v/K6eFfHmd07Xy77Qhhhgy791hd+/c1Mrl1uuxwlqRzS7CMaxzzDTXgrrwwU4AyYnF8PS/PzYfNDpnj3YOxa5YL+4HMQTHNtUGtFZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710893563; c=relaxed/simple;
	bh=DDq9d4RWSMovsK3RcjrSeNColdro937nI8yanZ1E+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm4Rp71VvFKPNIoWdE7nVpV855/0lwRz3ns66dpX4w9dqYqcbkk+RZWJphMf5qZgcHooXN6rxjqPQeiXUVq71i6vrAasmsen6ZOGl+SUOn8gRn9DpFwjUCZbCE8PhfSWyhfnYULQPZhRBSSnLtDJJ+XFSPvoNE3xrMue8bebGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=I81Z0psl; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1710893551; bh=DDq9d4RWSMovsK3RcjrSeNColdro937nI8yanZ1E+DE=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=I81Z0pslmiDaZIKQHOmFnU9QTtgG3qHWt/XsS+/mqMkFu4AUMHLtHAnjfJWI6//0m
	 SQDAjyvbnMOjdq8OzU+aEaELTGEtRW8kq/KRCBLUshMR1dFxat2FO0d0ZKNZEP/LT/
	 zhLcK8DD+6cQCTTwOp2MG6CjXabM7vhqaf28/OXs=
Date: Wed, 20 Mar 2024 01:12:31 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <j.w.r.degoede@gmail.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/5] power: supply: axp20x_usb_power: set input
 current limit in probe
Message-ID: <73j4grggnygltxrw6l44w53bjdc2e52c5m2ld5s6dg2q4plmrf@oicpllrnw53c>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren <aren@peacevolution.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <j.w.r.degoede@gmail.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@bootlin.com>, 
	Sebastian Reichel <sre@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240130203714.3020464-1-aren@peacevolution.org>
 <20240130203714.3020464-6-aren@peacevolution.org>
 <6nf7h3nc4q7fwrnm4spmgv2sdkczowkfpietcv2tyv4mixkq3b@svxgzkdqnzlq>
 <hlnzivsmt66icz4bsayv5wtlgbktq355m4qxj532lg4lgeimju@jammw2y6zpha>
 <uktr265th6h4btay765p33zgihuzgafu25rz7npwfm3ojhq2tm@wvrymmf3xtxy>
 <jzmibxh5avq4oxbldzayi754s6ir3e5zcphh4sfwzrl72j4msa@qersxklkpmtx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jzmibxh5avq4oxbldzayi754s6ir3e5zcphh4sfwzrl72j4msa@qersxklkpmtx>

Hi Aren,

On Thu, Mar 14, 2024 at 06:39:52PM -0400, Aren wrote:
> > Also in Pinephone case, you'll not really have a case where the battery has
> > < 2V not loaded. That's not going to happen. PMIC will shut off at 3V battery
> > voltage when loaded. It will not discharge further, and after shutoff battery
> > voltage will jump to 3.4V or so, and it will not drop below 2V after that, ever.
> > So the battery will pretty much always be detected as long as it's present.
> 
> The most likely case I can think of is if someone intentionally tries to
> boot the device without the battery. I suspect it's also possible for a
> battery to degrade to the point where it won't hold a charge.

Yes, that's my usecase that I'd like to preserve. Pinephone has removable
battery and using it without battery is quite reasonable. It works fine
currently for me and this patch will break this if there's no opt out. And
there's no opt out other than patching and re-building the kernel.

> > What actual problem have you seen that this patch is trying to solve?
> 
> The problem, in theory, is that the pmic ignores the USB BC
> specification and sets the current limit to 3A instead of 500mA. In
> practice (as long as the power supply is implemented properly) if this
> is too much power, it should just cause the power supply to shut off.
> I'm not sure how likely / what the risks of a power supply cutting
> corners are.

Pinephone with no battery takes between 0.5-1A from VBUS. Even under full
load, it's not enough to damage even a USB 3.0 SDP port. It's only a
slight problem for unprotected USB 2.0 SDP ports. On protected 2.0 ports
or ports with overdesigned output power, it will either shut down due
to brownout, or just work.

It's not enough to overload any actual USB charger.

In any case, people wanting to run Pinephone without a battery probably
will not do so from a USB 2.0 computer port. Maybe for FEL USB mode, for
development or flashing, but at that stage the power consumption is still
very low, well below 2.5W.

> I find it surprising that the hardware/driver takes a lot of care to
> figure out what the proper current is and stick to that, except when
> there isn't a battery.

It seems to have apparent purpose documented in the datasheet:

  https://megous.com/dl/tmp/78d4c0771fc6d2c8.png

"If Battery not present, and this bit is 0,the VBUS current limit set to 3A,
for the F/W update in factory"

You can also get rid of the issue by writing 1 to:

  "REG 2DH: BC Module VBUS Control and Status Register" bit 6

in the bootloader very early on before enabling BC. That should fix the issue,
too in a more proper way than forcing 500mA limit halfway during boot, when
BC1.2 detection might have detected something higher earlier on and the boot
success depends on the higher value.

> battery. The datasheet says that register 0x2D bit 6 is used to indicate
> first power on status. According to it, if that bit is 0 and the battery
> is not detected, it will set the input current limit to 3A, however
> setting that bit to 1 doesn't to prevent the pmic from setting the
> current limit to 3A.

Actually it does (I made a quick test with Pinephone with no battery being
plugged to the PC's USB port and executing a test program over FEL that talks to
the PMIC):

PMIC registers: (initial values post-powerup with no battery)

2c: 0    - BC disabled by default, something has to enable it
2d: b0   - bit 6 not set (*not* first boot bit)
2e: 40
2f: 0
30: 1
31: 3
32: 43
33: c5
34: 45
35: 68   - initially 3A limit
36: 59
37: 0
38: a5
39: 1f
3a: 80

changed values

2c: 5    - test program enables BC
2e: 0    - disable DB detection (otherwise with no battery DB detection will
           prolong BC detection result by 45minutes or whatever is the timeout)
	   see DBP_Timeout_CTL(DBP Hardware Timeout Control)
2f: 10
30: 2a
35: 38   - test program sets 1.5A limit
36: 8

.. about 400 ms later

2c: 1    - BC complete
2f: 30   - BC result = SDP (matches reality)
35: 68   - 3A VBUS limit set by PMIC itself


Another run with 2d.6 bit set:

(initial values omitted, same as above)


changed values

2c: 5   - enable BC
2d: f0  - bit 6 set (*not* first boot)
2e: 0
2f: 10
30: 2a
35: 38   - test program sets 1.5A limit
36: 8

.. after about 400 ms

2c: 1   - BC complete
2f: 30  - BC result = SDP
35: 18  - 500mA VBUS limit set by PMIC itself


So the detection works with no battery inserted. PMIC's BC correcly detects
regular USB 2.0 data port and configures a correct limit in about 400ms
after cable plug in. So I don't see a problem with the HW, that you're
describing in the commit message.

The proper way to handle this issue is to fix whichever component is configuring
the BC detection initially (it's disabled by default, apparently), to properly
set the first boot bit before enabling BC. IMO, that place should be the
platform firmware. Then the detection will work from the get go and proper limit
will be always set correctly and will match the USB charger, and there will be
no need for any kernel hacks.

Pretty much what platform FW should do is to:

- set "not first boot bit" in 0x2d register
- check if battery is present
  - if not clear 0x2e register
  - otherwise configure DBD in 0x2e
- configure DCP/CDP current limit to 1.5A or 2A (1.5A maybe safer)
- configure VBUS Vhold to 4.5V (Pinephone needs this for powered USB dock to
  work with in general with arbitrary chargers, and it will overload weaker
  USB PSU's less)
- configure BC detection and start it

My usecase of using Pinephone without battery will still work, too, and will
not be broken by this patch.

> The point of this patch (after a revision) should be to make it explicit
> when and why this driver ignores the USB BC specification. And to reduce
> the cases where it does, if possible.

The kernel has no business forcing the limit to some fixed low value that
has no relationship to the last BC detection result and breaks boot in
the exact scenario this patch is targetting (no battery -> too high current
limit).

This doesn't make any sense to me.

kind regards,
	o.

> With the goal of making it explicit what cases ignore the spec, I would
> prefer to have an opt-out mechanism. I compiled what I believe to be a
> full list of devices that use this driver with usb bc enabled (detailed
> notes below), and there's only a handful of them. It shouldn't be too
> difficult to out-out the boards that need it.
> 
> > 
> > Thank you and kind regards,
> > 	o.
> 
> Sorry it took me a while to respond, I haven't had much time to work on
> this in the past few weeks.
> 
> Regards
>  - Aren
> 
> p.s. the notes on what devices use this functionality:
> 
> These devices include the axp803 or axp81x dtsi:
> $ rg -l 'include "axp(803|81x).dtsi"'
>  - sun50i-a100-allwinner-perf1.dts
>  - sun50i-a64-amarula-relic.dts
>  - sun50i-a64-bananapi-m64.dts
>  - sun50i-a64-nanopi-a64.dts
>  - sun50i-a64-olinuxino.dts
>  - sun50i-a64-orangepi-win.dts
>  - sun50i-a64-pine64.dts
>  - sun50i-a64-pinebook.dts
>  - sun50i-a64-pinephone.dtsi
>  - sun50i-a64-pinetab.dts
>  - sun50i-a64-sopine.dtsi
>  - sun50i-a64-teres-i.dts
>  - sun8i-a83t-allwinner-h8homlet-v2.dts
>  - sun8i-a83t-bananapi-m3.dts
>  - sun8i-a83t-cubietruck-plus.dts
>  - sun8i-a83t-tbs-a711.dts
> 
> Out of those only these enable usb_power_supply:
> $ rg -l 'include "axp(803|81x).dtsi"' | xargs rg -l 'usb_power_supply'
>  - sun50i-a64-bananapi-m64.dts
>  - sun50i-a64-pinetab.dts
>  - sun50i-a64-pinephone.dtsi
>  - sun8i-a83t-tbs-a711.dts
>  - sun8i-a83t-cubietruck-plus.dts
>  - sun8i-a83t-bananapi-m3.dts
> 
> sun50i-a64-bananapi-m64.dts: The barrel jack is connected to acin, so
> will be unaffected. Banannapi docs say it's not possible to power over
> usb, but schematic suggests it should work. Probably needs to opt-out of
> the lower current limit.
> 
> sun50i-a64-pinetab.dts: unclear if charging is supported via usb, vbus
> is connected through a component listed as "NC/0R". Regardless device
> has barrel jack and battery for power, shouldn't need to run exclusively
> from usb.
> 
> sun50i-a64-pinephone.dtsi: is typically booted with a battery connected,
> shouldn't need to run exclusively from usb.
> 
> sun8i-a83t-tbs-a711.dts: has an internal battery, shouldn't need to run
> exclusively from usb.
> 
> sun8i-a83t-cubietruck-plus.dts and sun8i-a83t-bananapi-m3.dts: Both
> appear to support being powered over usb and a barrel jack. These will
> need to opt-out to be able to run from usb.

