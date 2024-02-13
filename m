Return-Path: <linux-kernel+bounces-64453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED6853E89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212162921AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC362168;
	Tue, 13 Feb 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9BCO3Pz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63E62143;
	Tue, 13 Feb 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863044; cv=none; b=uF39VjHatjixsr5tlns1YqCEecFnE59JTdorp9yi3qdIYdhQiUnFi/eGxda6vBQhYOyS9eNf/lfS2Miz+X943qjAmb0OyeVMk0inORqP3DoNIoN6syMyKnMod7kPr6iLOQLb8w4DaWCPTSPccluZoGcZn014PlC738erNULT230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863044; c=relaxed/simple;
	bh=Q7yhFk4pX598SxD0gAFPG2cq1/Q1XfZlHBopnV2lvSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h2gZsGGMXBreQ/iJ2Jgfev0gtgwOtQrWfZIOSHtLBJRZzEnyRSEWZTqNLxpMqYMR/r4gALYJSE8UZqepVwvd2RDrUmcANjHsOZfmFkRb8pKB1dJZW0yxzeQSWwF+L6vIZ96UknkAigGxMtq5HNPeelqiiLmWnC03pSNTR04OXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9BCO3Pz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1db4977be03so1358845ad.1;
        Tue, 13 Feb 2024 14:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707863042; x=1708467842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmPPVce04OmE6pjEU+43mxBTewwTDrSldoXWGdB+S6k=;
        b=l9BCO3Pz0ZgsT495TmCSyhY3gxKFVIbTkUt+b579x2/EspyUgVlauHdFgqIaMtS4eQ
         PAuuPlbLHPwxun5JG+ANZhEjIkMsQCiA7td7T2t5yo1t2Mz2Bgyhyh7cj6ur65wEdfho
         CavI1O7VfJ7tmXe/qB4iXIWhJUoLQOKJbZzHbCSEwnWxgvhV/sHh/kZnZxzYSN8l1ha3
         T0foq+UlZwxUa0wJS4QGA1PktR4zDWDQpEmWXuPCV6YN97vUzVFcRGV+vAKBarVgpS38
         IbinwudBLUnkTqa0A4QfpbznUGPilicQLhhrclU8Km1smXcndZjaIJSItZXLFFXa+l/h
         Vn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863042; x=1708467842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmPPVce04OmE6pjEU+43mxBTewwTDrSldoXWGdB+S6k=;
        b=Mh4smeMEJzFOXnfeld4xukjlFvfzj5ajAxStxsAMknkoWYKvo+4q3O5SjYrmKw7VbU
         zzJImmV4EMeR+qbu2HplXD86tcwycN7AMJCBSgBr5G8cYp15qqDf5DgXnjwcBRxKIo63
         D4o2C7MZXtTjgGANRg9G5cdXDkoHYh/lfJGAKwIuTJXaxYH7CqxjsYjTCIvaaSi4frUI
         Moe5NhHBJr0fpcAhItj4+k8Eqg4dhEVceMN003E8AiyduXnMymuODz5yJxjGT20DPJ0f
         YWzNSr2LUYtXsJtnWJ7jTCthnyHn2T+iTS2/7wFKpZagVIgEYTuPzPHPBpyyXr5OjKW6
         x7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXObQ8ObDVphZM1I+qOZHYJJSux7AfFz1H9EE6Pv/p7tCafr3+aIMXrvFIED8Uati4gUy1E2ez4t23vPu+KZygXqRmyTjU5MhNT03BZr4IhJ7Mas1OTa+oG7nj2MJkAaZRaFkEB
X-Gm-Message-State: AOJu0YzV7lllYBBhtP+s3ThMU4ytnZh29XfGB7UtRvy8vd4krPiGqD4t
	9Lje6gsrNrWS/CPJHDfoRRmU7YSLnuHkHfB7Cm9gHjivRVvnxA89
X-Google-Smtp-Source: AGHT+IFxIAWWVA/VRD5OF45TafGXBeA6kTytVJZ4XCV0BD7jXp9sXvvd9vxhEfjWFzOQ5wMefamshA==
X-Received: by 2002:a17:903:1207:b0:1d9:5ef2:a562 with SMTP id l7-20020a170903120700b001d95ef2a562mr254090plh.10.1707863042047;
        Tue, 13 Feb 2024 14:24:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkwRA7jCuQUCYvCGX5y6jn6WOIQAvqoxyUJoInq4shQ4oAEDnLQTAPlD5c21AXpe6neVlVs8ycyq3JJnMxxjgni56SX2HHl4B9Ccyx0xyihpZAVOsLAm8aSXcw7XeXKz6oX2J78DxbcSSsaVEMpBbJ4s3Sg+7dgcIjDFxyrVdEAzgmFbYV4ZVim6aIQNp1Ly/aADUy0iqKskkXYV+Vb9zvBloQIeibN6GLC4r7OruA68stA/e2U9hYUZBQzvZk4N0RaA4YmTxM/PTi8TEvpCugz7PUwikVUoAeWnM9iy88TNhsknuF9BgDcvw=
Received: from jmaxwell.com ([203.220.178.35])
        by smtp.gmail.com with ESMTPSA id iz21-20020a170902ef9500b001db499c5c12sm776490plb.143.2024.02.13.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:24:01 -0800 (PST)
From: Jon Maxwell <jmaxwell37@gmail.com>
To: jesse.brandeburg@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jmaxwell37@gmail.com
Subject: [net-next v3] intel: make module parameters readable in sys filesystem
Date: Wed, 14 Feb 2024 09:23:44 +1100
Message-Id: <20240213222344.195885-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux users sometimes need an easy way to check current values of module
parameters. For example the module may be manually reloaded with different
parameters. Make these visible and readable in the /sys filesystem to allow
that.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
V2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
V3: Correctly format v2.
 drivers/net/ethernet/intel/e100.c             | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 01f0f12035caeb7ca1657387538fcebf5c608322..3fcb8daaa2437fa3fe7b98ba9f606dbbb1844e58 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -171,8 +171,8 @@ static int debug = 3;
 static int eeprom_bad_csum_allow = 0;
 static int use_io = 0;
 module_param(debug, int, 0);
-module_param(eeprom_bad_csum_allow, int, 0);
-module_param(use_io, int, 0);
+module_param(eeprom_bad_csum_allow, int, 0444);
+module_param(use_io, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
 MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4df8d4153aa5f5ce7ac9dd566180d552be9f5b4f..31d0a43a908c0a4eab4fe1147064a5f5677c9f0b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -202,7 +202,7 @@ static struct notifier_block dca_notifier = {
 #endif
 #ifdef CONFIG_PCI_IOV
 static unsigned int max_vfs;
-module_param(max_vfs, uint, 0);
+module_param(max_vfs, uint, 0444);
 MODULE_PARM_DESC(max_vfs, "Maximum number of virtual functions to allocate per physical function");
 #endif /* CONFIG_PCI_IOV */
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bd541527c8c74d6922e8683e2f4493d9b361f67b..9d26ff82a397d4939cf7adea78c217e4071aa166 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -147,13 +147,13 @@ static struct notifier_block dca_notifier = {
 
 #ifdef CONFIG_PCI_IOV
 static unsigned int max_vfs;
-module_param(max_vfs, uint, 0);
+module_param(max_vfs, uint, 0444);
 MODULE_PARM_DESC(max_vfs,
 		 "Maximum number of virtual functions to allocate per physical function - default is zero and maximum value is 63. (Deprecated)");
 #endif /* CONFIG_PCI_IOV */
 
 static bool allow_unsupported_sfp;
-module_param(allow_unsupported_sfp, bool, 0);
+module_param(allow_unsupported_sfp, bool, 0444);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
-- 
2.39.3


