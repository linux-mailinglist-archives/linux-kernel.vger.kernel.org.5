Return-Path: <linux-kernel+bounces-44495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156478422D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C528E29746C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E733679E4;
	Tue, 30 Jan 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UES6Peze"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FB66B29;
	Tue, 30 Jan 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613575; cv=none; b=Eu813VhJ3wDdY5GJXSEoQGUYlvsS2lgY6pWu1AGB80h/FHE2guv350E0BxdjmPsDrgU/E+2o1JP/8GoaxF6X3AbDA1fCQoPGYNheIs3b0C9zixkErP5+2+xoJuffDQbj4nmRtUYJ5t95VLO9nrrwhRdR+jDy/5WX1KzOsM/0z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613575; c=relaxed/simple;
	bh=s70PcDfdKXIabz66bTOUuUFV2uNNbNxl1c/riZr0MiQ=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cs+VhR8VpjZw+k2od27kUpHdvBIYJl7RVunWShvW2n2jgrAsdj029/7iEJUZgruep33M0H5eZcOianuQ93CqNZfchl3Ma+0NldQ9D5GcRvvNczkjvmoSMCr8z/gGFx13N19D2hzL/dkgwOn+UeDyCJu31S+vibm0b/ixPOrhsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UES6Peze; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U6iRsK012474;
	Tue, 30 Jan 2024 05:19:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=Ukr1kR4PFuuto5kMeCHeJHaq5ynfZ1UT2dmL/7dyb4k=; b=
	UES6PezeE76ROxOmmxDiwBhE2hq3PdiS2dOR1RgbbD7snLVIEjpAEnIe038MG4CS
	EEMB7feNI4IaZTgMVTyd468BE5CU19w9FPFc2k13QuKlFLPSHbh2wHQIikU6uIQ/
	BlNGCE91LjNvSww2/NhX5dVcN31H+dGTzF7jBabFe3l4fgxejWe+bGHVYUvX6/c/
	hG2fJKVIwl22PRVONIMYWNBneYzUAQscTz9XDQCcJEqbkdykFuUa0VT4kQmEcE75
	kiOxpAHQ/TibXwPOdcemDVTlliQHmYLh9ZxJ3eguZ41CS/axqCy5J7JCGJG8ZGh6
	0hO1Dv3UKR4JSBo4bLhIdA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nu8bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 05:19:18 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 11:19:17 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 11:19:17 +0000
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.65.148])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0CD31820241;
	Tue, 30 Jan 2024 11:19:17 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'Takashi Iwai' <tiwai@suse.de>, 'Kenzo Gomez' <kenzo.sgomez@gmail.com>
CC: <alsa-devel@alsa-project.org>, <david.rhodes@cirrus.com>,
        <james.schulman@cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <perex@perex.cz>, <rf@opensource.cirrus.com>, <tiwai@suse.com>
References: <874jfdwsfg.wl-tiwai@suse.de>	<20240127164621.26431-1-kenzo.sgomez@gmail.com> <87jznr3wvs.wl-tiwai@suse.de>
In-Reply-To: <87jznr3wvs.wl-tiwai@suse.de>
Subject: RE: [PATCH v3] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
Date: Tue, 30 Jan 2024 11:19:16 +0000
Message-ID: <001401da536e$29b9a070$7d2ce150$@opensource.cirrus.com>
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
Thread-Index: AQMwSTp61jXDtCjZqGhsSN60gQXN/ADh2+gYAkptiTOuLOdmIA==
X-Proofpoint-ORIG-GUID: FiXCtoKUHx4eaglYTZ9jVRv6zeFZnGXQ
X-Proofpoint-GUID: FiXCtoKUHx4eaglYTZ9jVRv6zeFZnGXQ
X-Proofpoint-Spam-Reason: safe

Hi,

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, January 30, 2024 11:05 AM
> To: Kenzo Gomez <kenzo.sgomez@gmail.com>
> Cc: alsa-devel@alsa-project.org; david.rhodes@cirrus.com;
> james.schulman@cirrus.com; linux-kernel@vger.kernel.org; linux-
> sound@vger.kernel.org; patches@opensource.cirrus.com;
> perex@perex.cz; rf@opensource.cirrus.com;
> sbinding@opensource.cirrus.com; tiwai@suse.com
> Subject: Re: [PATCH v3] ALSA: hda: cs35l41: Support additional ASUS
> Zenbook UX3402VA
> 
> On Sat, 27 Jan 2024 17:46:21 +0100,
> Kenzo Gomez wrote:
> >
> > Add new model entry into configuration table.
> >
> > Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>
> 
> Cirrus people, could you take a look?
> I'm inclined to take as is, unless you have any objections.

Looks good to me.

Thanks,
Stefan

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/cs35l41_hda_property.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/sound/pci/hda/cs35l41_hda_property.c
> b/sound/pci/hda/cs35l41_hda_property.c
> > index 35277ce890a4..59504852adc6 100644
> > --- a/sound/pci/hda/cs35l41_hda_property.c
> > +++ b/sound/pci/hda/cs35l41_hda_property.c
> > @@ -76,6 +76,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] = {
> >  	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 0, 1, -1, 1000, 4500, 24 },
> >  	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 1, 2, 0, 1000, 4500, 24 },
> >  	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 1, -1, 0, 1000, 4500, 24 },
> > +	{ "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 1, 2, 0, 0, 0, 0 },
> >  	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 1, 2, 0, 0, 0, 0 },
> >  	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 1, 2, 0, 0, 0, 0 },
> >  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0,
> 0 }, 0, 1, -1, 1000, 4500, 24 },
> > @@ -410,6 +411,7 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] = {
> >  	{ "CSC3551", "10431533", generic_dsd_config },
> >  	{ "CSC3551", "10431573", generic_dsd_config },
> >  	{ "CSC3551", "10431663", generic_dsd_config },
> > +	{ "CSC3551", "104316A3", generic_dsd_config },
> >  	{ "CSC3551", "104316D3", generic_dsd_config },
> >  	{ "CSC3551", "104316F3", generic_dsd_config },
> >  	{ "CSC3551", "104317F3", generic_dsd_config },
> > --
> > 2.43.0
> >



