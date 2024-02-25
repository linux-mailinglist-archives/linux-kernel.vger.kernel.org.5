Return-Path: <linux-kernel+bounces-80017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578148629C4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD35281824
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2DEADD;
	Sun, 25 Feb 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxIglPmh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10FFC02
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708850521; cv=none; b=gg8S+FSor/rDj0dxpWOf3thTdneVFrMoNUc6C/uFolexJgEyuPm5Jhz3nGtIBMsaniTh4FSu1iffrv7XetwZVpFPvlU7+lzNQKxZt3vjktwkHhpMvw5M20VNZG3BBaP8pS4h/pUFGvygpr2IRP/o4uJRZbciEWs/YxN7RctgOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708850521; c=relaxed/simple;
	bh=ADXWWn3aihrNdObnQdFuMx+J2IzGQidw1FrBetQfMq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NEvVVvHudWoMPNU617o27zf1+2VRFujabT76KHMZ+VtcrZQE9VyONO9Vhh3F1nPNnVOZpzhLlwZaiYF6cj712MVQvzFA0jPTjIJiP0Ub8Q4V1kQX1l2P+aipNBpF1z71Q7pm7xAhRHELUOvT/Xrsm0uZGatM85vAxj8a3ySk95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxIglPmh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49b00bdbso17732205ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708850518; x=1709455318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXcTHohQKUEWCG3AfRPALlxApVKdvPfbvuOAXc4fB5c=;
        b=FxIglPmhqCYMsLG21jUbzYqIg4HACLU72K5hTEv5jnb13R1YiKNXp0lYFqZYsqRCdo
         KSUt7L48h4V6d00B3+QJptQcifAk1zgs5LHE8cqAd1HPONZiOoqIvmp6a11RMzkjpOfO
         I4aukFX+0k1jyTM/YHhO5hBkTThskACkoZEEqXFsTKsa9ymjwMDNUHWZGaABLVTHLveC
         mQaeQnkFyMG1QwolDrLNnYMsZ4Jn6RmOZBVhlt08CUApkc3ZHZiAw92RKuLZFAvCAAua
         GuLpJnwGSFvg7MRKhUeyOntStrcg42pg5eGO9iPG6U42ayhG5SBDPC6ZnvP0WELYrBTR
         3CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708850518; x=1709455318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXcTHohQKUEWCG3AfRPALlxApVKdvPfbvuOAXc4fB5c=;
        b=K9XtCkTkCxYsiG0Kb+9RPr3Fg8Rn1IAOuYYgJsJ/H4D/t0j5rd4bVDgvjZvhnHHVdZ
         nZd1CFCzN6FjmRCmlorAYO0GcUZ46azcu3kEG/j9lpmyDZJEk73kJ6wxslKidbVZCDRm
         zZz9t6aWbBmCVv0aJI7Q0JE+XqkRYxV6x5f13L1ac8vdPdZSMS4+L8ieWwyTC3glndw7
         ivzX4vLTr4KTUlcGqTi7hjW4zf8ZwK7YI4X4Z3jcgpsFRZcjNhClI3e4fh29MYEvRxU3
         96cm+Ve54VPom78QJn8Wp1P8MQU2xI1mqhTQJ9MtJXXbcRlvv1AUDolPrHKsSHbTQEQv
         cZIw==
X-Forwarded-Encrypted: i=1; AJvYcCXAzk4Atl3A4zpfumYaQd1QuJNFfEEDFfm8Rvu0/s80WqTmT2BCkMmHcOEqM15mIJQzcxonTBfSkVlr//fFUQ2nrjWik43G/FPGHvcj
X-Gm-Message-State: AOJu0Yy8ryA/VDohEzqiBcDNaa2DPHDU0CMWdFG8kH7DP5Z9qdvaxakQ
	cGP/TotI2RknBM0uk9AXSJ7zcFHVbSZ3zTG8Vr+5Ly7/pHE4Mtj+
X-Google-Smtp-Source: AGHT+IHaSPeFmSU8LbgQp6DtCzv3SLULosPQKgzi/lNKyeSLUsDjebl0vj2X4o7c4Gbq1Kxs7N69Ng==
X-Received: by 2002:a17:902:db01:b0:1dc:6373:3cc with SMTP id m1-20020a170902db0100b001dc637303ccmr4354300plx.50.1708850518265;
        Sun, 25 Feb 2024 00:41:58 -0800 (PST)
Received: from dileep-HP-Pavilion-Laptop-15-eg2xxx.. ([2405:201:5c1b:782d:790a:81c5:9183:eca7])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001dc2d1bd4d6sm1968425plb.77.2024.02.25.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 00:41:57 -0800 (PST)
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
To: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: pure.logic@nexus-software.ie,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	Dileep Sankhla <dileepsankhla.ds@gmail.com>
Subject: [PATCH] staging: greybus: put macro in a do - while loop
Date: Sun, 25 Feb 2024 14:10:17 +0530
Message-Id: <20240225084017.418773-1-dileepsankhla.ds@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enclose the macro gb_loopback_stats_attrs defined with multiple
replacement statements in a do - while loop. This avoids possible
if/else logic defects and clears a checkpatch error.

ERROR: Macros with multiple statements should be enclosed in a do -
while loop

Signed-off-by: Dileep Sankhla <dileepsankhla.ds@gmail.com>
---
 drivers/staging/greybus/loopback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index bb33379b5297..eb5a7a20f5a3 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -162,9 +162,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
 static DEVICE_ATTR_RO(name##_avg)
 
 #define gb_loopback_stats_attrs(field)				\
-	gb_loopback_ro_stats_attr(field, min, u);		\
-	gb_loopback_ro_stats_attr(field, max, u);		\
-	gb_loopback_ro_avg_attr(field)
+	do {							\
+		gb_loopback_ro_stats_attr(field, min, u);	\
+		gb_loopback_ro_stats_attr(field, max, u);	\
+		gb_loopback_ro_avg_attr(field);			\
+	} while (0)
 
 #define gb_loopback_attr(field, type)					\
 static ssize_t field##_show(struct device *dev,				\
-- 
2.40.1


