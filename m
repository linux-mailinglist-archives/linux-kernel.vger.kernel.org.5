Return-Path: <linux-kernel+bounces-110605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A32886131
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F6A1F21AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560F134420;
	Thu, 21 Mar 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPOidhmQ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33B1E500
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049950; cv=none; b=hQnwhuFYJWGP/0t9kLsV1R43r4TyxsPob26jgKnD2SO+qbo/zQ5ypXsNAu0xEfrzPeDIBIYiOsWHsKwpGvsTqqpzP/PgbQcsd211LWbUBXt2dxqki57Ugf2hgV9/vDXWTCTlxkeiA+5GZE3LZdik+0X+j26dq9ZnOcweQhb4Quk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049950; c=relaxed/simple;
	bh=ZWs9MGmoEQmOULNBWO9zIf+jgNwwwIuWqfOo19Mn/X8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EmswVynJJLTt51q+52KsXpct8Ay2ya2d6N3NLWSExSTHeFSGr5QIMaDM/rplqYZ++Sl1kY0JNZDTxG2xgjcbEn31WI8lCoNepRpJ9QjDxurqp4kvHW/VfrLmMNeY81ooegxC3J7JBQvFJNBlZUCfSxVKFNfvbh4BSX2jEjbWFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPOidhmQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so1147744b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049948; x=1711654748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GjN88eAgX+ChV3wXk8WomMcLdGGxDAjAjqUJdjdhg/I=;
        b=GPOidhmQRnGjqMW9FsjiDzDExMqA5QZKh0JlYwLuJCr6//x31ijVqPbMPNeuU8dbEa
         4mSo8o0y3pC22MB8pFsI3AS+KStDgW3mBBke0xuEYuzIlfHy9kMu/qaa+G5Tau8aX8o5
         6LiQiBPPFQtqeWAvFUao8A/hR6oCdLLSoTQjasrIMYT4y5vdw8mMUw2xGXkb6GTPh7ZC
         RFgJ5au8oTcVKeeuXdLEGreldLfUMSOjbOOcZE0AfB09JUrYLVbh8bGnJcJkjfXiLzSy
         37pGkqG070L/bt5tAsu/e3KXfUVbzG45u0ZFfwxXdFD33Yv8E701nxaWJlH0nMOzWJIc
         ZU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049948; x=1711654748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjN88eAgX+ChV3wXk8WomMcLdGGxDAjAjqUJdjdhg/I=;
        b=hw97iTpWXdn1H1cyJdZsQ1SMbI9iQ/o+SiuYuzaP4RoU7LmC9IsEZJ233LVmBhl3h1
         lZStjplfT5pvIBZgLjW5UzM5QeArzO7pFzU0/BgonCagsjzYdeiBbdTGUbU2orec9RgD
         hN2HCTRoKLg2pUpDl16zoymOKCZWt4biGXzipPmuoOE2tBifTrcFmRfD0BbIcQrZ5MSX
         MpfjBp9ZHBC5nFfF8Ekm9aoRowupjT3DoKQpECbGiU/hDTQikZxQCTH+5GokdcMfwO6S
         Q8td70CdrqF4PCLHaUyJE/aQZGmojpYI6V6CFj9a82KuWnh1HlxirZLkIGSsMNHcTNFd
         Vb/g==
X-Gm-Message-State: AOJu0YxJhBh9/HolMpG0CpuMY+ZVuKqjVmsmDZkd0lGorjZzKVI4Sf7z
	UHWby9AC/GzLSV89uyekSe4zGTtew7FuqrSuRch8Z1bfdsWthc6haAceuDzE
X-Google-Smtp-Source: AGHT+IEwmW6Gi0aaz6kBihV8/J3sHQPsF5Lqp3kXyvg4jTlLatzJyJI84wwpfBKcP6OtdHhxPzWdZA==
X-Received: by 2002:a05:6a21:1a5:b0:1a3:3cba:816 with SMTP id le37-20020a056a2101a500b001a33cba0816mr620360pzb.45.1711049619001;
        Thu, 21 Mar 2024 12:33:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7854f000000b006e681769ee0sm206280pfn.145.2024.03.21.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:33:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] nios2: Only use built-in devicetree blob if configured to do so
Date: Thu, 21 Mar 2024 12:33:36 -0700
Message-Id: <20240321193336.1708790-1-linux@roeck-us.net>
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
 arch/nios2/kernel/prom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index 8d98af5c7201..a7cd76b322e3 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -30,8 +30,11 @@ void __init early_init_devtree(void *params)
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


