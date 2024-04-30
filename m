Return-Path: <linux-kernel+bounces-163412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE078B6A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974551C21193
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AEF18EA2;
	Tue, 30 Apr 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iD38tpbv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA411FB4;
	Tue, 30 Apr 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714458627; cv=none; b=s4ew/KyWZs8lFnE8g09g2mcHLe09SO6LizM08fz0dq9Puu+YqHV+2XR3zk33kAqgn9xcqUHUfffSMaO0EbKLG4JuMFINnjazSuevg0YLlVDzK+RougUtsJ6lTDc2de+WUcMGljq5mNBVtsAVIakT66MBR6fylogsg5u69KPKAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714458627; c=relaxed/simple;
	bh=IQhBn/hMmd7HCHLsytKP5JxhjL3zE6VFWPB3jK+r4j8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYffBPHODDejy0G3z8NvOJSpiSHnG8tA2kNevGA+S3th+v+C7OI5aFW/HjRf1HPKmLyu7qK706CRm76z6ogNVoUoZtv25H+rmgT2iMtu+mZkAL3d6iPKSsUqn8WDW4vIDR4wV7fPsBTk36qBd+Dn+wkUlQP2lBxqaGQHP86mgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iD38tpbv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U6ToM3019194;
	Tue, 30 Apr 2024 06:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=JpG2WFOB0nCfCkne5qeyZ
	jGa2reeN+MFVg/J5Y+W930=; b=iD38tpbv1Wj3mUuANOox/AtqQGQmF4BJ4LJbY
	L1+YX4gKva6kpBoBpt8Keo93ztql7SOlLim5aCBsXJuxfQwSIpcppr6ApcjPHIoo
	qlzMNtFpCdC2j0pEM0w4kRhdz2oZmYz4AohR7u+4EzyiHKtHs73OV73ap13ifcnn
	tFLwhg7I0Lr78SIvRX3K1v5aYwpzQvD8Sqx09IVtliZjlb++1MWUtbL29Uw3nNXn
	r1DV3knQDvqluWUCiLQz/qWTCJONyEccIYkyN4GknQ+U4RYujWClOPgldGyt+735
	jhe1d48nEQJ24d97C3QfKp5Kqnv9+PjcKBta9eRFMgJ8DACtQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtsnm8a9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:30:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6UErB006756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:30:14 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:30:09 -0700
Date: Tue, 30 Apr 2024 12:00:05 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v10 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
Message-ID: <ZjCP7VQ97lS6SeHS@hu-varada-blr.qualcomm.com>
References: <20240429091314.761900-1-quic_varada@quicinc.com>
 <20240429091314.761900-2-quic_varada@quicinc.com>
 <cfd60a71-b0c1-49d5-82ce-0c52764cea14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cfd60a71-b0c1-49d5-82ce-0c52764cea14@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SWOotf9iUibpdBuQnnr9YJVeQP-cFQcQ
X-Proofpoint-ORIG-GUID: SWOotf9iUibpdBuQnnr9YJVeQP-cFQcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=924 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300046

On Mon, Apr 29, 2024 at 12:08:40PM +0100, Bryan O'Donoghue wrote:
> On 29/04/2024 10:13, Varadarajan Narayanan wrote:
> >   	for (i = 0, j = 0; i < num_clocks; i++) {
> >   		qp->clocks[i].clk = data[i].clk;
> > -		node = icc_node_create(first_id + j);
> > +		node = icc_node_create(first_id + data[i].master_id);
>
> You have a few conditionals in the way down the end of the existing for()
> loop but then you hit this
>
>         onecell->nodes[j++] = node;
>     }
>
> which means that this
>
>     node = icc_node_create(first_id + data[i].master_id);
>
> is not analogous to this
>
>     node = icc_node_create(first_id + j);
>
> So for any loop of this for() where j was incremented previously you would
> not _not_ have the same node ids after your change.
>
> In other words dropping the j index will result in different node numbering.
>
> Is that
>
> a) intended

Yes.

> b) correct

Currently, drivers/clk/qcom/clk-cbf-8996.c is the only user of
icc-clk. And, it had exactly one master and one slave node.
For this the auto generated master (= 1) and slave (= 0) was
enough.

However, when drivers/clk/qcom/gcc-ipq9574.c wanted to make use
of the icc-clk framework, it had more number of master and slave
nodes and the auto generated ids did not suit the usage.

Hence wanted to move away from the auto generated method. And
instead use the ids specified by the caller.

> and slave ids" which it does but it _also_ changes the autogenerated ids.
>
> So could you either a) fix that or b) justify it, in your commit log.

Will change the commit log and post a new version.

> Also I think the 8996 specific change should be in its own patch.

Earlier it was separate. Was squashed into this based on
community feedback. Please refer to https://lore.kernel.org/linux-arm-msm/CAA8EJpqaXU=H6Nhz2_WTYHS1A0bi1QrMdp7Y+s6HUELioCzbeg@mail.gmail.com/

> TBH I'm not sure the autogen change is on-purpose or warranted and for
> certain the commit log is not elucidating on which is the intended case.
>
> I think you should rewrite this patch in two ways
>
> 1. Fix the autogen case or
> 1. Justify the change for the autogen case.
> 2. Separate drivers/clk/qcom/clk-cbf-8996.c into its own patch that
>    applies directly after changing the core
>
> Perhaps you've already gone through this debate with other reviewers but
> then you haven't captured that in your cover letter or commit log so at a
> minimum, please do that.

Will update the commit log and post a new version.

Thanks for the inputs.
-Varada

