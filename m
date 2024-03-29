Return-Path: <linux-kernel+bounces-126209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BC8933C0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73F51B21FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651381487C9;
	Sun, 31 Mar 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZxDVxbYE"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB8148839;
	Sun, 31 Mar 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903198; cv=pass; b=ioE8WtFHehxPzFgYX36Z2U8DIWktNT6GtJae5/ZSks4q7DTgO+/N5YpY1wYaGWmw72qX7RQx0qdNjHVBIITl4ZeAWSKl/u7wH3dadsxytEgjDiCNGe+OsfNPJV32ZXaRrW2fe2fx+1r0sG2MVSq+LImn4Nvq9mgySRuSTUdGRDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903198; c=relaxed/simple;
	bh=J5LIx5QO4UTpoH00UmARxJQQGAw/SK3Fu40quzpO/5s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=KrdqP8zaUazQnHlOb1S28GkRyXp17rmm03BfwGbTXJvwsVr77lhUDmJxkyXXUD1ALURoWy0nOKWjna1itt67ECI9gDcm0lNTi2X+yw8eqIdfBcatayWvUXwTthQY9OWu59PCFGQXzqn+TO+AKpZe/BQ9lpn1D6R/OfL81m+PVFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZxDVxbYE; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 309A52087C;
	Sun, 31 Mar 2024 18:39:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWGA4oZoyEZx; Sun, 31 Mar 2024 18:39:54 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B4E2A20844;
	Sun, 31 Mar 2024 18:39:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B4E2A20844
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id A8207800050;
	Sun, 31 Mar 2024 18:39:54 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:54 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:45 +0000
X-sender: <linux-kernel+bounces-125529-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoArUqmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 9457
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125529-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 124EA200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZxDVxbYE"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755058; cv=none; b=e49wQnZGJlZa+Cuq5Nvt3Jd2LSohXL9m96jy8uAJlQq022NnvYaH0EBTsmO9DbC/2O3M2D6LcfqXxBV0tcv717H5ou/dOhH6eF6qsRMMnBXO1V7b0ydLBkX9Fz+AF0rwkeQN4dEzyN8g1vVMsPwAYr9xSgWPAzRqLdWhRAd+1Qs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755058; c=relaxed/simple;
	bh=J5LIx5QO4UTpoH00UmARxJQQGAw/SK3Fu40quzpO/5s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=c2rPKQ8zufKizKK2o73OJc4xC60J3ehsmJicpA+L8jxDkLmMpavXmMT/mDbwqBHm17wMVsIwtvOsyasOqaoB5ClWQJJdCk2xHxteT07noDh2slUcHqVH0rF4Wq/L1Ev4mKXvuLjykNGV2mF9AhnvaONNI2xKpOnyl9XKyIx6ke8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZxDVxbYE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=jExMj2ePWMn70U
	E/9PCuqtzjYyxnKvP7hV6+ozEGZqY=; b=ZxDVxbYEqyBO+mIbAo7UlIhNmGL7p0
	XtffhcJumVtU9bDlOrHb9WTBjMV+r/wRP/YSmdq709z83asxxFIM2J6XL+Bf9fAP
	AKTOhh5nLRffvCcRrnRGQIvYv5aY/MYRvix59c9MDQ0dtc8p7kcCLD6LY+FB6+3J
	igNIyJ/B3BoNbuTJIbpEDAmTnNSzgeElDiWUF6N3+fTMr+Ay5Iube1R/gkECi4Iq
	mC6nzc16XZSkvNBf2atAfEfxnTfTHaERP1xQZWPAIR6jZkyhcM+ilr65dhntK+mX
	ylwdDAuQKtaVN9awo4E07h8D5/nVXrji+uNgQYjnYnlW6+QnwePGoEcg==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath: fix hal_rx_buf_return_buf_manager
 documentation
Date: Fri, 29 Mar 2024 16:30:49 -0700
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quicinc.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClPB2YC/x3MQQrCMBBA0auUWRuIMcXqVUTCpJ00AR1lkkqg9
 O6m3f23+StkkkQZ7t0KQr+U04cbzqcOxog8k0pTMxhtrL6Ym4r4clKdX4ITKovwkW9knEmUnUK
 vBxMGb6/QHl+hkOrxfzybPWZSXpDHuF+xRMVUC2zbH4Xh01OKAAAA
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
X-Proofpoint-GUID: YJ4gGW3Du894zrdNRYlDsqs9kfuJQ_yL
X-Proofpoint-ORIG-GUID: YJ4gGW3Du894zrdNRYlDsqs9kfuJQ_yL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=473 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290209
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Found two instances of the same issue once I added the -Wall switch to
my kernel-doc command, so fix them.

---
Jeff Johnson (2):
      wifi: ath11k: fix hal_rx_buf_return_buf_manager documentation
      wifi: ath12k: fix hal_rx_buf_return_buf_manager documentation

 drivers/net/wireless/ath/ath11k/hal.h | 2 +-
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: f09e3b774fe806ee0b1f2bb69771e8c29961e40a
change-id: 20240329-hal_rx_buf_return_buf_manager-4df5082f8b47



