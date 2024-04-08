Return-Path: <linux-kernel+bounces-135200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491989BCA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D6284037
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB252F83;
	Mon,  8 Apr 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Ba7RVx2n"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B5524B7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570737; cv=none; b=FMm3QVW5OYgclquPOlUA1bb+Un6c9YE1JALBiscTe9pm/vD+VW7zeZrJTmNsuT3k/aO0wH878dupTD8/LKTRtesHitJ4b/rE+RCFZ5Pkf7qBjDpHz4qnSkrIwvyQion+rZfe1cnkrfniien/qnrJvODkOxarDK4A6Cl9z9tm6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570737; c=relaxed/simple;
	bh=OsJTelcc7tlBV2QwkwR67SVR5ZBOd+QZDuhUnZw4FFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFf9zB/RpX5nZXHCobBJuLXqAfuAyUQ+ki7ZdsYnCr/85U/OaxEfkpzvnh7bChBthO+iOl1rFe0o/wZxJGBgwxZEafAJCewAP6+z2FJo158rL9Hksi/DntZ4f05Y+ODTFta0DLSGK2rWRoV3LI/p/L9fM7A7dQpXQX21jUZJjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Ba7RVx2n; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-229d01e81f1so2503416fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712570734; x=1713175534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eBLG7eQZNN9ZhfgeoyOekEyjLAkk752YA5M9Sq+ECMQ=;
        b=Ba7RVx2nkMlPZYV1qgmwM//g6czFp8lPWZLAJt3JoO+pv7iEgbCGEsHksV9F4/qMBi
         N3EuTdaWJVh+GFE46PZOK6TFYOInI2t7Q0mJexjgsUn7ycpyejoVHpXjUhhObShY9Lmh
         9EYPdQ0vp40up4vZnEn3Dri/ExXsZ5tIbwis51XvKHcJumPBfBv7JChsu5FOdPUmigeD
         ZjdLjBfeJcmFL9s/AJ+syajnnZnNm7PFR52WEpgpVvtMrpzI+v4pJBKf05z32zrWKygD
         F9z/7M//CiK6irQ4ihrSRRQcbeDG3LwZQz12o2Ylz4XxdZEwqVR7KnpqhEAvI+Rzeyrj
         pI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570734; x=1713175534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBLG7eQZNN9ZhfgeoyOekEyjLAkk752YA5M9Sq+ECMQ=;
        b=UE9kHHOeC1iJ6GcfNTv081DUATdD+IIqrLiZaULpBSCzO6tlxrokfPetyqe/JZw4Ix
         cBGh/xu/+TDxPzSzvMD/NsSqImaUUlFvkcdVzFg2ReIEW1nRhye8PcoopNsc0aMJOFzE
         2JKkPCrOMIdi5Oqb3wUNkuXR5woUh4V+Zb4ccEAT8pAhTsACvOR0w+K9NCuC2tygdwEJ
         lHRZuBA1lUPsLRSScyMY00tn9eRRfQGZo01em/0f5K3DUKbCz+qc0t1tIpqo0QiS0aCL
         q0sCpybQfU9OgqMRwFHPTrwbFoSBpWSc3a5OYBEfs45jvIsaZ4gjMw911LcS0+/WmJgr
         yZZw==
X-Forwarded-Encrypted: i=1; AJvYcCUoqNXo5VFrOWXMWN52YTomilJ57WDakOCaL+gKjf745uKciX4yZJRPZz/kXB2V78bx/zjwgczO3vjBX1QbzsVUOoFZbUY+Lml3eyk8
X-Gm-Message-State: AOJu0Yw+Q/rCap5X7IX5izU2csbtNVEErhHM/Hr6dGjoB+6E7irIrmFe
	WASUe72DZLOV8XhHQvPb20DxDB4j7FS0+bWXf3mKUF8sO/7s1C8wEy1rgBkEheo=
X-Google-Smtp-Source: AGHT+IEx7VTx0K0yOwbxPA8x0d94YSdl3SQSAKztRAl4yW5VnRP8hMQdfy/b/azX8aClfP0obPVdAQ==
X-Received: by 2002:a05:6870:f70a:b0:22e:7460:d2a8 with SMTP id ej10-20020a056870f70a00b0022e7460d2a8mr9628681oab.42.1712570733497;
        Mon, 08 Apr 2024 03:05:33 -0700 (PDT)
Received: from localhost.localdomain ([103.172.41.206])
        by smtp.googlemail.com with ESMTPSA id fe15-20020a056a002f0f00b006ea8cc9250bsm6144272pfb.44.2024.04.08.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:05:33 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] scsi: megaraid_sas: make module parameter scmd_timeout writable
Date: Mon,  8 Apr 2024 06:05:03 -0400
Message-ID: <20240408100505.1732370-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an scmd times out, block layer calls megasas_reset_timer to
make further decisions. scmd_timeout indicates when an scmd is really
timed-out. If we want to make this process more fast, we can decrease
this value. This patch allows users to change this value in run-time.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..2a165e5dc7a3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -91,7 +91,7 @@ module_param(dual_qdepth_disable, int, 0444);
 MODULE_PARM_DESC(dual_qdepth_disable, "Disable dual queue depth feature. Default: 0");
 
 static unsigned int scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
-module_param(scmd_timeout, int, 0444);
+module_param(scmd_timeout, int, 0644);
 MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), default 90s. See megasas_reset_timer.");
 
 int perf_mode = -1;
-- 
2.44.0


