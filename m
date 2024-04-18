Return-Path: <linux-kernel+bounces-150128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A768A9AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC161F25B71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9821635B7;
	Thu, 18 Apr 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WDVttgJs"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B41411E4;
	Thu, 18 Apr 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445396; cv=none; b=SutHwG96eetuvZ77u+9+dDBZ22mlb0KCuHkTh3ZAinI+nCVppKSf7R6kbFt55lX3pbhNWFHiOqs8hYsgga3icXEF315afqo8+RK4kYAyNMh+autqnqOzhiSAjca5SdJDVneFi5J83AL6KVLgMS0qqovG3eDfm4s2RDhFdV0rXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445396; c=relaxed/simple;
	bh=Zb0FoMjxs0n61sYEGfUe+TJZmKIF3dIF1soB4gHZJSs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6gmNxxjWXqxArDaX6eufiemKXijbtq8OZOUWRpaqAadSIHo3oajgRfjDlwGD4vbtug/j2EbLihjlkf/xYNoo2WpplYZXhWdL10HtOTmGGK4TgYinQugrG9iw1tSDEIk5hIVvA5WpLlyWwZtiAh3Y00cN1Nvwmj+MT0+gDzW2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WDVttgJs; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I4jfe8023908;
	Thu, 18 Apr 2024 08:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=r8zK1/13z0HJ+6I
	XCaTJo+f0tyrzjy+dr5hvebpgKvk=; b=WDVttgJs4TWFLFOt2u3HwGc82O4VJMZ
	JpPLaIEPA560L2ISXdpx49dIaNfSduSevhxJrzZXrRwPh4BSGjMHS7GsO2LsRTdv
	ogzz31p4bfkyLdR3hHWa3+kJ0H3rNZAU/gFOPyYglee3TXqQYbL58nsz+Vtyilby
	NpBjwk33k5SZr/se6ZT5IgNETpzQk8FTYZZYt3C49J7iPYCntUamC4JxKDRcHB07
	1aJ6YrK3KSwRDMzdWIUooaiLQbbVJNyi0FvcPKLEWmS0UinljgXCnbOOTpZPIdQp
	6eeWjSLqcs8sdXI+ILeTi5TfLkKf2pbrZ2WE9AjCykfTBRr/83WJcew==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeycrt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 08:02:52 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 14:02:50 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 18 Apr 2024 14:02:50 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id B47C1820245;
	Thu, 18 Apr 2024 13:02:50 +0000 (UTC)
Date: Thu, 18 Apr 2024 13:02:49 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: cs42l43: Correct name of ACPI property
Message-ID: <ZiEZ+aSNM0d1/X+2@ediswmail9.ad.cirrus.com>
References: <20240418103315.1487267-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240418103315.1487267-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-GUID: xcKt_Uew1h2qac4f3ucpYGS5MbEk8KYz
X-Proofpoint-ORIG-GUID: xcKt_Uew1h2qac4f3ucpYGS5MbEk8KYz
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 18, 2024 at 11:33:15AM +0100, Maciej Strozek wrote:
> Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

