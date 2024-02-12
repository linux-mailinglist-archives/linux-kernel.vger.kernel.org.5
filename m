Return-Path: <linux-kernel+bounces-62303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C14851E50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190BD1C222B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338B482CF;
	Mon, 12 Feb 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bP3iAHEn"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3947F6A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768271; cv=none; b=EuvO5Ob5XZDl0BCdj61gSkwXdy+C31lZSz07MBc8tRVutFrUddFpvnior+K7fvGWNCt8PElHw6iD66UeJRIXsfY1s2uLG/gG6/XXjEp+rzsugdzygK7+hcoCiepdJM/ju9uCbrkFqk56CpL57oTwa5rTMpGDIri0OewlBx6MDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768271; c=relaxed/simple;
	bh=/dPB3W4ot4IPM57QJHJQ3SgqCr0LIpHfgk+Di4Umxa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezEYv2ZDm/cALc49pCYQc87kg8AzS+kRU8uiBwEuAY9w7BHgmCEYkFI+63K3T1EhtKhSqtlcL+ovW2g7CtMnbadzyvymvtnuI2pCDgTuFRkHRCQiBwkMySRlDqFgaGtn76uQPdkJmJ1YBBLdLYzByfgwFSRw6k1vHjhzQKm1AnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bP3iAHEn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso2435300b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768269; x=1708373069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+k6mhvn9Z1qEZ9gBX0t2yHWJO1e3EK/9q68mH5gChTQ=;
        b=V0jKTLUzHSjmgBkSAJyqqwN2KLokY77pdxWFuNEJ1bhEDUEaSWwyoC6zQk+HpKRNNT
         OPgzU4eduk/bJ/bJ7VbWDxnowsVQrQvI195S7st/MPu59f0s3RxpHM+it98nWYoZF7DJ
         5trR8l6vXvEFC0xqEF+RBMMk7PGBEG3hoSZ9sQEYGpFlU7JJ/K0NP4Jtz9n6kDsrruTN
         yCvPcu62VRPxLTgMSrlCP9AH6fpAiDklUNGW6UKKzIyvbc6Ll98HYoCm308TKoMSMG54
         i8cNZJeseQhSIBo2TvnSfqgF7aUyZ93Iu6dOEQMSDdd6ik0O5kcPvemaJWKhRFn97Gpt
         RD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz+jpdwCo1XOeFHiHuWHz1JioID/H1t36j2OmlTL/ThqXW9UK8duMvE8Js42CC9iAr+paIlRNvvhBpfqvRIaMlWiYnmxxAUppK3P27
X-Gm-Message-State: AOJu0YxS0BSJdd98SDgzpmRPWGgRhOJGMC6W6XZ6kV4vNXaK+vQPmKBc
	YCzvvkvbdmmi4qI2S6wocCQdxycM7qBo/JOv6s6LQb7aKWaV4KBm
X-Google-Smtp-Source: AGHT+IGINKvWIJviGPBsQnG5Y9YOLcPHdz9CrHwwAVWMn9ql/eiw3kT15DsdD3uic+drF37CCVC1HQ==
X-Received: by 2002:a05:6a00:2285:b0:6e0:e83f:22b2 with SMTP id f5-20020a056a00228500b006e0e83f22b2mr690051pfe.6.1707768269378;
        Mon, 12 Feb 2024 12:04:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgCKtXsirL9+QyNsE0b5YkwqaCJEVuunHmZiNUfim68vjnO8XGkKWA2NreEOZ0RSlBb3qqPDE9lmUmMvdr98zBQy8+1jKmB9dfhrw8nu6MM5mlX8CEaZ/iT0CgLQnTGOAZydd0Csi8eeyOx2IKo6VZ/n/Ut8LWuj66AZ2+5UXFInwWbYcjtpnFYkA3p/WGduxbKaZbt62JulX6ZC71jRy4yujVg07lxtY7ckd/Fq9yMi/FfOd6tejjrmZB7odbngxdb11zlm5mXngl+xli
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm6111971pfv.176.2024.02.12.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:04:28 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707768267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+k6mhvn9Z1qEZ9gBX0t2yHWJO1e3EK/9q68mH5gChTQ=;
	b=bP3iAHEn0t2yIJiVbc1IyGN2VF+//5u0L0EATzxHY3YxIY4L1r0vN0V9Cbv9NQDfzFpT3q
	Bqgo27U94aD0xX6d4v+y7PNjMECKek+XV449DEEKPWFRYq/oAcXGXh/D4AX+UCYmcCBklV
	NP10gnmtADQzI+Ousof7Y2oArHK4kfo+uwnQT2Fm+8qh19D/q3GzF45gQHdhsCJqwKnghe
	oA6IVAbiuyv/s26a9Ar/wddXkkOOfQqip4dNNYdy8YbeToIp6UYDa79/gLsXX6k2Z76nUz
	s7J9EUiy6wlS/MJeSIBjouw9VM8uNzcmDqGciSBZ3avEsAKouc3jRDfobjMquA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 12 Feb 2024 17:04:59 -0300
Subject: [PATCH v2 1/5] powerpc: vio: move device attributes into a new
 ifdef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-bus_cleanup-powerpc2-v2-1-8441b3f77827@marliere.net>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
In-Reply-To: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3550; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=/dPB3W4ot4IPM57QJHJQ3SgqCr0LIpHfgk+Di4Umxa8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlynnuYhyrYfoN9ksVb2HrsIX3LZN4DUe/acctL
 x6Xnv1jhDaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcp57gAKCRDJC4p8Y4ZY
 pogdEACTenv2YC6Xsjpap9+JxL5O8Hq3ORJnwXLvrAn4x6mBHwtceDg/pPNfOqkVy9XQZRxfFVJ
 KwWQV0VqIM2Z52von87F2QcHJxdL6F6WanAxjOzy27t5q0qAzTUxERt37hiHxKAHK7rL44KmhEK
 +hpKTYyBAh26HMTqROzSD/KenTsWP/vcmiNYVpMcPy+5iF/Z9U+cbkByxndneohlOxnbHGZ0Rj9
 +8K3wWMo7QWf6ZVFIrDbUozum0iw4tKBYoPOcWTTt21zVRE+2Z10E9EDhaXZ/XxWD5Xz/MjjOSh
 xVXmwjsEy9T03nNVoHxWTtPzM3y35XIvvQGgCV5ZuhXOiAFD2EAV7aSCMY8+fNW+xi70zgw73c0
 PIYgw2TbBATBlTe4kHi+S0gffDNmN/aiLOOd0F0EpW66emuyI5k2HhEW86uTvedC3SlQJupi3PX
 QosGuWCkcwsvFqHhIcPHh8m3LJ8RpGm7kavGSVij1fmPvNNd+ba588nPqJTz93vS7H4KEOQ2pmh
 oWInWLPm+ONFZReKtvOnJRjuapq5ktmelIMwSQmGeB0vchpwU49Zg5wsAG8NV+Lhszu1nztPuWi
 Fiz07LP/fRLsHcsF2JCIGLhZ6JbhgXnVrcTZzrOxB7qYcJLd7i5fIvgKfoPgYaDslzaiOb8OLG7
 4+8MdJT/Qw5wCqA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

In order to make the distinction of the vio_bus_type variable based on
CONFIG_PPC_SMLPAR more explicit, move the required structs into a new
ifdef block. This is needed in order to make vio_bus_type const and
because the distinction is made explicit, there is no need to set the
fields within the vio_cmo_sysfs_init function.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/platforms/pseries/vio.c | 59 +++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 2dc9cbc4bcd8..6c58824190a2 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -991,18 +991,6 @@ static DEVICE_ATTR_RO(cmo_allocated);
 static DEVICE_ATTR_RW(cmo_desired);
 static DEVICE_ATTR_RW(cmo_allocs_failed);
 
-static struct attribute *vio_cmo_dev_attrs[] = {
-	&dev_attr_name.attr,
-	&dev_attr_devspec.attr,
-	&dev_attr_modalias.attr,
-	&dev_attr_cmo_entitled.attr,
-	&dev_attr_cmo_allocated.attr,
-	&dev_attr_cmo_desired.attr,
-	&dev_attr_cmo_allocs_failed.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(vio_cmo_dev);
-
 /* sysfs bus functions and data structures for CMO */
 
 #define viobus_cmo_rd_attr(name)                                        \
@@ -1062,11 +1050,7 @@ static struct attribute *vio_bus_attrs[] = {
 };
 ATTRIBUTE_GROUPS(vio_bus);
 
-static void __init vio_cmo_sysfs_init(void)
-{
-	vio_bus_type.dev_groups = vio_cmo_dev_groups;
-	vio_bus_type.bus_groups = vio_bus_groups;
-}
+static void __init vio_cmo_sysfs_init(void) { }
 #else /* CONFIG_PPC_SMLPAR */
 int vio_cmo_entitlement_update(size_t new_entitlement) { return 0; }
 void vio_cmo_set_dev_desired(struct vio_dev *viodev, size_t desired) {}
@@ -1584,14 +1568,6 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
-static struct attribute *vio_dev_attrs[] = {
-	&dev_attr_name.attr,
-	&dev_attr_devspec.attr,
-	&dev_attr_modalias.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(vio_dev);
-
 void vio_unregister_device(struct vio_dev *viodev)
 {
 	device_unregister(&viodev->dev);
@@ -1626,6 +1602,38 @@ static int vio_hotplug(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_SMLPAR
+static struct attribute *vio_cmo_dev_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_devspec.attr,
+	&dev_attr_modalias.attr,
+	&dev_attr_cmo_entitled.attr,
+	&dev_attr_cmo_allocated.attr,
+	&dev_attr_cmo_desired.attr,
+	&dev_attr_cmo_allocs_failed.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(vio_cmo_dev);
+
+struct bus_type vio_bus_type = {
+	.name = "vio",
+	.dev_groups = vio_cmo_dev_groups,
+	.bus_groups = vio_bus_groups,
+	.uevent = vio_hotplug,
+	.match = vio_bus_match,
+	.probe = vio_bus_probe,
+	.remove = vio_bus_remove,
+	.shutdown = vio_bus_shutdown,
+};
+#else /* CONFIG_PPC_SMLPAR */
+static struct attribute *vio_dev_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_devspec.attr,
+	&dev_attr_modalias.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(vio_dev);
+
 struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_groups = vio_dev_groups,
@@ -1635,6 +1643,7 @@ struct bus_type vio_bus_type = {
 	.remove = vio_bus_remove,
 	.shutdown = vio_bus_shutdown,
 };
+#endif /* CONFIG_PPC_SMLPAR */
 
 /**
  * vio_get_attribute: - get attribute for virtual device

-- 
2.43.0


