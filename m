Return-Path: <linux-kernel+bounces-44434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91A842203
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE74B28B51C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407486774C;
	Tue, 30 Jan 2024 10:53:58 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D90679E1;
	Tue, 30 Jan 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612037; cv=none; b=mNuKkwycJ1VE4esOG4nCrwQGiQacv6BTyDP1Fo5cswrQWFPvTzEe/JO2zhbItj1VsWU4qxiBNApXrQ1zSY+8lOz8w/vXwlxWhfqtHBev7nj/FqQ6yqZysPLe7e25sAJxUZlDuIRg3sl8iVNbaDbLXieCxLUcYtztrIbD0vxDIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612037; c=relaxed/simple;
	bh=RIK1GTg4s+rzbcaZXHK3u636sXfCOEHmIpjFNKQH/dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JiibWpJB82JXnNVVBzE/dcC4xrIMvHi9ZARa4AR8wfUXiylIPyVcjysWqsPEYSPluO+6v4CCAmPPjN2YGVG4HjNLWra3FiHL7cYH2gRKOBszanoNqSX0IN0iZE7zZWEtpr7hx952Y3vCUsTJCFmXs5Xs3lqaQzQMd+NZuIr4RcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1706612008t5pdrgw5
X-QQ-Originating-IP: McRnbfgIa0ScS2LSD6966zLm+LhiBWrKFLqPBn+AjPs=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jan 2024 18:53:27 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: hbRRqFkQ5Km9KMEaVsJ8Yg3S2qaluHN41rFJKLGwpIe8Lc2o6QRSVAfxL3TFV
	ul80InEbhhCPqguTFs9hhU18gu/OibUWzEo+mLfpAt1x+Er0r/aUmVgQYEt/YOrBHMiv7Tw
	UkOhG1giJz8R3tkYqA+j9M30/jdcNbUFctEmlY0fISL6aBq7LqspOEXTRIlHen/OAhMGJm4
	9ALwTwZ6CIBntsfSB5rgrVpkOA6R4sG83H4AbzNomaffUewLBEx+9ZSHfyCAjavjkSY7iiO
	Rn38RTa1e4XSw/2li8q0MrE34SdHN5LeyuVl0iAB3CJYBqkuCHZRQMQ/tKynlLrhetrB1ut
	J8zGe2kLEw13E9G6STJ2QGRSdPG7/+n6O1uCiGLMnNNj+YZyXOir++MBdunvTQliHsvT7ki
	DDNM/GpLbiQ=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14637609362048520855
From: Dawei Li <dawei.li@shingroup.cn>
To: robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 1/2] of: Introduce __of_phandle_update_cache
Date: Tue, 30 Jan 2024 18:52:35 +0800
Message-Id: <20240130105236.3097126-2-dawei.li@shingroup.cn>
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

For system with CONFIG_OF_DYNAMIC=y, device nodes can be inserted/removed
dynamically from device tree. Meanwhile phandle_cache is created for fast
lookup from phandle to device node.

For node detach, phandle cache of removed node is invalidated to maintain
the mapping up to date, but the counterpart operation on node attach is
not implemented yet.

Thus, implement the cache updating operation on node attach.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/of/base.c       | 16 ++++++++++++++++
 drivers/of/of_private.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b0ad8fc06e80..8b7da27835eb 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -163,6 +163,22 @@ void __of_phandle_cache_inv_entry(phandle handle)
 		phandle_cache[handle_hash] = NULL;
 }
 
+void __of_phandle_update_cache(struct device_node *np, bool lock)
+{
+	u32 hash;
+
+	if (lock)
+		lockdep_assert_held(&devtree_lock);
+
+	if (unlikely(!np || !np->phandle))
+		return;
+
+	hash = of_phandle_cache_hash(np->phandle);
+
+	if (!phandle_cache[hash])
+		phandle_cache[hash] = np;
+}
+
 void __init of_core_init(void)
 {
 	struct device_node *np;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f38397c7b582..89559aad8ccb 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -94,6 +94,7 @@ int of_resolve_phandles(struct device_node *tree);
 #endif
 
 void __of_phandle_cache_inv_entry(phandle handle);
+void __of_phandle_update_cache(struct device_node *np, bool lock);
 
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
-- 
2.27.0


