Return-Path: <linux-kernel+bounces-58472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAAC84E6EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5E928747C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1123823D2;
	Thu,  8 Feb 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cDLYybtF"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD381AC7;
	Thu,  8 Feb 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414073; cv=none; b=Dj/9Y36OfiEB8lNi21e46bnqgAYI9z/V3o6WMfM3y3Gwdg8NewXnbMevOsp2Bdm6l0ltZcmYDNCdHqOqwGIml4H2+FDsqaBX9XZ8kcdQylyAsGtFbv0H9E3YwIFTmsrL/VqIgTUatnx5T+2lGsysR3JGk6yDe70ToMD9FQPKE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414073; c=relaxed/simple;
	bh=OHpjNeUd8rfGn2M/yr+06fB/dBBJtjGpyc+A8UCE5S4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2pM24z8X4xEf6ZkEIYnTpC56IPw68oiHU2XgyC8lskGItPUGpTKXE51Sc3Qhd2e+xi2PhPg5BWuX0YlAqLFEDvSKQq3uRpPvtVLNl1HANDPtq0XISPbNdgwE6SWp4t3vPFLcWOCyrCvcVaa4Vyegu94RI5Oj1kbv9F4H4Y9zlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cDLYybtF; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418BPM4L023756;
	Thu, 8 Feb 2024 11:40:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=ulMqF2iefaKOhVi
	jWnH68eJsum+vHDPM0L2QKJzokJc=; b=cDLYybtFiM03GEAr65RkB+IFfQkUanp
	0wP3eCCo21L9XGIbEEJjUggi2i3CtipQSEzcCi2l2k1EsL9GD/d0iLIF4V2bjQqR
	KqthiKwabpaqdnmYTvNFBcqXSa5MEr3Cig1454zjTZxkM3it/DmCloozr+i+5RJM
	aKFa/oRZM3LwfcbXMSuEqzszOfjcBTuxbGaLFWk578OSZOY3Kp+bt/LKsMmJzFqA
	Lba3TikG1OQxrIyZTxw2CVDHXVAHQ/5LYpkz8e5IKog0i3PGrvKmPaLDs8jX8Okg
	eGSHvZ0srMEOJ+knXkSXtyBHwra6nqJM4RlR+1yYp0NwJdk35+//koA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3w46p7a2yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 11:40:52 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 17:40:51 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 8 Feb 2024 17:40:51 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 0E5D7820241;
	Thu,  8 Feb 2024 17:40:51 +0000 (UTC)
Date: Thu, 8 Feb 2024 17:40:50 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
CC: <broonie@kernel.org>, <andy.shevchenko@gmail.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-ID: <ZcUSIoAXmYsm0Lui@ediswmail9.ad.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
 <170740158622.1056271.11724106959925085700.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170740158622.1056271.11724106959925085700.b4-ty@kernel.org>
X-Proofpoint-ORIG-GUID: ROE_9VbixP1biOM_fGCDi9CHuq8nzohH
X-Proofpoint-GUID: ROE_9VbixP1biOM_fGCDi9CHuq8nzohH
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 08, 2024 at 02:13:06PM +0000, Lee Jones wrote:
> On Mon, 29 Jan 2024 15:25:52 +0000, Charles Keepax wrote:
> > Including some missing headers.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/6] spi: cs42l43: Tidy up header includes
>       commit: 0863c47b4147b948a23f03031ac880096512a878

Thanks all, sorry about the confusion I really should have kept
including the blurb I did on the first version of the patch that
pointed this out explicitly.

Thanks,
Charles

