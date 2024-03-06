Return-Path: <linux-kernel+bounces-94370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D4F873E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497D41C21163
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A21E13F00F;
	Wed,  6 Mar 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WNkgUXTS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC313BAE9;
	Wed,  6 Mar 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748115; cv=none; b=UkCTUWBvdM7sdWNZ8kVNswf1p9/V0xWJZ8n6EUuHkpJhrasFGlpgHamgx5lvm+3jlDcOySQLpyhiM2FRPedxg9rkxGN7LGv+uBv0sYR2JtPiUioq1+l5ewoOMQvPMGkDumoDitFl21SJFVCRQWao2mq382eLmHbtVYNsRmTpDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748115; c=relaxed/simple;
	bh=WUJzhGYyB2Ri6kPDJweaS0R/kNRbw+oc+bRFKM4vtKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCQVK0r8PmQc+1h9Ilcjijxu40dx5o3/aUHPHEd2+k2Gt5qemrCO9e1oOlmwl0q82TrEcv15pHBM6VcMP3EdpyOAqSQOxvidSufh3pfp3VoEKY/yfjUNR6iQzjVQGydQftbCl3nFC5qoaJhRKgB7Fumz5OVJPsDluF5kUw2bxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WNkgUXTS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426Ae3dM004280;
	Wed, 6 Mar 2024 18:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=WEAfSEkkHQ3/425640Pby
	4gzYSJi7TXLgGMkYugkpt4=; b=WNkgUXTSnNljmIxyZcBG8bny1QsGt8jkTCdIu
	n4tMmjlRlN9DObX4WDXPMLzydCXG5QUIOdjSs9a+RPpTGac3QLfgcuBR3UZRb+ll
	FssjSi4hFQM2S4alN92PXCpdoqwdX3zOLXBUf87DoKbP6JnzUXqLzMbI3BrcZ4E2
	WhlMpmhd2SlQkKg4EpQCBLHWnSxZlAogea+eP3vq9f9JBBhhLvtI1TgMMgQROevh
	rdPluureRrQOEQ1BPmvV/6nDEN83UJUG1nSTWIb6AhcJylo74EdCIassQoMPUDvj
	zIL6i7D1DKbj8xCG5L96sJHEXHRvYaz3pf7lX7xjh7N03BteA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpepca2km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 18:01:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426I1ZPI016198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 18:01:35 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 10:01:34 -0800
Date: Wed, 6 Mar 2024 10:01:34 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Message-ID: <20240306095357736-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
 <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
 <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
 <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5DJeZAb2NtAabu9ImMNMEGT8SNvW_AF2
X-Proofpoint-ORIG-GUID: 5DJeZAb2NtAabu9ImMNMEGT8SNvW_AF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_11,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=732 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060146

On Wed, Mar 06, 2024 at 05:02:37PM +0100, Konrad Dybcio wrote:
> On 3/6/24 05:10, Elliot Berman wrote:
> > On Tue, Mar 05, 2024 at 10:15:19PM +0100, Konrad Dybcio wrote:
> > > On 3/4/24 14:14, Gabor Juhos wrote:
> > > > There are several functions which are calling qcom_scm_bw_enable()
> > > > then returns immediately if the call fails and leaves the clocks
> > > > enabled.
> > > > 
> > > > Change the code of these functions to disable clocks when the
> > > > qcom_scm_bw_enable() call fails. This also fixes a possible dma
> > > > buffer leak in the qcom_scm_pas_init_image() function.
> > > > 
> > > > Compile tested only due to lack of hardware with interconnect
> > > > support.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
> > > > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > > > ---
> > > 
> > > Taking a closer look, is there any argument against simply
> > > putting the clk/bw en/dis calls in qcom_scm_call()?
> > 
> > We shouldn't do this because the clk/bw en/dis calls are only needed in
> > few SCM calls.
> 
> Then the argument list could be expanded with `bool require_resources`,
> or so still saving us a lot of boilerplate

If we want to go that route, I'd vote to add it to qcom_scm_desc in a
new field.


