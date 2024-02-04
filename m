Return-Path: <linux-kernel+bounces-51935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F0849199
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0291F21D64
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66C11731;
	Sun,  4 Feb 2024 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiMx5mIp"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D6F9CD;
	Sun,  4 Feb 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089273; cv=none; b=lXmiJ+Oa53mKgZUNkZMkc7ZnYInUnHqO7JyLOR1GjfcleMrIErYXREWa+Wf18CojP2NpAtZSPWEXlECOkZISWlGBuT8WWvK8VSsNrNTroqBfpi1blZ6jIIaWhd+RlMLwrSZrQ/44sq1hNvWGVy6SbE58yYx2nRzzprsC6KPRWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089273; c=relaxed/simple;
	bh=0Dhbz0e0k9pnk9gKX2ysvxsoM4DXRcpizkZgMHADKHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwZFy8v7zeabMgn+SpKs+eYb4HPNXCLtAHI+fif1evTu6f7ctEFqo+lQaYReY74f2G6tWfUf6LEvkc5leuahdOiKkO5V98LbM2xRFo9qBdN7DL4bBhIbldaEQi7tAZcaMs8m4UYNrJQ/iJe5nx87qjEC48dleS/5p+X4BYTDZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiMx5mIp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e02fa257eeso599281b3a.0;
        Sun, 04 Feb 2024 15:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089271; x=1707694071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeOF2vTWeLJbFAHfz2hDqKagDfAGXtCBgTXHflqm9kQ=;
        b=EiMx5mIp/t8A/Xxkn1d1gQnnHCnjZj/g2JV4VUlU4wCfnOQbVjRdN0EO8Q+auF3kGB
         ScPqTD1wNttkRHhEChPjS8bbvx2V9aZPlAvgp88fKHfQFnH4MYuud2DBQdeCeclduba1
         EBzyq7NYu19c+2D5JM+hoxhrwozr8uRWqe8XfFERUnzKvikPbKdOrN35d42GulwPozRt
         wt95NwCtsw4SIz6yMDvhoT4nlaGv6eQqX7/58s+v/58gWCdqocmDkch0FsOFjVC22AgC
         wW+YJdL3otIM48/YfOrVL/5MLbuf0KK0cpGcvrNkcrigwxvRvj2DYc+XoTrKAMQ880f0
         BDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089271; x=1707694071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeOF2vTWeLJbFAHfz2hDqKagDfAGXtCBgTXHflqm9kQ=;
        b=xETi0X/SmvJgXup8AgOvhLP9Wl+ehx9rQvm0dNBIZYfi0XrcKaKy2PM3CzSh1aCVNN
         mHDYTCUqBwyuBPuop62xyDQDBI2DkO1COQUI0OaAVDpPKTQKyzegfQuOH1UuiMCpihzZ
         M2eR121DznbHurex0b0jrxTeeGmf5T/pxHEcvWFRNJwkiACkYiQ91mtZbnooLCUj6ik2
         kV80+aofm3ChAr1w5x5WTa3qEZh7UrK3OywXq8vSYKvf7K1mWSNJ5xi/BnMiA1j1aBv6
         LYs4Hoo+vO3IxaqsZ8ngcKZqqO0emDEHkxnzfapS6yhfXcjR/FFGkJGfZa5Y3sdlezin
         eRbw==
X-Gm-Message-State: AOJu0YzP1y68iOoiycTbYG/LcnEcP/w/ap568+UFx1zreW8OllF7wi4x
	eep52oTPB2KLmHPF25OfiK5OPjZHOVkkPUebLrmTXLScvjwTrS1U
X-Google-Smtp-Source: AGHT+IHP63WvAnKZ+5pvInnyBwxFACqxW28GNyfm31W2cn8H3mRGEd5lRMAhW4KliXY1LafVHrWbNQ==
X-Received: by 2002:a05:6a21:3984:b0:19e:4c37:8737 with SMTP id ad4-20020a056a21398400b0019e4c378737mr5385798pzc.5.1707089271143;
        Sun, 04 Feb 2024 15:27:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV+ke2saEvZq6xSyjRSJNCqT4ZQKK8F6VxNI69xP04mXexMsHPrFtGC0cEGQDoSoOiPmQohNx7rH3X9ogGkGDRt/sEKAvKEsOkk0oN6fNlvD3zrYBm+TGI/rlS4JWUZH9Z1DawDK/whjT+MRz6qdIfU9a2eQAB4ItohMgdJKy9z4SsFmQc5b5F3FAVQBf6kT+ny0ogWsd/uXDdeLQGe
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id x7-20020a626307000000b006e04022e8f0sm1172789pfb.208.2024.02.04.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:50 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/8] net: netconsole: move netconsole_target config_item to config_group
Date: Sun,  4 Feb 2024 15:27:33 -0800
Message-ID: <20240204232744.91315-3-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support a nested userdata config_group in later patches,
use a config_group for netconsole_target instead of a
config_item. It's a no-op functionality-wise, since
config_group maintains all features of a config_item via the cg_item
member.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 58 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 93fc3b509706..12bfb7eaae7f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -79,7 +79,7 @@ static struct console netconsole_ext;
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
- * @item:	Links us into the configfs subsystem hierarchy.
+ * @group:	Links us into the configfs subsystem hierarchy.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -102,7 +102,7 @@ static struct console netconsole_ext;
 struct netconsole_target {
 	struct list_head	list;
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
-	struct config_item	item;
+	struct config_group	group;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -134,14 +134,14 @@ static void __exit dynamic_netconsole_exit(void)
  */
 static void netconsole_target_get(struct netconsole_target *nt)
 {
-	if (config_item_name(&nt->item))
-		config_item_get(&nt->item);
+	if (config_item_name(&nt->group.cg_item))
+		config_group_get(&nt->group);
 }
 
 static void netconsole_target_put(struct netconsole_target *nt)
 {
-	if (config_item_name(&nt->item))
-		config_item_put(&nt->item);
+	if (config_item_name(&nt->group.cg_item))
+		config_group_put(&nt->group);
 }
 
 #else	/* !CONFIG_NETCONSOLE_DYNAMIC */
@@ -221,9 +221,13 @@ static struct netconsole_target *alloc_and_init(void)
 
 static struct netconsole_target *to_target(struct config_item *item)
 {
-	return item ?
-		container_of(item, struct netconsole_target, item) :
-		NULL;
+	struct config_group *cfg_group;
+
+	cfg_group = to_config_group(item);
+	if (!cfg_group)
+		return NULL;
+	return container_of(to_config_group(item),
+			    struct netconsole_target, group);
 }
 
 /*
@@ -370,7 +374,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -398,7 +402,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -425,7 +429,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		mutex_unlock(&dynamic_netconsole_mutex);
 		return -EINVAL;
 	}
@@ -450,7 +454,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -473,7 +477,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -495,7 +499,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -532,7 +536,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -570,7 +574,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
-		       config_item_name(&nt->item));
+		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
 	}
 
@@ -638,7 +642,7 @@ static struct netconsole_target *find_cmdline_target(const char *name)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!strcmp(nt->item.ci_name, name)) {
+		if (!strcmp(nt->group.cg_item.ci_name, name)) {
 			ret = nt;
 			break;
 		}
@@ -652,8 +656,8 @@ static struct netconsole_target *find_cmdline_target(const char *name)
  * Group operations and type for netconsole_subsys.
  */
 
-static struct config_item *make_netconsole_target(struct config_group *group,
-						  const char *name)
+static struct config_group *make_netconsole_target(struct config_group *group,
+						   const char *name)
 {
 	struct netconsole_target *nt;
 	unsigned long flags;
@@ -666,7 +670,7 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
 		nt = find_cmdline_target(name);
 		if (nt)
-			return &nt->item;
+			return &nt->group;
 	}
 
 	nt = alloc_and_init();
@@ -674,14 +678,14 @@ static struct config_item *make_netconsole_target(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 
 	/* Initialize the config_item member */
-	config_item_init_type_name(&nt->item, name, &netconsole_target_type);
+	config_group_init_type_name(&nt->group, name, &netconsole_target_type);
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_add(&nt->list, &target_list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 
-	return &nt->item;
+	return &nt->group;
 }
 
 static void drop_netconsole_target(struct config_group *group,
@@ -701,11 +705,11 @@ static void drop_netconsole_target(struct config_group *group,
 	if (nt->enabled)
 		netpoll_cleanup(&nt->np);
 
-	config_item_put(&nt->item);
+	config_item_put(&nt->group.cg_item);
 }
 
 static struct configfs_group_operations netconsole_subsys_group_ops = {
-	.make_item	= make_netconsole_target,
+	.make_group	= make_netconsole_target,
 	.drop_item	= drop_netconsole_target,
 };
 
@@ -731,8 +735,8 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
-	config_item_init_type_name(&nt->item, target_name,
-				   &netconsole_target_type);
+	config_group_init_type_name(&nt->group, target_name,
+				    &netconsole_target_type);
 }
 
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
-- 
2.43.0


