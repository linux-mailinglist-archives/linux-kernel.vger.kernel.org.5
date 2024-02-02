Return-Path: <linux-kernel+bounces-50176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFED847556
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99F4B21D38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE7148FFE;
	Fri,  2 Feb 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mwJEOoIp"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48251487C1;
	Fri,  2 Feb 2024 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892571; cv=none; b=W4Kq+eFSECZT3nlZj+NA5F1FsTdewYM+VDRf+HJZWhykFnNjfBAQuUNG6ufulAkRs9vYuMxy5qUUbctcxAcQnP8yA7xjA9d5b5MbGE3VHFyy5NDxKSsVogAePpnzRPOnWrJbrOWcwgziB1UUgBNYVvq9vEK5T+taQ3ieeVoBRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892571; c=relaxed/simple;
	bh=+im1RKMjzZ4h3VkkKdLOvJQjbpmu5h9lZoheruaIOSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OoMNfSVZdeWZPpVybyvNqTObT1nzbL0ts5VxVEjT8vbLiiqzn12WnksZ/C95uA9+Az8OgWdrXeyUSYcTRe2Wpd5IyDmHOHwx41rB1CX7LWrDS19+eRQ6j9O1JDoBZPYaVDfgZWwZBgmnJutFiNvXg8i1WENZARGp+9FbFApcUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mwJEOoIp; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412G7Mcq013162;
	Fri, 2 Feb 2024 10:49:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=U8WQG/27RFVW0T/lszOLDs3q2p3WIe4SF89sGIgigVI=; b=
	mwJEOoIpTHTDlrg6DfTlGWj1YlyXozpO2dWPs/4lAIaCxX4ADSv9xgsnFKk5P0Mm
	6E/FLh4w6EpBrodBUhgDociv1xy1juZHJyiOKbQo0Ln+O26I+UsWyzdnhPWSplF/
	orKwXlHM11LVeQEKnTaJdP5ccRPGPyjBOwc0M0Z5AoVYJxhc4XMNmgpH7/DxtlU4
	80CysspmRbMYv9YpJREQYAgUhf2pudnky0rru8yPbURhAvjkVuycgy+4DnR8Xcca
	SprHUylSvm54INyyzLVExYZaHnk+reSgSqW98C+21mRWy8u32QVnpj5HlfkrlSVI
	ZTCSlEFxC+as4xg5+pA85Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3w0pwx0rnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 10:49:08 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 16:49:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 2 Feb 2024 16:49:06 +0000
Received: from [198.90.238.164] (LONN2DGDQ73.ad.cirrus.com [198.90.238.164])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B0A01820246;
	Fri,  2 Feb 2024 16:49:06 +0000 (UTC)
Message-ID: <5792f9bc-b77d-4a90-be61-a09797295a8b@opensource.cirrus.com>
Date: Fri, 2 Feb 2024 16:49:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ALSA: hda/realtek: Remove two HP Laptops using CS35L41
To: Takashi Iwai <tiwai@suse.de>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240202161727.321373-1-sbinding@opensource.cirrus.com>
 <87v876bz6b.wl-tiwai@suse.de>
Content-Language: en-GB
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <87v876bz6b.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7hVQcVNpn4yaQ_qZEnDXAyxZuy54POCT
X-Proofpoint-ORIG-GUID: 7hVQcVNpn4yaQ_qZEnDXAyxZuy54POCT
X-Proofpoint-Spam-Reason: safe

Hi Takashi,

On 02/02/2024 16:37, Takashi Iwai wrote:
> On Fri, 02 Feb 2024 17:17:27 +0100,
> Stefan Binding wrote:
>> These two HP laptops are changing configurations.
> What exactly does this mean?  The PCI SSIDs are no longer valid, or
> the quirk became wrong, or what?
>
>
> thanks,
>
> Takashi

The SKUs, and associated SSIDs, are no longer going to include the CS35L41.
They may come back, but will need a different quirk.Sorry for the churn.

Thanks,
Stefan


