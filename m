Return-Path: <linux-kernel+bounces-98875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA4878089
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BB8281487
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859D446BA;
	Mon, 11 Mar 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aFtMVzve"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D54204C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163409; cv=none; b=Ha4bQHOKrYvdbxxDG+pks+WqfXTcHtSf08a6zJ14PqATB1p7A51QF/nzJt1gvf8M4so0FZbMvF8dVW/9pzTSzF7Mf0Fi4XPKgB8+5JBIdvZ6CdgCgfXfJD96B/z/PaiNCHV0wt5T+7gO9UIIRCP4hvKdQjnG/01Wbtx/P7xQxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163409; c=relaxed/simple;
	bh=xFq2r254un10Vo9LCdFpXbLV/oBD8Dnl4Uq8M82cuaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxRAMquTF0OV07oUPq7VRuvaAzyG4tuwLzVaY5jQsa7f913TUBbtlDbzD8fsn8vRNtwNhdZ3ACkm18kYh+h1XWT6XcVJFr09y7DrYE+UJTkR2zdYfDuwM2RtphdnBbgI5st3pN4A3CXoDkx+PSkvn3lyJh7EgAi8aDLPRBD18QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aFtMVzve; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45fd0a0980so236951366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163406; x=1710768206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c8Be14Vo5XsbELfBJJCoD5NMAbQazGtWYb9r4LXMpE=;
        b=aFtMVzveYSBwQd1SF3wit0yf/llnVYD38WFYe/MfDtp3RYdgBn4FzcW/K6+mst5vHF
         yui3mFJBD83J3QEqY4YpzBTiIMwGb1Vn0WoMn1B41SFf2gDf4R2GiJPRqM0Zy5sp5xC3
         32tc6ZKIbEZcPVQb5TR50cXxCUOtav2PwbIk9wkn9rgDSKplAkqIjlkmaXfZ3xQACJN2
         3w/+93sbE8nYeeSKa94BCeQ4UXH4NTmXnHFAI4Jwiz0x29wmgSHxgWTkSV9XW1lk5unO
         3AqjrW3fle1JIJIwmLxlUd9zlNlDVL/akn3EheLJBmuaSzl2P8LsFtEsGeQHzCtErKkT
         /DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163406; x=1710768206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c8Be14Vo5XsbELfBJJCoD5NMAbQazGtWYb9r4LXMpE=;
        b=S1vE8Q/TtyjBiuT12pBZiuABl3CrBHuN08ExeT3P+yFKoiWloI3GF7cxXe0tZ8+Gce
         imayiA0VXePxPxuh89un9akXHBoztNs6cMRYW5aG+Ep2VvfGOZhb2fzLiVIN+JWXq/PK
         99Y0n7QjGWr5F0mfdnMEKLvWKtaoZu7R0wHuWOXIFoPUU77ywvK1dpvw353ez50J3dIO
         A2z1Mw0kNmAXmMUkRkGzzQjIfcvVDOAbJQWE4WBaPfStFufjT/zP7k5uBktylfdvTO73
         Khra+0FDMCnG1BqDy9BMKAxmJCH5xtBisFi6YaHOxlhxf7ncP6IDs5/QPnN1z4NUycP1
         wX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMg8oJ02LSGZO5MlwMtlz+kDwqsRPRQozaMsB3FZiiLtyWrYHi4OqHmijBUHDuU4C/3tKTzOU1N6DDGsj2+IASm2jQ2XiFnHGfZhSo
X-Gm-Message-State: AOJu0YxF4fCJr/0r2Saakx6s+wxOWNxsimv7y7RtzcRHpVPM7COhO8QH
	m40ADNbrXJpzyNvoILzmBm+0bRzvScinyo9cbCCcHlIJMtL1ytGUVTzbsVPHmdI=
X-Google-Smtp-Source: AGHT+IFiK5DxhHhYV196iGsvV+mZzp0074MZ9wUlVApB+317DFC5cWlRCMV+BM4l5k6aFzdnL402ww==
X-Received: by 2002:a17:907:d30b:b0:a3e:b523:90b with SMTP id vg11-20020a170907d30b00b00a3eb523090bmr4861550ejc.14.1710163406323;
        Mon, 11 Mar 2024 06:23:26 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:25 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 11/11] arch/alpha/smc37c669: add missing includes to fix -Wmissing-prototypes
Date: Mon, 11 Mar 2024 14:23:06 +0100
Message-Id: <20240311132306.3420135-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:

 arch/alpha/kernel/smc37c669.c:2467:13: error: no previous prototype for 'SMC669_Init' [-Werror=missing-prototypes]
  2467 | void __init SMC669_Init ( int index )
       |             ^~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/smc37c669.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
index ab22ade3dea3..be71ea825690 100644
--- a/arch/alpha/kernel/smc37c669.c
+++ b/arch/alpha/kernel/smc37c669.c
@@ -1,6 +1,9 @@
 /*
  * SMC 37C669 initialization code
  */
+
+#include "proto.h" // for the SMC669_Init() prototype
+
 #include <linux/kernel.h>
 
 #include <linux/mm.h>
-- 
2.39.2


