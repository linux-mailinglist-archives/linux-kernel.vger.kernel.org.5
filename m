Return-Path: <linux-kernel+bounces-52614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FAE849A70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D50C2819FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A241CAAE;
	Mon,  5 Feb 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZtrYtgLE"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA231C6AF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136529; cv=none; b=GfQb//zv/xZhl1q5GPxkDSWn50emwdlXC1sU2B5+xqQt9URWwxhU60NaHVzEautiomIv8/ayC5AHct7GETro+bIPJMYHsiSzGh03F/ByMcFSU1hio+BVfk0SHfD+SkNcsRT6RrwNjBy9UULxuBxBjre0sdpwz0HP+HyJuOtVhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136529; c=relaxed/simple;
	bh=5d6UiYMglkTbWmRhqsEoPg9BNX2q12MK63EVcZLBafI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOJ3bQ1V0xnilqU5UpOdbCu1ttZi4H6jlYcvPvwxdeXmM9PBipLM7fPLLmzxPGWWHPcH0kz7sc6woXvI6dSeJFCHLZ53QxCh2n9XOeNi1rfJ9A6Vsqo+LXm/XIETa5iJej3uwc3ZtSMW0Oo7PMDne+yeF+khnJWV3Q0z+gpYEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZtrYtgLE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d918008b99so31962165ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707136527; x=1707741327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8sipwMRC4Kd6MHj5r1Ne28hNhCgrZv7vPqfbBQ2q0M=;
        b=ZtrYtgLE4lrp4hep7JNiDbGQt0SinOyw1fqb5W9sqzCg3bEWODfWAHbF/grbhueypU
         GxZ2fTweRhyPmz8nBXFX1Xx9bdsTemSnC9II1PhocTspmrUyiQMH58+cOtptElaKytKB
         OUD9jpl5LwJxxqNitFOTHSdwJD32oeDIaf4Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136527; x=1707741327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8sipwMRC4Kd6MHj5r1Ne28hNhCgrZv7vPqfbBQ2q0M=;
        b=GysnQnWReolSI+eFghALNxYSj8tVNQpY8m01QZXZwxBFRrWoW2TeAn62bd1+NLkMRw
         yDwT98E5Jbsm8ATEKXvRgQc3rGE0GuaRl67xfn1yn4+E8IWMK/MH9fvlxPDzd9AN7GdR
         2Iy0OTpCBYBummMl58v05q42LXRNMi9L4xxN8Nk0FO+KLgkN5k+9vD7qRsmYjNLoL34m
         U/b3uWpO2wEDbRzBXR/u7bfMVir81Ed73Sl1EEC+fKG9CnNvEocW+SP7rgUn0yoQwvgN
         ZCsgSyCtcuy/PoG1aXWMxUlHyoGhVqzvleNcuxOH/SZtqdwdYYjPNgiYTPAhaJl59Ivk
         VZ+g==
X-Gm-Message-State: AOJu0YzTO/+9Trrt+yKzKDhjNWCxSazLmlSlg30N/IK31vaRlccKbjoP
	rJk24XemSYlgltfpe90F+5w8jsa3B/n6qCsag4sdslBBDLzr2pUOYW4JxBD4ig==
X-Google-Smtp-Source: AGHT+IHkHiW4eCpoZrH5VS9fL3wKdw7R87tdm2Mzop8u3my/RGXZjyKz1iWzGWMARGlP4o8yTfJaLQ==
X-Received: by 2002:a17:903:11d0:b0:1d6:f1cb:7a95 with SMTP id q16-20020a17090311d000b001d6f1cb7a95mr17046893plh.57.1707136526725;
        Mon, 05 Feb 2024 04:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWByyKi34EiBtuytAcMo6KMj6URrFVZ74/I4YaRUx7jw6ft7ydbHcPrJMa34hmYyUIhs9cH2qnU/xx8FhYaq9HJ0U3MkBMjasin/nW1UcbkS2a7mj1SzmE8BTcYjHDA7AOHT22fZ6eRugXVe6Wi/7kvmoRMWLibqZswU8V70tczIDUzmG0UC+65vvl+/8O1BFB6VGOFye62MbQrrtinDcuyGokYnuGz8v+wbZScio1q/AWhlvG6Wos7OcFTU0oo5aq1W5sjgZP5CnfVqKgNyi9AF2mm5agu8+3qn8u+xENHnq7e0qzvAO+zwRTYWRqvAyId9Ee58YJtv2tSp6QysUWodSAEnx8YCAaXJj6jvEZShKsJWbRXUSMoFbCiJu2BXFJGGykEt9ZXjazuc5b8kPZmaCsdA1dnyEVd8mAxehAYat+/ZuaQMIv88Lgc1EXfOcl6F4SWfULyk2KSIRZSmKsH
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mn16-20020a1709030a5000b001d8aa88f59esm6202642plb.110.2024.02.05.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:35:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 4/4] um: Convert strscpy() usage to 2-argument style
Date: Mon,  5 Feb 2024 04:35:24 -0800
Message-Id: <20240205123525.1379299-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205122916.it.909-kees@kernel.org>
References: <20240205122916.it.909-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5346; i=keescook@chromium.org;
 h=from:subject; bh=5d6UiYMglkTbWmRhqsEoPg9BNX2q12MK63EVcZLBafI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwNYLb+R0+gw7GgnI3QI4KGLyNGSb52JGRxet5
 1XMuj4aUkGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcDWCwAKCRCJcvTf3G3A
 JrXHD/4k2l9SR9HgecqdmGaTxym3IrejezIaI8b5MzIPvoImcFWT0Mf8aXTgXEyxq8uWxUSGeHF
 WbBtFjN5vndp+eT6d7Aau0bKlAgZIyzEb5oh+f4vwVnyErCKtq8eTR2yjy+ki6dPXhZ6yV/6yL/
 GX58ENWMI4OasMu+pLJDYzsdkCia0HyOtB6IYN+UcnWWEdLT4p6q1WN8uLfGUgxAWDif1KgsnHt
 wL1eZTaHu04b3TXgAbUYcHaAT7WdkDwcotPpcAshvhqyhILsV9GaRrkXZIq4mVVw3kn7KAuO8VU
 wmm4YHXaQgZO6P0F3dbT9CVdvBFQ95hne9VsR+LTrnh+eLKUyXYTtBZcE7qo/gC8P6gV7tmFTSn
 tyo0uiKhU1h4ykOlP4qxbmRQXTceEMzGZaWf7PuO8sOeHjfssdyktyPLKxuB+qfDGp5B7DLfel8
 6kgbcZJ/PgHx45rckxp+K6ea68m6d5S5K3hCpfNcrmAbg3o4N8DCSLcC3cimv9KJtzQxDhYoRsT
 HO7X2O25NJL+WtwX62RvK8qmvioZ4Lxadnhl9DWe6o4Mi/bLK8es5poQg3jOy4wqI0x7F9HnhOX
 vfIrHiKUhhofqwMXaGiv2ZxH4yN/5Q7mUbiv/NPgHVG7c9p7EckxeVDWYw0VSyqUiFM2rTbu0TA qVzP3WSRN66gMAw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The ARCH=um build has its own idea about strscpy()'s definition. Adjust
the callers to remove the redundant sizeof() arguments ahead of treewide
changes, since it needs a manual adjustment for the newly named
sized_strscpy() export.

Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/um/drivers/net_kern.c               | 2 +-
 arch/um/drivers/vector_kern.c            | 2 +-
 arch/um/drivers/vector_user.c            | 4 ++--
 arch/um/include/shared/user.h            | 2 +-
 arch/um/os-Linux/drivers/ethertap_user.c | 2 +-
 arch/um/os-Linux/drivers/tuntap_user.c   | 2 +-
 arch/um/os-Linux/umid.c                  | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index cabcc501b448..77c4afb8ab90 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -265,7 +265,7 @@ static void uml_net_poll_controller(struct net_device *dev)
 static void uml_net_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
+	strscpy(info->driver, DRIVER_NAME);
 }
 
 static const struct ethtool_ops uml_net_ethtool_ops = {
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29576..dc2feae789cb 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1373,7 +1373,7 @@ static void vector_net_poll_controller(struct net_device *dev)
 static void vector_net_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
+	strscpy(info->driver, DRIVER_NAME);
 }
 
 static int vector_net_load_bpf_flash(struct net_device *dev,
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c719e1ec4645..b16a5e5619d3 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -141,7 +141,7 @@ static int create_tap_fd(char *iface)
 	}
 	memset(&ifr, 0, sizeof(ifr));
 	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
-	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, iface);
 
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err != 0) {
@@ -171,7 +171,7 @@ static int create_raw_fd(char *iface, int flags, int proto)
 		goto raw_fd_cleanup;
 	}
 	memset(&ifr, 0, sizeof(ifr));
-	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, iface);
 	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
 		err = -errno;
 		goto raw_fd_cleanup;
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 9568cc04cbb7..326e52450e41 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -52,7 +52,7 @@ static inline int printk(const char *fmt, ...)
 extern int in_aton(char *str);
 extern size_t strlcat(char *, const char *, size_t);
 extern size_t sized_strscpy(char *, const char *, size_t);
-#define strscpy(dst, src, size)	sized_strscpy(dst, src, size)
+#define strscpy(dst, src)	sized_strscpy(dst, src, sizeof(dst))
 
 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")
diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index 3363851a4ae8..bdf215c0eca7 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -105,7 +105,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	sprintf(data_fd_buf, "%d", data_remote);
 	sprintf(version_buf, "%d", UML_NET_VERSION);
 	if (gate != NULL) {
-		strscpy(gate_buf, gate, sizeof(gate_buf));
+		strscpy(gate_buf, gate);
 		args = setup_args;
 	}
 	else args = nosetup_args;
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
index 2284e9c1cbbb..91f0e27ca3a6 100644
--- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -146,7 +146,7 @@ static int tuntap_open(void *data)
 		}
 		memset(&ifr, 0, sizeof(ifr));
 		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
-		strscpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
+		strscpy(ifr.ifr_name, pri->dev_name);
 		if (ioctl(pri->fd, TUNSETIFF, &ifr) < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "TUNSETIFF failed, errno = %d\n",
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 288c422bfa96..e09d65b05d1c 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -40,7 +40,7 @@ static int __init make_uml_dir(void)
 				__func__);
 			goto err;
 		}
-		strscpy(dir, home, sizeof(dir));
+		strscpy(dir, home);
 		uml_dir++;
 	}
 	strlcat(dir, uml_dir, sizeof(dir));
@@ -243,7 +243,7 @@ int __init set_umid(char *name)
 	if (strlen(name) > UMID_LEN - 1)
 		return -E2BIG;
 
-	strscpy(umid, name, sizeof(umid));
+	strscpy(umid, name);
 
 	return 0;
 }
@@ -262,7 +262,7 @@ static int __init make_umid(void)
 	make_uml_dir();
 
 	if (*umid == '\0') {
-		strscpy(tmp, uml_dir, sizeof(tmp));
+		strscpy(tmp, uml_dir);
 		strlcat(tmp, "XXXXXX", sizeof(tmp));
 		fd = mkstemp(tmp);
 		if (fd < 0) {
-- 
2.34.1


