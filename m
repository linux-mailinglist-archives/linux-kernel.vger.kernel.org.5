Return-Path: <linux-kernel+bounces-78779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E0D8618B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA161F25D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E261132483;
	Fri, 23 Feb 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bWlCKrvA"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2D12FB23;
	Fri, 23 Feb 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707760; cv=none; b=Q1SWYrJQ6qjoD01gUxEwUs1ToAxOY2ipmZxZuY5KMxWhJeTUzq6OcbLdim72gJTY7z1e3D7UeZ4vgKq2+cv/m+YKOJDMj+PzeKfAMNO6mxKGcqYp0zUAzElZfyFvd7T+bIvIP8uPDKUWJKqkntkut9QDcEaGM2zW1y6CDKDo7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707760; c=relaxed/simple;
	bh=MLId+vpL1GJSYnk9r4V10bG6KRC9aNji3+0kQGieFqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OmrHgiVFVdw7YInHRtDv6Pn9HWl3msVzWPp+yk65OiS2bKi/9oBsTA1Xg4PnZ20ZCt3Q5DVig9dQHfnm1zvpQ29wHL2uuRcoDIOe36xhiigMsycKE4PdzS4+PQ0M4yAxri6njCTRyLqPH5KDLBXpgT34mhU8ArH0EmS0GRyqga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bWlCKrvA; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N6HREp027836;
	Fri, 23 Feb 2024 11:02:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=x/AtCItlvRqeTztsKy5EsHh5og0itw6wNDcPMUzLjho=; b=
	bWlCKrvAeBVO4Ssmi/QxqKGTXiqcqBTnYxBFp3Gb7KV51QPwLvmCu1Choq/DX837
	1gsatA9mcK2riPDaBdjbNdNoJwv4tD7mTeQZh0FeZ3vhWZQDpCbi7ciylpaNW2Le
	Tm0/hRthSKWXkTy//LaLAt6Qgpmb+FCNptV/+gFbwQELQXmviypneXUPWV5RW0DP
	dASxgw5iFWmHA+6CBEBbb6ejlpC0gFW0NpFy0+woJCD/qmigeNd8sffXxbEa8HRq
	AnboIH7irKiwAKU6aUPMlASwci6ttZ4TPG5J0W6ZOJ1gFFyC8OJC7xgAesjHyPar
	F2DHavGgqai6nSHlrYomKA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wd207mbqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:02:05 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 17:02:03 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 17:02:03 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6F06F820243;
	Fri, 23 Feb 2024 17:02:03 +0000 (UTC)
Message-ID: <956f2b88-8b52-45b3-a27d-fa8e75a02642@opensource.cirrus.com>
Date: Fri, 23 Feb 2024 17:02:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] ASoC: cs-amp-lib: Add KUnit test for calibration
 helpers
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
 <20240223153910.2063698-7-rf@opensource.cirrus.com>
 <ZdjMIVYp7Qb/Tt9d@finisterre.sirena.org.uk>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <ZdjMIVYp7Qb/Tt9d@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CnArif1KVPkqp-jNYyI0ptCu1_Z1L7YN
X-Proofpoint-ORIG-GUID: CnArif1KVPkqp-jNYyI0ptCu1_Z1L7YN
X-Proofpoint-Spam-Reason: safe

On 23/02/2024 16:47, Mark Brown wrote:
> On Fri, Feb 23, 2024 at 03:39:10PM +0000, Richard Fitzgerald wrote:
> 
>> +config SND_SOC_CS_AMP_LIB_TEST
>> +	tristate "KUnit test for Cirrus Logic cs-amp-lib"
>> +	depends on ACPI || COMPILE_TEST || KUNIT
> 
> Should this not depend unconditionally on KUNIT rather than KUNIT or
> some other stuff?  ie
> 
> 	depends on ACPI || COMPILE_TEST
> 	depends on KUNIT
> 
> or equivalent.
> 

Now I look at it again, it's not correct. It's the ACPI || COMPILE_TEST
that is bogus.

>> +#define TYPESAFE_ACTIVATE_STATIC_STUB_PTR(test, fn_ptr, replacement_fn)		\
>> +	do {									\
>> +		typecheck_fn(typeof(fn_ptr), replacement_fn);			\
>> +		__kunit_activate_static_stub(test, fn_ptr, replacement_fn);	\
>> +	} while (0)
> 
> Should this be somewhere more generic in the kunit headers?

Damn, I meant to change this. I did a patch a while ago to fix
kunit_activate_static_stub() so that it worked but it takes a really
long time for kunit patches to end up in the mainline kernel. Hence this
was a temporary workaround. I noticed my fix has gone in at last but I
forgot to remove this workaround.

Can you skip this patch and take the others (assuming you are happy with
them) and I'll fixup and resubmit this test later.

