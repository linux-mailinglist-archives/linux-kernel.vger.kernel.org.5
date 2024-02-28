Return-Path: <linux-kernel+bounces-85651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8386B8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F71B1F21A89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5075E082;
	Wed, 28 Feb 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBEQZvUX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD55E069
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150258; cv=none; b=De8vSGxOK9P4ZLIqUI38VXa1a6LazFdbEmfTbWZRhYjG3yWC9ZjvsQQVydd8J5xwW6MOq4iPJAuEVaPgjiALzSAmRfQqaH3EsHivSdXC5HUb7uO3F2n8xHat0HXwfnr5Vq6gjDlXhqzNmfjNn0C6vc/BQnTHj5RAitS/8J7Fjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150258; c=relaxed/simple;
	bh=SMOG+WsxxxrRL58uOoT/CELvWopH124sOV3RAvVE4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fx8hzJVvBO4Rj5GEeTwcqhbKm0DtfapK6eW3dNRZUYu1Zcu1k/nMmEMRGIJ8ugsmVSiey20LVkL1cMxC/PhnF+zku3PSBX988wo+vVPLUVRlxC5fZAi8JLyxKjsl4uVTuabYho/1hdLLwVqi3qSsGqndbwhc86sxB9uoojhovK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBEQZvUX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709150257; x=1740686257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SMOG+WsxxxrRL58uOoT/CELvWopH124sOV3RAvVE4R0=;
  b=PBEQZvUX6pbofO4KqbQWixeHcyVjNQmVjiuT2n6C6TV/EHi0LBj4oiCu
   TeLwutZ1HNDXAGyho0ZoyqoxFHqQwRrv0xv4xqUUzG8s67VXk3lKQDVIz
   xYZa2q2Ohh3b3Nkap/cMGXw2tlOP06yzwt2CUNEnb0zHKKheyKSb9om95
   l/UGElFsO/z6c+8WBvsHR03FdFTUcWNByL7KJVuctEpaTIsOzJpldvkgx
   0fA/cUk9B93LRAhh+1EMjjG2q0wkBRKgyZ+g/6kN9p6MotRGtfkRwFa5s
   FTr+y9bqUh8PFXPevw+HFxRv6jEuC/uJwiP12O9CG2olQ3pnMV+SeJyr8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14992993"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14992993"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034612"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034612"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 11:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 49DFA1C5; Wed, 28 Feb 2024 21:57:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen Jiahao <chenjiahao16@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: Support Opensource <support.opensource@diasemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regulator: da9121: Remove unused of_gpio.h
Date: Wed, 28 Feb 2024 21:57:30 +0200
Message-ID: <20240228195730.3607154-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/regulator/da9121-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index b551a400bdd1..5ee76b533576 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -14,7 +14,6 @@
 // Copyright (C) 2020 Dialog Semiconductor
 
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
-- 
2.43.0.rc1.1.gbec44491f096


