Return-Path: <linux-kernel+bounces-151633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620648AB15E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FA51F24955
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CF413049E;
	Fri, 19 Apr 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Z52YMWLv"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB312FF83;
	Fri, 19 Apr 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539385; cv=none; b=EIMOZCRZ8k6F2VJw1A/sqL0bjYf8FFd8gnfs5PUCyjQcfn5QegxfVxMSocuK0/dhJ3fZn8Ag8jkTrANuD1fcN1jRIqPlDYeT4w3gqNNF+3BbUppFbiEhX3XUVvajcFlaFk5qx23fwxZByZy837I9cbL4ABN6ilsPkQ5SO3D0YT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539385; c=relaxed/simple;
	bh=UXrRR8Rwe3eGNw6FPQ1CGv2PxvSvMhiUfVg6LFJkYNc=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=omh1kb7wxsC+mQDJBxFd4TV4UezU9ISKXmal53YERSfFJtCNkyi5juhrU5TqaMHet4SPVyVOuqbYRYD+ty08f4B+TrjqCciIGyrd5zc27elg8fmINuddQhVGQi/5H0I0m6dDa7uoPBLLRPc+TjEnKtol1yaGWr98riaNFSrOZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Z52YMWLv; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43JBUO8S003820;
	Fri, 19 Apr 2024 10:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=A9fXj62GSpn81C11BByaZ+3oCtn50jmJ5C0FCnZnlVU=; b=
	Z52YMWLv/UsRkPv6iI+bm2kU37ti04w6Z7qVxuRV6aICL1G8k9bZGBkh8+hl25I5
	T27O24PvwyBahNZgc8EUIYJIO0oOPxa9U5fh0ChA9XXTnnsj20uqqMdvodlwEn5x
	hjTRubut65G18T1wp6KDz8Zyt6FRABtk4bgm/b9XvY5/pGbT8Vtc0y0kUkxb08IG
	jvdEAQ0skz3XtQ2jqql4X7N6fo5ZGck1uUhrxbcxfnM2/+A0XE92+hgtRRdoy3rK
	JLTZUdtufcVGA0VqmyEYYlLhPtTEf7PPMY7Q4ywD0JiH5SnNiGgBuMCiwngKdsyU
	jaUMME/+tvf0gwHXwmjJuQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhwxfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 10:09:39 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 16:09:37 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Fri, 19 Apr 2024 16:09:37 +0100
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.201])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9027D820249;
	Fri, 19 Apr 2024 15:09:37 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'ArcticLampyrid' <ArcticLampyrid@outlook.com>
CC: <david.rhodes@cirrus.com>, <james.schulman@cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <rf@opensource.cirrus.com>
References: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM> <TYCP286MB253538FE76C93C032DB55212C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB253538FE76C93C032DB55212C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Subject: RE: [PATCH v3 1/2] ALSA: cs35l41: obey the trigger type from DSDT
Date: Fri, 19 Apr 2024 16:09:37 +0100
Message-ID: <004201da926b$986d8040$c94880c0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLGBaKYvvIVJPcFyfh0lTla+wDh4gIh6rgar4e74eA=
X-Proofpoint-ORIG-GUID: 2XBwu9EnbRzQkZAfZRVS81mGGkeiydAF
X-Proofpoint-GUID: 2XBwu9EnbRzQkZAfZRVS81mGGkeiydAF
X-Proofpoint-Spam-Reason: safe

Hi,

We are still investigating this issue, but I do not think this
solution is the correct one.
Configuring the interrupt in this way does not fix the interrupt, just
hides the issue.
We are still looking into what we can do to try and fix this.

Thanks,
Stefan

> -----Original Message-----
> From: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Sent: Thursday, April 18, 2024 2:20 PM
> To: sbinding@opensource.cirrus.com
> Cc: david.rhodes@cirrus.com; james.schulman@cirrus.com; linux-
> kernel@vger.kernel.org; linux-sound@vger.kernel.org;
> patches@opensource.cirrus.com; rf@opensource.cirrus.com;
> ArcticLampyrid <ArcticLampyrid@outlook.com>
> Subject: [PATCH v3 1/2] ALSA: cs35l41: obey the trigger type from
DSDT
> 
> On some models, CSC3551's interrupt pin connected to
> APIC. We need to obey the trigger type from DSDT in this case.
> 
> Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
> ---
>  sound/pci/hda/cs35l41_hda.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c
b/sound/pci/hda/cs35l41_hda.c
> index d3fa6e136744..d9c7b4034684 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <sound/hda_codec.h>
> +#include <linux/irq.h>
>  #include <sound/soc.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> @@ -1511,6 +1512,14 @@ static int
cs35l41_hda_apply_properties(struct
> cs35l41_hda *cs35l41)
>  	irq_pol = cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
> 
>  	if (cs35l41->irq && using_irq) {
> +		struct irq_data *irq_data;
> +
> +		irq_data = irq_get_irq_data(cs35l41->irq);
> +		if (irq_data && irqd_trigger_type_was_set(irq_data)) {
> +			irq_pol = irqd_get_trigger_type(irq_data);
> +			dev_info(cs35l41->dev, "Using configured IRQ
> Polarity: %d\n", irq_pol);
> +		}
> +
>  		ret = devm_regmap_add_irq_chip(cs35l41->dev, cs35l41-
> >regmap, cs35l41->irq,
>  					       IRQF_ONESHOT |
> IRQF_SHARED | irq_pol,
>  					       0,
> &cs35l41_regmap_irq_chip, &cs35l41->irq_data);
> --
> 2.44.0
> 



