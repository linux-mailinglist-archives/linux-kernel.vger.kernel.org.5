Return-Path: <linux-kernel+bounces-103339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9AD87BE45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3019FB21619
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6916FE03;
	Thu, 14 Mar 2024 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X/CI4wht"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAD6EB66;
	Thu, 14 Mar 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424995; cv=none; b=Z3FuUBLgDZW1VK9ts/mHDj80JsN7+C5BM51i5ITOkWPSjMvmTwPZhDgvSTqZs2Nve+S5EvrOR1NpcsAvSatV8r1umbloZGBW2A8958b6GOmK19HpzrqbGJE4/gjXRmoY+Tj+Ggj0/3OVh3Tp7X90nj5mfrdk9G5WhooBKiPIrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424995; c=relaxed/simple;
	bh=844SbJYp0YccqYz7MknF4OAt+XbquUX21VVzyVSNX1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb8J5lUrNiUejoE4vIdIDxdrMeS/98fcc0jk1U2OB7PHDPH/mfRMUywV1Wnht563+1Yw3YQGnmPZMicTCPFyQWJgGq9YBMVYVk3fnaatgIBxeJN69ojkJvXnX7Y1LjixhuMftQguyuYnsN2w4rlCH2Emo8vIa0ez5kytR5ZUqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X/CI4wht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EB9LB5004256;
	Thu, 14 Mar 2024 14:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=QRASeV5e
	5btENATSzgRrGdH7Ex9wvJnRWFPwAvogqt0=; b=X/CI4wht1u9O1U3vd9tLTGbp
	q7IrfTxUuqIwVtZiEjalLeyGKYL3jHepRrtc3nfwOsbmAubBTklhGEAM7z0m7VmB
	2nmXpg/DSgq3PXqzfZUbxNWsSMneeveVtPGa7oMzxwirb6ZyahWxdWMRGYkNwp8M
	JEhwGZOpw9Td+ZiJ30w2xuf3eYgMUhffpJR9P0nPy9HYV05L2Z2XUgkR1zvN+e+h
	LTJCsdrZAK9AvpoLObSBTjj0eWtVCgNbeCwEoC/3rSqZ2E71PEErvhSPLd9HUl+X
	I6ajJV4rkkghDVSxZvIbNuIGT6JKABdthjJO7l0p0sra8CyKQ7Jiz91pEbgSrw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuruqscje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:02:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EE2wfA009451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:02:58 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 07:02:51 -0700
Date: Thu, 14 Mar 2024 19:32:47 +0530
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
Subject: Re: [PATCH v17 29/35] gunyah: rsc_mgr: Add RPC to set VM boot context
Message-ID: <20240314140247.GV440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-29-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-29-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tvqKn6XGgTPprC5J6Q1w97_CxPajaH5U
X-Proofpoint-GUID: tvqKn6XGgTPprC5J6Q1w97_CxPajaH5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=646 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140103

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:52]:

> The initial context of a the primary vCPU can be initialized by
> performing RM RPC calls.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

- vatsa

