Return-Path: <linux-kernel+bounces-44435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD3842204
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690B81C24083
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B86775E;
	Tue, 30 Jan 2024 10:53:58 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D267740;
	Tue, 30 Jan 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612037; cv=none; b=SMa3dTidqb0UVWOgBlRZEGqJWt1HPg9ggQC8xQhEhQZS54qTwOLjclm7AxMSfiC1hzViJNlxVDuM1ndVB33s/wMv9vrNATjNwO6LcqveUacrRxIOVq71m/swHHgKPDPILW+hAtTX6l3iQi2SZZIkR0HC6QouSw0pFP/MKdkR0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612037; c=relaxed/simple;
	bh=c9tOg96jjd1LYzpQtVgyPp0A7gtdbS1WwYmc3xRzXsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4fkI140GUg9XAxXX3MGQiho55a7EtwPYP5lDuZUfRYWaMNWJw7BPygae/q1v2fX6Db4X+UShKPGDfsoIdpuxXg5aSlX9mO6vCxKmtg/V5UwCVlsAcmNq295xXgsr/npstp3sXkiiTTCnJglKuwREuFVJ5BgTogSZqjqbsQj0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1706612016tco7no5s
X-QQ-Originating-IP: sVtAEtWP2BlVI0gAQDFaEXd9/6kioAwv56yjNvYRZ40=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jan 2024 18:53:35 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: IcCSTr/hHjNqMNUvibW4KEATWHxQ7jO9cOlP29TxqqXeG+vbkkOJxRQ894o2P
	J+1fVc8tsK7M6zdn5BDfzHcAsQNTloGw/RwDvaEcyhiUR5E3QLO/7YX7gLBiExmy+DsykVi
	fexCB+3o8qvf7RlnV+VizBV81YsZpkkRQg/ZabEZ3romKKEG3C2PCf9bzeFfz9xgZqwFRpO
	/2ziOVO93DKvIcM+vOiY/o1qwvr4CcmJMomRdzM5eYZ09gtkNcg4N2p77LkNSdCFI/7BR/P
	QQOLBJfH7aKCXI4/yKhoEa8XzoHxBLpSc2obWldHeFRaNCrrVgS+GZ0fzhdEzGCjb30EPSc
	llnGJCB5Hxfp+SWh2eMsbwW6jqYjSZE83iqhnalETRtgV5WOeDxB0U9YcsuFwTXbUlyYa0x
	pBsab0rPFkI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10820603791902915855
From: Dawei Li <dawei.li@shingroup.cn>
To: robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 2/2] of: Implment cache update operation on device node attach
Date: Tue, 30 Jan 2024 18:52:36 +0800
Message-Id: <20240130105236.3097126-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240130105236.3097126-1-dawei.li@shingroup.cn>
References: <20240130105236.3097126-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Use implemented __of_phandle_update_cache to update phandle cache on
device node attachment.

While at it, make explicit assertion on locking dependency for
__of_phandle_cache_inv_entry.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/of/base.c    | 6 ++++--
 drivers/of/dynamic.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8b7da27835eb..44e542b566e1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -153,6 +153,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
 	u32 handle_hash;
 	struct device_node *np;
 
+	lockdep_assert_held(&devtree_lock);
+
 	if (!handle)
 		return;
 
@@ -195,8 +197,8 @@ void __init of_core_init(void)
 	}
 	for_each_of_allnodes(np) {
 		__of_attach_node_sysfs(np);
-		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
-			phandle_cache[of_phandle_cache_hash(np->phandle)] = np;
+
+		__of_phandle_update_cache(np, false);
 	}
 	mutex_unlock(&of_mutex);
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 3bf27052832f..a68bf58f2c24 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -219,6 +219,8 @@ static void __of_attach_node(struct device_node *np)
 			np->phandle = 0;
 	}
 
+	__of_phandle_update_cache(np, true);
+
 	np->child = NULL;
 	np->sibling = np->parent->child;
 	np->parent->child = np;
-- 
2.27.0


