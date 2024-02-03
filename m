Return-Path: <linux-kernel+bounces-51185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417484877A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005292856C1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36CD5F57D;
	Sat,  3 Feb 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhaX9zOd"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225C80B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706978589; cv=none; b=ocfL7JKCL++yghhQNKvJZVUawuWnsdXWN2iJyH6CkBihsPcBunukbNrfCyhpdyFs7T4QdjlKqJ8POtU8EAsL0NogIuvb1Kg3HiVILb2EQCwPN6mo1TvbXVrWIJjItKph6aaWvgVc2wWxvaVyoDBzJA8+PojxmLPPgGdqU7Cang4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706978589; c=relaxed/simple;
	bh=I562TcgqfQSMitQ564OtLTfBvmpYm6xrnSmNYWbGnI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQGR4zEjfuxYkQ2JmTb1Y8nmNGKmIIGd+nrKYDHmwdMGpKFl6B4qVZQhTQycUqGa0pylMA0UnPB295Kpz5SQYoe0NGYaOkDI+PWmHdGWgdWt0/GQ2Iz8Jz29MqztAyClK2Ee3wvZ1at4VKX/oQofmm0EZpMQUt5/0FivFhE4qno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhaX9zOd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso2540195a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 08:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706978587; x=1707583387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=898cO/dLe9YkUvrZSvyaCxblTlterCxFQmMbGCZo940=;
        b=YhaX9zOdpVMjctkx+XnxFBEIY75QdPbyeZWLigIKVoKtfQ8yeCyqr2rcr7RGqbRTij
         XJ5F878ahStSsXG3mvy/UeoKqs6SH3THg6RMsqFENH3jFsHpA4+9b0UFsGrMcwoSzSdU
         /evP0RWalFel7M5/e+y5prkSC4AxcJOqVFeFghAi3HXb3CMUJIHu7udW8YcYNxiLmP4X
         yyqww9M4u4urdKVN9NxZJmXVKtvDfR3GR73t0RKVtbbjND/6yKSy7q2R/mC/DAL360jX
         n72RRAOU+aKxNzeEb7Sc2GXBIMl91HOFt9XKHPl5nqjqgHm0kC6vLiZ+IjlrLugdOKWi
         kIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706978587; x=1707583387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=898cO/dLe9YkUvrZSvyaCxblTlterCxFQmMbGCZo940=;
        b=pj2Dy7qBJxAf0tpv5m3GKbOUVnRFMKL7/Kz4+ZD6g/sVtmnsjJzrgkNaQds5zficv0
         +PBkHoOkcRLWMJ5S/LsY9BGlvAjH1m6CETApIqna4jZLZAIN2MsDLlOmh/rHJ+Gks+0q
         cg2RoIgTtLX207C5yh2w6gQ7GUb7sPXjEEDcShZC785s6EEF+WNGr7BPytA0Sfw6gvhx
         RcEcn7oPKdiUCuo2qIK/XPn9ktf3e5oiGz94S3+3HB1D8g1XwylX0mPg09bx1TQtXRQu
         9j5uKAPouOLVLAnXTp7yr0RvB9uB4/DxFqiX19i56N7oyQSt0YbsVLOCtJ5lyt2G69EJ
         vMEg==
X-Gm-Message-State: AOJu0Yx7SLB/FsA7b6zvV6hD9qbZHXCcU+wz7+VZ+yj1FUVRrvTEV/M8
	DPDqSOF9xCQSCNyRfsjY9Nk2eRR+0KbSLyB8E4XxjDAmlhoADYLL
X-Google-Smtp-Source: AGHT+IGRwNqWb1j8WhVzJSsmKsD7nfnnGe6hfs5s5Z5DncYFnXaTAElemngb9TM/rJZMLoYEcPni2g==
X-Received: by 2002:a17:903:32d1:b0:1d9:4eea:9afd with SMTP id i17-20020a17090332d100b001d94eea9afdmr10236103plr.10.1706978586797;
        Sat, 03 Feb 2024 08:43:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVw71NKE9ALXCPyjJa8S8ASTrTsHgPb4QCKC4Z40/MSuWLKNeHaPuqag2s8DuriK0Mov6y96JG4CFrdzYgCVBOBi3TAzb/BESaT
Received: from localhost.localdomain ([122.161.75.254])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090320d200b001d6f29c12f7sm3472963plb.135.2024.02.03.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 08:43:06 -0800 (PST)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] Task: Kselftests: LKMP Bug Fixing Spring 2024
Date: Sat,  3 Feb 2024 16:42:30 +0000
Message-Id: <20240203164230.149317-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Added <stddef.h> header to fix implicit declaration warnings
-Added ksft_exit_fail_msg() return value checks for fchdir and chroot

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 .../filesystems/statmount/statmount_test.c          | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 3eafd7da58e2..47ee57da9942 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -124,8 +124,17 @@ static uint32_t old_root_id, old_parent_id;
 
 static void cleanup_namespace(void)
 {
-	fchdir(orig_root);
-	chroot(".");
+	int ret;
+
+	ret = fchdir(orig_root);
+	if (ret == -1)
+		ksft_exit_fail_msg("changing current directory: %s\n",
+				strerror(errno));
+
+	ret = chroot(".");
+	if (ret == -1)
+		ksft_exit_fail_msg("chroot: %s\n", strerror(errno));
+
 	umount2(root_mntpoint, MNT_DETACH);
 	rmdir(root_mntpoint);
 }
-- 
2.25.1


