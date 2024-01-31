Return-Path: <linux-kernel+bounces-46731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEDE84434D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D769BB2C631
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9DC1292DB;
	Wed, 31 Jan 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kf3hVBn4"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176978B7E;
	Wed, 31 Jan 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715739; cv=none; b=MNSeLpfIVfrCTGIwCzUD5M+xuTjlY0IxxjcxRge7EH9MnmMgFgH7j07ISFZZitmxZfOre33dW87LNg/uYZkbJOgOSYvUWP7LxarZHb9qMen7E504wXVXBOowln74tKHJa2Xu5OapC7iCdUFnoLUN/5+rNEU5ERWuXel8guz/qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715739; c=relaxed/simple;
	bh=ejQDb/K2pqX/zGSPCSBHEbX1yV2ewgTMosiZWj4uTBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+W3SC4thgaSZj8LDP/SUwIp8oPRcDz4fwQfpAsTXDEHlWbsvSnPT9Fb+MewcyrdhjpR0hfYA7OzsFje0VLbDRb4VMosm2oxQWMB5fIkrhSGqL+ekIAtxacjyjKmlP4juSbqK02X8H+6/4cidHN5SwnJYGVIqw1iU8O7xF9Ot7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kf3hVBn4; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V6hZO0021183;
	Wed, 31 Jan 2024 09:41:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=9zRUek2aBogSyza
	Uq35rUcFSlWZ+bDNLWJplCN5AqvU=; b=kf3hVBn4657bGK2vMU8xTyDRMQHDBgR
	H3anUKrF9Dz5CGVcpuhAYctmIxGyI31uJYCOcX/tAbRIHCz7QsCPMQba0rdXAUyr
	j/aV6QrzHvDAuYLZVFS0XaujRBqrsQz85icFVof9M+MsLt9oQ7GM6MuffT/GST2W
	mH2v3++KgWjLaMzvJGT2nm8h6vRWCA9gVbmiLdQOSvrOubQuZaxaCSk6uh4uLZ41
	qvL8Tp8YHVihJf1qppFIbvcS41KlhyIRvFF6DT03bobA9qzc9Nl1eWJ0eFs44WCV
	10NdwDpC0R17N1i8IuKam9Kx6k2ULa3mjMouoWLebcTPgcZYHbfjGNw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043vw4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 09:41:54 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 15:41:51 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 31 Jan 2024 15:41:51 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id A2CE8820242;
	Wed, 31 Jan 2024 15:41:51 +0000 (UTC)
Date: Wed, 31 Jan 2024 15:41:50 +0000
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
Message-ID: <ZbpqPuDj/v07yZ5y@ediswmail9.ad.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-6-ckeepax@opensource.cirrus.com>
 <ZalahZkCrBm-BXwz@surfacebook.localdomain>
 <20240119114917.GB16899@ediswmail.ad.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240119114917.GB16899@ediswmail.ad.cirrus.com>
X-Proofpoint-ORIG-GUID: tm09R4IRvormBltDxfOzMXF9SxmrUytb
X-Proofpoint-GUID: tm09R4IRvormBltDxfOzMXF9SxmrUytb
X-Proofpoint-Spam-Reason: safe

On Fri, Jan 19, 2024 at 11:49:17AM +0000, Charles Keepax wrote:
> On Thu, Jan 18, 2024 at 07:06:13PM +0200, andy.shevchenko@gmail.com wrote:
> > Fri, Aug 04, 2023 at 11:46:01AM +0100, Charles Keepax kirjoitti:
> > > +		while (buf < block) {
> > > +			const u8 *word = min(buf + sizeof(u32), block);
> > > +			int pad = (buf + sizeof(u32)) - word;
> > > +
> > > +			while (buf < word) {
> > > +				val >>= BITS_PER_BYTE;
> > > +				val |= FIELD_PREP(GENMASK(31, 24), *buf);
> > > +
> > > +				buf++;
> > > +			}
> > 
> > Is this a reinvented way of get_unaligned_*() APIs?
> > 
> > > +			val >>= pad * BITS_PER_BYTE;
> > > +
> > > +			regmap_write(regmap, CS42L43_TX_DATA, val);
> > > +		}
> > 
> > ...
> > 
> > > +			while (buf < word) {
> > > +				*buf = FIELD_GET(GENMASK(7, 0), val);
> > > +
> > > +				val >>= BITS_PER_BYTE;
> > > +				buf++;
> > > +			}
> > 
> > put_unaligned_*() ?
> > 
> 
> Alas as it has been a while I have forgetten the exact context
> here and this one will take a little more time. I will try to
> find some spare time to work out if that would actual do the same
> thing, I have a vague feeling there was something here.
> 

Ok found some time to refresh my memory on this.

The main issue here was as this is processing raw data for the
SPI we shouldn't assume the data is a multiple of 4-bytes. You
could write the code such that you used put_unaligned_le32 for
most of the data and then special case the remainder, which would
probably be slightly faster. But for the remainder you either end
with the code here anyway or a special case for each of the cases
8,16,24 bits. So the code ends up looking much messier.
Personally I am inclined to leave this unless performance on the
SPI becomes a major issue.

There is perhaps an argument for a comment in the code to explain
this given it took me time to remember what was going on.

Thanks,
Charles

