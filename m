Return-Path: <linux-kernel+bounces-126557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C989396E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4E3B20C68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97110953;
	Mon,  1 Apr 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AE2aJNqg"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D31D52B;
	Mon,  1 Apr 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964001; cv=none; b=ahzEY2/Q9pblY5ZAfqQQ562wsUC+6RyHpki86booTgmjspjOhLf2EVI0N1z1yCLrq2scbcce7La7nqrvG5P5oZPiOD6wuJnrpvlXAHMJqHtFgK4wNayHWICJo2ZyF+/1OA9e0uZtOY0Mclw6T04U0xSjOSYOdb8ozbrRyWqA9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964001; c=relaxed/simple;
	bh=gOkdMufNrYUHI5wqynku6mgw73bfwiCTsJ3WOegpWGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WZQVEGoImw7KiLlhXJ+95tfPINe/cb3TU8jsTwsMw5uBm5cK2OeqCRjUjs4Z0oipP33btYhBWABlwA0lLL4/GKZ7XmGa5iF1aHFqKzazCh5uQkVFKeV4Dh7I3D08hhUuQ7hD3OZ7xi3IWg0ZpGVHZvVQ22JyJLl7FtMUnV/RB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AE2aJNqg; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4315ekd0020303;
	Mon, 1 Apr 2024 04:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=IS79sOATqoSucVXftmm3JIChsEbp2Y5YeWT6V7cQvMU=; b=
	AE2aJNqgxtLWDMIHbo9wr1d72n9q6S7IRl64ZV441sOYw6jDPwLh+9OkaL5m0+8g
	ei8qL+rPDCbbvvpbFYq5VkUlNjeg4o3OLFRRMuq5CPdmTGYM9/W6CB1ANhkHhf2e
	YR8eUF5qIVaYoEE1+2VCe1Oer5FIFDjEKRNoYbHLr1SzgflqjDSAmNCt/XCaWqYU
	qdCBCnfLC5OmTXPpHAAaGRKgot+LaLM7aVwC5xcLj5AOwnlJkfjc3m1kBCedCRYR
	dPyP28RhvEZS9Fqo3YtGyCM+CR+Mipkc3m0j1yQ/mAz+D6+Rdfd+048XXQ097Tfu
	piVA4+TOuoDy0q+SHNnFpg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x6g4xht6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 04:32:52 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Apr 2024
 10:32:50 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 1 Apr 2024 10:32:50 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EC522820243;
	Mon,  1 Apr 2024 09:32:49 +0000 (UTC)
Message-ID: <41d1aad9-2381-4d7b-b247-9d114c5c517f@opensource.cirrus.com>
Date: Mon, 1 Apr 2024 09:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ALSA: cirrus: Tidy up of firmware control read/write
To: Takashi Iwai <tiwai@suse.de>
CC: <broonie@kernel.org>, <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
 <87o7awnmdd.wl-tiwai@suse.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <87o7awnmdd.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x87jzAli0Me04_Yui-dnNvnewki0wu45
X-Proofpoint-GUID: x87jzAli0Me04_Yui-dnNvnewki0wu45
X-Proofpoint-Spam-Reason: safe

On 30/03/2024 08:40, Takashi Iwai wrote:
> On Mon, 25 Mar 2024 12:31:22 +0100,
> Richard Fitzgerald wrote:
>>
>> This set of patches factors out some repeated code to clean up
>> firmware control read/write functions, and removes some redundant
>> control notification code.
>>
>> Simon Trimmer (5):
>>    firmware: cs_dsp: Add locked wrappers for coeff read and write
>>    ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
>>    ALSA: hda: hda_cs_dsp_ctl: Use
>>      cs_dsp_coeff_lock_and_[read|write]_ctrl()
>>    ASoC: wm_adsp: Remove notification of driver write
>>    ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write
> 
> The patch 4 doesn't look cleanly applicable to my tree.
> Should it be applied via Mark's tree?
> 

Yes, it will need to go through Mark's tree.
Mark's for-next has one extra patch to wm_adsp.c that changes
the same function:

f193957b0fbb ("ASoC: wm_adsp: Fix missing mutex_lock in
wm_adsp_write_ctl()")


