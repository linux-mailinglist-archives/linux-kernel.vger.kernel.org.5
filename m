Return-Path: <linux-kernel+bounces-31114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C82832931
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038F91C2386D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B134F1E6;
	Fri, 19 Jan 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CNGj36zX"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76D4CB5C;
	Fri, 19 Jan 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665006; cv=none; b=a6IsCTr05Nt4fj4GZPNsz0vkLU2XISirFQolORKXBhsgrS+p1hnQPWn0NlTEDjzu0Ri8McKiqiz/1yDw/VlkV9XJHq3FjhPAGU+qXoOiVqdzBre4AyjSxzposclZmoRkX2YOUFRUwPPdSKoPzrYBijK27A47vcvKjbQ2PCM4SjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665006; c=relaxed/simple;
	bh=s9L1qJwsp4OAkf5SryxRyzJmBumOjZ70oxKuHDq5NsA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgcLl8onDdzo3RM+vHvFFQ++rIhMQSzCjp1rpQcKTg6wXH7YURJQNEBicnsIgg0HdaYRnsYAkMx9A4WQW7onXs0rFAx9X4OThNLS1kyJMPI8tdtaSBsG2gSgBt7sMUCJ6vE+Ciy+3TaJK/nNy48vttz7TLXAirUAL+gehdjiVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CNGj36zX; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JAUOEC006784;
	Fri, 19 Jan 2024 05:49:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=7HmR5LukPFENdAY
	Knf4Yvibno9UDj7vaugDLawgj4Rw=; b=CNGj36zXSShnUf0vSbvu+L4Eh3M/acH
	vAwqfSbGuDdUaflB+OkBh/clU8F511tKAI1vJh6BzZgs829EmjHjj9MrbiX25WmA
	pElomK/vEAgdm35tcl9wPHe4GDowVdLnomVz7IFUDeTym7GhnmqtOD4BMHgfZNjZ
	qEg7gJ74QX0AFICSLNW+0TIN1/K+4NdGsd58+HJbtfzlqpWFj/QkfzCDXyLcyGE2
	OSIssmpIUFzprG8q7ucyTVikkqXLQkpADlRA9xJUzoBE3SZuBoYVSgPDF4Zhi4IE
	tIhriXygpoP+JOOrYqZDVx9SFJ5XZDM/+yF9je+/ToXPQcIwHdAO2jw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vkqtn8ne8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 05:49:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 11:49:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 19 Jan 2024 11:49:17 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C11A15B9;
	Fri, 19 Jan 2024 11:49:17 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:49:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] spi: cs42l43: Add SPI controller support
Message-ID: <20240119114917.GB16899@ediswmail.ad.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-6-ckeepax@opensource.cirrus.com>
 <ZalahZkCrBm-BXwz@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZalahZkCrBm-BXwz@surfacebook.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: ohyvYjG1e8LtKWvMGVOYufhV_Sssc_Ns
X-Proofpoint-GUID: ohyvYjG1e8LtKWvMGVOYufhV_Sssc_Ns
X-Proofpoint-Spam-Reason: safe

On Thu, Jan 18, 2024 at 07:06:13PM +0200, andy.shevchenko@gmail.com wrote:
> Fri, Aug 04, 2023 at 11:46:01AM +0100, Charles Keepax kirjoitti:
> > +		while (buf < block) {
> > +			const u8 *word = min(buf + sizeof(u32), block);
> > +			int pad = (buf + sizeof(u32)) - word;
> > +
> > +			while (buf < word) {
> > +				val >>= BITS_PER_BYTE;
> > +				val |= FIELD_PREP(GENMASK(31, 24), *buf);
> > +
> > +				buf++;
> > +			}
> 
> Is this a reinvented way of get_unaligned_*() APIs?
> 
> > +			val >>= pad * BITS_PER_BYTE;
> > +
> > +			regmap_write(regmap, CS42L43_TX_DATA, val);
> > +		}
> 
> ...
> 
> > +			while (buf < word) {
> > +				*buf = FIELD_GET(GENMASK(7, 0), val);
> > +
> > +				val >>= BITS_PER_BYTE;
> > +				buf++;
> > +			}
> 
> put_unaligned_*() ?
> 

Alas as it has been a while I have forgetten the exact context
here and this one will take a little more time. I will try to
find some spare time to work out if that would actual do the same
thing, I have a vague feeling there was something here.

> ...
> 
> > +	if (is_of_node(fwnode))
> > +		fwnode = fwnode_get_named_child_node(fwnode, "spi");
> 
> You can actually drop these is_of_node() tests and use another variable. In
> ACPI there can't be child node in small letters.
> 

is_of_node feels pretty clear what the intent is, rather than
relying on nodes not existing etc.

> But main problem here (and in another driver where the similar is used) that
> you bumped reference count for fwnode. I haven't seen where you drop it back.
> Have you tested rmmod/modprobe in a loop?
> 

Yeah it should drop the reference will add that.

> > +	devm_pm_runtime_enable(priv->dev);
> 
> No error check? Why?

Happy to add one.

> > +	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
> > +	if (ret) {
> > +		pm_runtime_disable(priv->dev);
> 
> Ah! Are you sure you properly simulated faults when testing this code?

This one has already been fixed.

Thanks,
Charles

