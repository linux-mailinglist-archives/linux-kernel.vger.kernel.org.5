Return-Path: <linux-kernel+bounces-155801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC48AF74A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F76628E484
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223391428F1;
	Tue, 23 Apr 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dd9HRWcZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28D1420BE;
	Tue, 23 Apr 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900340; cv=none; b=EDIfdMyY958IaAdiVfPKhtsHvB0XJJwlgqMyPKKPvyYUZTvKtzhKf9sQwKzC8H3P07i1TpBqP+05MHBTkYyetQOO3jx5G5cTV2hWHMaKoM+QgRFMuDMjCOcecDOSKGDk8EjpHoqasQTT162eTkpfcEVvWItm0PB+D8R3klm31Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900340; c=relaxed/simple;
	bh=HTsoFANv6JLEmjESsOo2isIzkzhPyuPDbVVy0uob3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUahyauUKbXZJtvamDuR3BRSG0mek4KtCQZICaq4HWF3nkqCRrOmlPFMCIZOyzqfnRiOnQpg0hHnafG02NnxyIZysD0X1zAiSs3ZzxHK4Pl+/nEsLBO4epNCF5pevZQpnmj8fugDrefO8T53VdXIIdbBlC0We+iqlFx9fzNz09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dd9HRWcZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713900339; x=1745436339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTsoFANv6JLEmjESsOo2isIzkzhPyuPDbVVy0uob3Zc=;
  b=dd9HRWcZX3/ms1aRbxakX1QOj6C0zCAqtSh/v4JHZfmSOO4eDq7gui7b
   N33atfrgcTDjoZZrlh2HYVeVNMmHqJpHrS5Rf5MLxjKdt42YaYBmnrw7p
   rED8yiD8vKyMeGt7GPIcIgUu/Qbk4Zf+Ht+u0G0UV5WRmEYEVfzPNNQ4S
   9uK75N8QZBHVSDqXmmt/I0XAcenw3SJxd8uQNVAW1cpgP+NJEpDe4P/lz
   qacHf97ctaOH8ZPuFopmEd+GNVfOJEvyzxzR/8y/Q9P6v8KtVGgfC3to3
   AssZqeqFgb5DEmhFmlzfN5Gfgv7UOqCiQvBY3ciBhRIeDMLHHbnwiJp75
   A==;
X-CSE-ConnectionGUID: ScO76M7gR3utAaHi4ZSHBw==
X-CSE-MsgGUID: foEDc1I6SsmLfBo1RI8mtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9613689"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9613689"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:25:36 -0700
X-CSE-ConnectionGUID: jU9dTxssRxCDT9Y4mI+TiA==
X-CSE-MsgGUID: owZMSlD9QfSf3MU/LQ5KuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24440743"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 12:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CA0E244E; Tue, 23 Apr 2024 22:25:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Sean Young <sean@mess.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/3] media: stih-cec: Add missing io.h
Date: Tue, 23 Apr 2024 22:23:09 +0300
Message-ID: <20240423192529.3249134-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
References: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the driver the io.h is implied by others. This is not good as
it prevents from cleanups done in other headers. Add missing include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/cec/platform/sti/stih-cec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/cec/platform/sti/stih-cec.c b/drivers/media/cec/platform/sti/stih-cec.c
index a20fc5c0c88d..99978a7c8d9b 100644
--- a/drivers/media/cec/platform/sti/stih-cec.c
+++ b/drivers/media/cec/platform/sti/stih-cec.c
@@ -6,6 +6,7 @@
  */
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


