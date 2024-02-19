Return-Path: <linux-kernel+bounces-71377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B085A459
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659EB2812B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B609364A4;
	Mon, 19 Feb 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLfi3+0a"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5492E651
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348067; cv=none; b=ludzByorIUtxBtwZLhLOXPchTbTrW1lapHwzfJmkbj8HWOh8UE9whkJHBi+7lMcXtUtUfGytQWrPTTMFZaQQymYrEDXdIwcgLNC2KenQWQD3aFILDUvMNpWu7WW7/VDyQzVpnxZwZvBFCLJRMytPrM+lSkC9R1ycEKWSmsidzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348067; c=relaxed/simple;
	bh=4B1hENKiAQ5A7FWy3lecw1iO5LY3wMhnaw8pz3g9UCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozwXqDNYq7i5xWRJWBQ7S+jrZyY45yqi0xpgwAS2NfAqCx9KfXgiUuPtgRItrlW1OEm35AFQyF5GGP2PUjKHAgqtRTyuHC7i63F56+KASCakJMhCEV4hPAz3x1sOMzydEGqd3tvJ3tQJcql30MJHNAYvjkVxFTonfwMwwKPdrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLfi3+0a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d911c2103aso22069295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708348065; x=1708952865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxjSDgN8k5Eq9QSDrchwS/jkSu2I8H4NnMpDWLp/M7U=;
        b=KLfi3+0aa/5DlyATjTMus58kj8J88SHpcgl14BTjGnSUUIQ3LxDcLj9djRgXCX0rC0
         x65ZUoVXbxU5zGxOjkDTLbHSQMuyY2ubcGvw3tqkts68XoKkdBbB1OAAblABad14OQFs
         JV7hliOdvB3qb7tPYrYVrcrSn202zfzad1zLQQ9iLe78U8lVBDb2kl2QGNqpZafm56ko
         PuITmkdZIlDkvphN31L4vBfK+GXPRA8s3h5jklSZBpJJzjpoBDnftSogD+gosMRu4ZSa
         VGDnoyk5YRBZzsfjsI5ZsCzURAeeM+P5kK209WaWBAt6At1bBUX2yNHZFH6n7dyYb2JU
         V5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708348065; x=1708952865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxjSDgN8k5Eq9QSDrchwS/jkSu2I8H4NnMpDWLp/M7U=;
        b=aDkgS88oIJIpbZc2ewBfXHi8130s85wzun0Fqf1pGsjFIqzHfhfExVT3GFog8sn2px
         V1D3wE6xonw2JV2tRPKDMQ/H6rjZ4UmngzXTFaboG3xzqMBnQ0M3nOO2soF7ksFitvs2
         lAyvIYmr8Of0Mwu+S++rCkklZqrCtPmL7FsCFi8MGlU62em8lLpq1hf1GmmJWST9Ij72
         VSFT3ZXo83D9CHylX+/iSgLpa8YOTmy24rg+mbrh1Si8omJWiQXe/5MboKLF4ZbkCICK
         OP4Z6fVgcIHmGjhJXVsmjLyAzLgQ2Ci0J4jF/TfkgikZwMigIt2ItsTTBM6vq2rF7EI5
         PX/A==
X-Forwarded-Encrypted: i=1; AJvYcCVGstiHB6lHgHVaVS1oOyPUc3h6yEGcygy6GFW5Zd0TwzbfoqtsYuKV7uvQDsb0WD+Qn5sM2Ldg/gbJgMLqevGD4TdbGl3mclTWZYiZ
X-Gm-Message-State: AOJu0YwuyMuLetwnEdZR5p+jSRkCg1CiMfa/SA46OkAI7/kr9HCbPBuu
	k22jNDf/r13IkKHubJzoLxQDrGVpxKRX6KgaWQmqT+ecVC+zcP0S
X-Google-Smtp-Source: AGHT+IEdlidlo/qLMZeFXhrIxPnycgSh09VpERMsTrQCueAFnlaWgozk1tJYjPE7vjToJHFZpNo9Tg==
X-Received: by 2002:a17:902:e84e:b0:1db:de64:97ac with SMTP id t14-20020a170902e84e00b001dbde6497acmr3715030plg.15.1708348065142;
        Mon, 19 Feb 2024 05:07:45 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902d28b00b001db40e91beesm4352633plc.285.2024.02.19.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:07:44 -0800 (PST)
From: skseofh@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	rmk+kernel@armlinux.org.uk,
	tglx@linutronix.de,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daero Lee <skseofh@gmail.com>
Subject: [PATCH] arm64: remove duplicated early fixmap init
Date: Mon, 19 Feb 2024 22:07:18 +0900
Message-Id: <20240219130718.2491496-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <skseofh@gmail.com>

We call early_fixmap_init() in two place.
- early_fdt_init()
- setup_arch()

Because early_fdt_init() is called before going to setup_arch(),
early_fixmap_init() can be deleted from setup_arch()

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 arch/arm64/kernel/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d60..ce45f4a9ac4a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -305,7 +305,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	arm64_use_ng_mappings = kaslr_requires_kpti();
 
-	early_fixmap_init();
 	early_ioremap_init();
 
 	setup_machine_fdt(__fdt_pointer);
-- 
2.25.1


