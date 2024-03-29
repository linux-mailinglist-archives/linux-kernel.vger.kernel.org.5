Return-Path: <linux-kernel+bounces-125450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6078892652
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BDE28338A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E813C8F4;
	Fri, 29 Mar 2024 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bKYTxqYX"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B011E897;
	Fri, 29 Mar 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748872; cv=none; b=hHk0nekHoIPv/rws/Ks3SiNb0IfsyINJl4WxtqzjrVw6gJ8uDj7x5P7/rjm0cuzQB/sTBnkH5quhEunNXr0CVFZzsyi7psEHDR9yPbhLRqTznVIN3RMCniUKFKyybbuwTBqY9yPrgkqs2EFJuRzzG+t2intRbsyLsRcFrw10nGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748872; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjdI+bz/mrpBe5XksTJ9iREl3SwofDtbu5AKcjiowdaJNJ/wlpfyv5BGNj+9UNekGVlfJKDa8ZNvTjCpDPHCH+ZM1vS8VG29yMd3cIp8K861WMu52mxpIrgve4OQNuk653HCygZlxakLlc2rFkPhADwZKcart38JNSox8YAvMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bKYTxqYX; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5vCV0WkLzlgVnN;
	Fri, 29 Mar 2024 21:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748866; x=1714340867; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=bKYTxqYXCw646WBgxS5DRbf9Rc4CvljYd3iLl0cS
	ppNDFiZGebbixYIq8RCThOZ9lXeWWr+uYfj3IggjSa7NV1nZeJrX/wR9Z66Gi2nJ
	nCBwKLuZYyaklO91h9ZFXviJ8GmhsjE4Z8hsTgV8LBrG67+4eo9JonNww3D9nab8
	UAWgwgTPNDYWI5esRnfi8pXTCwfvgCa6xnOm4NVx5uS0g5LiqmFChh2g4trRg3NG
	aw7z1GEpT2++KkG9LMPP3ANjhhC7qx8a1NSXLhFhTI/0eJ7acUg/YhwAs9MUkaNO
	Ec4ZzVCwbzdzfePHKS/oSNl7C1O/D8IJyxeGsMhfqy+1Tw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3idGS4ZxiJui; Fri, 29 Mar 2024 21:47:46 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5vCK3Y88zlgTGW;
	Fri, 29 Mar 2024 21:47:41 +0000 (UTC)
Message-ID: <56e0b858-598c-4730-88e8-901b88d01f51@acm.org>
Date: Fri, 29 Mar 2024 14:47:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] scsi: ufs: cdns-pltfrm: Perform read back after
 writing HCLKDIV
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Can Guo <quic_cang@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-6-181252004586@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-6-181252004586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

