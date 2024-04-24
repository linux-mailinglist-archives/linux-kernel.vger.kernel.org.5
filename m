Return-Path: <linux-kernel+bounces-156648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21F8B063B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC81C21930
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A9158DC1;
	Wed, 24 Apr 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pbWQxf3y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118A158DA8;
	Wed, 24 Apr 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951638; cv=none; b=HNDJmORJxP5XQbGldExLXazruI4VJcuUzQjjwaaSTYY0l+FquiXyLY2dlrCl+p8Z3+oWBzZWsy62mL4BR/LJCN8AXnuSi5he3FIgesmKIuMjVsOhFspYR7/05hP7TK0UbY95I85Fz3WHEs0pokt4UsSLqPX1eSzo1v6bZ0Pa4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951638; c=relaxed/simple;
	bh=mNayW+VecV2dc9vrrmAV27oQDPaUWep+d6YIBhCY27A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCP1EvPNqFIxDbfzPOS1BrXcqdLLdD6kWdNTPMSr6NyJ7wQ7hjtus8klbTUyxMvE0aghUAZncmrtSicBFnPUUWvvOz2o5C+YoRsOdD/BGamV1+xriWc36jOIGQUGt9JXd9Dc+h18k3bgSA8PoLDdrWcKC60E6t2O03NG3lwSVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pbWQxf3y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O7aedI025191;
	Wed, 24 Apr 2024 09:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=W2zEB8HQ
	4tTQ0a1nADzmO6g2Mci2r9l3DcHJICevofY=; b=pbWQxf3yYXquwvvyxi2w+bTw
	PtZW5sWRsQd2RFfedYbVIo/yM3AuLFx4D98oB5+xPLboCBWALmfz0qtNPiMKhXZU
	lsYp+5xo830zYl17oEMadZeJeSEdZeTfib5GSiqOwp+8ZkaM50CqCgWWf+Z0VGxS
	0GtPL2MQjkfZX0JBkAdulMKumQYod2VFqWzLWNLWxmwIS3kXxTgVUIOqng4kWxDK
	ODUSuyyP9IhziqGKGbCnvW0TTJf/SGTB+Tp2mBwyLyjCC3g6dwXcb2XYkYqDj3SW
	k3zEHcbAVk+D9i9DvxeuA8m7vV2Ra9eLmyZkHY9i5TGKojMDW5q5Sfg353WpNg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0f3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:40:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9e97n008033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:40:09 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:40:01 -0700
Date: Wed, 24 Apr 2024 15:09:57 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
CC: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik
	<quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v17 15/35] virt: gunyah: Add proxy-scheduled vCPUs
Message-ID: <20240424093957.GY440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-15-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-15-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XLbgIb0Y_-CpZ9y5rvGSoXb-QMYlvkEG
X-Proofpoint-ORIG-GUID: XLbgIb0Y_-CpZ9y5rvGSoXb-QMYlvkEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxlogscore=825 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240041

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:38]:

> +/**
> + * struct gunyah_vm_exit_info - Reason for VM exit as reported by Gunyah
> + * See Gunyah documentation for values.
> + * @type: Describes how VM exited
> + * @padding: padding bytes
> + * @reason_size: Number of bytes valid for `reason`
> + * @reason: See Gunyah documentation for interpretation. Note: these values are
> + *          not interpreted by Linux and need to be converted from little-endian
> + *          as applicable.
> + */
> +struct gunyah_vm_exit_info {
> +	__u16 type;

Pls add an enum to describe the various exit types.

> +	__u16 padding;
> +	__u32 reason_size;
> +	__u8 reason[GUNYAH_VM_MAX_EXIT_REASON_SIZE];
> +};

- vatsa

