Return-Path: <linux-kernel+bounces-33455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5622E8369E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824771C243AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D34F8B5;
	Mon, 22 Jan 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="joUCGuQr"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0B12DD82;
	Mon, 22 Jan 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936363; cv=none; b=b1jr+QSNnJUD8vLgFU1r6E7qKnwReJqCH+QE3DJU1OhSyhXbgZm0JxVkpqV1DeosN3PY2kJloHKkxlkId9FJZ/M/lNNmLmWM5C/wpdbjTdMN47yt5cIHR4unysvMSEZ7kx+ixiW8N8txHgD8nzNywXuJNOpLQX7WmGaPZRYAwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936363; c=relaxed/simple;
	bh=o205dA9KTuKJnFXhFeL4SaTHyssuKFB0zM0G0NFc6Dc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxkyqf27KIEBmiAiYHtSXnLRab4qffWqzwNH+9ViGxwPuGr+TQ4fdQOdseTBcMVzG5Byw1K4b1k+BlBm443SmQBCBJaTo5WOeuuFtAgTtqFIiF9L0QLOve+6hTCjqoSOwyH8qSngmMgSINvZXspa3F8xs1CqX0ShVu5U3aRP+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=joUCGuQr; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M6XGBI015332;
	Mon, 22 Jan 2024 09:12:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=+iHALaXLYA4PNuX
	W2xwffrmv76Pc5m+6eQ7rN8n4yUU=; b=joUCGuQrbAiS9epo0w4DT6gwxCTLMGd
	RUo7xWc54xxvTQe7ly0QDbt402qnW6pMD+t5abbtA/qg0um7a7Vp4xto4RSK51EB
	sPQcql+eftDQVb2nLz05GOZDvlPdkJJCmBsw0wxK3Kf6fXjxszEMYaxZXG4Crlf7
	x2rxJ8GeUPvrApgypnflCRLz3peLFdiuKwjqRnI8Bu7vYvnDfw7drB0QrfFu3E0C
	JDimN5FAPUSfq2nfrKXXTcJKnqqqgY1RvU03PkDZGcdnA+LcxZKENlQAv3Blny3j
	Jx765v2RduX3Hjf42Z/oJOp1nzqpkddTwf9HyHj1kMSllq1IkoOoGPA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vrbfptn44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 09:12:20 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 15:12:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Mon, 22 Jan 2024 15:12:18 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B385915B7;
	Mon, 22 Jan 2024 15:12:18 +0000 (UTC)
Date: Mon, 22 Jan 2024 15:12:18 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>,
        Cezary Rojewski
	<cezary.rojewski@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>,
        Bard Liao
	<yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen
	<kai.vehmanen@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for
 MTL
Message-ID: <20240122151218.GD16899@ediswmail.ad.cirrus.com>
References: <20240122150156.68983-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240122150156.68983-1-mstrozek@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: MkOKC_22gdf3RxtPlb-7QnD4K_IGM8IL
X-Proofpoint-GUID: MkOKC_22gdf3RxtPlb-7QnD4K_IGM8IL
X-Proofpoint-Spam-Reason: safe

On Mon, Jan 22, 2024 at 03:01:56PM +0000, Maciej Strozek wrote:
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
>  .../intel/common/soc-acpi-intel-mtl-match.c   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> index feb12c6c85d1..625f991b1ad4 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
> @@ -377,6 +377,36 @@ static const struct snd_soc_acpi_adr_device cs35l56_2_adr[] = {
>  	}
>  };
>  
> +static const struct snd_soc_acpi_adr_device cs35l56_2_r_adr[] = {
> +	{
> +		.adr = 0x00023301FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_r_endpoint,
> +		.name_prefix = "AMP3"
> +	},
> +	{
> +		.adr = 0x00023201FA355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_3_endpoint,
> +		.name_prefix = "AMP4"
> +	}
> +};

Sorry the amp ordering is still weird here, can we have:

static const struct snd_soc_acpi_adr_device cs35l56_2_r_adr[] = {
	{
		.adr = 0x00023201FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_r_endpoint,
		.name_prefix = "AMP3"
	},
	{
		.adr = 0x00023301FA355601ull,
		.num_endpoints = 1,
		.endpoints = &spk_3_endpoint,
		.name_prefix = "AMP4"
	}
};

Thanks,
Charles

> +
> +static const struct snd_soc_acpi_adr_device cs35l56_3_l_adr[] = {
> +	{
> +		.adr = 0x00033001fa355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_l_endpoint,
> +		.name_prefix = "AMP1"
> +	},
> +	{
> +		.adr = 0x00033101fa355601ull,
> +		.num_endpoints = 1,
> +		.endpoints = &spk_2_endpoint,
> +		.name_prefix = "AMP2"
> +	}
> +};

