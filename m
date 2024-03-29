Return-Path: <linux-kernel+bounces-126123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182CC893278
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3961C21CD6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3114A4EF;
	Sun, 31 Mar 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NvrFdpa8"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6616146A79;
	Sun, 31 Mar 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901006; cv=fail; b=IisEmO/z/ShC21fvvkIFVAhS27wW4+Mjb92wrFmzwjq4/TTrPci2PeHfyH2MTTBXLHq3ZDzd3UyEG1kV0IpnQ7xaZ7Wv4p2hblxsNiNAVSf+ASBjZlkkQTHDtB2mq9cmHKoNrSLLFzhdDEuiAYRqo43j0VuM8/dYVz5QOjghNE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901006; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dAMhML4pQIVa5dHULjmFUZQOBSzJFd2Q18IHSecV3IARRiZ8FuPqvLSv6CJ5uEw5p/ee3TH01cNUZLepqymji5jnffYw6+P9ZxAts69umLyIqEJMSmQqB7xG8fDWdZwMDLbkjPu/3IH/9DXxtMqD9bdKrjLppqhDnrbhKrf/0wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=fail smtp.mailfrom=acm.org; dkim=fail (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NvrFdpa8 reason="signature verification failed"; arc=none smtp.client-ip=199.89.1.12; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7CEE0208D1;
	Sun, 31 Mar 2024 18:03:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VvftS3fp1pd; Sun, 31 Mar 2024 18:03:23 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AE068207B2;
	Sun, 31 Mar 2024 18:03:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AE068207B2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id A0605800055;
	Sun, 31 Mar 2024 18:03:22 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:03:22 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:40 +0000
X-sender: <linux-kernel+bounces-125453-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAeAxrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAJMAAADLigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 10959
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125453-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2E8C020561
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748972; cv=none; b=imRoeGH5xl/m3DLOY7eCKUi7sprzA+ulAK+xbNkaFo1euIRtzYwvf3H4dlb7hLHe045/baQJ6cSZTbqo4R0pL5Iq5tUuITKZmKpTYKmEOpE+WR28JBkuvtdReqGO578erBnsayEER+gE0FpTbm2ORQ89kva6JAlO77OMhce+VuA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748972; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ5QcVIvIx+WnKyttgMHvYUQSlytXOS/S8mBHQM9Hu5SDmV6w8EaoneOQybOr2ia90h2pcCFuJ1qFgW2XHSKtq+rRo65+VyKB6HL7YMvKRvWoAljPnBIY1gT3eXWaHgGvBhyjfxIlHgqm5rqfVcUscZbRMZfQIZ/pKdrt3mA6mw=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NvrFdpa8; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748967; x=1714340968; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=NvrFdpa8pcA9cG+NIiJnuoeRqa/nPyhvnOtdKtLd
	WqtQBmfv5Xxa/dgMQibjBYWpMQXU99b6524nnJyI8pR/Q1lbHWv1wXDr0wGHEsNl
	MnIwbJxL0DpSjF8SNG2GSqM2pNOxYN5q/Qkk1lddJBYelx8ypgvgvClefq1Mhl24
	H0gUpQPwbjzLn0glITC1tXYRk/I87LnqCSGaNh3fPf4IJnFVILDFulxZED+xaII6
	iBr5thFOG0UqWCqaTUezS8lMnQIdJZ40OgJlZMfMAGoHuNfec/Jn1agU0vb5QT1L
	9pHLevDlEg286EulZVVF/0rInaBlREIxgEGvUz37Avt+XA==
X-Virus-Scanned: by MailRoute
Message-ID: <ecd24b64-0f27-486b-a7aa-b4b51b7b16de@acm.org>
Date: Fri, 29 Mar 2024 14:49:21 -0700
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] scsi: ufs: core: Remove unnecessary wmb() prior
 to writing run/stop regs
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
 <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


