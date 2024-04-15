Return-Path: <linux-kernel+bounces-145573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F18A57F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B66E1C20E98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640588624E;
	Mon, 15 Apr 2024 16:37:20 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C08528F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199040; cv=none; b=n7BuxvPesnlieYWv4cJpi9uQH2mDEMIVe8c+HvowRm85sJI7THBeZ4wyNsLyOPwIckvX/BU78Hnj5rf1dTbZmXSdAxRK9yvpGZdnX/ER1lkWcIkTwFSm15OO5TQnQ572nmf63UlM8dUhHYHJm/7zuvpK7tydTcg1PnAcuUMukFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199040; c=relaxed/simple;
	bh=OMR/yqpIYddJCEEtUuKf+hhpGhi5LPtMQ9a9LCFLEDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuJ8GB4d8SxIOvnvblsJYygNZHM4EbGLx6fZRGEUW/QL2re4hrz0LSmK9ByOivobP3dHiXLrpX8HguMZohlKyTfNBOlK1oSyyXe9qS5BJFq1EFMB+rZop1j3JB6wjYT7BqvMt2Q2cYf/jb5deOxCBaRsllvdo135FZhUREymg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 137492F20236; Mon, 15 Apr 2024 16:37:09 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 646162F20231;
	Mon, 15 Apr 2024 16:37:07 +0000 (UTC)
From: kovalev@altlinux.org
To: mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	edumazet@google.com,
	elic@nvidia.com,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org
Subject: [PATCH] vDPA: fix incorrect VDPA_ATTR_MAX value
Date: Mon, 15 Apr 2024 19:37:07 +0300
Message-Id: <20240415163707.517820-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

The VDPA_ATTR_MAX value should correspond to the index of the last
available member of the structure, not their total number.

Otherwise, it can lead to interpretation errors in other functions
when the structure (.maxattr = VDPA_ATTR_MAX) member is actually
incremented by one and refers to invalid data.

Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 include/uapi/linux/vdpa.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 43c51698195ceb..ab132a09565232 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -74,7 +74,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
 
 	/* new attributes must be added above here */
-	VDPA_ATTR_MAX,
+	__VDPA_ATTR_MAX,
+	VDPA_ATTR_MAX	= __VDPA_ATTR_MAX - 1,
 };
 
 #endif
-- 
2.33.8


