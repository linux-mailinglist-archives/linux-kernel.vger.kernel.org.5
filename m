Return-Path: <linux-kernel+bounces-139524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3ED8A03F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42991F214C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171533F9C2;
	Wed, 10 Apr 2024 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mfONAZt0"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320A2E417
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791337; cv=none; b=HFksBafACCtFd6/0ux+L/L6akz24dd1HEPko2/nIb6djHMjjFmAMfJP6Vnn9JLB2vNcgKLb6MustQlfCv2zmA8q1TJle2kBXhDhVjOkicMT3LFgKmsRTtU+g0p6auQHtNAxCEnGoHt7gbSSTtKrGgEf3JiYmEi7UE+0zQA408SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791337; c=relaxed/simple;
	bh=8JbUy6lckbhTM3ZPTAPlE4Ad+zV4OmjpIzHolEPOxGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opEXazTwTMUi4sUeuo2dqrqfxm+Tw5DRlrZkmPaoOxxPS2AI2lcdBXzZupdcfJ3XABzKyEZKlNkc8ZgiLfWpprUPkyZDoujxk5iMdQHTVRhoW/Cs9OtY4LCnlCKwE7mYZvzezS4KNiKVoTTjtQGs6uUcpFM37Q+swKlJJyBV5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mfONAZt0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a526803fccso2436596a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712791335; x=1713396135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6GWeq3XOyCgOhhTvpF1S7omIve7JbnP/NpPy+2G4KQ=;
        b=mfONAZt0YSpHYKNsRD2Xg47zyReC5XB4RpG61pDb3rJh19+EMmou7krSE7lyLJgu03
         QsEaZd1gdLJKfNQySEMVksFyD1+Ogrk6qCux6qC7b8uLqSDZzYvBrjYgKHLVMXV3GS6V
         El0AihUG8DzIYlZ0RQD6r9/uPh6s0b/6wbxMG2g+NAJqwS23xf4jxdI4iG3yuWpEzZbS
         jJb1l5ooDa1xhLQMaH//fBGIKXDlSh7v7F7VRNeKPz6b59KLCPO+WpI5Y2GOv5hP0T08
         RGxY+9f0mcT4DUp0Jfj1Ku2Vo+gDaUuRXzIiXVk0akoWBuGJSiytrkB2lV/MwuKEjPic
         J2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791335; x=1713396135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6GWeq3XOyCgOhhTvpF1S7omIve7JbnP/NpPy+2G4KQ=;
        b=isiprH2BCHpO7sop9LnXrcgHpuI9p+J5EaGRM2LT5VrTi/ms0ZPn/vGsSLcMp7xuU+
         MLoSeyxry/8L67QoV9wjmShoLdVfrb0yZTCMR6MBDV1uX5pDDRvYx771qDQxXSoLXbEC
         nhbQOwj20G/Q9XKgtk67XJQcH4AbrcCqxvG0YMJ2ycftpLLYc1ARusoTMPG/DuYeKTP5
         JqZ6fOoNdJWU6OhA5p0tcHPGdQFJdaLO11p724PAf7IioDoVs2oVzJvIB/xJaJ3uEBvN
         wR4HVEupbx/8MlaLn3GE1uyEalTGTzNYhpb+4bGpok5N9cUAk22UykxtTmEzSQHnHSi4
         NH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVPE9Byr32rGmhtD7w1BW4zIpPzXCyimv384tqsxI0iW1ZbEmC777MU6sU2Pi35AvTOV4+qITAXUj3WCGkHGQ4Cv0XJUvJQL6aox4hL
X-Gm-Message-State: AOJu0YzrhzDeVExDCW3UhFxbaId3MlfIE8maY6NZMVL0INTCyTsv3GuK
	OUZfbqtwSYrkDdWDzt33jmqiE2zVfHduuc9J7DtoCK7birkNGKTwVFiKZUjdj30=
X-Google-Smtp-Source: AGHT+IHQxkQzWHUTzxTLtP+m4JmR5VZ+DDzJOureKVO+ARelFpk0sk3IDdXuHWSl86HQ9vRbs2OFiQ==
X-Received: by 2002:a17:90a:7c43:b0:2a2:97ce:24f5 with SMTP id e3-20020a17090a7c4300b002a297ce24f5mr4347230pjl.35.1712791335281;
        Wed, 10 Apr 2024 16:22:15 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm161865pjq.40.2024.04.10.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:22:14 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cache: sifive_ccache: Use of_iomap() helper
Date: Wed, 10 Apr 2024 16:22:04 -0700
Message-ID: <20240410232211.438277-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410232211.438277-1-samuel.holland@sifive.com>
References: <20240410232211.438277-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies the code with no functional change.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/cache/sifive_ccache.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 6874b72ec59d..9833e9f6f36c 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -288,7 +288,6 @@ static struct platform_driver sifive_ccache_driver = {
 static int __init sifive_ccache_init(void)
 {
 	struct device_node *np;
-	struct resource res;
 	const struct of_device_id *match;
 	unsigned long quirks __maybe_unused;
 	int rc;
@@ -299,12 +298,7 @@ static int __init sifive_ccache_init(void)
 
 	quirks = (uintptr_t)match->data;
 
-	if (of_address_to_resource(np, 0, &res)) {
-		rc = -ENODEV;
-		goto err_node_put;
-	}
-
-	ccache_base = ioremap(res.start, resource_size(&res));
+	ccache_base = of_iomap(np, 0);
 	if (!ccache_base) {
 		rc = -ENOMEM;
 		goto err_node_put;
-- 
2.44.0


