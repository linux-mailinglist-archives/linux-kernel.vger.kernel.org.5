Return-Path: <linux-kernel+bounces-101685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA38487AA82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C101C22E13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185C47A57;
	Wed, 13 Mar 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JsGryI05"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAC47773;
	Wed, 13 Mar 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344134; cv=none; b=UVMjz7pe/mdqJm9D4Xq3D6SVRs7ikZGWK0+aE9rZb1zsM+lATJMRsWLcpsoCUL8jdxRsFjdjpx0c4I3PAh5b8DhEWMXBKtjL9rG0xrPP/u+nQOtOxmkSim2yQJeqX2UAYBME9BcDmS3tJ1O/yh34bIfPqIOp1ll19sunnVZz6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344134; c=relaxed/simple;
	bh=jOQp4CryTW9XagCDuR6uUkkHla07BH/PK6sB2sD9gbA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARDc7POu4phEAToTs4f5nhPgOOYMtvkfn0dc9WgKLtDutanKygEAiaMG5SoJnovQm40djO8Afl4m8T/NfuW7XOqq5r2HAMIYCComGSysYGwZlSCCVmVNJQicozvnNLZ29+nsSZCWH2I/hOXSuZnO85WFgfyZy9y52Z/EPmBeHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JsGryI05; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DAPHf3019208;
	Wed, 13 Mar 2024 15:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=d52KNA3q
	0BZMEfgemsDgnZIe/xCWMrozSCni3qIL1PE=; b=JsGryI054YgtkJQmVj05IhF2
	nNO2JpXzrj0y+U9pXCIWM5TGt057i8EktE24HO+6/jowwc+PDKQhfggTDYFlKegB
	AZ8haHqr5iKoiONxG7KIpf0CNYmG2gFdKdDcam6LZ3nqPau6zS1rAQCvOv7H1jhQ
	bhLRy3ys4L5Vy7ZnxhKSMazoGKtKIrUfX1L+sIBLHJLPA9jQFxGs/OwO6pTLXIAr
	7Crnb83FayC3zxMA5dSwOWegVPyPSUVrEc2JvUv/ZYLxMJ9wRt49SJolH6tXSB1D
	olR7vWQxGAXQVuhfTGhwc5OryOW7NAptdojYL2K0eL+yjgniwsXWPVZBNhImhw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu815rys8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:35:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DFZF03025574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:35:15 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 08:35:07 -0700
Date: Wed, 13 Mar 2024 21:05:03 +0530
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
Subject: Re: [PATCH v17 16/35] gunyah: Add hypercalls for demand paging
Message-ID: <20240313153503.GR440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-16-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-16-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mFx73PGakvisSNip6iUaO2FFTWeGcFAO
X-Proofpoint-ORIG-GUID: mFx73PGakvisSNip6iUaO2FFTWeGcFAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=512 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130117

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:39]:

> Three hypercalls are needed to support demand paging.
> In create page mappings for a virtual machine's address space, memory
> must be moved to a memory extent that is allowed to be mapped into that
> address space. Memory extents are Gunyah's implementation of access
> control. Once the memory is moved to the proper memory extent, the
> memory can be mapped into the VM's address space. Implement the
> bindings to perform those hypercalls.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>

