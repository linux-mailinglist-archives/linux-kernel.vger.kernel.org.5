Return-Path: <linux-kernel+bounces-79279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4709861FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18761C21AED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3651250E5;
	Fri, 23 Feb 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eT+WdXFE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3446B5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728350; cv=none; b=EYRBYSwGg9uNS4u6kCvDFuxB9XhOgVojlvFCXMW4Vv0ND7z+obaMCLYZYGrAP9Lcz4KNymoci/Ofhac9XnqsF+fyQyYExmQTbIgPrrWNXgBObLqP+ZikbTaPuDHfE5TZdpbRcjnhrsnDGMIbjM6wG/pTqN9+ySTRkBVxZQlIrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728350; c=relaxed/simple;
	bh=nOdu+R9SwAQE3ScVjJjzihMA66FVurHBy9yICrhcDkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RmHmaC3X7dxs754VJQSvOqnUX+mkP/9A2q6XHOvnFSoVGfSQibf5VPDV9EBFBDYpVr1+Fyq4cU7WsZ9yKFP9xNv8ahYgcu/nPoz/SAE2yU2a8CYG94qnWRk2fKIycxXn3lMEEBsa1XUfy8nZwu6IwgKaZ85f3WPuvk0s1ufHR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eT+WdXFE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NLvSGT014639;
	Fri, 23 Feb 2024 22:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YD4lCrGltCC56TZC+wbX5tnI+mS1YEO1eQc114gkxb8=; b=eT
	+WdXFED6/wjcR5QIl4LEZb5DvqGaoH7GlN95BJQiJ4TdqRhwWXRAPEGw8ETy+JHj
	MXh2ZP9gVwhc4fpp6DwmLmtc7yWwd0CUkElBXDHW9GmTNrksBIjrbQ295tmxHrUL
	qSuAGhhQu+EgoS7LBUElPAvolKSZruFsT9icL3MOgL3a1+LhZPlDJ/BuhZSclBpJ
	6HrcdTVv7OUCHVSB4s3QGDHCsav37RX+ooCjnLtkUXbmXRCONrDN7xe3W/mEtm2x
	mx2PGSzZEhlvcZS6N5XderwgbJH2J5BYzQ3QpoNiYwX+h9KGEpxv2t91wnJVBOZW
	IzZ+PaoFxdyGlScY80WA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqcf9u62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:45:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NMjgG0001132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:45:42 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 14:45:42 -0800
Message-ID: <9616d460-0b17-69ae-7c8a-9006b17b2583@quicinc.com>
Date: Fri, 23 Feb 2024 14:45:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] accel/habanalabs: modify print for skip loading
 linux FW to debug log
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Tomer Tayar <ttayar@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-3-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-3-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A4OoWCEc96IUIYM0X2I8JBKot2_8dMfn
X-Proofpoint-GUID: A4OoWCEc96IUIYM0X2I8JBKot2_8dMfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230163


On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Tomer Tayar <ttayar@habana.ai>
> 
> Skip loading a linux FW image into the device with the current supported
> ASICs is done for test purposes only.
> Moreover, for future supported ASICs it is possible that there won't be
> a need to load such an image.
> The print in such a case is therefore not needed in most cases, so
> replace the used dev_info() with dev_dbg().
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

