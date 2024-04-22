Return-Path: <linux-kernel+bounces-153407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7828ACDC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC41283C93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0D14F130;
	Mon, 22 Apr 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MPefd/YC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127214A09E;
	Mon, 22 Apr 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791116; cv=none; b=AMi8mTRlCGvQNscEJSWKKxEGeOV3zepOQ1QtIYL67qwU3lr+FNcGDZckQ7GbKaQZOxc9YNNtCk9ikNGdqAOj3pPZDT/eWhBKo8YGNYTYppRmkYXTUhGCZFmcxVYN5aXPeGz+/UMNR8MTuGZPmgizsTU/kYOD1Dfu4TPssjWVV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791116; c=relaxed/simple;
	bh=AYXYdSjrS60uqFRFCctj2ZvuCU8r3kYG/nyJjGjXGJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WsF+FXsfyaakXiBsd/cboBj7NUO7cJTyFRpyZYhAF8CFRUaA88BllahRyBwFcpD01eic73shBu+MVMzHwLGm+/lGzNEb078JxjxtBicoZz7UEEtBjm+0BOCUQiIIFyWx2REfIxXJVAQW3P5N/euZH84mymQvIGBBDyWd1UMFAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MPefd/YC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M823do002911;
	Mon, 22 Apr 2024 13:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ovWSv3B+H61oCuvCm9t/WxM2ikWw4yKO6zzZ6kbn6us=; b=MP
	efd/YC4mStE/VFjrFv7AQ5/g9JmootfCIgScSvJ3qiEoUIbZPOb4WBXbURHytVTQ
	KJ/1IA4HcVLrO74nfMg34pO7VotS+b0BNWy8lah9lnQ/sEPMije8XUt5JdaUIEF/
	K+wj1upWCyY3vCGhE0BE0GfOtMEvCblSZTSdnP3yIEGNIS6SJMIzX7eQ9ai7FqgM
	ClvftXve3UDz8XvlXSkD7kLgc+Bsf4hV9jn3cBb2mfN+gELm94RXNoU7Ym77qtbk
	WSK8s4VXGvJ8BgWrfjjXuYgF75SJnCyEk2D7IZYdpm34k0WM6vPMuU/xvkWDca5j
	P/6AswBTYFIUiYZ4y6Rg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnm1bgr9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:05:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MD52l4016431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:05:02 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 06:05:01 -0700
Message-ID: <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
Date: Mon, 22 Apr 2024 21:04:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: Johan Hovold <johan@kernel.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Zhengping Jiang
	<jiangzp@google.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZiZdag8fw8H1haCb@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4nbmb7XqAGuKelga_czZbGHYiJEazCxq
X-Proofpoint-ORIG-GUID: 4nbmb7XqAGuKelga_czZbGHYiJEazCxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=658 lowpriorityscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220058

On 4/22/2024 8:51 PM, Johan Hovold wrote:
> Hi Luiz,
> 
> On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
>> Qualcomm Bluetooth controllers can be registered either from a serdev
>> driver or from the Bluetooth line discipline. In the latter case, the
>> HCI UART serdev pointer is NULL, something which the driver needs to
>> handle without crashing.
>>
>> This series fixes one such issue at setup() time which incidentally
>> masked a similar crash at suspend. Fix this in two separate patches so
>> that the latter issue is address in pre-6.2 stable kernels.
> 
>> Johan Hovold (2):
>>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
>>   Bluetooth: qca: fix NULL-deref on non-serdev setup
> 
> Could you pick these up for 6.9 or 6.10?
> 
> The patches are marked for stable backport and only privileged users can
> set the N_HCI line discipline these days (even if I'm not sure about
> pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer.
> 
> Johan
> 
Hi johan,
could you share the patch links for me to review. i can
't find them now

