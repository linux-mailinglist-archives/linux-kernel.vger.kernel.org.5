Return-Path: <linux-kernel+bounces-126265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D6893474
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BA11C238A2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15E15E21B;
	Sun, 31 Mar 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s/Dvxr52"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46015E1EE;
	Sun, 31 Mar 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903398; cv=fail; b=Hb6yvwfp3VCrBX0pnjRft1tCRhNVShurfM1qlJSsV2xa1y7NumfE3CDOTK+4+kZH9xt+QHiq0x0jMU4+u2K+4pDGrM67g7b8keFNiaVi1NLNZoSd3eroR0mYLFV//3cYZRO9Cr9KFdUTiH8NDj13c8VcyG1LDnbS3ak3JcxbOx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903398; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OWsvc1cqszKw4VxEwhaRWox8zRe2X4xiAAH/lgPgwIZ79yJu5ukPmVp7vhq2774pKiN59RP593EaLPGH2F/+4en34OEbcuZclp7xeUORyPk+BTnQ/Vz6S4q0WfxY2KLaKU2SRUjrbKl6wgD+JAywr3FpOSKVnlBKIN2654Rbsbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=fail smtp.mailfrom=acm.org; dkim=fail (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s/Dvxr52 reason="signature verification failed"; arc=none smtp.client-ip=199.89.1.11; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1F76020851;
	Sun, 31 Mar 2024 18:43:15 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lq2V0N2KrWnv; Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8FDBA20896;
	Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8FDBA20896
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8219B800060;
	Sun, 31 Mar 2024 18:43:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:42 +0000
X-sender: <linux-kernel+bounces-125451-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAAkimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8536
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125451-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 4D990200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s/Dvxr52"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748918; cv=none; b=VPhuwEAboN1B1KPk5aQyEpkEMVWrWWP/IdhXXV5eLRCna7HEkKp7BM3rDJITZyXyt8X5jXK27fGKjIROL6xPPOAD8uOa4c0AAx40IPrO74Zh4xrC8gGZ9PiycA8fnItZ3mHiYd/ItOjFlY6RNVHfYc2jgWXvIJ7ylR8YlG3YAOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748918; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmDDcUb1o/8HWQ8aWmJe3HtVNcfO4grSSaHP13RUl9LUDfyLMpOL9+9yB7FyWMajHfhBW/ni5MFQUW3gIkzS6Hf97oHNP8Rj2SM5sAItR1w0hsv7U9UnTkGpPN4TYxFFlNTmebJbbnr5cUtp0oI1Dhl+qjQ4pNAUeUBCQdtMkdo=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s/Dvxr52; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748911; x=1714340912; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=s/Dvxr52XitclrTlpgcZFz1EvTsZ6IJyetgiEUoc
	fGPCO+2x16JzhzlNHQ8RX0ZgBiZDvWPA9xqloF7JTB1Zqve2kpgh9ayH1QM7g6sr
	gfdVpHECtsbtLnA0NEzWVfy7UULP0qh790n3BUwTAOSVpq/L/UN2lJcOZibeOzvL
	S1QB6xOn9LmNJ5yMxY0cQQSSGywBxihLBMyeO9yj4KnmuUhIK3O9/rO/XQzRn4vi
	sNMTNIFdrN/1s79czI9ponzXiHo4bF8N/ica5CsWXf+Md1hVGOlSxq3ALbB8Nf6E
	VlQfHFOvYCkVIQ0tUmNfxBk1tBNrmhcESEEEaTL2NZncMA==
X-Virus-Scanned: by MailRoute
Message-ID: <abaf0f8d-8531-42b8-a714-cc02ae658646@acm.org>
Date: Fri, 29 Mar 2024 14:48:25 -0700
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] scsi: ufs: core: Remove unnecessary wmb() after
 ringing doorbell
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konrad.dybcio@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Janek Kotas
	<jank@cadence.com>, Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman
	<avri.altman@wdc.com>, Can Guo <quic_cang@quicinc.com>, Anjana Hari
	<quic_ahari@quicinc.com>
CC: Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


