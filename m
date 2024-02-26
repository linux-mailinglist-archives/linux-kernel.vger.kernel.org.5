Return-Path: <linux-kernel+bounces-82321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6686825F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B02B20EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528D8130E5C;
	Mon, 26 Feb 2024 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="O+kp4mZt"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030312C7F6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981482; cv=none; b=Nz4cRpeJLS8xDRXY4s+TSHP9K7Wlu7mKz7KGQF+oc0RDY8U28vTbbqSUgPCM9AYeOOp4rRZpQvILhmKYFFq7XQ53b7+A1V0oBKqGe4HjUk6sZWon4dQeKPUKaTazMCWNpJgfis21LgjuDd2+0QqKldy3zWG3XxAUk5pdcYCh8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981482; c=relaxed/simple;
	bh=5tVQ0AMIfAJPSPk2zY4do+pRL26IYgV2hvr8tGafaN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UF3n9V6awylHOdOm4/ZFZsiSzc1kbSxEdHCHvARrGqNl2bsuzgWo/Vr4cObk9Q7OWVkU7vKniLpDshcl62VhwDGw102BLwX3L4v1uKqMY0bt10KKbY3PFqiWD1/mCMMSEfMoZZaOM/YbfsdFb54wFMjPYUGFdO/oQ0A7mXCnC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=O+kp4mZt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e47a104c2eso2022671b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708981480; x=1709586280;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di/AZFz9sLot2V88t6wDfyehv4U4V7LTUaaM/w4fGrY=;
        b=gdZTkqvZhsrpxzXyKPEGWkug4zEwNbL1CelU3AWv/Bx1Sw74/1cgolf+si4GYoqbqJ
         udyVvRueoxdRx8TDDEewVFRonMBCLnZ2sbVDcOYBeNNwMNDT4zQKAT/Gt8T8LhbSPt8J
         onQnUUtwLgWXZtzT2CqiwnViRBFDvFUiNFPl/4+auydDfBYRVeP2gk+/bptx8ZfuEPWR
         z/+/yYA3U0o1XBCurfYqCtVJClo/Cfn9PkHtMkmPs4wlvfud0iWJTBOEN4i8c+utvSP4
         g7qOalmXVSHzEQUVIh/rgWxJhF69qvV8Uw+Z2agpYObOU62oXvoZe6BXffM3c2u89VhB
         pMUw==
X-Forwarded-Encrypted: i=1; AJvYcCUFYDKcKWicBuPpE0K9lq9yeg9Xm2stduYhmSXdX5eQIh5+F3q9ykrfwJsz4IrHu0a9vlML1HXBfe0HLd1zXpvVXKhM4yVkF31ZNtVz
X-Gm-Message-State: AOJu0Yxm9kqM1CYKIY4WYI9yuHNS3dyVWqYDkrczXqfNGH2ETxtt/nTa
	ogdf53l/FOAqn+1XR5G0scW+JKzm2k0cw6CPzUxsf2jHD/Bn/9MX
X-Google-Smtp-Source: AGHT+IHLff8hF5X99cuoYiqtIthswWIQQHVmGF8jh4pG2pljdRsU7vN99EJhhpGtHRMJEb08Ifl0Kg==
X-Received: by 2002:a05:6a20:6f87:b0:19e:cbe9:64b with SMTP id gv7-20020a056a206f8700b0019ecbe9064bmr353724pzb.50.1708981480296;
        Mon, 26 Feb 2024 13:04:40 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b006e0dd50b0d0sm4478320pfc.8.2024.02.26.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:04:39 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708981478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=di/AZFz9sLot2V88t6wDfyehv4U4V7LTUaaM/w4fGrY=;
	b=O+kp4mZtE1neSJbHU9ouoMvy1Tws5X8oq8pCWjz0pRVnpcNwgKmss6/9lIJRad88qcB3uR
	xinrZD4qXViDTZD6eyTAohvRzHJOetgk8e3YnCtASYPqOlJLlOA9xe4WybOAPUIGcllGfa
	VPIXdR5Ilna3Ir9fFX8vFC8anxm33M0sLjRWIFTyAaSR//bTYBwq20aGAF5M15WTVdVASo
	h6cEJ93KFsm3DF5fSA3gnMKYmp0xdmckUrnYMQeYBNO7WluvUvWjqbiPybRuByS0wOr5xb
	Q9HJl3ENxlO1wkDETyjr2kOqd+HcJ7cNepeeDVcxKrjs6OVVy9ZTvzSMtLohjQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 26 Feb 2024 18:05:19 -0300
Subject: [PATCH] greybus: move is_gb_* functions out of greybus.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-device_cleanup-greybus2-v1-1-5f7d1161e684@marliere.net>
X-B4-Tracking: v=1; b=H4sIAA793GUC/x2MWwqAMAzAriL9dqD1BV5FRLZZtSBTNiaK7O4WP
 wNJXgjkmQL02QueLg58OIEyz8Bu2q2keBYGLLAuEFs1i2RpsjtpF0+1enpMDKhM11ZLI0qpDUh
 9elr4/s/DmNIH7HTC32kAAAA=
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Alex Elder <elder@ieee.org>, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5tVQ0AMIfAJPSPk2zY4do+pRL26IYgV2hvr8tGafaN8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl3P0d9kMM+PbT3cDnBmZLrC8fNpA0mO+2XqX+h
 YrEzMq/RzeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdz9HQAKCRDJC4p8Y4ZY
 pkaMD/4ljpY9VocuH1egUJQ9hR0j7hv3W2ShMTpEraG0BmXGH0DG2tAGOofhaB14D/T6/FmHKqr
 7xEsRh5oB1PcoDhIJpEqKPhMR9Axxm87E1ruZuEq1p4UeWmj3hy63zzzFCA1TQZcBQXJm6HvIcy
 2zjlgCCugNcCHx44zEVHE0vEM7Bcax1jz2+LfHOigtY9BMzsG8LQ2oW6kHzIMXxp4V40/T4v+Ux
 fsuiBAO7Kt9yFHJzQAmQbmMmyApMBiUikImrGk4RD9+QFHG14EG+PCBWfV7m00dM/UnajsDo0qy
 y/oipRbebMww8IzcBuC4TEfGYtrTqiNd5B3eDUlbr2Su6Tve50PHrEGpNgTAG6zwexJ1VoVWA7j
 THJ6aX7G1LS7JqowYvKomp6HQUYmq2l3Dbn/HEsmocVB2q73unx8v3KzkKQMaN44G/94J2D5rQh
 GFIISnNX8YdwhWdItrA8Xriz9ljNJ3MYCOhJjfFRo89XXgzlsem30QP92OuMHwVuNoJuN26BD0y
 R+71NkqgGMMDtlgP7fzg6F6MFTcn9nmoV6ICrLhU0Ar1Gz4HBlWELCXFAyRbfexp77RVRciyCFm
 IDQnvbDjIKTtt21fJ1tFNyr+JiVUFmh7oqjmzGZhJJXzUvvnaE48d0yYzsKDYK5QbrbeqDo+9t+
 h5ZKvmHDtS3cNJw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

The functions below are only used within the context of
drivers/greybus/core.c, so move them all into core and drop their 'inline'
specifiers:

is_gb_host_device(), is_gb_module(), is_gb_interface(), is_gb_control(),
is_gb_bundle() and is_gb_svc().

Suggested-by: Alex Elder <elder@ieee.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/greybus/core.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/greybus.h | 30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index 5714be740470..f660b213233d 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -27,6 +27,36 @@ int greybus_disabled(void)
 }
 EXPORT_SYMBOL_GPL(greybus_disabled);
 
+static int is_gb_host_device(const struct device *dev)
+{
+	return dev->type == &greybus_hd_type;
+}
+
+static int is_gb_module(const struct device *dev)
+{
+	return dev->type == &greybus_module_type;
+}
+
+static int is_gb_interface(const struct device *dev)
+{
+	return dev->type == &greybus_interface_type;
+}
+
+static int is_gb_control(const struct device *dev)
+{
+	return dev->type == &greybus_control_type;
+}
+
+static int is_gb_bundle(const struct device *dev)
+{
+	return dev->type == &greybus_bundle_type;
+}
+
+static int is_gb_svc(const struct device *dev)
+{
+	return dev->type == &greybus_svc_type;
+}
+
 static bool greybus_match_one_id(struct gb_bundle *bundle,
 				 const struct greybus_bundle_id *id)
 {
diff --git a/include/linux/greybus.h b/include/linux/greybus.h
index 18c0fb958b74..38c45ec7d099 100644
--- a/include/linux/greybus.h
+++ b/include/linux/greybus.h
@@ -113,36 +113,6 @@ extern struct device_type greybus_control_type;
 extern struct device_type greybus_bundle_type;
 extern struct device_type greybus_svc_type;
 
-static inline int is_gb_host_device(const struct device *dev)
-{
-	return dev->type == &greybus_hd_type;
-}
-
-static inline int is_gb_module(const struct device *dev)
-{
-	return dev->type == &greybus_module_type;
-}
-
-static inline int is_gb_interface(const struct device *dev)
-{
-	return dev->type == &greybus_interface_type;
-}
-
-static inline int is_gb_control(const struct device *dev)
-{
-	return dev->type == &greybus_control_type;
-}
-
-static inline int is_gb_bundle(const struct device *dev)
-{
-	return dev->type == &greybus_bundle_type;
-}
-
-static inline int is_gb_svc(const struct device *dev)
-{
-	return dev->type == &greybus_svc_type;
-}
-
 static inline bool cport_id_valid(struct gb_host_device *hd, u16 cport_id)
 {
 	return cport_id != CPORT_ID_BAD && cport_id < hd->num_cports;

---
base-commit: 70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf
change-id: 20240226-device_cleanup-greybus2-b763f50221ab

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


