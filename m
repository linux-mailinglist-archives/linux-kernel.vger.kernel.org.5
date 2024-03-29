Return-Path: <linux-kernel+bounces-126211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905CC8933C3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38241C22E18
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39046148848;
	Sun, 31 Mar 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j+mW4tSn"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFB14883A;
	Sun, 31 Mar 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903199; cv=pass; b=HPxKAzMCPmnh1HLOCJuscc2uguw9VPyNaDWcba6SL44GjAKvjSJTZ0ZyZCidlIwmcOzIFFFnPVSC0QU+L4MvVK1bv3lzpb/O84gsCQ9NAfTgM5rL8XGQHhuGA5h7d84LDTDrP0m848ua9DcXNxatOg4/L1GBOW5X0c7qwry7CMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903199; c=relaxed/simple;
	bh=wNEr96hbZAhFfCued7lRV8Yr//BFDNMs0NMQUkiAb9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l5jMU089O/NlXdTqk5kjUDqaO+CuIzUy07JK2I8cg4kjPuIEFt3UG7pFHZF/ZHCygXIttV5qZlO11ClUqPt5ocJINMQeaQpDIYqBLfFYZUZAB9hGpm9zegG0OCv5YTIvhFV0cvdH88Yy+1V5f0Se7tx2/7vEKuqJiIt4J17+Ka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j+mW4tSn; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 020C52084C;
	Sun, 31 Mar 2024 18:39:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6zUpqJaRjUg; Sun, 31 Mar 2024 18:39:55 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 278612087B;
	Sun, 31 Mar 2024 18:39:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 278612087B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 1A4D3800050;
	Sun, 31 Mar 2024 18:39:55 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:54 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:45 +0000
X-sender: <linux-wireless+bounces-5631-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAqUqmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9762
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5631-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BAB3C208A6
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755058; cv=none; b=pxoK3GCHRJFFbaOzOV9fp85bZfH+gNqrlWhQILJTAKUocFhT5FOf5fABGA1IgvUKWeHBH41NjuthFJRb1zDR0RfXwm67VfSw9MKO130RfwBsgUJpz+2MNNNqUNmkR2sA8KSBMbDlrGdiI0a8l8Qfp/453StBeNwigUTy38rj76g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755058; c=relaxed/simple;
	bh=wNEr96hbZAhFfCued7lRV8Yr//BFDNMs0NMQUkiAb9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a569xJwHjGjwUOUGNe0rKikWvSjQHL9uVMbljY/4aDxxq7OsOKjuD66fkyUvM/b52ce6W2+SU6rwuOrxrC9bLPP0d1jGFqeUxJfm+vCWMzHM7OcSuZ0civNgs6LTw8AZrr/CaTClIaiDvQfPcQgW6NpsxqoyHemMyTQJZINNNRg=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j+mW4tSn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=btMEj1aDrdTcd3Zv9FcYOvSp4BckjwM0F4bigfeZiFI
	=; b=j+mW4tSnzVHkAi1Uz4sNohN0wtKGNQ4a5xKduE11uw5rcseapnVrts4bi7K
	F9xZOjPr8+dioSOT8uV3I7ZefkuHwT2hWQKvYWVUDYMmAL+IIxTThaN9MgoYc9JT
	HrA3zaQ+a/rOEi+3o1rUlH2LQiAYv9xg0d8uGeYEWd3q75HfeSedVTL6nRkQGorj
	6Cy9eoMFD5sFV5gdIaSGKe6t0qr9s/viTqdY2OV7450e6tuKQyDB4MtHWcLYlu3I
	vGqMjXdYvX7cg3qpShxYLOhUq7ie18Bb1zSa5cxHfHn/PePPv99DmYl7lgYtSiF8
	3ttnUndd050GYqh1FmmXMMhlr+Q==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 16:30:51 -0700
Subject: [PATCH 2/2] wifi: ath12k: fix hal_rx_buf_return_buf_manager
 documentation
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-2-e62ec9dc2af9@quicinc.com>
References: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quicinc.com>
In-Reply-To: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1TRfxswzYYGmIIvFz4OQbnVPNd35DZRQ
X-Proofpoint-ORIG-GUID: 1TRfxswzYYGmIIvFz4OQbnVPNd35DZRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=681 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290209
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

kernel-doc flagged the following issue, so fix it:

drivers/net/wireless/ath/ath12k/hal.h:771: warning: missing initial short description on line:
 * enum hal_rx_buf_return_buf_manager

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 107927d64bbb..dbb9205bfa10 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -767,7 +767,7 @@ struct hal_srng_config {
 };
 
 /**
- * enum hal_rx_buf_return_buf_manager
+ * enum hal_rx_buf_return_buf_manager - manager for returned rx buffers
  *
  * @HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST: Buffer returned to WBM idle buffer list
  * @HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST: Descriptor returned to WBM idle

-- 
2.42.0



