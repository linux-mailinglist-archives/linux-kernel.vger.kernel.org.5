Return-Path: <linux-kernel+bounces-62393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D23851F98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2ACAB2279E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A6D4D5AC;
	Mon, 12 Feb 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWwCTANO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A524CE0F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773517; cv=none; b=NQXzR3OYrUSeGtLmVg0zJvhAvfSpnfCRt2g5VULik7dV0ohAAkBnnfp3S90K9THQy+qKhg/EsEXI/KQWcAkzLI7dw5w5M5KFaGEPxgrol6een3cBpR7miNmFPSdfpd6ekEzs1LoUBiaGyPYdMBmem2O6o7uchDEPvENM2aKif2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773517; c=relaxed/simple;
	bh=sWUmF3vh9o4HGU5Ho8G3VWDldprPEGq5gO9RSRL2L2Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Ah8zi9AJvpKgf9rgFIBQw+QsTzrUic9YVfYE5cMaUDzewrMq5BaAjT1DoJ77xTy/jlxRJsf+u+P24jCgHgnKcnrslvNZN+74phB/0b2a24rkuridT20/3e5EioFTYMViw/1SPAvcS4cIogNgdITbev86Zu5N7cUM3v6m1dw+/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWwCTANO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso335279276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773513; x=1708378313; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K3jZfz6ZJpM1n2dt5cwkWjr08+sSZMq2mLrsQ52mPs=;
        b=SWwCTANOSojhEP/TPDLG2MAkbnsPBHvzOb4nHKVYPKWax76GqlWab2GpaaCa6UEPAA
         5gnnbwcWHNXCo7tHkn4SPZxMhPcLGrZPwDeDpl+OhncIHOL+uA8d5IGFvBpvVXeXdfwV
         ttirQYu4301FK7s4Ft3838L6fsr6OvpW6qhR5uC8FfItmGy5vbdPmXBDTKsGT1HXqQLn
         1vL+J9B4FSuypUKGV0WHDoGOX9BxrKjAlFqaMtlHlA8BKiTSSiZtkFgM0KBLq0efn0oU
         LG7YI8aVleZ2lRMhC0zPI7EKctU0GQmSPHllimq8RhwaO/vIVDm9B+UmDDMjNbBxqJ3Z
         +yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773513; x=1708378313;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K3jZfz6ZJpM1n2dt5cwkWjr08+sSZMq2mLrsQ52mPs=;
        b=QlNyM3jTIhpP4/6YnnMhoDvHGJhJBHMGvR5vfUU3RLvTI28m4WWrMZGpS2Y2idBcIM
         pQnNC1bWmlQYuFNPYCZnkuPJbCAqK/9dccO2mgSxJjq6Iu50AUdzdU3SVTcuDLRNCMhK
         IKUV8FQ4bN/g7VPnuHrhDa7HV6M7DPtOlVgJpNndB+j/Fc7Mnsu5WjuWAsS4JAriIJbo
         4XGLR16bRkjY0F3DccZWc3MfnO6Qb4YAQXR5qktOD7i8tIDE+nIGU/pOo52EW75LX1y7
         l5RAN/aqXoLIDYiwYv8Ak0rJ44wJFmuHtLBkcTR8ozmaAQf7a3UVW2MkuqjOGCcMjv53
         G2ew==
X-Forwarded-Encrypted: i=1; AJvYcCUIzmq/1K40kjsf1QFf9Q+Dh4WXZgKGLYENjBpqBOyBVyQHfuhHmrkLAc9KiUwXqrysg058NeTHHSH+3dpS3P79W+cD28gajvMHI0n0
X-Gm-Message-State: AOJu0YwaGNj5XI9ELEUtrcijWJGQvzvaVNGtKzutDR1tsSXZkWlMWWN4
	jUtw43r3/kY+eJyHOfdQsF5pEg4Y5CpFiPWArYeAWmNYzf18+j28CkHRCFzMCLMPDar4Px3xaSv
	E/Qpfc57riCIRtg==
X-Google-Smtp-Source: AGHT+IG2sLxSJk82/hktC2zn/qdFBTpCmKaZcw9oEv2UKYAOJVNxgfSbgnqyRF0XmSFtDUVWifT630+miCbuk20=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:496d:5de1:a404:8bee])
 (user=saravanak job=sendgmr) by 2002:a05:6902:728:b0:dc2:466a:23c4 with SMTP
 id l8-20020a056902072800b00dc2466a23c4mr2039431ybt.4.1707773513682; Mon, 12
 Feb 2024 13:31:53 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:42 -0800
In-Reply-To: <20240212213147.489377-1-saravanak@google.com>
Message-Id: <20240212213147.489377-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v2 1/4] driver core: Adds flags param to fwnode_link_add()
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the callers to set fwnode link flags when adding fwnode links.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c              | 5 +++--
 drivers/firmware/efi/sysfb_efi.c | 2 +-
 drivers/of/property.c            | 2 +-
 include/linux/fwnode.h           | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..33055001e08e 100644
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
index 39a3ee1dfb58..751c11a28f33 100644
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
2.43.0.687.g38aa6559b0-goog


