Return-Path: <linux-kernel+bounces-126147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA008932D0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D87C1C219CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A156147C8E;
	Sun, 31 Mar 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZxDVxbYE"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DD1474CF;
	Sun, 31 Mar 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902384; cv=pass; b=pQ9gqOMbLEKWwISPWE737i3QmS9AmNlCp5hsRLJcnNM9SszpCBBfSWlebLqXXqDODySW8aUi5yCmBX2Aq7+SKjRsFMHwlnJ/04cwuahPAn4e4fSu5ub9r6/0kOix+sl6O/aAWyOXaJba6Zk2aNXxxRmz1gSRVQvpUnJLjdEP1rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902384; c=relaxed/simple;
	bh=J5LIx5QO4UTpoH00UmARxJQQGAw/SK3Fu40quzpO/5s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=T5kRVNLGX2UPOrWcm6JboHyRCHrUVVmjNWTdqU9vxv4LUtb30QaKW+g+MThe3iGujftsBT7/3yYgStYsYteLs2+PMxdK4fRjwcKYoMn8wBIbWX3nVlr8V4vZ4/lASL2DvIcUwhTjbNOo1LXFH/GxQmFEs0p/zC3EbdqwQfw+094=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZxDVxbYE; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DAA50208A2;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jhYLttcvY_FQ; Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A3F2420842;
	Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A3F2420842
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 97F3780004A;
	Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:36 +0000
X-sender: <linux-wireless+bounces-5632-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAo5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB6AAAAjYoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11763
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5632-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0633B20870
X-Original-To: linux-wireless@vger.kernel.org
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



