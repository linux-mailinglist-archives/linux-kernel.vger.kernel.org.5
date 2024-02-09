Return-Path: <linux-kernel+bounces-59647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB984F9E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BBE1F26FEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808B12AAC0;
	Fri,  9 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OME2SHjO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F4128382
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496878; cv=none; b=Fvz+sjklBG0L33qxdPZY/xu0URAyIaqlQhfzh89D9ILqBzexQhebv632p1IJoCS9xuAqbDFOIFaCN3hfqZRDYHj47Btkgliyd6DY1KhO7XYEvKUu+nXMnbYAQlua+1afOBJCg+D0euEGa4t2xIW1tGBRJGDGs8Uvr+Ay2ehnS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496878; c=relaxed/simple;
	bh=FaWrvDRhCn6qo66e2LFY1/am/fRiqeQ00xmmtBjY9fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSOfT089iQkWMAUSmNuun8PmAvD0pWGOmhePWcBDE4tWx4OJVJd/VIek5btSbRRLJ98a8unF78EszKGV524FFDqMB1TdTvluEf7OuGhExLoOeNyerP6tSHQTaQIzRj5m9GROnMAa8N8R+crHvmivUc/qTysXAUsjpYYalQRuBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OME2SHjO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3be9edf370so113641566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496873; x=1708101673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=OME2SHjOEEnOIuVYv0xrxC4V+6LsLoundaWDtxAidJwQ9cLNawmYAAH2Y3uc7ylO4v
         qDfmdhlp9hy+Ukn9AR7NQzQx6VKdPr3hNvjWSHmB4ZXGPUP3Ur7jnj/KwtabSV6Dv7bG
         2TsRR4BAqVqtrO+1IPv+4DvX5bJNgJGgorfzxMdVvXZTkcNlbBT7afe2BJzq+VGcfDS1
         WLajWE9yqTQ08Kv1O6UA3hN0iZ1pvijEp2tBvW1a0AKy4omyg7Qjgo9QWilcdQVQcfA9
         lS7bkNOOP4iZS1bREsGrhH173/CJGiTuBhonSuISKnOeBl0xWVM0vWLRE8mYHRSnxoE4
         SufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496873; x=1708101673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhd0Wyk/ZgeZM/EU3KZ6LbkcM94I0OFOZkDaLa9LsZQ=;
        b=oobJ7tcudzroCn5HwDHpWk7iw/hTfOXVA9aLfAYdB1ZylA3Ql8X6Tw1cM9r0cIQ+M9
         rWKO/a/dmMAyRvpgw3asdmXwaFi/Sn2+2O7on+5IvVOu1VZAv0+Uw2hw+HLZlVlns1qI
         IzMWG7kKf0mQFHO1+e0VrV6nhSM/DeIpex3aC4JoIsQbKZ+WKYs+Gq9dHutaQJh6mWVN
         ULG1GVAGfMkfue7cPRgnvjFf+KEVk9qbawPMyTnQ2dVo4eMplVDndodkzYcGrULJraZ0
         7dCms+87pSziaLTe2VKyoK2SCrpD/94GEimGqFP90yIOnplpC7iu+rHY/RobOxsm+c7e
         BFSw==
X-Gm-Message-State: AOJu0Ywjl2BmCmN14A22z2q5ESpKREFsTTriRS8O9leX0uEakqW+QS4K
	V4CcDDhwlOpUGchCuP3lcxU5Y9Vm6kBBmnEwCNRjpwmNtcCm5AGzapCp1LF0+0c7JYidUg34NSK
	Q
X-Google-Smtp-Source: AGHT+IGc6qKoVSrXTWrVz/5SZ7bzl/yh/yYOiQ2+BceVCnIn0iyvL12zumI7r7tlFhwv3iqG2e4Y6w==
X-Received: by 2002:a17:906:1b12:b0:a3c:b14:32e with SMTP id o18-20020a1709061b1200b00a3c0b14032emr683223ejg.47.1707496873640;
        Fri, 09 Feb 2024 08:41:13 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:12 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 29/35] linux/random.h: reduce dependencies on linux/kernel.h
Date: Fri,  9 Feb 2024 17:40:21 +0100
Message-Id: <20240209164027.2582906-30-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/random.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 70e5250f3bc4..3183025ddda9 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -4,7 +4,8 @@
 #define _LINUX_RANDOM_H
 
 #include <linux/bug.h>
-#include <linux/kernel.h>
+#include <linux/limits.h> // for U32_MAX
+#include <linux/log2.h> // for is_power_of_2()
 
 #include <uapi/linux/random.h>
 
-- 
2.39.2


