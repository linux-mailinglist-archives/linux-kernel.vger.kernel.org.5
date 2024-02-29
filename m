Return-Path: <linux-kernel+bounces-86225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909286C1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE78BB257C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC544C76;
	Thu, 29 Feb 2024 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YZBpx3gb"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0044C69
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191231; cv=none; b=dN0L+6UbiMXSUBFNMPgWpiFUyGfPMuXFo2PHnI3wY8BbSjnLX8TjuoE6Z8lNXrcfE3G7t+6/swjLoLtJeID3E6eYVuioMl3StryFvbFRMIdrbGCCISIxOwah+lLqee5tprBdXd8cEBxaK7FJUIv9uSln0CYnCOPJ13B4j0L9fWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191231; c=relaxed/simple;
	bh=5owT2mmSIcyPKIqHX6anxx+p48OkmUiZh6ZFklUw16o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbCqpsfEbdWozVm1JDZcLSYDoEbw00uVReCSLGgDIBkhY6/RvohG5KbZfITX6Msy1lqfBD+OY+9mvEryuaKwzC99U0q834krao3YC4CujEOulX4OyStSMFefjr92ZjZxbhwTRfNld2sj2mR/7cSXWItHWHTZwX4oq9ozOJfX1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=YZBpx3gb; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T6UtXs004078;
	Thu, 29 Feb 2024 07:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=aQA1FGjGBZCnin1GCXGqv02s3sd+HBBVDdeHye7+N34=; b=
	YZBpx3gbvIBv6RmJbqslPZBJ47w/XEvHB4xslc9QbyyMHKlaNomR3QGMdKqJmN3+
	ToBbmi5N96y/vlB3PhTZNSaoA7w0YVvFVhOVT59SKiBtnRQ03WGw5TZOO5oBAzYw
	6DLeR3nfEspaeo7zZE/ZtN/66OVAiwVSuWu7/UXv98Sv3ABYFedyGnMjf4Q7W1FP
	QcrJObapmy/Q6P8SkqOPh3Z0iPdcGu9EvchA4o7gNMEYSSwTaWEO5mQGFWNtxvLE
	4BrNgr6RQ1nOBq28r2iRUxlwTRqpDbKvkq/tTOuABNDTU1z8eNqiIytlnmuKzAuF
	/kwvAO0VlktnJBz/e280JA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf7e6d5mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Feb 2024 07:20:19 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 23:20:18 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 23:20:17 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [media?] [usb?] INFO: task hung in vb2_video_unregister_device
Date: Thu, 29 Feb 2024 15:20:16 +0800
Message-ID: <20240229072016.186240-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008faf0a06126a0ffb@google.com>
References: <0000000000008faf0a06126a0ffb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bu2QW6jWm8BcqEre06joraw_P8BXXTKC
X-Proofpoint-ORIG-GUID: bu2QW6jWm8BcqEre06joraw_P8BXXTKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=772 clxscore=1011
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402290056

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index c575198e8354..437f80551a2d 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1262,8 +1262,7 @@ void vb2_video_unregister_device(struct video_device *vdev)
 	get_device(&vdev->dev);
 	video_unregister_device(vdev);
 	if (vdev->queue) {
-		struct mutex *lock = vdev->queue->lock ?
-			vdev->queue->lock : vdev->lock;
+		struct mutex *lock = vdev->queue->lock;
 
 		if (lock)
 			mutex_lock(lock);

