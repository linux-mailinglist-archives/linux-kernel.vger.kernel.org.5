Return-Path: <linux-kernel+bounces-40297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D51A83DDE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AC4288F16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C51CFB4;
	Fri, 26 Jan 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ri8PJyjD"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44981CF99;
	Fri, 26 Jan 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283916; cv=none; b=cJnQUtzsFjFRuOkpyw1tX8HY1dVJV4dOYQVCLZDgbkGo6FJr1CSgGwcGmGR9JDc7GRIDiYNmmtiaqc7WT3wZoHKEVSYpTkmp7PT57ZFishHx37S13G4Y0rjz6FCXDZXfNHXuEl2KPmti6DLeXskfSnbV5YDyIAC5g9J/pjXKqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283916; c=relaxed/simple;
	bh=fqIG2jDZoTw9TE78+cnz0OxfSJ1D3qd3x/zWVd40lg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=djjHx0Q0V3mt1W3CI4r6seUPwr5A0kxY6N+wdupDbfLjMbbGRDBi/NXOFIe3kLY4AS8w1Qeby1jxEixs9ugAM1fPZkJ8RQCzoK8WfD4GJ1FL2wiJKheAHdyRLrH3w51Kp3pYDA6x2MVAT/2gdtWKxcc+9LuBCWhOdltsGXzIvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ri8PJyjD; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QAV94J011624;
	Fri, 26 Jan 2024 09:44:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=sTeLXv2n33njXj2pPXt/tcA9jUcN2EMferdUpNRom0c=; b=
	Ri8PJyjDWJtzg8CIzUcE0ikkQ1nqkbryUAHzfBf0llpykpe3ffSObCi+gVCBOvv6
	n4KEx4iA0veIgB0pKnPg46QOiXPpwp1sdzc8m6UXNWkWqlbI8G1t1Eon0Ty03z8i
	hV/AbhvL3gRKHCue5Dz3gOZUG8TEW6KPql4/3dkWH0fMEFFOsMlwlUy2tuHx4pR1
	1CHiHlvft8jpmqFbZun/9s4Ozy2otCZzE9zEBJf+4/kyPZEs5yESvpldsHurtgsj
	RPihom5z4+IZrHmXJIL1N6CbER9KTUBSsyxLdmrMujcbFLmd8hplYX0AjOZEeP38
	r8EtDkU9GnWU6VB5tJW4XQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhm3ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 09:44:51 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 15:44:49 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 26 Jan 2024 15:44:49 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 060D6820246;
	Fri, 26 Jan 2024 15:44:49 +0000 (UTC)
Message-ID: <0d2aee4d-edc4-4e6e-99c3-d548eb6d6e18@opensource.cirrus.com>
Date: Fri, 26 Jan 2024 15:44:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Support HP Models without _DSD
To: Takashi Iwai <tiwai@suse.de>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
 <87wmrwnn2n.wl-tiwai@suse.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <87wmrwnn2n.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0A87Bz0BkaY1TQM-BuRqLl5iY_Dge84p
X-Proofpoint-GUID: 0A87Bz0BkaY1TQM-BuRqLl5iY_Dge84p
X-Proofpoint-Spam-Reason: safe

On 26/01/2024 15:14, Takashi Iwai wrote:
> On Fri, 26 Jan 2024 12:30:03 +0100,
> Stefan Binding wrote:
>>
>> Add Quirks and driver properties for Dell models.
>> Driver properties are required since these models do not have _DSD.
>> Some models require special handing for Speaker ID and cannot use
>> the configuration table to add properties.
>> Also fix an issue for Channel Index property, when set through the
>> configuration table, to use the same method as when loading _DSD
>> properties. This is needed for laptops with 4 amps where the
>> channels do not alternate.
>>
>> Stefan Binding (4):
>>    ALSA: hda: cs35l41: Set Channel Index correctly when system is missing
>>      _DSD
>>    ALSA: hda: cs35l41: Support additional HP Envy Models
>>    ALSA: hda: cs35l41: Support HP models without _DSD using dual Speaker
>>      ID
>>    ALSA: hda/realtek: Add quirks for various HP ENVY models
> 
> The last one conflicts with the latest for-next branch due to the
> recent change from Cirrus.  Could you rebase and resubmit?
> 

Yes, sorry. That's my fault for not syncing up with Stefan before
sending the other patch.


