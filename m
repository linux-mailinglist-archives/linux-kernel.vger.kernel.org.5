Return-Path: <linux-kernel+bounces-80415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D8866845
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C02817C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71640F4EE;
	Mon, 26 Feb 2024 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ixulh+Bh"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50052DF4D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915050; cv=none; b=Ag6V7exEwwW2BJdSvzZmXVWX4+1dckcioB/z0W964AtP4G7wlE51qnP89270J4TMoQDaoqx6/+qGNq1x12tsKPWgoVHuKNopNGdi09Q+nAKLUMBxHuz+f0+45fiinf4WMbtgfhHwz5ZyCM70yk0TNvjZHPSuHccJVLm4C5EybBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915050; c=relaxed/simple;
	bh=8ju9nGrnqXllCGUq/uiRZIGQQs1V4xbDgF3+PcJa57s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epw5qjgpXeCl0BuT9xy1/iJUESBAM0R66SZtxPmRCWD6apt3BQixJ4+z6n1wRL8kTtiUPPMr4KsggWU9+PearFIP6eXixH/R9yHc4a1pUdoNh0oljFGM3Rt3zwG8J4XrZvZLTDkZBFHQNOKaEq45WSIa7ukNZKU2RAHj6lFs4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ixulh+Bh; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q2L6ID032332;
	Sun, 25 Feb 2024 18:37:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=m1S/jeDFhTPTdtWYr2qH1HJyolt7fFJSe0iiRSUr624=; b=
	ixulh+Bhrj2SnHHNoxfwyPzXzyk2hbxs0JDhEKRSvg6UvoUTshlvZ8I8yEOL+f1D
	A5IqQ4DGTQoIAZ0SXm3s8SksFWwDr5EHl8m6bDnEftGiQFbtBjXyIxXOfiE7NwnD
	KwGBXGyoRJhn+T3dFGWYcuY1lX5dS+OuwIoDa4bqtkNtaInEXc5BM9pBgV3TLaL1
	cov5Zvoz8gcOHjxH/gul/PY0WGTuHiTpxVA8IyXLczJ2EVXKPtUiVGnbeDp1NO6C
	AWTVOtNZRxNYSuTgqphvZjUPisQUkKVHP/UUMcux1HrAo+zzNt0LD+jDCxv6ygAo
	+XopG6S+kAjER/pfUJvHVg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wfgumh2um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Feb 2024 18:37:18 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 18:37:17 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 18:37:16 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
Date: Mon, 26 Feb 2024 10:37:15 +0800
Message-ID: <20240226023715.2653372-1-lizhi.xu@windriver.com>
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
X-Proofpoint-ORIG-GUID: UC24_vY1kVfJziGg6v_0CoL4BSBsTSav
X-Proofpoint-GUID: UC24_vY1kVfJziGg6v_0CoL4BSBsTSav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=856 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402260018

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.8

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 61e500b8c9da..ae31e000dce2 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -100,7 +100,7 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 
 	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
 
-	if (WARN_ON(*vblank_time == vblank->time))
+	if (WARN_ON(in_vblank_irq && *vblank_time == vblank->time))
 		return true;
 
 	/*

