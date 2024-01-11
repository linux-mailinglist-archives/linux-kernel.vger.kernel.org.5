Return-Path: <linux-kernel+bounces-24074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178B382B66F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414A2B253BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C858127;
	Thu, 11 Jan 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="e4sMeJ5r"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FC55C2E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id O2JmrVmt2IwxKO2Jrr8eYG; Thu, 11 Jan 2024 22:10:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705007434;
	bh=Au8ou1/ehK/ewWV5CH7xTk9DiIt72uJgjVqWbMMiIas=;
	h=From:To:Cc:Subject:Date;
	b=e4sMeJ5rqSYP8HL7TApioXx1CP4TZbUub2qR0rp9uquhDd0fG4Jg0el6qu9WGuf+o
	 VLNMqrJquKkIAV+mCf5GDo8+9xeX3YzxsgEAczA8vXugIg08mglUE8dezXgSN883Wb
	 5WPF5dzd6iBNqx4HB+7DhPgkuYd4mm1E6vAHKLIat/UPa1X+2g16upRbBR7E1x0rWJ
	 0QARq/YQOl5DMpOGmz3PMq2uBBrqt3qzrumB1y4vrcIbk22wqVfUrnW4YIEr0ICPSh
	 R23+UXGYb/I5tmeV1HFIBV+7y0UCMHjonakGTK6o+bjnH1ns9vd/dzhq9RhRAokPOA
	 4k2NgwJaBtSPw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jan 2024 22:10:34 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-usb@vger.kernel.org
Subject: [PATCH] thunderbolt: Remove usage of the deprecated ida_simple_xx() API
Date: Thu, 11 Jan 2024 22:10:21 +0100
Message-Id: <7fce4c8c4345d283dbfadd3cea60fdc49f9ca087.1705007397.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added
when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thunderbolt/domain.c  | 6 +++---
 drivers/thunderbolt/nhi.c     | 6 +++---
 drivers/thunderbolt/nvm.c     | 4 ++--
 drivers/thunderbolt/switch.c  | 6 +++---
 drivers/thunderbolt/xdomain.c | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 9fb1a64f3300..c067f9442694 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -321,7 +321,7 @@ static void tb_domain_release(struct device *dev)
 
 	tb_ctl_free(tb->ctl);
 	destroy_workqueue(tb->wq);
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 	mutex_destroy(&tb->lock);
 	kfree(tb);
 }
@@ -389,7 +389,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 	tb->nhi = nhi;
 	mutex_init(&tb->lock);
 
-	tb->index = ida_simple_get(&tb_domain_ida, 0, 0, GFP_KERNEL);
+	tb->index = ida_alloc(&tb_domain_ida, GFP_KERNEL);
 	if (tb->index < 0)
 		goto err_free;
 
@@ -413,7 +413,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 err_destroy_wq:
 	destroy_workqueue(tb->wq);
 err_remove_ida:
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 err_free:
 	kfree(tb);
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index fb4f46e51753..e77a95aea066 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -465,7 +465,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	if (!nhi->pdev->msix_enabled)
 		return 0;
 
-	ret = ida_simple_get(&nhi->msix_ida, 0, MSIX_MAX_VECS, GFP_KERNEL);
+	ret = ida_alloc_max(&nhi->msix_ida, MSIX_MAX_VECS - 1, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -485,7 +485,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	return 0;
 
 err_ida_remove:
-	ida_simple_remove(&nhi->msix_ida, ring->vector);
+	ida_free(&nhi->msix_ida, ring->vector);
 
 	return ret;
 }
@@ -496,7 +496,7 @@ static void ring_release_msix(struct tb_ring *ring)
 		return;
 
 	free_irq(ring->irq, ring);
-	ida_simple_remove(&ring->nhi->msix_ida, ring->vector);
+	ida_free(&ring->nhi->msix_ida, ring->vector);
 	ring->vector = 0;
 	ring->irq = 0;
 }
diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 69fb3b0fa34f..8901db2de327 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -330,7 +330,7 @@ struct tb_nvm *tb_nvm_alloc(struct device *dev)
 	if (!nvm)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&nvm_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&nvm_ida, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(nvm);
 		return ERR_PTR(ret);
@@ -528,7 +528,7 @@ void tb_nvm_free(struct tb_nvm *nvm)
 		nvmem_unregister(nvm->non_active);
 		nvmem_unregister(nvm->active);
 		vfree(nvm->buf);
-		ida_simple_remove(&nvm_ida, nvm->id);
+		ida_free(&nvm_ida, nvm->id);
 	}
 	kfree(nvm);
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 900114ba4371..eb2d33091012 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -771,7 +771,7 @@ static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
 	if (max_hopid < 0 || max_hopid > port_max_hopid)
 		max_hopid = port_max_hopid;
 
-	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
+	return ida_alloc_range(ida, min_hopid, max_hopid, GFP_KERNEL);
 }
 
 /**
@@ -809,7 +809,7 @@ int tb_port_alloc_out_hopid(struct tb_port *port, int min_hopid, int max_hopid)
  */
 void tb_port_release_in_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->in_hopids, hopid);
+	ida_free(&port->in_hopids, hopid);
 }
 
 /**
@@ -819,7 +819,7 @@ void tb_port_release_in_hopid(struct tb_port *port, int hopid)
  */
 void tb_port_release_out_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->out_hopids, hopid);
+	ida_free(&port->out_hopids, hopid);
 }
 
 static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 9495742913d5..8a5544243d56 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -997,7 +997,7 @@ static void tb_service_release(struct device *dev)
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
 	tb_service_debugfs_remove(svc);
-	ida_simple_remove(&xd->service_ids, svc->id);
+	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
 }
@@ -1099,7 +1099,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 			break;
 		}
 
-		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		id = ida_alloc(&xd->service_ids, GFP_KERNEL);
 		if (id < 0) {
 			kfree(svc->key);
 			kfree(svc);
-- 
2.34.1


