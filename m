Return-Path: <linux-kernel+bounces-79315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E278620AD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7E61C21044
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761814DFC6;
	Fri, 23 Feb 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MDyX4SlA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB8DDBB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731129; cv=none; b=lObYAKAtHDMuLVG/bdjqNiAr7zXUwamoy8BUUocA0yfiw4+5e0HQBhbxPcRVFIKa1SVTaH6MCNqsdQ/8eDGdrkCHJukY4xSIcdr+r9EtCkHcMXvFSTB5eFk31YwMrLpSBnFc7bZ/DLaalb2YMeWUvl1nHDDvmPj676+731UZRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731129; c=relaxed/simple;
	bh=mptfRWcSfZNkIIg8e6vRfg8SebiYxorzuLLHQ5JQ/b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SmAJlw8EUDzUIAwnw0RX8uZfPl308029JMDh/jfFtcT/1YhW0o+CNgCV7u25ZW5SB+uIwiqfGOXniqa/QfXquuNNODBdTkYIHXD77T7khQz81TKfL/ZjwRaNgEZmMmFk03dHRlzd7P8AO0WeAixwktWjZHz66fpjSZz8ohYoKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MDyX4SlA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NNW2Lc004437;
	Fri, 23 Feb 2024 23:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+ybNdyyNqdSX3SG4wxvmEr9BC/uDI+SRx62ONRrwA28=; b=MD
	yX4SlADaYWi2omjdnSR9I6RKzd+X2dGUE91hP8VDotlQ0FiovRcKSC3L60Oq+uoK
	t9pms2Z56jA7YGgT27QjhSXmYEuf/LN2CC7kjepDOHiu2we0yf1KRlrBxeksxvfo
	+twXxspG2Wpl8RZRZ00SBet6D58238vLCoG2iT/05WFekddoVB4p+08zSiRm2ktl
	smjMQ2GO/fGw4E14veogG6f6Hq0Co3pefG34J5VojEP8A3j3cil6DWqkj30yw86n
	ykYUO3cU2IV46Xbw+QCJyZkdPBFkvg+lACY6FgkTKa5Dame/7c66R5MREfdhlloR
	Nu+zNk1lBA1oNaH8ZZww==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wekvetb3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:32:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNW1en015897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:32:01 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:32:01 -0800
Message-ID: <bbf83ad9-825a-0a9f-79df-620067de5c5b@quicinc.com>
Date: Fri, 23 Feb 2024 15:32:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] accel/habanalabs: modify pci health check
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Ofir Bitton <obitton@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-13-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-13-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lRhb6A63RkV57UqHTKzBCx0vhLv_bei3
X-Proofpoint-ORIG-GUID: lRhb6A63RkV57UqHTKzBCx0vhLv_bei3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=827
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230169

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Ofir Bitton <obitton@habana.ai>
> 
> Today we read PCI VENDOR-ID in order to make sure PCI link is
> healthy. Apparently the VENDOR-ID might be stored on host and
> hence, when we read it we might not access the PCI bus.
> In order to make sure PCI health check is reliable, we will start
> checking the DEVICE-ID instead.

What's keeping some system from caching that as well?

Since this is checking for PCIe link health, it will be 0xFF when bad. 
Checking some part of Config Space that is writable would be more reliable.

-Carl V.

