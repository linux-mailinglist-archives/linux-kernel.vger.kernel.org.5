Return-Path: <linux-kernel+bounces-60696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0D8508A7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632991F22700
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F3C5A4C0;
	Sun, 11 Feb 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnU3eqby"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AF59B45;
	Sun, 11 Feb 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707647972; cv=none; b=O7UukPgwVBx2NXHzZ1PrxqihLb7LXwZ7JK4neCUKjd3mcvluub/JgmeGZ+k5cU3ZlUOl6G9sV6D84+wkjfGAl/GqMp399Ge/HUZ6R8u6SWyFmGNCqmIDoRANYY8c0b5k1CQAGk5Cwa7/7YlYoz2h/xNJqx/pCogOc2KkTedW5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707647972; c=relaxed/simple;
	bh=m415TQ2f6zPniNTVAv0NuTKu+4yIMix/PsLmcmvOR1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KckgnEZQZyk4uFcAtbICR1KcbcnL+gGf7Yd4pF9UOA9LH6P3U9i+h4kdt1vmMJ9Te5zVqKkQakDmlzFxE21uqeJpw2CcPsdRYEhUtit30NGjb6axpq1mcYnhaFU1gGqYDbSB3qyJiQmZZ1mfZlACWaM6qY2Ao2hWl826M9Dvlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnU3eqby; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707647970; x=1739183970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m415TQ2f6zPniNTVAv0NuTKu+4yIMix/PsLmcmvOR1c=;
  b=fnU3eqbyBf3P1dAgAiE68fFNoY9zxqu0WmtCXDDpWysxL6BJC8IT0uGT
   Tzvm/kMep3P9HnFWyAJuBDGH4cji2T+Q/fXXV6A7Cqb19pvjOSIyfxIsI
   +eiMxNhQ6wm8UbiTDm8vR9csELZ2mQtFaCHkwfpGnKnSaE9/yJulfZJnv
   5XRzh4qFSmTk/DM09I/aBGUqRUaw+G65Rcyf9ZRTIh+OfhKMuygYI1zcF
   AQGa8vwVupDADO+KakK6zGkc2BFGPmyjkW3DDivb6gHpIO37ymhiML3Yv
   ySohXMlLc4ei0Oa52Dfk3CMJMpNFHu0sIztKlaQLWrHt1ZhCmSGE3TMx2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="396053097"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="396053097"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 02:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="2631665"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 02:39:28 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 1/2] mei: me: add arrow lake point S DID
Date: Sun, 11 Feb 2024 12:39:11 +0200
Message-ID: <20240211103912.117105-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add Arrow Lake S device id.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 1 +
 drivers/misc/mei/pci-me.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 961e5d53a27a8c4221b4b33c..b10536e4974dbdeed046f4f0 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -112,6 +112,7 @@
 #define MEI_DEV_ID_RPL_S      0x7A68  /* Raptor Lake Point S */
 
 #define MEI_DEV_ID_MTL_M      0x7E70  /* Meteor Lake Point M */
+#define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
 
 /*
  * MEI HW Section
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 676d566f38ddfd2cbb5c167f..1a614fb7fdb675e77bcb6be8 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -119,6 +119,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }
-- 
2.43.0


