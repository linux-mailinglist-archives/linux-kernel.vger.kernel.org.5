Return-Path: <linux-kernel+bounces-121441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BF88E7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584512C4799
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC8130AED;
	Wed, 27 Mar 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QBVczwqO"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015212F396
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549920; cv=none; b=JZ1mINjz1A2JYcsppfLnNAhNKMkGwcerLufUKAGg117z4Hw0CkDsXbpPQ2psv/vcMXivS0s1uLopqmSlCXRfgqUrqT0IJbzK0GE+pOxmGbfolBmeiKas3uwgGFmtT3r0gTMrSOSDOVWvN5nE0kMpOSucICKG0cOvZW5HPJtJCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549920; c=relaxed/simple;
	bh=YKVSTmT3qUBwpqlB7Y//kiJHq4Q11YOqzoKuNm3NEV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p838/ntkshQ6jGg3a2Zzj38qGuSj9Rekv0n6lErgGIi/marJJGxeSq2J56nDoOs1nFzCWr0JgOy+j0NgP4n5HsXaOj7FmdgXua5rtS5g+v9RmJL0fQhfBuKCIeoawbSlCwNf1E+YjdmNDiHf28OofSR3XQmYgQopxeGfhZO4oTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QBVczwqO; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R79ddN013715;
	Wed, 27 Mar 2024 09:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=pe1OiEZ/eODz5fKDp9yxijNPbhXTJ0sYV+MyonGZ+tk=; b=
	QBVczwqOFBStTWl5gMTxL5+JsR9aZlg56loF2X7EjsNNTw0BAAJJ9BqCPOEpW2oU
	een1ZcoVrckffhSCvIAMiyixYo9xHHGVQmpWXprPsGcdWyyi5NnFXQa10Wm47MeN
	BfbaB6J/BBeBnL5EC2NPEE0Yo1cvtOITojyuN3O+R7ayhJL9imU/jNm7jEXZMtTL
	P8ms1oTv86t6mxXz34l6i3h/2yhlQ1Ub01qg4/yFYUXbYweiSi6ue7X/P6OXi2Ju
	0nFfeG6ghDqNwMh+qeXTcJM40msjYMxaL7fZlj7xfE+abBRrN6/Zd3yNuduylFHx
	9VgYmp8QuV6hmo5BXamW3A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x4et80gkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 09:31:44 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Mar
 2024 14:31:42 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Wed, 27 Mar 2024 14:31:42 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 543ED820246;
	Wed, 27 Mar 2024 14:31:42 +0000 (UTC)
Message-ID: <8c7c3463-a912-4eb2-9b32-983bb0705386@opensource.cirrus.com>
Date: Wed, 27 Mar 2024 14:31:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: maple: Fix cache corruption in
 regcache_maple_drop()
To: Mark Brown <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240327114406.976986-1-rf@opensource.cirrus.com>
 <c83f359d-ae9b-4b09-b00e-ae99fe9eb74b@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c83f359d-ae9b-4b09-b00e-ae99fe9eb74b@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: grDCCVOc2IBUekP4saexUyRgAdRnPORy
X-Proofpoint-ORIG-GUID: grDCCVOc2IBUekP4saexUyRgAdRnPORy
X-Proofpoint-Spam-Reason: safe

On 27/03/2024 14:16, Mark Brown wrote:
> On Wed, Mar 27, 2024 at 11:44:06AM +0000, Richard Fitzgerald wrote:
> 
>> This bug was not detected by the regmap KUnit test because it only
>> tests with a block of registers starting at 0, so mas.index == 0.
> 
> Can you please add a test for this?

Later, when I have the time.
I've already wasted over a day debugging why the values in my registers
are not correct, so I'm that far behind on the work I should be doing.


