Return-Path: <linux-kernel+bounces-81165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC4867162
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D72128B70E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7B5576C;
	Mon, 26 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a2h+nP8P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055D54FBA;
	Mon, 26 Feb 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943425; cv=none; b=iLbe6US5XVLwMaOkNxd6dS2OhI2iWGSKLFFm8Yt8ujTbuB/qMWvhkmaefb4XJMf4xQxkqKuLM8yTuGNcbYDOLtl5RGHLl6FXVJpQ4NSNUXuzIYUqQI0wzE4a0jzyNlC/SbKTu+5/UL9Vmh6Ym1o68Wusch2xWxsxvmzy/SofvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943425; c=relaxed/simple;
	bh=R2ave+VKw8AG0nmVmTwyOlNLt2F8ifyUq03l0B4OtVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgYsaf6nFOSI6Sio+pjF8JdR6uxGEUOw4YeIelMW4eif+XH2N+HAxn52odY5nAEbozCL3OqcuRileaMpLYhFljTPWrR4o+haAhsD82r2nWdE5R54O7/xsyyd7StUprN14jGyc8Fxijdua1pobbYlsOLh+gTqMXqYFiiydaN4z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a2h+nP8P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q9tuNs011093;
	Mon, 26 Feb 2024 10:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=riixjeCWiyR8itCb2LMRE
	VDtb9m8Cn2wHYFk6ADL81I=; b=a2h+nP8P/GK2TOE28pZutvyLX5XA7b4omLQxZ
	6+3fak/cDKVnWgW43ZNgwfP7azxAm3kIPVn26mGXEZfqPeaS+Aihsc1S7jVvLM1d
	03ollrHFAxQHvtLQUrKxkvvurY82X2R9Sh8Yg5lPVD/Pfc2174P7XAFS4DeRzqCI
	CYzj1YrtdCrCFxJq6gYMGpipMMQoC2xXPRKiZNs6li7+jrw4rqsh3N94dg85ntKz
	94xLRgibsEZ1yaNNQgdhbHLczptlasUd5/rjD7mb/m1YN5rij6bcAa9Fb1bUVAat
	mCYMIk0wlPS54bjuu3AWFsGv2Ezp2iBvJe0T0enQSemyMF1fg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxm0km4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QAU96N010217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:09 GMT
Received: from hu-kuldsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:30:00 -0800
Date: Mon, 26 Feb 2024 15:59:56 +0530
From: Kuldeep Singh <quic_kuldsing@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh
	<quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian
 Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini
 Kandagatla" <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@quicinc.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Deepti Jaggi
	<quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 02/12] firmware: qcom: scm: enable the TZ mem allocator
Message-ID: <20240226102955.GA19256@hu-kuldsing-hyd.qualcomm.com>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-3-brgl@bgdev.pl>
 <tnylagkmj36lve2ub5voumtkqjdy6j3hr6yyk4mqkaabvc3gdv@voaiu2oqi73o>
 <CAMRc=McmfufqqEvouRCjY1ukVB_ie1r5QEocqRUK0VBheEq5Hg@mail.gmail.com>
 <CAMRc=Mc_iwMzKznfUknm+RwS3jN_GimpirdTDVCPtnYYS_1PNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc_iwMzKznfUknm+RwS3jN_GimpirdTDVCPtnYYS_1PNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YAYVSprMegzkEPn8MCJpuljkkaLzy2VM
X-Proofpoint-GUID: YAYVSprMegzkEPn8MCJpuljkkaLzy2VM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260078

> > > As we're not moving from the callers freely allocating what they need,
> > > to a fixed sized pool of 256kb. Please document why 256kb was choosen,
> > > so that we have something to fall back on when someone runs out of this
> > > space, or wonders "why not 128kb?".
> > >
> >
> > If you worry about these pools being taken out of the total memory and
> > prefer to have a way to avoid it, I was thinking about another
> > build-time mode for the allocator - one where there's no pool but it
> > just allocates chunks using dma_alloc_coherent() like before and pool
> > size is ignored. Does it sound good?
> >
> 
> Or we could even have an argument for the initial size of the pool and
> then once it's exhausted, we'd add a new chunk (maybe twice the size?)
> and so on.

Hi Bartosz,

Thanks for shmbridge patch series. Few questions.

	1. With current design of every client maintaining it's own pool,
	For any target, we might end up occupying lot more space by
	different clients than we actually need.

	2. Also, there's no option to configure pool size for each client at
	runtime level and a fixed 256K value is chosen for qcom_scm/qseecom.
	Pool size will be same for each target and thus making it less
	scalabale if there's adjustment needed at target specific level.
	Ex: For a low DDR memory target, pool size should scale down accordingly
	as 256K will become a big ask but there's no way to choose specific pool
	size for just one target.
		2.1 One way to do configure custom pool size value is to add new
		property in qcom_scm/qseecom or client DT node and then create
		pool of size with this provided value. Though there are ways to
		tackle this, but still clients specifying it's own pool size
		will always fetch more CMA region than what is actually needed.

Can you please share your ideas as well for upcoming version.

Regards
Kuldeep

