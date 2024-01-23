Return-Path: <linux-kernel+bounces-34938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285D838973
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844751C25B55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269257300;
	Tue, 23 Jan 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QmYz032Q"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704C56752;
	Tue, 23 Jan 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999765; cv=none; b=VzKigILjK10mz8RlvIY/pOHNSJaxlkCyEbHZI1t15j5Y+58sBt3MOGGpUNhYiD5CyRijz/24hD5arWteLAz/i93XUeC97+mYy/EzUSEd71cWaNTCMCZ8AAVqPMUHAujRmDzGOmgzLM3KwExbVJnVgz80xXCl+7Bd6ZQ9mJDj0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999765; c=relaxed/simple;
	bh=dhY165tMS0Miq8EqkLLuTWzkti65/pXyDCZ6C1zNaAw=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JscfuMZl+fL7cwewD11VUke3K+MWTc/KgmMcFKNTs9Dp1BrwU9PAK8MTfpJDRFt1ON+7Acf1jPCsnrn1FaHrl5H5Z6HGQMORs+vc1hNWwSehzx9zd7XD86AdgmLKjqrSN1Gg5NcOdCtpXcPnI+T6DFsCIetxqliKaO6jyAqSu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QmYz032Q; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N5mRpw012720;
	Tue, 23 Jan 2024 02:48:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=
	PODMain02222019; bh=6GVSsBOtJASVspjRjHj4J47rudy6/Dh7Gcb1mVujeKY=; b=
	QmYz032QwQtAOpem/ebdhFIDrpoqX8j+gPEIIe+3iL4jNmepAdmq3QVBWTjxJT00
	eWADrpfn9SezkbAcT/lPdP+gfBRK5S80HKCLFL0WdIxaE2nl81pEfgOXDX9t24uw
	JcZlAXa1ET9sTLY5hFEDuyFQ8tej98za56xjO7SIzLTjQvWhGqusLyWNdoPssvYz
	99RlpyNFm8Z4GxEVbXx+sFyi28FgidBQkANkcaf7Kp/AjZfRjYlS+WvWMwEkT/IR
	qT54ie6+KGXJxmajbMbm8bppF6/vHNzgqlNrX7oYVctD3jevQ4IYiWw7yTLvP8T2
	mc7pYyz+JXpK53v69eni6w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vrcf33scm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:48:58 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 08:48:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 23 Jan 2024 08:48:56 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.251.123])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BCEA946C;
	Tue, 23 Jan 2024 08:48:56 +0000 (UTC)
Message-ID: <c41bdd66cdf02db82fece500f75296d23f4d8041.camel@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23
 for MTL
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown
	<broonie@kernel.org>
CC: Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard
 Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen
	<kai.vehmanen@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 23 Jan 2024 08:48:56 +0000
In-Reply-To: <30f022a5-7ab1-4b2d-b4c1-5a209ec67c5b@linux.intel.com>
References: <20240122151545.69437-1-mstrozek@opensource.cirrus.com>
	 <30f022a5-7ab1-4b2d-b4c1-5a209ec67c5b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0zZL-g3xvMlGVsP8krmjzLMFqwF3KYzY
X-Proofpoint-GUID: 0zZL-g3xvMlGVsP8krmjzLMFqwF3KYzY
X-Proofpoint-Spam-Reason: safe

W dniu wto, 23.01.2024 o godzinie 09∶34 +0100, użytkownik Pierre-Louis
Bossart napisał:
> 
> 
> On 1/22/24 16:15, Maciej Strozek wrote:
> 
> It wouldn't hurt to add a brief commit message describing what the
> hardware layout is, specifically how the mics are handled.
> 
> It's also best to submit the corresponding machine driver updates at
> the
> same time to check for consistency.
> 
Will add the message in the next version

> 
> >         },
> > +       {
> > +               .link_mask = BIT(0) | BIT(2) | BIT(3),
> > +               .links = cs42l43_link0_cs35l56_link2_link3,
> > +               .drv_name = "sof_sdw",
> > +               .sof_tplg_filename = "sof-mtl-cs42l43-l0-cs35l56-
> > l23.tplg",
> 
> was this topology submitted to the SOF tree? I don't see it, usually
> we
> review topology/acpi/machine stuff together to avoid disconnects.
> 
Not yet, sorry, I'm aiming to send the topology to the SOF repo today.
Will include the link here in the next version.

> > +       },
> >         {
> >                 .link_mask = GENMASK(2, 0),
> >                 .links = mtl_cs42l43_cs35l56,
> > --
> > 2.34.1
> > 

-- 
Regards,
Maciej


