Return-Path: <linux-kernel+bounces-79278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C925861FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE91B2241B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABC5146019;
	Fri, 23 Feb 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LYJmRkC4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043138FA1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728168; cv=none; b=MGQq6yUQwG93QJbYJC7vlAXUyH8HoraPi3dbWJcEbv3hdOMFc9nSr4/tlAmG0KVgoSMs5V3i5vCIhIgOuF50G949RWeusKF0Q4k0NR86dn7JV9HR3g2D7IQIm+7wkzJT116n7gpnRI6NrCQv3WSlKn4cMXJpDVSG90z3Kt9katM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728168; c=relaxed/simple;
	bh=dGHY4G6N3sAvDAeTh/MBRS/sofIgI8nC92EnuSNmioM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dwqS4AsjLNA3i0kD2cx/Y+OFMauzTMbtzxab15zXvU2avgunOS0Xu/7Cyv7B9wQ1YFT6cUoM62wv0mq52q7CjKuVN8s0rBcCgiJ0+QUW5NJ7wLQRMeFPyQbUD3cSyq0NZQ57SOEYLbpMThh8Q53xep0Ify7zaaY84/aRjKM6pNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LYJmRkC4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NMdYkf007479;
	Fri, 23 Feb 2024 22:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1SKw7Unhlk/3oa4dj1L4BiXTr60aSnQ8WqGpLQ5NrRw=; b=LY
	JmRkC44KnyIFdgdLfxHEY6TLRsDKjAQuilsJHoxiYuX2+moICP06EZa3kOkPxBqy
	924BWnD2uam5ese3dhPiI/mHbzOoV7t+lUQkBw5OkhAxrSrbHmsGqPlUJn7SSK1F
	xZ9/D6g/Cr+8YVlVsyIUm6BDcjvL9m+RJX0CDe9EMtVHKly4SMvmB+xq6hjRVP2n
	5do/w5SCvng5Iy0Q4d2lQHFEKguP37hAeNFO4lvbhKqo9s4hbU6s0ewDB3+x+F+p
	6ZzO3HQZRqAJPlnJy5BGBbYK8BJBeZo2xkM/lolqSOKRrnfgrx3v6ZCWDZ1J1kMB
	zT4/otLRCpy3CqHcULWg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weq6x9uhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:42:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NMgf3e019477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:42:41 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 14:42:40 -0800
Message-ID: <0d8e6c76-66d8-3774-1706-eb114ef1ff15@quicinc.com>
Date: Fri, 23 Feb 2024 14:42:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] accel/habanalabs: remove hop size from asic
 properties
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Farah Kassabri <fkassabri@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-2-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-2-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VkZXWP5d_Vet_8t9X9dc19qnUB5rILR0
X-Proofpoint-ORIG-GUID: VkZXWP5d_Vet_8t9X9dc19qnUB5rILR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=869 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230163


On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Farah Kassabri <fkassabri@habana.ai>
> 
> The hop size related properties is a MMU properties and not
> asic properties.
> As for PMMU and HMMU we could have different sizes.
> 
> Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

