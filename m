Return-Path: <linux-kernel+bounces-8619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6981BA35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59E3285A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7C4B15B;
	Thu, 21 Dec 2023 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VHlOqkgc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63810801
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL8GXM6016665;
	Thu, 21 Dec 2023 09:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=UUKCRXUyzIolQ67Odwnf0tn0G/BtVWfqdW/OIg89/54=; b=
	VHlOqkgc5XBXgUxu6eh/m5IddhQBC+0RlGzeQWcMR3DNZMkRQIG5fh0TLI5z54Mp
	dUqg5GvFfhAH0EARa5s9oSGJzZsPBqcZZssQvVj8WIqub2KT1umDlilHc9runJpl
	oH/kVeLoNwO+q88jtP69Sk/0+rMwOdU1vDIjcuOfEnkOu1hAvzb9QaRG3nJ3l1aq
	/g2NoaFkgCEJ8i8R/PtZhwAkVUwfizBcOIJ/BJemScy5IuY35vRsdTu/X6oCCcPH
	vBYGZgv18j3zZXwexO5Y0lGsqU0sYN5B2+VnIDOzp+VsoQi1VdJuNYeUokmx/4Q4
	XBABs9MfMeeGY91/g3dstw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a627hj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 09:09:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 15:09:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Thu, 21 Dec 2023 15:09:17 +0000
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.132])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F327046B;
	Thu, 21 Dec 2023 15:09:16 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'Aleksandrs Vinarskis' <alex.vinarskis@gmail.com>
CC: <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>,
        <james.schulman@cirrus.com>, <josbeir@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <perex@perex.cz>, <stuarth@opensource.cirrus.com>, <tiwai@suse.com>,
        <tiwai@suse.de>
References: <8170413d-07a8-4e77-b43d-78cd9e4ea76f@opensource.cirrus.com> <20231221112434.13730-1-alex.vinarskis@gmail.com>
In-Reply-To: <20231221112434.13730-1-alex.vinarskis@gmail.com>
Subject: RE: [PATCH v2 1/2] ALSA: hda: cs35l41: Safety-guard against capped SPI speed
Date: Thu, 21 Dec 2023 15:09:16 +0000
Message-ID: <006c01da341f$aa9dcdb0$ffd96910$@opensource.cirrus.com>
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
Thread-Index: AQHBvASMLXdMRoUjXEjgpQelQ430kgGT5HMZsNgh7ZA=
X-Proofpoint-GUID: sDeIMgik0km7oVfqZVOMTz4p3zI_h9d1
X-Proofpoint-ORIG-GUID: sDeIMgik0km7oVfqZVOMTz4p3zI_h9d1
X-Proofpoint-Spam-Reason: safe

Hi,

> -----Original Message-----
> From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> Sent: Thursday, December 21, 2023 11:25 AM
> To: sbinding@opensource.cirrus.com
> Cc: alex.vinarskis@gmail.com; alsa-devel@alsa-project.org;
> david.rhodes@cirrus.com; james.schulman@cirrus.com;
> josbeir@gmail.com; linux-kernel@vger.kernel.org;
> patches@opensource.cirrus.com; perex@perex.cz;
> stuarth@opensource.cirrus.com; tiwai@suse.com; tiwai@suse.de
> Subject: Re: [PATCH v2 1/2] ALSA: hda: cs35l41: Safety-guard against
> capped SPI speed
> 
> Sorry for incorrect expression and confusion, it is indeed not the
driver
> that hangs. What I meant is that _computer_ "hangs" on wake up from
> suspend. Unlike boot, where driver does not delay boot process, on
wake
> up
> from suspend it seems it does - after lid was opened/power button
> pressed,
> with firmware loading taking ~180seconds in total, computer still
has
> black screen and is irresponsive for said duration, which is
completely
> unacceptable.
> 
> I do not have enough expertise in particular area, but it sounds
very weird
> to me that audio driver is delaying system wake up process at first
place.
> Was this intentional? I would assume/guess most correct solution
would be
> for driver to run non-blocking, like it does on boot, but again, I
am not
> too familiar with the subject.
> 
> > (~80s per amp) to load the firmware.
> 
> Besides firmware loading, there are general
initialization/communication
> taking place as well. I have disabled firmware loading to try: at a
speed
> of 3051Hz, it takes ~16 seconds on boot (non blocking, so not a big
deal)
> and ~7-8 seconds on wake up from suspend (blocking, so it is still
not
> acceptable).

In my opinion it would be wrong to kill the speaker driver because the
SPI
performance is so poor, even if the cost is an extra ~8s on wake up.
In the case where an extra 8s on wake up is unacceptable, there are
easier
ways to disable the driver without having to modify kernel code, than
if you
had to do the opposite, and re-enable it in code.

Thanks,
Stefan

> 
> I am myself extremely exited to get support for 9530 in upstream,
but I am
> just afraid that such a big wake up delay is a huge hit on a end
user, and
> would affect everyone with 9530 where intel-lpss patch was not
applied
> yet.
> 
> > Instead I would prefer that we instead disable the loading of the
> > firmware in this case.
> > Without loading firmware, the volume is much lower, but at least
you
> > still have audio.
> 
> This indeed sounds like a better approach, I did not think of that.
This
> should work much better for generic cases, but unfortunately, will
still
> not prevent devices with _extremely_ slow SPI from badly affecting
UX
> 
> Taking into account the above, and unless driver being blocking on
wake up
> can be resolved, perhaps it would makes sense to do both?
> a) Your suggestion - disable firmware loading if SPI speed is not in
MHz
> range and
> b) Do not initialize device at all, if SPI speed is ridiculously low
(like
> for example 3051 Hz)?
> 
> I have tested on 9530 without firmware loading, with SPI speed set
to
> 50000Hz: it delays wake up by ~0.9-1 seconds. Subjectively, I think
this is
> the maximum acceptable delay.
> 
> > I have a patch to do that, which I was planning on pushing up
> > (hopefully) today.
> 
> Thanks for following up on this!
> 
> >
> > Thanks,
> >
> > Stefan
> >
> > >   		/*
> > >   		 * Manually set the Chip Select for the second
amp
> <cs_gpio_index> in the node.
> > >   		 * This is only supported for systems with 2
amps, since
> we cannot expand the
> > > @@ -219,8 +232,6 @@ static int generic_dsd_config(struct
> cs35l41_hda *cs35l41, struct device *physde
> > >   		 * first.
> > >   		 */
> > >   		if (cfg->cs_gpio_index >= 0) {
> > > -			spi = to_spi_device(cs35l41->dev);
> > > -
> > >   			if (cfg->num_amps != 2) {
> > >   				dev_warn(cs35l41->dev,
> > >   					 "Cannot update SPI
CS, Number
> of Amps (%d) != 2\n",
> 
> FYI intel-lpss patch was submitted for review [1]. However, as it is
in
> different tree, it cannot be guaranteed that it will be always
applied
> when your patch for 9530 and other Dell devices will be applied,
which is
> why I am insisting on safety guard against _extremely_ low SPI
speeds.
> 
> [1]: https://lore.kernel.org/all/20231220205621.8575-1-
> alex.vinarskis@gmail.com/


