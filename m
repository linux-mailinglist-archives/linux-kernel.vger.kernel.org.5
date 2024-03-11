Return-Path: <linux-kernel+bounces-99298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B964878633
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211EF282F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181BB4D59B;
	Mon, 11 Mar 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LoNd7a1L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982F29A9;
	Mon, 11 Mar 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177605; cv=none; b=UOfl0xrV3kMWaEmvEptsyW8+bAsOWTmVP2KZzVCs1BP1Ir+//ChaZVIoXHHSnbHpB6JUxZAhVr6MDyCPZagyqH6XXROvlxwIo0BnASU2JP07gTe+LYb8fLYq/LCAUbVpZ6PpNCqKM4Y6ap/YbQcrmXyknKlNI6a6NOT9SyhG9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177605; c=relaxed/simple;
	bh=m2TxzT08YQKjAbbryIv7/Hqm7X/KD6qpUKmSbGjWy5c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmVJdcSngHhCPPIpwkhTKy2tFcUCVJYC3Fj0bVpiNDgz/J6xRQVhlcHSNQZPra4xoGEaOaihQd2e4RB/PmYFlIRuZMU314oPSOl5pDvXOkYYywKMG9SwH+p3jOSBvDc/GWBO+KNaf450pq7t08U+caoZWGNKb0PY1qcreJA+Jpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LoNd7a1L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B7wlVJ015645;
	Mon, 11 Mar 2024 17:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=WWyuMjMTY1FvQzmp5Vyly
	D/JLzCDxHXDW87OYD0aoaA=; b=LoNd7a1LEfO5YPrzFNm3OGkbXryXJnqKK41ph
	YeIxm/3KwN772o8oyPTkPH2Fb48/BiJx7/ueDPHYtVK3IEd3GFurQRL6OuW4tj4m
	Ue3gkuS8Rh1niug38eQ8iC72+7qdwlW4Ndc4pAYUdfIedj5ADzKgG5uihULj7Yk5
	KQd3ZVUTUZfaf7YfwyX2p9x9cMoWNYM9QM4a7GV+UpkoMvirpGp0rKuGZi/SDaL0
	3B590DbveV5pQLEEryX2L05e1RYBZH+ab6WJykOznStL6TCSupfbdTHi/NyQYWnQ
	2pPqOBVjCPDYy85wEgkU0KcqAt1XDT0EQWAHqf3JFEmLkceBg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsv209rn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 17:19:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BHJeuC012055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 17:19:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 10:19:39 -0700
Date: Mon, 11 Mar 2024 10:19:39 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
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
Subject: Re: Re: [PATCH v17 11/35] virt: gunyah: Translate gh_rm_hyp_resource
 into gunyah_resource
Message-ID: <20240311101433139-0700.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, 
	Alex Elder <elder@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Murali Nalajal <quic_mnalajal@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Carl van Schaik <quic_cvanscha@quicinc.com>, Philip Derrin <quic_pderrin@quicinc.com>, 
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-11-1e9da6763d38@quicinc.com>
 <20240311053905.GN440762@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311053905.GN440762@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JI12OXthCOMKMmTkBgAekRJxQYN4-_Nj
X-Proofpoint-ORIG-GUID: JI12OXthCOMKMmTkBgAekRJxQYN4-_Nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=695 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110131

On Mon, Mar 11, 2024 at 11:09:05AM +0530, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:34]:
> 
> > When booting a Gunyah virtual machine, the host VM may gain capabilities
> > to interact with resources for the guest virtual machine. Examples of
> > such resources are vCPUs or message queues. To use those resources, we
> > need to translate the RM response into a gunyah_resource structure which
> > are useful to Linux drivers. Presently, Linux drivers need only to know
> > the type of resource, the capability ID, and an interrupt.
> > 
> > On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
> > ID number and always a SPI or extended SPI.
> > 
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Minor nit below. LGTM otherwise
> 
> Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> 
> > +struct gunyah_resource *
> > +gunyah_rm_alloc_resource(struct gunyah_rm *rm,
> > +			 struct gunyah_rm_hyp_resource *hyp_resource)
> > +{
> > +	struct gunyah_resource *ghrsc;
> > +	int ret;
> > +
> > +	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
> > +	if (!ghrsc)
> > +		return NULL;
> > +
> > +	ghrsc->type = hyp_resource->type;
> > +	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
> > +	ghrsc->irq = IRQ_NOTCONNECTED;
> > +	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
> > +	if (hyp_resource->virq) {
> > +		struct irq_fwspec fwspec;
> > +
> > +
> > +		fwspec.fwnode = rm->parent_fwnode;
> > +		ret = arch_gunyah_fill_irq_fwspec_params(le32_to_cpu(hyp_resource->virq), &fwspec);
> > +		if (ret) {
> > +			dev_err(rm->dev,
> > +				"Failed to translate interrupt for resource %d label: %d: %d\n",
> > +				ghrsc->type, ghrsc->rm_label, ret);
> 
> Not bailing on error here appears wrong. Can you check?
> 

Ah, yes. I'll return ghrsc here. I think it's better than returning
NULL because user of resource might be able to cope without the
interrupt and can let us get a more helpful kernel log messages because
the higher level VM function will complain.

> > +		}
> > +
> > +		ret = irq_create_fwspec_mapping(&fwspec);
> > +		if (ret < 0) {
> > +			dev_err(rm->dev,
> > +				"Failed to allocate interrupt for resource %d label: %d: %d\n",
> > +				ghrsc->type, ghrsc->rm_label, ret);
> > +			kfree(ghrsc);
> > +			return NULL;
> > +		}
> > +		ghrsc->irq = ret;
> > +	}
> > +
> > +	return ghrsc;
> > +}

