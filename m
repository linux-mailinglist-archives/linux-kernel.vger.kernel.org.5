Return-Path: <linux-kernel+bounces-80633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09281866AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21BE1F21174
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D161BF31;
	Mon, 26 Feb 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="VkzPfiBZ"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2471BF27
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932612; cv=none; b=MjG/DN6aoPmPKGJHZyaNXZdSJWcxA4tOkGi+a2oE++MDwNpSyP5Bs/78CyzFw66Ik+k+M0GwV2YUtBztfBQkwV9tOvM9Qsr9IS+Z/M+QA3IKldoXi8X3m6jhopx6YkFulPsruuRS8zqnp8/+g99MoseAficEIUTPHwPa4sOkrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932612; c=relaxed/simple;
	bh=bZ5BRcxIgT25jdo0qV0ny4CuAKwGateNRh5VLJjnIU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPLh8Z8WgBqLVXkHBvbMftj8X4jn0XzCim+PJnjZxyGjfZkuDjHR3sAfr5DmuNBYkUordDxeoSgrrLkmvPAyQTey1NVkgaxiwl3yFjTZe84IEjZCSWaDP836MI9HO6FnP6zO7e0XkD+NF2nL9XR43pCI5LRIwLX+S5y3MsyKBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=VkzPfiBZ; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5dCCP026565;
	Mon, 26 Feb 2024 07:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=tUwXftD1tbwMrW8GhPkEx1MEpT8RN8HhiQS0CcOAEo0=; b=
	VkzPfiBZIdBzHMhYa3jXkowPB7Gq7edh4xguJzLvYJaeoG9Z5Q88wezHcXG1ASM6
	8/HSpmJObhoXV1O9MIcnVYI7Smb07yHqR1uCNyxd49elt9lgdIGHOLgbT2GMURYZ
	YGJNITJ3L5r+yBltxwUEWUc0tjox1t2E/MKPvWiPPZxXlwxGL3oTb/uJMrNopNLX
	eMWa6t2V8UxuVO9+swq4OAUIpyOHfTVauS8UqKL+ICiklpDkmhl9VMYMqYfPNeCM
	VtADOV4fzbomYQl2YiIx1F3ScQSBs+6VLyGDSItLxvhg2YJPfjDrOSLn5f95E75y
	13lQZBIQ8ZFys1OrrRTo3g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf7e69jxp-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 26 Feb 2024 07:30:05 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 23:30:03 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 23:30:02 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
Date: Mon, 26 Feb 2024 15:30:01 +0800
Message-ID: <20240226073001.1248179-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000edf6a306105afb50@google.com>
References: <000000000000edf6a306105afb50@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MWiiFpwpgfxYc934K5izVACfAA3GpMtE
X-Proofpoint-ORIG-GUID: MWiiFpwpgfxYc934K5izVACfAA3GpMtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=962 clxscore=1015
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260055

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 61e500b8c9da..45942547af44 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -20,12 +20,12 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 
 	fence_cookie = dma_fence_begin_signalling();
 
+	spin_lock(&output->lock);
 	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
 					  output->period_ns);
 	if (ret_overrun != 1)
 		pr_warn("%s: vblank timer overrun\n", __func__);
 
-	spin_lock(&output->lock);
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
 		DRM_ERROR("vkms failure on handling vblank");
@@ -100,6 +100,9 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 
 	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
 
+	if (!in_vblank_irq && *vblank_time == vblank->time)
+		return true;
+
 	if (WARN_ON(*vblank_time == vblank->time))
 		return true;
 

