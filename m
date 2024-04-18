Return-Path: <linux-kernel+bounces-150229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434678A9C07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0003028284A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC4168AF7;
	Thu, 18 Apr 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Jla47F2B"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111F84D02;
	Thu, 18 Apr 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448801; cv=none; b=I1KA5grR7Z9ePK9ZCcWLQj/fVOh5TfvkSDR+9sWXABjtq6dENQiw1UlEuiTVVvJCq1c9AcDgN/uEEMXIe0htun3r9uFuLOT0sD7PJlTOeMmfCpOpLCqh8aMkTBfsDCAXWexcstLvh0orqAhP70EK6uQa3glQwWmIlKYcipuIPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448801; c=relaxed/simple;
	bh=AJPEjPlUPQHJ4hOGffADPP2SRRuSF2ri7CkK+4eg5ro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsCeEimNA2wKvLo0vL0rCwAhRVmACVAGhbTGydrUV/fczsGfTd1+KOhOWhbHgyCKlaRfeHsgpBN/XR6KrPCB/BnZCEjA5zlLAa+Po8lR9pDaPX37ocqjp/mF9jsyvLsfKA0GaE8Pk9sjkfyD50DeRLxYCJf5Knzd4Ax13E47hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Jla47F2B; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I4kSSo025732;
	Thu, 18 Apr 2024 08:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=RViRRtMM8/41BS4
	fsufbmgDyWahRy+WUSOiq+FX5YFc=; b=Jla47F2B05U0+DpWmxSAtlFEchV+PoB
	+6us+KXEh7/ptsumv/cUSMS+3sjIwcEydfhucC68WWDVu5dDL21uVfWNbpiuTwbl
	xjy3ZOnV+Th2yH0OOMevp/tQ1ihqV7IGKX5Valuf57i8qHQm9S1/3PYQdmnF5R2V
	xMSKsB3u6TJYa6dDsL2MvY6lPSiluyGqMi1o6lCTwkntxf/HQ9fFy/Matci99PHl
	PlBCjOf4QX9izX5ww6vPTI2RwTVCRwJLeO0c+TNzsTX3Jo6nJAwnUcCjQRphgwOa
	nsGg4fcCkHWs4ccgK9/m5KgAxDfu7rd5mza2hxxtXASAFalu9/S5R6A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeyctxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 08:59:55 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 14:59:53 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 14:59:53 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 61517820245;
	Thu, 18 Apr 2024 13:59:53 +0000 (UTC)
Date: Thu, 18 Apr 2024 13:59:52 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: ArcticLampyrid <ArcticLampyrid@outlook.com>
CC: <sbinding@opensource.cirrus.com>, <david.rhodes@cirrus.com>,
        <james.schulman@cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <rf@opensource.cirrus.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for
 Legion Y9000X 2022 IAH7
Message-ID: <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
References: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB25359B61BB685A4B3110BB44C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYCP286MB25359B61BB685A4B3110BB44C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Proofpoint-GUID: CX0RV_R6dqnRXP9MnD36QRZK8Bh6ECaB
X-Proofpoint-ORIG-GUID: CX0RV_R6dqnRXP9MnD36QRZK8Bh6ECaB
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 18, 2024 at 09:20:06PM +0800, ArcticLampyrid wrote:
> This fixes the sound not working from internal speakers on
> Lenovo Legion Y9000X 2022 IAH7 models.
> 
> Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>

I would wait for Stefan to review the content before respinning
but you need to use your real name for the Signed-off-by line as
per Documentation/process/submitting-patches.rst, it's a legal
thing.

Thanks,
Charles

