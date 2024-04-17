Return-Path: <linux-kernel+bounces-148778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0EF8A8747
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B583FB21E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167E146D69;
	Wed, 17 Apr 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gTi0NYPs"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F3146D7A;
	Wed, 17 Apr 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367105; cv=none; b=jc30cybiA916xzAv/joPLki4s4Hh8pEFuP19uFyJBdXTwOj/6LNFOA7ZgLMyUuTxXC7C4JqDGFnvwuOgBTXE0LbM/bzFzDs5MoLAkZp/SzoNWxbg7RvoD+MWF3WxCtJ5dIljPU+BTChndGeYkcoYy7HMgvCdHNUxsuLMhvCvWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367105; c=relaxed/simple;
	bh=UCvKgH15XtcWuuJM3Et1GONeKzZjSa8bZhAbQjjlMj8=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOaTwu32U2PLArFDmZ8jAfdHwgdqmPq+wG+XA3X+X2y570cPchgSKjNx81kXS01nFuyrxAxAnGE75u1HohCG41LzToSWpqRq994tQptchhGV8gEql5DWmpiDCpxWEJuxyp91fjcoYJ/x1Gwq6UUCa7/a76lgFZwBqm5J63UwEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gTi0NYPs; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43HEOFsx006689;
	Wed, 17 Apr 2024 10:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=nrN3WbjM3RczYinOD+lIxoJ8mIYpDnnuJD9PvOqCy/A=; b=
	gTi0NYPsGxp67YyQT8KcF1ra/p19m+AJ/ciU3WCICu5NkZGSXlb8XI47h2LF8w1R
	bTOVMcBnTsPFaO6WioFmt72ZWnTi3uWv23MOONqEvW1QdYIIXOolHABv2cQOXqMp
	PZU2u+8/tdmeTwvsHiwrXTi3HCcFTf+VCLlD+MT7Na+hYREIbVjtXePf4wmA7KMs
	z5uCCywDJAa6t7qtrPbq8jUWSHGCU7vpL1zmAKCtzgLixTHaWf9jLnIBWvuvlE2X
	sXJjbZde8VXSiaMAWN3JCSHpuU1z90Pl+DrDD7Z//GGOv2PzLtobxDZAax/HILz7
	3AilllyD/5xQIFcgxFSYHQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhutkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:18:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 16:18:09 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Wed, 17 Apr 2024 16:18:09 +0100
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.201])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3C3B1820245;
	Wed, 17 Apr 2024 15:18:09 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'ArcticLampyrid' <ArcticLampyrid@outlook.com>
CC: <david.rhodes@cirrus.com>, <james.schulman@cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <stable@vger.kernel.org>
References: <335eb6d4-424e-43e5-8990-3d87ad579e7c@opensource.cirrus.com> <TYCP286MB25356BFBD3D67D4E1FD09732C4092@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB25356BFBD3D67D4E1FD09732C4092@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Subject: RE: Re: [PATCH] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Wed, 17 Apr 2024 16:18:09 +0100
Message-ID: <003501da90da$7495b710$5dc12530$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLIObYyTwZEKKzZlbkEcITlLVX1/QM8HhB0r3daXwA=
X-Proofpoint-ORIG-GUID: 6IAQS1ViQKnTZA5g3nJzB0i56MgXvlqQ
X-Proofpoint-GUID: 6IAQS1ViQKnTZA5g3nJzB0i56MgXvlqQ
X-Proofpoint-Spam-Reason: safe

Hi,

To clarify, was the log you attached here using:
 	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
0}, 0, 2, -1, 0, 0, 0 },
Or was it using your original value (index 1)?

The Speaker ID for this laptop should be index 2, if my ACPI for this
laptop is correct.
Both amps use the same GPIO for the interrupt line, thus the interrupt
is shared, and there is only a single interrupt line.
Disabling the interrupt on the second laptop is not a good idea, since
the interrupts are used to detect and recover from errors.

For further investigation, can you create a bugzilla ticket at the
below address and CC Cirrus Patches (patches@opensource.cirrus.com) to
it.

https://bugzilla.kernel.org/

Can you also mention which distro you are using, as well which Kernel
you are using.
Also, can you please attach a dmesg of the error, as well as the
acpidump of your laptop.
($ acpidump > acpidump.out)
(You may need to install acpica-tools to do this)

Thanks,
Stefan

> -----Original Message-----
> From: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Sent: Monday, April 15, 2024 5:50 PM
> To: sbinding@opensource.cirrus.com
> Cc: ArcticLampyrid@outlook.com; david.rhodes@cirrus.com;
> james.schulman@cirrus.com; linux-kernel@vger.kernel.org; linux-
> sound@vger.kernel.org; patches@opensource.cirrus.com;
> rf@opensource.cirrus.com; stable@vger.kernel.org
> Subject: Re: Re: [PATCH] ALSA: hda/realtek: Fix internal speakers
for Legion
> Y9000X 2022 IAH7
> 
> > According to the ACPI that I have access to, this is not correct -
the
> > Speaker ID is on index 2 not index 1.
> > Index 1 has a reference to the interrupt line. Therefore this
should be:
> >
> > 	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 2, -1, 0, 0, 0 },
> 
> Sorry, but I'm unable to retrieve the speaker ID index from my BIOS.
> Please tell me how to check it, thanks.
> 
> I've tried using `spkid_gpio_index = 2`, but haven't noticed any
changes.
> 
> > The reason for any issue you see may be
> > because you have assigned the speaker id for the interrupt gpio in
ACPI
> > as mentioned above.
> 
> Despite changing `spkid_gpio_index` to 2, it hasn't worked with
> `generic_dsd_config`.
> 
> The journal logs show:
> ```log
> kernel: Serial bus multi instantiate pseudo device driver
CSC3551:00:
> Instantiated 2 I2C devices.
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Adding DSD
properties
> for 17AA386E
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Using extra _DSD
> properties, bypassing _DSD in ACPI
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic
CS35L41
> (35a40), Revision: B2
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Adding DSD
properties
> for 17AA386E
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Using extra _DSD
> properties, bypassing _DSD in ACPI
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line busy,
> assuming shared reset
> kernel: genirq: Flags mismatch irq 58. 00002088 (cs35l41 IRQ1
Controller)
> vs. 00002088 (cs35l41 IRQ1 Controller)
> kernel:  cs35l41_hda_probe+0x94b/0x9d0 [snd_hda_scodec_cs35l41
> 5706d5af6d4d4abb9d294b49d5cd4cc8a51aad9d]
> kernel:  ? __pfx_cs35l41_i2c_driver_init+0x10/0x10
> [snd_hda_scodec_cs35l41_i2c
> 8858b01ad506c8ac36ad9a656c7cb71d39d6ec09]
> kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Failed to request
IRQ
> 58 for cs35l41 IRQ1 Controller: -16
> kernel: cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.1 failed
with
> error -16
> ```
> 
> I believe this error might be caused by the configuration of the
same IRQ
> multiple times.
> 
> Additionally, I checked the Cirrus SmartAMP driver on Windows, which
> appears to use only one IRQ (ID 58) on my device.
> Therefore, I don't believe there is a need to configure two IRQs on
my
> device.
> 
> The message `Flags mismatch 00002088 vs. 00002088` is confusing.
> Further investigation reveals that the following check in
`__setup_irq`
> failed:
> ```c
> if (irqd_trigger_type_was_set(&desc->irq_data)) {
>     oldtype = irqd_get_trigger_type(&desc->irq_data);
> } else {
>     oldtype = new->flags & IRQF_TRIGGER_MASK;
>     irqd_set_trigger_type(&desc->irq_data, oldtype);
> }
> 
> if (!((old->flags & new->flags) & IRQF_SHARED) ||
>     (oldtype != (new->flags & IRQF_TRIGGER_MASK)))
>     goto mismatch;
> ```
> 
> While the previous request used flags `0x00002088 = IRQF_ONESHOT |
> IRQF_SHARED | IRQF_TRIGGER_LOW`,
> the `oldtype` was actually `IRQF_TRIGGER_RISING` (0x1) rather than
> `IRQF_TRIGGER_LOW` (0x8), leading to the mismatch.
> 
> I am new to Linux Kernel, not sure if this is expected behavior or a
bug for
> `IRQF_SHARED`.
> Ideally, a clearer message may be provided to facilitate
understanding.
> 
> Sorry to bother you if I make some foolish mistakes.



