Return-Path: <linux-kernel+bounces-67860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096788571F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD896281E82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D677146916;
	Thu, 15 Feb 2024 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NnmohOhU"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392F146011
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040992; cv=none; b=re0SI0bM86R/H1xoFaEmKKfaOWLvr/BRoNY+dxwSfHVEgLPb7c/1tikskFC0Ym5gPUZwyg28YBjHipMCF0Ga8tuGTaHsiC0D7+U1w7BywCgR8smTRQnS3MRCh70omY72xWCmjNozplNODOaSki2nNGnJNpt2ziSmouoLGszWMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040992; c=relaxed/simple;
	bh=PHl9FCLkfWKFMQFCPe17LVMkAUORzkZKTisWv/34xqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiy8SDka6+SDuNzuI0GCNI8OOHKLYyeIqla0EBJizxpSNWQaaJ61qYMkQmAGM12CO1gLwhTTMV2UHEFKfa+poQHNxZ/VNFGiwewKs3AqO+bY4LcC+3jcKGI1p2ZeyUhoj9RfUKd8JrXVDJ/jUVmRddPDTivRqC/utgz04K/1guA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NnmohOhU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0f5934813so1224104b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708040990; x=1708645790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rifv2r9AYOj+Pzx28lr78UDT6/TFCnKPoGuCgecYqhQ=;
        b=NnmohOhUM3iGX67CcZXuzgm5fCfAeuRVdd1d/4cqLTe1BRAJ8Yv0hNMVwNpNgzgbDd
         lGoDg2q7T5zvm4gagiDV2Y/AWc+cWIDT8YqimB1mtY9SnN2UyLfocGgThkXF5DxJ8iuZ
         0r0MN3vtnOYTzjJty3jbQiXMtby/S+3H8EOpdaCEgqRNAFjbFiFc/rtVmqHlEdLRryRd
         WE6Run3BqyhHir1agZFBUsHD1SgUI4bJ168gnvNmWhUlrrPHVreVCTDKXCgWSnyfYxSB
         zYSgQGvNObf8Xd6CSK+msQ/NYs5UTeJtzmdPuR80VBpEMaWi3bbTTiCl/VfVv3se2fg6
         4Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040990; x=1708645790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rifv2r9AYOj+Pzx28lr78UDT6/TFCnKPoGuCgecYqhQ=;
        b=S39O9zF87tlpZdoTlWkNACk6PXQ3hPp2EAvsKsI4gut1lhVs472duXz5HWS6Iv6VRI
         1EaNovPL14IFPWiRmpxMdckttz4o0sCgFninmqEoq8itaglWpZLiurDE252OB9Ymp4S+
         d/OXwZcCWaaESHXVC6HB30SA45NvNoQ5uxewOX7mYVtFTPGVBfeJeoMR8JnBzb9nzdBB
         YjgO5eGQ0kw4jMeJdnEYUd2/qnclUzxUFb0m4H3BnufB3iLX3EBbuEDgYDwGej0Vnyg/
         fNKFtcfz9RSGbihiNOR8jirJID0KCh8lz5hCvLIhh5GFfGSkWzyLX3hnSn6M2boQJfy/
         TW/w==
X-Forwarded-Encrypted: i=1; AJvYcCUaDY+uAmu3PCKAjTAcKXU3M2yezXgYdp8dMtamZvbTTUOOYK1SMHXLnynaA4tuwFxcvxkDYClSw8gC2VPvLcGdzZp05Rl3/f8ktte/
X-Gm-Message-State: AOJu0Yz6HuurOIncwwycEcD3mAYMYwd5jNe0JEhAwBZlTKRqFvL5urvG
	g5UvND51aTPDZaIQ0EOXX9NpwbxF52z3kxhsv0kTMppZI0wUOptNcv9M5aB4q3wT28RJpfpJXAZ
	0
X-Google-Smtp-Source: AGHT+IFQ6beUFzBYt5s0oSfunWfGOxdy7IjhnlyCNClELPZW6125cIlESnuKiwnVj+4uUVw8TdTwMg==
X-Received: by 2002:a05:6a00:6c9f:b0:6e0:a30c:8c84 with SMTP id jc31-20020a056a006c9f00b006e0a30c8c84mr4257355pfb.1.1708040990183;
        Thu, 15 Feb 2024 15:49:50 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78488000000b006e10bfd6a88sm1855529pfn.69.2024.02.15.15.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:49:49 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Greentime Hu <greentime.hu@sifive.com>,
	linux-riscv@lists.infradead.org,
	Green Wan <green.wan@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update SiFive driver maintainers
Date: Thu, 15 Feb 2024 15:49:11 -0800
Message-ID: <20240215234941.1663791-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as a maintainer for the various SiFive drivers, since I have
been performing cleanup activity on these drivers and reviewing patches
to them for a while now. Remove Palmer as a maintainer, as he is focused
on overall RISC-V architecture support.

Collapse some duplicate entries into the main SiFive drivers entry:
 - Conor is already maintainer of standalone cache drivers as a whole,
   and these files are also covered by the "sifive" file name regex.
 - Paul's git tree has not been updated since 2018, and all file names
   matching the "fu540" pattern also match the "sifive" pattern.
 - Green has not been active on the LKML for a couple of years.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 MAINTAINERS | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..f1bbb0f82664 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1395,6 +1395,7 @@ F:	drivers/hwmon/max31760.c
 
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Samuel Holland <samuel.holland@sifive.com>
 S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
@@ -16725,6 +16726,7 @@ F:	drivers/pci/controller/dwc/*layerscape*
 PCI DRIVER FOR FU740
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Greentime Hu <greentime.hu@sifive.com>
+M:	Samuel Holland <samuel.holland@sifive.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -19968,36 +19970,15 @@ S:	Maintained
 F:	drivers/watchdog/simatic-ipc-wdt.c
 
 SIFIVE DRIVERS
-M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Samuel Holland <samuel.holland@sifive.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	drivers/dma/sf-pdma/
 N:	sifive
+K:	fu[57]40
 K:	[^@]sifive
 
-SIFIVE CACHE DRIVER
-M:	Conor Dooley <conor@kernel.org>
-L:	linux-riscv@lists.infradead.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
-F:	drivers/cache/sifive_ccache.c
-
-SIFIVE FU540 SYSTEM-ON-CHIP
-M:	Paul Walmsley <paul.walmsley@sifive.com>
-M:	Palmer Dabbelt <palmer@dabbelt.com>
-L:	linux-riscv@lists.infradead.org
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
-N:	fu540
-K:	fu540
-
-SIFIVE PDMA DRIVER
-M:	Green Wan <green.wan@sifive.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
-F:	drivers/dma/sf-pdma/
-
-
 SILEAD TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.43.0


