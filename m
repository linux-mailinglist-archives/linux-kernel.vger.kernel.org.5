Return-Path: <linux-kernel+bounces-111035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C788672C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A336FB245D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032E10A1A;
	Fri, 22 Mar 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SReBjUEN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076FB67D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090470; cv=none; b=Ftn46q2eaxJnAlLxNlUbiJX9JTH5/RKqwTbPB3D5Nwmn1dFD6ZPJu73Zf6vWmzQdbiIIZN4a1avs1IYejMtV9SUz/wHi9qqtr7c2bPZNPMtZcj8FRVUhBVNA3VJUSkYHCHDINwdlruiQtErcn7SbBg3k/UYuVZA/BvztwXlf1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090470; c=relaxed/simple;
	bh=CwivtobiDV0JP5suaKdnRG4SEUly7OjQuKyLrbF/kJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQdQ0odQpMDiPuQxMtWCGN54G1CnUP1UmoJ5L7CMpeu7/AA6vAXNy8B2o2CxrptiZwGx/ZeNc7nBjpu1Mdlg8oAbufrzGANQQfDm9+Se3FV68Ih2MQbCCR+fAAmEjM9Suo3wOX3e4Yrv0Luuq0isvmcVCwE+4zRDpvKAk2ZfuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SReBjUEN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0679b1562so14636865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711090468; x=1711695268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X0mR9FBOo6PCCJK1XwCHn0BmyHsHKqqF1G8PPT7MSnc=;
        b=SReBjUEN+/iorPEv2jRb8plK3lS9Iu21shQpQmfzXiu10tFcA1ZwpTaGjHQn+68Rxp
         ZW8e7bxaPshHVGxwUjN0MZfkLae9ircslPGEiHbSzevgKKkTx0WdzUYXX5wKnwgNZ7qn
         8KY2beZ+TVILfBdRnPwol9cHNTwaCKfKPk5HyHGXtObw6Dqk8PNEibSU5IbSHtEw/e3s
         HxMN/AVIS1JGACASjKxTXEAvN9+jZYGUm6exSntbbOX5YsGaq3tU7h+cvNGRTCAgb2Jm
         So7vMu3fD+R71GBEh3f+nTB3pFW3vd3U5faJkoeFqAQ9G7uXWH3sPjPECajnB4SrLrdy
         jcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090468; x=1711695268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0mR9FBOo6PCCJK1XwCHn0BmyHsHKqqF1G8PPT7MSnc=;
        b=ZeF2UKSFT0iN0ZmAfuPFR867mcBmeN7M6rcOgy3M4ZRNMHmjce/Ym8tTSYWfsUX1w/
         8O5iA8zbjHMgbvvti4q/263WPA0cNEI1ilFQwdcYydh8hCiUP0KYGAWWSSZzJbr50c1i
         PXexDnEBZCXSUKhTxVHItamjZaeN7NY0KXnLcU/fYdDoWlGnQXAtfOOd+zNkMqwCfrc1
         hjgG89tn5nhTJZA0HXORYRr3cnj6e+oWr4wpIWjx4e5S2buLCC1cqLyJtbjOuPjFz07J
         NpW5KneV5PLndZrletFrT34XbcONkti/Eu3foMyfE7zK5RD67JP+BgkHSsFsUhIYHpeD
         uSbg==
X-Gm-Message-State: AOJu0YxjXZXEt2CZQODjmRQnhrYt0El73cU5vdd7fxkaWn9NpeoaJRVt
	B1epufikaQhSEBlhO1ojVGyQwk01fstWz3CTXg/m2nHDrK0AdVJJxE7Q6xG9
X-Google-Smtp-Source: AGHT+IGyLm625qbYLZcsvIXjqykpbRKd+VW055+PzbQFcO0QE4cp/QVWCWfXzfBpbbcFMhPscGTqEA==
X-Received: by 2002:a17:902:7c0d:b0:1e0:6a:1c01 with SMTP id x13-20020a1709027c0d00b001e0006a1c01mr1294269pll.52.1711090467505;
        Thu, 21 Mar 2024 23:54:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902c94e00b001ddd6ba8113sm1076851pla.207.2024.03.21.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:54:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2] nios2: Only use built-in devicetree blob if configured to do so
Date: Thu, 21 Mar 2024 23:54:19 -0700
Message-Id: <20240322065419.162416-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with commit 7b937cc243e5 ("of: Create of_root if no dtb provided
by firmware"), attempts to boot nios2 images with an external devicetree
blob result in a crash.

Kernel panic - not syncing: early_init_dt_alloc_memory_arch:
	Failed to allocate 72 bytes align=0x40

For nios2, a built-in devicetree blob always overrides devicetree blobs
provided by ROMMON/BIOS. This includes the new dummy devicetree blob.
Result is that the dummy devicetree blob is used even if an external
devicetree blob is provided. Since the dummy devicetree blob does not
include any memory information, memory allocations fail, resulting in
the crash.

To fix the problem, only use the built-in devicetree blob if
CONFIG_NIOS2_DTB_SOURCE_BOOL is enabled.

Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware")
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Mark 'dtb' as __maybe_unused

 arch/nios2/kernel/prom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index 8d98af5c7201..9a8393e6b4a8 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -21,7 +21,8 @@
 
 void __init early_init_devtree(void *params)
 {
-	__be32 *dtb = (u32 *)__dtb_start;
+	__be32 __maybe_unused *dtb = (u32 *)__dtb_start;
+
 #if defined(CONFIG_NIOS2_DTB_AT_PHYS_ADDR)
 	if (be32_to_cpup((__be32 *)CONFIG_NIOS2_DTB_PHYS_ADDR) ==
 		 OF_DT_HEADER) {
@@ -30,8 +31,11 @@ void __init early_init_devtree(void *params)
 		return;
 	}
 #endif
+
+#ifdef CONFIG_NIOS2_DTB_SOURCE_BOOL
 	if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
 		params = (void *)__dtb_start;
+#endif
 
 	early_init_dt_scan(params);
 }
-- 
2.39.2


