Return-Path: <linux-kernel+bounces-91686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E7587151B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AC7B2335C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC348CD4;
	Tue,  5 Mar 2024 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DrxWbXC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE44AEF9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615108; cv=none; b=P4m//64m6n1JXpKgS/0FgKwsnNgx/7QPZy37DD3MJVxX6Xw+8EtAcZwrzXZ3FwV+tE9XpiQIZVUEUSQxv7QOKuKZSYF3CboQx/HElO2gna23jz81FyI1wVFoUwXp6OI1r5jDoKOfOzOf+vTW45Le1KwIv5x7abBIa+Hp1YHYZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615108; c=relaxed/simple;
	bh=XZDv8ekUBDuPcx7JKwUSFcvODGOCjCS19jys6D4SP1U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=PkfdOnmG1uIjcwMsYrzsAm1bVb+y1ElA2wtGGwc+21U3ZJ3sV16+REakQSzn4xAofepxfPMRVf2FAToHnIcb2H6uHQDgg6P5uU64LDofBWEmCT37PHly7z6IgZJEWYTcwb4QNRviWACN/ssJM8MPZqyrNGhIOVI7ZR9YyBGVusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DrxWbXC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so68778057b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709615106; x=1710219906; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QkOR2sMhH+Si14pz9snYlJ/FpZBxS/MFY8PC4k8Ihg=;
        b=2DrxWbXCO75d+Bu/Yrx5LVx7+e61YOJ7kNnjDbKZ9f9fPcLL7yha9ztcwEWo50fTC0
         vTNtddtLDeKGVHAj6VxhFxzlYgbn0/Vb/e6sQqoYhajatHIKzxIN76g/R3Nc0AWGlkbM
         KrG0yhldCCQWLuJS2hHWOxZarDEKJ0T5IwniOqhZq5i2OeStVLdVZiyY3tMzKtAnchtD
         SOsoO9PwC9JBn7JquAEH6ie7r5ihPEmRP4aH1ednrGU9A/9SWdO+JryGwGCrgAOfCU/R
         qWoDgRHWmefbd/aVWMVnH4HFzr7EVhNSiuEe1ogZBSIAOyWrOeNd8agig8xkyTYC6epk
         i/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615106; x=1710219906;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QkOR2sMhH+Si14pz9snYlJ/FpZBxS/MFY8PC4k8Ihg=;
        b=ZLNLbx/ennHVknxMB0smp99t9m3nIjKxIHRvGs5CivR+NjUhC/VzMu94IWT94k/zqW
         NLbHDI8+jBfjqp0zo1+wfuPCRsO6ngsU6WjDOcypX2cTh4QzbjnMzcPCod24O4DNqdvG
         DVRROBLOU4bUEY8mpNom58pCOsclfXg95xve7EabUw5rULSbVkF08/z5zuCf9aV1pT+7
         +zx0NzY1VrzMTf3JkZKJMZJ1xe79Gw/fZCRQcfBIU1ImIpqdgEwGHEVwBfAmiidbf0G1
         UJ9HdzHrOtbxDGDO1mINoIsuL03Bv+ggKWemt1HQT/cHtGe1vZEZBOC32IRTmqTPXbSP
         u8ng==
X-Forwarded-Encrypted: i=1; AJvYcCX6KlKziLOf9QDNgXJZEpmhjqivzqZ9lO0LB647GAmSmef3SQVb7QQKPCnMx7bvI67RAMkF/89lB/L3KsJzlUplNBeSaA8ysNm8OZPj
X-Gm-Message-State: AOJu0YwiTua+mcSzZvJNpTp79IuQ/vfw8dW/ntMbnBWTgMg4v0sqTgiq
	AVYITVBDDBifCfkQrkdNQqSAcHR+SpS+/xZ4mcBzrWRK71g8WyzLQ9muvjw+0MRF0yEwW+eHeTT
	SaBjuhKSOz3KfCA==
X-Google-Smtp-Source: AGHT+IFBN8VA4FaW/ghps1zLmeYuq0EAXL9hg4A2mHhIFtvwUqQNXCx0C87Vi+9hsAj/TMtp6ZI+h47oPYMl1AU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d64:6ee3:55a9:46e6])
 (user=saravanak job=sendgmr) by 2002:a05:6902:10c1:b0:dc2:2e5c:a21d with SMTP
 id w1-20020a05690210c100b00dc22e5ca21dmr443242ybu.6.1709615105906; Mon, 04
 Mar 2024 21:05:05 -0800 (PST)
Date: Mon,  4 Mar 2024 21:04:54 -0800
In-Reply-To: <20240305050458.1400667-1-saravanak@google.com>
Message-Id: <20240305050458.1400667-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305050458.1400667-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v5 1/3] driver core: Adds flags param to fwnode_link_add()
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Allow the callers to set fwnode link flags when adding fwnode links.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/base/core.c              | 5 +++--
 drivers/firmware/efi/sysfb_efi.c | 2 +-
 drivers/of/property.c            | 2 +-
 include/linux/fwnode.h           | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 9828da9b933c..adeff041d472 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -92,12 +92,13 @@ static int __fwnode_link_add(struct fwnode_handle *con,
 	return 0;
 }
 
-int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
+		    u8 flags)
 {
 	int ret;
 
 	mutex_lock(&fwnode_link_lock);
-	ret = __fwnode_link_add(con, sup, 0);
+	ret = __fwnode_link_add(con, sup, flags);
 	mutex_unlock(&fwnode_link_lock);
 	return ret;
 }
diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 456d0e5eaf78..cc807ed35aed 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -336,7 +336,7 @@ static int efifb_add_links(struct fwnode_handle *fwnode)
 	if (!sup_np)
 		return 0;
 
-	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
+	fwnode_link_add(fwnode, of_fwnode_handle(sup_np), 0);
 	of_node_put(sup_np);
 
 	return 0;
diff --git a/drivers/of/property.c b/drivers/of/property.c
index b71267c6667c..bce849f21ae2 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1085,7 +1085,7 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
-	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
+	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), 0);
 }
 
 /**
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb..c964749953e3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -210,7 +210,8 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 }
 
 extern bool fw_devlink_is_strict(void);
-int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
+int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
+		    u8 flags);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 
-- 
2.44.0.278.ge034bb2e1d-goog


