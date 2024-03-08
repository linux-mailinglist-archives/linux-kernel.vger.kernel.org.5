Return-Path: <linux-kernel+bounces-97524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBBF876B75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64401C20E45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4A5B5D2;
	Fri,  8 Mar 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d2dVYaLP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCD2C191;
	Fri,  8 Mar 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927746; cv=none; b=cdxc72L7nsTymoqEO/SiRQz9+8DDBlPt+t2/FtBCB/a6KG6B+56s5A/k0MDlCmarSkjMfISlPCOJP47OxQzKLTKWE16DVMI8I9fF96kRiZqK8urbvcEyS9C9eWB0rjLQk9KsmCCDbNUbxAEMJrwzFY7IN6JFmRs8RXI4phPQibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927746; c=relaxed/simple;
	bh=tnPTILfzWMATgYslzfwpu4T+3aF7xtrJICkZUDR6nu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LngjkKAXmLGsjGDys95sOx0ZNVh4loLVQzxVHB37YiacLpZk0I6Iahkw2PUzj1HlqszJ4nmQskdPk+NG6OHIr0RVhhsKm4AW+6BVbXr61Z/NdStZ4mad5AtqZqsvctyS6Tl/f9DB6loJhh3i9q3HSVG/Wz2EJHlOGdoT2QwhBfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d2dVYaLP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428EaM3a025654;
	Fri, 8 Mar 2024 19:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=HYm7SjumDtT6XU7tM/etg
	wnCfvR/pgbIRZpy4sQN8C0=; b=d2dVYaLPD8z2QEmEyrny5gf8A91PN+Mvwwi5w
	ga3YnrmT9a0jjaWOxKC8pT2B27aMlBOg2E9QpAswY5YkRy1jtV1SYQhBRzGUYUSO
	q2MoQISzH4+5trJUqMbg2tkwQgCRu2dVdem+3Zyzaunqbd8ZqyttEwx30UWxiaYd
	Y0YZJXwp3nPeUsMEq0jMwrY3H0Addx338SsmsOyf7JVGyj9wLYCBGrU4VrcsFZao
	AHZppHq1hTGixVbKkr65sNo677UqGnMMUFbdQwMHeI7033JkBkpCN9rokyEezzh0
	BcubJRrBrPPH2WwrmDTe6qyb+15T5ox8NPMOZcPFkLZP2Ya2w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr1wj138e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 19:55:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428JtOEZ001763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 19:55:24 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 11:55:23 -0800
Date: Fri, 8 Mar 2024 11:55:23 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Quentin Perret <qperret@google.com>
CC: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Android KVM
	<android-kvm@google.com>,
        Patrick Daly <quic_pdaly@quicinc.com>, Alex Elder
	<elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin
	<quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Fuad Tabba <tabba@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: Re: Re: Re: Re: [PATCH v17 19/35] arch/mm: Export direct
 {un,}map functions
Message-ID: <20240308113215616-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Quentin Perret <qperret@google.com>, 
	Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>, 
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>, Android KVM <android-kvm@google.com>, 
	Patrick Daly <quic_pdaly@quicinc.com>, Alex Elder <elder@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Murali Nalajal <quic_mnalajal@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, 
	Carl van Schaik <quic_cvanscha@quicinc.com>, Philip Derrin <quic_pderrin@quicinc.com>, 
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
 <ZeXIWBLVWzVycm0r@google.com>
 <20240304094828133-0800.eberman@hu-eberman-lv.qualcomm.com>
 <Zec6shyjblcZvTG0@google.com>
 <20240305093131473-0800.eberman@hu-eberman-lv.qualcomm.com>
 <ZehcEqvC3Y9YytNi@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZehcEqvC3Y9YytNi@google.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CBoYWssXhH8RPoK4yG0CRdOyh2SPhfnf
X-Proofpoint-GUID: CBoYWssXhH8RPoK4yG0CRdOyh2SPhfnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 mlxlogscore=588 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080156

On Wed, Mar 06, 2024 at 12:05:38PM +0000, Quentin Perret wrote:
> On Tuesday 05 Mar 2024 at 12:26:59 (-0800), Elliot Berman wrote:
> > I still disagree that this is a Gunyah-specific problem. As far as we
> > can tell, Arm doesn't specify how EL2 can tell EL1 its S2 page tables
> > couldn't give a validation translation of the IPA from stage 1. IMO,
> > downstream/Android pKVM is violating spec for ESR_EL1 by using the
> > S1PTW bit (which is res0 for everyone except EL2 [1]) and this means
> > that guests need to be pKVM-enlightened.
> 
> Not really, in pKVM we have a very clear distinction between host Linux
> and guests, and only the host needs to be enlightened. But luckily,
> since pKVM is part of Linux, this is pretty much an internal kernel
> thing, so we're very flexible and if the S1PTW trick ever conflicts
> with something else (e.g. NV) we can fairly easily switch to another
> approach. We can tolerate non-architectural tricks like that between
> pKVM and host Linux because that is not ABI, but we certainly can't do
> that for guests.
> 
> > If we are adding pKVM
> > enlightment in the exception handlers, can we add Gunyah enlightment to
> > handle the same?
> 
> If you mean extending the Linux SEA handler so it does what Gunyah
> wants, then I'm personally not supportive of that idea since the
> 'contract' between Linux and Gunyah _is_ the architecture.

Fair enough. We're building out more use cases where we want to allocate
memory from buddy and donate it to some entity which unmaps it from
Linux (some entity = Gunyah or Qualcomm firmware). Video DRM is an
example we're working on. I imagine OP-TEE might eventually have
use-cases as well since pKVM is doing same. David expressed concerns
about exporting the direct unmap functions. What kind of
framework/restrictions do we want to have instead? I don't think making
drivers like Gunyah a builtin-only module [1] (even a refactored/small
portion) is the best approach, but maybe that is what we want to do.

Thanks,
Elliot

[1]: qcom_scm_assign_mem (d/firmware/qcom/qcom_scm.ko) is an example of
a module that would have to become builtin as we upstream use cases that
lend buddy-allocated memory to firmware


