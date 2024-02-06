Return-Path: <linux-kernel+bounces-55103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A484B7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D77287B39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A907133294;
	Tue,  6 Feb 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EC1MJvSD"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A513248B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229346; cv=none; b=ZDTnjkU4WTgYaNwXRDDafH/vYUTn6n0r9rb7vAHMQMHiOhnDTt5yViNU0gtLuAsL+3ZKbwvyYOiRhI1rd12yOWWhUYN7+Z6UEkJIrakS/kJhW1C50HWu4d8hJPVpTS6uhvrm50X/e1cFDj/YgRArS5DfK//cGjLRxBN0twB4A/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229346; c=relaxed/simple;
	bh=5d6UiYMglkTbWmRhqsEoPg9BNX2q12MK63EVcZLBafI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bx1wozHHDKQeh6PjZ+W4LESGmD9WPt72Ty1pSd+kh5CBXfShulvyKHhBO1PhrAZXW+dfDhpewQPb+eQGZPlyg4r2tDuXcPC6TIR4eh94q/kPiYWdDtglT8jwqMNKDqUqQ2AG/rD4JlP2Q9i6vF/9FBPISBWme3cdmIYZGK0dIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EC1MJvSD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d94323d547so45649365ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707229344; x=1707834144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8sipwMRC4Kd6MHj5r1Ne28hNhCgrZv7vPqfbBQ2q0M=;
        b=EC1MJvSD/KKmEnzdZBiQdaFG96XYZduDz1p+hnLFj1nMFuBQdP6Vok3gW497iCXw1l
         ENyaWtDAp7wR6UHqCDkLTVreetn8Bx/49eZAjXnZrahssrb/rHjZp7ZjfJ6e9XpfELs9
         6yg4hWehIX+KZIGiXI0pHVbVX/Bkhd+ZzMP6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229344; x=1707834144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8sipwMRC4Kd6MHj5r1Ne28hNhCgrZv7vPqfbBQ2q0M=;
        b=DNDRbUWgLYTGpIL7At+VtbT5isq8C5dwPnDlcRcZ78LnsxrgOkecJgXkajCyen5rHG
         LbRMCEfsIo0bwxMLnTgOBdt5MsCsAEGNCaZ5irvjl84v7P5Em95IWHUfjQiBPzNDBReL
         zLIWVl1S3+RoXB81Dos7EeX5HNYuHrW1OLRg7SsM/L235EBg6vcYcb20Lpizor4VY2rc
         h3HRVg3yrcmjnG4kwHeBxI0YDmboMgJ3z6OVjWnh6jZZ/COaIsBCvrIH4aFkq526UGLG
         mf4S1lFtMw2V17qP+FqhUpbVHdu9O0jhd+hca8eAhPLQcGiiKTgRdStojHovvuSMrhrp
         rjbg==
X-Gm-Message-State: AOJu0YzfVH8ywE7cCBZ5N9+A0hkwWgaBXlWR/5wZPijOPjnhreMvhXYV
	2HFnyyoUDgY0YUhOXqF25oy49iO0BmLR+qWlEdGjomDAaXxXvotmr3/9OOi3VQ==
X-Google-Smtp-Source: AGHT+IERIxKn88lOl0cyb9e1UJkSAHE659XgTaUtWm+I9M+Kfk3V8TUyat4dnkKEwfb6x4oxHPGpCg==
X-Received: by 2002:a17:902:f542:b0:1d7:133e:5c09 with SMTP id h2-20020a170902f54200b001d7133e5c09mr1642447plf.22.1707229344131;
        Tue, 06 Feb 2024 06:22:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbFC6MzphzX7s48wrl19nDEGaMUIhhhiQ13Coh/LyO2FjO7KheuxoclJRov+nF6HKUEA5bn3s0SpztfPJ3mPIP0R5TJno2nPN46T6lXi8bDx2kYTDH/53JPv5G0cn6QyzK0sykeUswyJUbdR+oCk4bZJO/SxxlsJ4CnPE5QwSRsaaBjBhGENbq/B/cT+beuDt4pge6/BOtLtz+6UwOS9YeZyIbCGETv1DKeAhem47gmmKoyeeGTL4/kIzMpBt8WXKrPJptwuM2SwqNTtG4m2Wma1aZ4RzRPG5AiLM2bsZHKAHJbjxyJxqovV1p30DDKw2ejrnhUCyLIArP19TkndjvaXqDcU2Ue6KqcpbPt3UMudvwzkgpBDxFi7z2moeo4W6ZJhFxDPYDgESWVFi2ka9Yq4y80vqpBqyE1n76OOTEpKczE0L3c9okrqEQvmC/LMI/ImXDuic9SsCZM3QEQ/y2
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001d9620e9ac9sm1922529pls.170.2024.02.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:22:21 -0800 (PST)
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
Subject: [PATCH v3 4/4] um: Convert strscpy() usage to 2-argument style
Date: Tue,  6 Feb 2024 06:22:19 -0800
Message-Id: <20240206142221.2208763-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142027.make.107-kees@kernel.org>
References: <20240206142027.make.107-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5346; i=keescook@chromium.org;
 h=from:subject; bh=5d6UiYMglkTbWmRhqsEoPg9BNX2q12MK63EVcZLBafI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwkCbb+R0+gw7GgnI3QI4KGLyNGSb52JGRxet5
 1XMuj4aUkGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJAmwAKCRCJcvTf3G3A
 JvgOEACrK+19fO5TvvKkPLA3lsjbTwmh6j03j+gO1FLjDgE6NpUFUN3owP+6g03lsKp09hc7gIl
 EMQicPbXlLKVXbz1YmLPx7zDelYGWby10hglehRvQnvhssFjPTB6EhA1H6U4o2geZsWZGvWef7e
 FLZ2aPhtS9ITWTsUPZLgrOgXJZPpcOXRRMkcbgH7zy9LrYOvuKyrOk3jpQd9B6mEFnBlJFbBYnc
 owMbotjUIKfSvk/o7IhZvdfYQsFuJOEeWGyu/ba5Cdm5VLymZ4f961qutEhEA4UuqR6qMVZdL98
 qpDSxA2bI+FtvRQvV6AFPZ2nVN7cexonUiyhvLQylRQ7EufLhnM/WXyL2PiHfIuLC6c+XOfbptw
 3v4Hh4A9B2zjmIUVrrToFCrU8d3MacbS6XaPf/1kc8h4tjMhHDTD5LYyOeUNA7CloaBx7ZoVeV1
 AYnbWMGFLvgrcTHYLgifat9iRfPNqonWjYlxbaOJrjk2B3wNvD5cMrbZQyFneVA0K1k0Ye4EGW5
 Y3paNJzKZTKVSwPhDN20cAZewJpRMLz0jAWJX2vYmRS1zaYu2lsJtZjKn+MaugVL58UyZeVGreo
 FXXiVdl11N1na+abV9bHYWm/gizgAuM2IQ1u8FSCDA1fqSELtHFvg4I2JdBPXxN5Ls4DIb9Fmxi MvFlNm9TRhcbsyQ==
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


