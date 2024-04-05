Return-Path: <linux-kernel+bounces-132382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6B18993D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEF91C2388E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B922C69B;
	Fri,  5 Apr 2024 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VjKdmhCR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B1225D6;
	Fri,  5 Apr 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287519; cv=none; b=MuQDxNVmf/wsbTvLvZa/0oF6UrBRBgEUJ+yeyQpuQY1Z6c6RII3Gsn5oQxhF01ez8GL/lXXqKaRG3ke4Hhi6vvBKyjkxHXxnqWcO3TTL73lF0IT1YAjWBvP8syo49l6NjbJ+cMvJbO3GJ2/HHr52I68P3N4vb+v1o/92pIwuCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287519; c=relaxed/simple;
	bh=cXdbJLTNqU91g03IUWPDt9s3dcd9a7zvX2yVIwFMzkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOypWZDYXBsJWG3a9aZVx2HH+5/G5oXIi8NQdqCFNBnTQ/UozYNsLDvMDCS3w36gUDGwYU7W7CdXbo8QgXyiCQ0U16kWlIzWfZcUDGO7SW72Pn0PiJ60PC4IXjOaFnuCxEUqXNjuO4bTpl5LplAVozqwekcd5saquo1izd5mR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VjKdmhCR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4352MsDR017309;
	Fri, 5 Apr 2024 03:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=O7pAdYq0gXOgAPMzGRLRY
	4J+NTxIeiW5B+fKq2Jblkc=; b=VjKdmhCR2DqBfiSGs5KIDs2vvtA3TCPpPG4Qs
	909hppOeReNK9fubIFvFD2+3C3nVCkZ9hWypVEHggQptJNNZ1USy3WaoqC1qjkQW
	nCv+SclwSXTepllJwcXHINswpzW/r+eERH3Q81CZEmSiFDqUs5nRfuknaJBkOsrD
	7ryAk3cLeWNSxoAiiPwd+nu7KgWRS+wCmMrrgpyJW/VRDpcuBIX2ahHhUCYV3by4
	sbpnAUDPCD/TqeEkG40vbOsxvzRYfsEw14y7HBO5aZBzsvsIVx/kenGMvCV8cjsI
	e57SOq4JxW1VoA71cJ4MQ2h35lfeIZ6kG58qoXbHrx8zFuK/Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa8fc02fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 03:25:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4353P5U4029645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 03:25:05 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 20:25:05 -0700
Date: Thu, 4 Apr 2024 20:25:04 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Andrew Halaney <ahalaney@redhat.com>
CC: <linux-arm-msm@vger.kernel.org>, <robdclark@gmail.com>, <will@kernel.org>,
        <iommu@lists.linux.dev>, <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_c_gdjako@quicinc.com>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>
Subject: Re: sa8775p-ride: What's a normal SMMU TLB sync time?
Message-ID: <Zg9vEJV5JyGoM8KY@hu-bjorande-lv.qualcomm.com>
References: <kord5qq6mywc7rbkzeoliz2cklrlljxm74qmrfwwjf6irx4fp7@6f5wsonafstt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <kord5qq6mywc7rbkzeoliz2cklrlljxm74qmrfwwjf6irx4fp7@6f5wsonafstt>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kkGa_eprPLj8gEcvkM7IOIyfEexXuxYn
X-Proofpoint-ORIG-GUID: kkGa_eprPLj8gEcvkM7IOIyfEexXuxYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_02,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=576 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050023

On Tue, Apr 02, 2024 at 04:22:31PM -0500, Andrew Halaney wrote:
> Hey,
> 
> Sorry for the wide email, but I figured someone recently contributing
> to / maintaining the Qualcomm SMMU driver may have some proper insights
> into this.
> 
> Recently I remembered that performance on some Qualcomm platforms
> takes a major hit when you use iommu.strict=1/CONFIG_IOMMU_DEFAULT_DMA_STRICT.
> 
> On the sa8775p-ride, I see most TLB sync calls to be about 150 us long,
> with some spiking to 500 us, etc:
> 
>     [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd start -p function_graph -g qcom_smmu_tlb_sync --max-graph-depth 1
>       plugin 'function_graph'
>     [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd show
>     # tracer: function_graph
>     #
>     # CPU  DURATION                  FUNCTION CALLS
>     # |     |   |                     |   |   |   |
>      0) ! 144.062 us  |  qcom_smmu_tlb_sync();
> 
> On my sc8280xp-lenovo-thinkpad-x13s (only other Qualcomm platform I can compare
> with) I see around 2-15 us with spikes up to 20-30 us. That's thanks to this
> patch[0], which I guess improved the platform from 1-2 ms to the ~10 us number.
> 
> It's not entirely clear to me how a DPU specific programming affects system
> wide SMMU performance, but I'm curious if this is the only way to achieve this?
> sa8775p doesn't have the DPU described even right now, so that's a bummer
> as there's no way to make a similar immediate optimization, but I'm still struggling
> to understand what that patch really did to improve things so maybe I'm missing
> something.
> 

The cause was that the TLB sync is synchronized with the display updates,
but without appropriate safe_lut_tlb values the display side wouldn't
play nice.

Regards,
Bjorn

> I'm honestly not even sure what a "typical" range for TLB sync time would be,
> but on sa8775p-ride its bad enough that some IRQs like UFS can cause RCU stalls
> (pretty easy to reproduce with fio basic-verify.fio for example on the platform).
> It also makes running with iommu.strict=1 impractical as performance for UFS,
> ethernet, etc drops 75-80%.
> 
> Does anyone have any bright ideas on how to improve this, or if I'm even in
> the right for assuming that time is suspiciously long?
> 
> Thanks,
> Andrew
> 
> [0] https://lore.kernel.org/linux-arm-msm/CAF6AEGs9PLiCZdJ-g42-bE6f9yMR6cMyKRdWOY5m799vF9o4SQ@mail.gmail.com/
> 

