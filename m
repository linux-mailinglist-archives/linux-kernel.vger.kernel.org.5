Return-Path: <linux-kernel+bounces-79311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078F8620A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF101F23089
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23914DFC5;
	Fri, 23 Feb 2024 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KdVuPVj7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8898DDBB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730839; cv=none; b=gaE32L5/7PFZrU3hHTo0+kjaroTm1BZVEDS0WKVwxlKbY8KjbvPqQsfSehI0g0XklRd7NmNIyFZ25paKmQ/rSQWP4LPopugl9tbsQ7JDS8cisnotAU0UWG4upJjngN4mWB6UlyGjGx5DnIYDG+7W+L4zytwH7UWGfpMoO4TwknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730839; c=relaxed/simple;
	bh=sRA93S3U0fdH3aroTqNQT4FXLMizSCGYGHO9L39PQFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O9FamZRpue45+jz0j7SKbTSyO7MThH1UyTFTMHzZZTEugDa3WitbG+O5C5CR5EcOIdRimGK3NgoWkUY7xMMkbJjpKcou0PZ2G123P6sjL1ffJsseqzY21/jy0IdYT9Nr6S1XGJiZvHZcPvcamHKUm1JG44D7nz8rNk8ox8cLKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KdVuPVj7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NNE6QK009400;
	Fri, 23 Feb 2024 23:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GMlwPg168LMCR+HvBr8hWUjGGZFVAjRcZEfvSkUFUws=; b=Kd
	VuPVj77sr72em4hL1GZqeWit+Ygwh+vl20kBJ4kZlhJWV3i7t3f/keFCoE/e0P5H
	qE3WxpYjeyBobMq57smINboCDlwCDmeSXvK76XhmFERPElnxLUxRaKe2cGVnpOFt
	nL+JHPQ9Iw4k1aO9C18iBDX+yjSSdSHD2383l2lqtHxJs5YlWXFRyR4zijNhCF0Z
	M/1B0+QjRM/dOFMV106BQ+EqjGMei2Bgs2UnOuVQNz1FF86LeCjZVgzNPeXZUyBt
	vjphT6KhflYZy3b1zQM3rehMHaqLVnX5S3Wv9GxkkWBNyAURt01/jS9WdMdY5GLh
	NDnoJNZlXDU67dL2uudQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf3gm053b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:27:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNQvtE009178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:26:57 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:26:56 -0800
Message-ID: <8fb0ff4a-ea12-f673-0e94-dd3f3d4acc11@quicinc.com>
Date: Fri, 23 Feb 2024 15:26:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] accel/habanalabs: keep explicit size of reserved
 memory for FW
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Tomer Tayar <ttayar@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-12-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-12-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hYMaVSgsYa4PfEy6vUUEIlFyfLa0wWoy
X-Proofpoint-GUID: hYMaVSgsYa4PfEy6vUUEIlFyfLa0wWoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=625 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230169

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Tomer Tayar <ttayar@habana.ai>
> 
> The reserved memory for FW is currently saved in an ASIC property in
> units of MB, just like the value that comes from FW.
> Except the fact that it is not clear from the property's name, it means
> also that a calculation to actual size is required everywhere that it is
> used.
> Modify the property to hold the size in bytes.
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

