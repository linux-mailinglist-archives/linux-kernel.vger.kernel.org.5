Return-Path: <linux-kernel+bounces-92903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3AB8727D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D41F28FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338212B14F;
	Tue,  5 Mar 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Q7/JDQz0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67B86AC3;
	Tue,  5 Mar 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667631; cv=none; b=AKxEarD3G1FRXU1Px9rBdSGNZ9HCqJ1IwsvdN8PYcCuFswIirqg1C7UxeQYOGefEaz5c+HquHAV7NzGrR+0X0PRJ/QaIuuLWUPENwT0y5OhgPEaiMU/pTf0JmHLhaqzQOFI1oKneJhbNsYytHI6IsPShzaRxQYc0Viai6HDEx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667631; c=relaxed/simple;
	bh=aYEnoEaK8lvdazf1apUl70SZAkWUVo6cPnMSWocdxf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C7uykNqpxahpboKfGmy+tcg+BYcHHKWWlYDIXj7TOrBOwqdeaP3NmDqqV6k61FUPKVHL5GX3iS7YxuhSVXoJ04+uhVX1Sju0qn1m7h3364CDadz+4IyHdM4D/QUBLk+OFNBfWEQnkOB3BsMDGdQifPo90DUeMvIotwEz6wr7b0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Q7/JDQz0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so3654246b3a.0;
        Tue, 05 Mar 2024 11:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709667629; x=1710272429;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbOk/Gqyi9LltFIdUYglAWdVxEfqass0k2Pwo4RSlsc=;
        b=t/hMEoDKfhkXEBnAf3TKOwwwbFG7lV31pdbS+DFdQLr5LW8kGqsbbDVUPIH0gJUyex
         ggWaCNFjJdepg4RElwOhbvXY20EMGMcpTLHw6NuLsS/iA2RUYVDYJn4L6dQMDbH5lQhQ
         MBu4rgXH5+g9/VWxAobN67CzxeA3RC/yTyFQkRGHTfLFNx/2t12A9htD7FbnsgH5NCaZ
         HyIx4lCRMR7HMrl092f2+yx1p18Y27TrZSL/k1nmiDvGFMr+Y9N+hLhrX2vgpLTH4nye
         PrbQsISs71Y4Eq3kjPiNhqidkDbESxOq0CSfBCpqsx991w53ULimb6AetK7YSxLfvMXt
         N9dw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Qa3yZcigJ2IgIis9ARWgf6XYKVCVC7bRWliiVb0w99rjrrKXkhrQ2dsQol6Jfvqo6n4eAlRn+2nROI/+2+u3cnUxN4sQLw+TqajO
X-Gm-Message-State: AOJu0YxNG3CLJX4+jgbmb51qXjidJ/eDhjSckGI7jTD3042rnkloUvci
	jh8ZYcSggN81an0cVzUrGiA0E99NePLWyLuHNk2i84rFYRFKSVXOscrrs0txdV0rzA==
X-Google-Smtp-Source: AGHT+IFQzC+hq4orwy5u/GXVGLqkKMY2sD4mqYBvpHgvZcdwlXBZEAcW/vIDS9kDeyt28vHpaG9h0A==
X-Received: by 2002:a05:6a00:896:b0:6e6:4946:985f with SMTP id q22-20020a056a00089600b006e64946985fmr474334pfj.11.1709667628961;
        Tue, 05 Mar 2024 11:40:28 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q23-20020aa79837000000b006e5e93e7854sm6012875pfl.151.2024.03.05.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:40:28 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709667627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZbOk/Gqyi9LltFIdUYglAWdVxEfqass0k2Pwo4RSlsc=;
	b=Q7/JDQz0+772PuNm4IuQFgQq5HWmlpCGPK9jCCmEnGy+qZ7vHcRZp7vqEei/b9blQuADE9
	nY7L/v0vlHZkxCT0Le9+pBUFye2yfZRrx0OLzz7UNkMmI3X5nBC1bl8orn0/fEqeIPlFU4
	UvLS0mFfWP/A0wlNTU5abQHLxOI6EsAjYKe8oUI9GmqYQqqoEkde+O+RR9MemAMXOHFsOW
	rphaMwfDQlApO/961cvnYIpS8u/eBBCy9QMqbvZebMySTs6U54/Le/rYO/DWLdwFB3NfnQ
	xENSF0dtJQ0cpygKUsLrIdFS+Lah9dg+12btp2r3IAQHcnXk7MkCK3ZngZ6tkw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:40:23 -0300
Subject: [PATCH] remoteproc: make rproc_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-remoteproc2-v1-1-1b139e9828c9@marliere.net>
X-B4-Tracking: v=1; b=H4sIACZ152UC/x3MQQqDMBBA0avIrA0ko13Eq0iRECftgE3CTFsE8
 e4Gl2/x/wFKwqQwdQcI/Vm55AbXdxDfIb/I8NoMaHG0g32YuAXVJW4U8q8aoU/5UpUS0SSHDv0
 wJu8ttL4KJd7v9/w8zwveuXDAawAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=aYEnoEaK8lvdazf1apUl70SZAkWUVo6cPnMSWocdxf0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53UoF5WUvPGlq4VL+7i6YHDw3CvmBCkzhUVPg
 vKBiqxKdSKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed1KAAKCRDJC4p8Y4ZY
 pipSEACwnMbkOr2h9S8BDhLWgU2C57CHwLERMTpqJlUFRTUjanlY57NEbpYFjSuJ4BUr0p0B4B1
 fpne2elnneCrI0fJ+A8qU05viHGeSBDdkyVXykbDKZboyP5w/GvsYe7jpEWGYPFar9WqfmW+ch7
 dQO0UnSSEmdVub8ZlmJ4Lo/UmF2R5qPJSrgfJ/TTcXo7oFRf03ZbMwaoryZEoTE3kxbRcnhOR/7
 kouVynUlCLalM4cLVqOvF5KDbCgy2rai9vOWFjaUCz8/Sj/L9pnobiBcNRdfGFwPijWXkC9Bngl
 IEOON0cxGxP1PgKGbed3CGh0RXrNhHl44u0aureCUsajpejt2JDq1MRl8bfGA0nT9PmIe4Wm8tt
 IPjHklHiYcoZxMM9KlyWvZxJwRN4+/4iwCNlD5nHBLRPuYcP5ea9FR/cjcYMUS4kPf8wFu+0r9C
 8J781ru5vxPHSdsanUFDi1tnkNV/kmyWa+ggjwywWai1aUqFLozhlaUMOaBwD1/k5M16NvXmFgz
 q0DNfFq7a9O8/kCqR6lwhAJLl9+lfyt4+XkfapaJCiQcQqVMwVCbjGYviqm0OfchvrsOvqnc0M4
 VMP3UhQg4ViCRVbXtPmCqGns4oW4ih2rtAA9urjcjXw8RD1tUEWDm6gG4n6ELVXWWoMc/vJkoHm
 Azd+bXJkljFPV2g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the rproc_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/remoteproc/remoteproc_internal.h | 2 +-
 drivers/remoteproc/remoteproc_sysfs.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f62a82d71dfa..0cd09e67ac14 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -72,7 +72,7 @@ void rproc_init_debugfs(void);
 void rproc_exit_debugfs(void);
 
 /* from remoteproc_sysfs.c */
-extern struct class rproc_class;
+extern const struct class rproc_class;
 int rproc_init_sysfs(void);
 void rproc_exit_sysfs(void);
 
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 8c7ea8922638..138e752c5e4e 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -254,7 +254,7 @@ static const struct attribute_group *rproc_devgroups[] = {
 	NULL
 };
 
-struct class rproc_class = {
+const struct class rproc_class = {
 	.name		= "remoteproc",
 	.dev_groups	= rproc_devgroups,
 };

---
base-commit: 8b46dc5cfa5ffea279aed0fc05dc4b1c39a51517
change-id: 20240305-class_cleanup-remoteproc2-f1212934f990

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


