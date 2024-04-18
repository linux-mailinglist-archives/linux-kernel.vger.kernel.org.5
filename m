Return-Path: <linux-kernel+bounces-149931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F48A9801
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49511B213E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101915E1EF;
	Thu, 18 Apr 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cgVhfUZV"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423C15E5C7;
	Thu, 18 Apr 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437899; cv=none; b=hCFcYJ4lzXZu2C9rA0GqdBkESBXsjB1DMxfv+ZzzmG7+zvnpebmI0JteduCTdHgS8aeztzHPhzW86CBaI8qHGbc8ZVgy7pMWD1BiAb9mNSOOLT4xIMQcGBpe0qmD22C315Jie/2u+wvljoG7HbYYsxcsl3wduEjYM13JY1YCNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437899; c=relaxed/simple;
	bh=aG5dZ+d3QHN3xIqCCpbZWxkzuRvR4q/UcWO1COl9Q8U=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5HwpFj9p1HYYfi5g3o6bBrU8cfCFvux0XuApeSsy16PjmQbnq6WkNMAxtL4OMkqHnwD4i6jntYwgO+/WMOC7F+AR9lVxvHcTOdMjIYzNwm3KILRuJK6OFg+6sz3PuEx3vyIA63sN6OPmy89R2cdY3lwFfpgb+fuuKfOwslEN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cgVhfUZV; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I4kSKS025732;
	Thu, 18 Apr 2024 05:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=7sFDW0pZEjFEt7FMhT7204tWMxNby+5KfqvWAUN05Ao=; b=
	cgVhfUZVMBcR8qpJFP+/n5c2j1c7OvZyRCR00nZcl7+VjWrmNfLZuwbiMF+YHqfZ
	psgb6iv9G8xmm5I0fGeL4jONW6H3KEMNNLb8LJydv8T2Lx7toRoFkqp9jbCvaNj+
	NeYRWdIkSl3V89NaxrJtlBWfnUngab5yPg++Lzn7nCoeRJC+m3W1+55seAq6XmPV
	1VrMd5UDnBQqUk8fXRXsBleTLPZ2I39rj6Y4rcavBDNTq+sDM5jiwGc8s5zSyKN/
	A+NyhXPffPVP7gdTbB9gYgTVbUaiUtKJG1/WZXFm3ksE0R5uRC7bulsvLOQpbQxk
	EwChqLbom4oom1u3B+4z1w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeycn9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:58:15 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:58:13 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 18 Apr 2024 11:58:12 +0100
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.201])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AB399820245;
	Thu, 18 Apr 2024 10:58:12 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'ArcticLampyrid' <ArcticLampyrid@outlook.com>, <james.schulman@cirrus.com>,
        <david.rhodes@cirrus.com>, <rf@opensource.cirrus.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM> <TYCP286MB253551BDCC83320C246BD494C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB253551BDCC83320C246BD494C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Subject: RE: [PATCH v2 1/2] ALSA: cs35l41: obey the trigger type from DSDT
Date: Thu, 18 Apr 2024 11:58:12 +0100
Message-ID: <002001da917f$4ebdb2e0$ec3918a0$@opensource.cirrus.com>
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
Thread-Index: AQJzUjqa4IlF22ZsXxMyjNS9IQLhdQHJdBdKsC4OJvA=
X-Proofpoint-GUID: zUNP5uEu8i7xy497Qi-UziALsKJh1S6N
X-Proofpoint-ORIG-GUID: zUNP5uEu8i7xy497Qi-UziALsKJh1S6N
X-Proofpoint-Spam-Reason: safe

Hi,

Looking at the ACPI attached previously, this issue needs some more
investigation.
I don't think this patch is a good idea, since it is unknown what
effects this patch will have on other laptops.

Thanks,
Stefan

> -----Original Message-----
> From: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Sent: Thursday, April 18, 2024 7:46 AM
> To: james.schulman@cirrus.com; david.rhodes@cirrus.com;
> rf@opensource.cirrus.com
> Cc: patches@opensource.cirrus.com; linux-sound@vger.kernel.org;
linux-
> kernel@vger.kernel.org; ArcticLampyrid <ArcticLampyrid@outlook.com>
> Subject: [PATCH v2 1/2] ALSA: cs35l41: obey the trigger type from
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



