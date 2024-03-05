Return-Path: <linux-kernel+bounces-92429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1868872008
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CA284801
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961ED85C44;
	Tue,  5 Mar 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VyW6bH3o"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36B55E77
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645094; cv=none; b=AddLuOS7nQ7+iOALg3xGpEwuEA3bgLZCHRBECQlZnl0cX8kDxG36IAT/Vmw4E9o88cGz1uYFCgwm/vVTOrhbNhzjvWZB63vPR9QNjCpkRbQQMrqS2Bn7jBZU75dnx3cO4oqyi+g9ycc6VpLenbyujUYh4crrciJkZAYw5/49UgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645094; c=relaxed/simple;
	bh=1q5Yl/qte9Q6wO0ustPZcZZlP5R/+aF87r8s/YtOT6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HEBtL5hRVxqOaJ7jJJ5m7K4Dfs2N9m4QI3K8WSx7iNfQIEQdLDIqATNJticUX1X1lNU3oIqYjiUOGXKDWXhkQalsbTLo6RYfC+9Q3sE6N26vBFCGiAGZpkwyI4a3xNTxs7uKjB3+JboWOlwf/py2Wwo3fvU+4TjDcxdjLdjmcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VyW6bH3o; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709645090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAnWFjhme+Jy4FpyDR7luzM4shNJlsSc/yEtH+AkW4g=;
	b=VyW6bH3oKu7YzBCKju1CvcwXKtZhuqykpIaos9vDEa5cf/lSc31Y7pbrZBxJLqFTx81uzA
	gY66iHhBIEJToOyv+diDoJ04lhG9Dv6+xCqUNBOx2jKNvWGfIeJ+qo8F3PVvkmYkuM7RaT
	vIUCYOLV6/rJKG0239id+M1b3yme3Lc=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: gregkh@linuxfoundation.org
Cc: rui.silva@linaro.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] usb: isp1760: remove SLAB_MEM_SPREAD flag usage
Date: Tue,  5 Mar 2024 13:24:42 +0000
Message-Id: <20240305132442.2122214-1-chengming.zhou@linux.dev>
In-Reply-To: <2024030555-turbojet-headscarf-e26e@gregkh>
References: <2024030555-turbojet-headscarf-e26e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 76862ba40f35..0e5e4cb74c87 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -2521,21 +2521,19 @@ static const struct hc_driver isp1760_hc_driver = {
 int __init isp1760_init_kmem_once(void)
 {
 	urb_listitem_cachep = kmem_cache_create("isp1760_urb_listitem",
-			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY |
-			SLAB_MEM_SPREAD, NULL);
+			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY, NULL);
 
 	if (!urb_listitem_cachep)
 		return -ENOMEM;
 
 	qtd_cachep = kmem_cache_create("isp1760_qtd",
-			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY |
-			SLAB_MEM_SPREAD, NULL);
+			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY, NULL);
 
 	if (!qtd_cachep)
 		goto destroy_urb_listitem;
 
 	qh_cachep = kmem_cache_create("isp1760_qh", sizeof(struct isp1760_qh),
-			0, SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
+			0, SLAB_TEMPORARY, NULL);
 
 	if (!qh_cachep)
 		goto destroy_qtd;
-- 
2.40.1


