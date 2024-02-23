Return-Path: <linux-kernel+bounces-79308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D286209C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C67284782
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9814D42B;
	Fri, 23 Feb 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NNsVgKg4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DA1493B1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730685; cv=none; b=X5CaCAeXWkevmP1CJY5DDXpv3wFcsQSWjhXMKCWjYc79Cgmg1CeK1+U3iVAfFvAQj+XW2MmLyQmPBZ0sQl6Ac32BFNb1W4LiD75jxldQW2+unfYW0qh+NaXUyqx9GSV3dFfkvzdexvFO2ayS4SikrmMQLJTE725ayXEsgBF7AfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730685; c=relaxed/simple;
	bh=RhHzKbivcnr5zk+dnn36c9lo+jWc730FW7H3u34hn6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KaRgvhzZTL0mhp3G4ZjQOv8JNS75R1Bvw8qe4QGe/kxGyrSLGQbAIhdaOha84910MwjTt5K8Twx4fjQ4WwogCwIolIKQjRLQaI1BdYYt/SwJ8BZPS0Ij25I2wzLzBbCrTiqvESyd1uiqhDC2q1V0uStm8JoTRON+0+JLYqUbyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NNsVgKg4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NNOIA6027862;
	Fri, 23 Feb 2024 23:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Dvfy9SYvwBWfaPmPj3e2BSbtJB5OT6zxo7xpPYbgGJ8=; b=NN
	sVgKg4Sp77bsJHjXYbe8xGcJdnUCrEmLLhtWbg99VSSXGPuLE9QtscuV9HpI7pA5
	Z3/XaTOzd143q/mJyiPh7KMsXCZoxVnqnYccf+yh4MZ+A5QijSOQvlDweXJ1mV6i
	Vw0vDnriJSG9EGCGf8iHD6iQPSYtjtBZUB+ONEojIrR6HBCN2dBvmbvNwMcZnOGo
	hjmQtT1yNibHY2Qhk1No9GwjZ/BOusy6GyAHOt7lOYSZvWZOB8aQjPw7iOY+U7gx
	MwctXKIvvvngxmdYnihhbHrIktWU3ffuOT2V1+gC2MCsBPgXAJHzl8mAefkePYc3
	MTkKIcYmdS4g/+VKh5mA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf3gm0508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:24:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNOaJQ024410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:24:36 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:24:36 -0800
Message-ID: <428c4bc9-8ab3-e238-6feb-7d850ebdee61@quicinc.com>
Date: Fri, 23 Feb 2024 15:24:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] accel/habanalabs: handle reserved memory request
 when working with full FW
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Tomer Tayar <ttayar@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-11-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-11-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D_R872D-fRy0LKAfA5l5Kud-GkL76Pgp
X-Proofpoint-GUID: D_R872D-fRy0LKAfA5l5Kud-GkL76Pgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=781 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230168

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Tomer Tayar <ttayar@habana.ai>
> 
> Currently the reserved memory request from FW is handled when running
> with preboot only, but this request is relevant also when running with
> full FW.
> Modify to always handle this reservation request.
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

