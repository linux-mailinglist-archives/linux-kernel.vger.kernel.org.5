Return-Path: <linux-kernel+bounces-111547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53974886D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CDA1C23B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0754647A66;
	Fri, 22 Mar 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQsu4f6/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEBE4644E;
	Fri, 22 Mar 2024 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114440; cv=none; b=UPyGjtWuQ5+GPy4O14qjprV1GEIrHJNDAAq9tETjj0ZCg4ZTku2eGi3PUNuV3182hN/YLUar6oRIvkntNHnX6WPMOGB9ZN12zS20YBD0o6o1g3NyqFT5GrtPdyiztbxRQn9RxFdfCabCfq74mnYoSvSAddp2dvW6vijf+f3VtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114440; c=relaxed/simple;
	bh=yE5wBVMHogIzvyyzaRHBTaXQJOP4Z2kLr8QtkZBlMWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aurM9xdxTg5wYWhJed07z4F89SE+Qxx/D9teTEqbdHScneKLRFpUJsu8gpQRN6BBPonzdkqbOiz6VO5uBwlFXXb+bAi/tSL3nbFjRAH9PxACMFDwJBFzeY4s4Jb4JgGsSz/AqJ2rh7hB2rQ2joBXW36zy8a2/ypuHxG125XhIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQsu4f6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10874C433F1;
	Fri, 22 Mar 2024 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711114439;
	bh=yE5wBVMHogIzvyyzaRHBTaXQJOP4Z2kLr8QtkZBlMWw=;
	h=From:To:Cc:Subject:Date:From;
	b=pQsu4f6/TGxgJUdcMFkAxMPrajaxaOyOog13LeTSk3cPTVDLMGblTTiDM/5+IUV6S
	 KP3VzkDWC4PmSLknOWUl7P4JNkTZol4Z5InmQ2mTE/gkNkzrbOy6tsmWkg9Dn00okJ
	 k1ZqcXjqBInIYf28SnleEBL2bnDYu/BIPMkB0GQjQbX93SH2iW1KCiOjTp4wS0beY1
	 TiJFn3cMN+oZpbHkchAWoyGp4+iPvZpJiBY+iWXKiAjjqQIyU/67wgQx6FtZtfe8MA
	 uZJ75XKEZOP9qOflsl2Uvti+1B17LZH1KaAucQi3VPYjkvtZte9gElSWq8eEUnGqGk
	 3195zj7iZOAoQ==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] media: rcar-vin: work around -Wenum-compare-conditional warning
Date: Fri, 22 Mar 2024 14:33:46 +0100
Message-Id: <20240322133353.908957-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-19 warns about mixing two enum types here:

drivers/media/platform/renesas/rcar-vin/rcar-vin.h:296:12: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
drivers/media/platform/renesas/rcar-vin/rcar-core.c:216:18: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
drivers/media/platform/renesas/rcar-vin/rcar-vin.h:296:12: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]
drivers/media/platform/renesas/rcar-vin/rcar-vin.h:296:12: error: conditional expression between different enumeration types ('enum rvin_csi_id' and 'enum rvin_isp_id') [-Werror,-Wenum-compare-conditional]

This one is intentional, and there is already a cast to work around another
warning, so address this by adding another cast.

Fixes: 406bb586dec0 ("media: rcar-vin: Add r8a779a0 support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There are only a couple of -Wenum-compare-conditional warnings in the tree,
so it seems best to just address them all instead of turning off the warning
globally.
---
 drivers/media/platform/renesas/rcar-vin/rcar-vin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
index 792336dada44..997a66318a29 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
@@ -59,7 +59,7 @@ enum rvin_isp_id {
 
 #define RVIN_REMOTES_MAX \
 	(((unsigned int)RVIN_CSI_MAX) > ((unsigned int)RVIN_ISP_MAX) ? \
-	 RVIN_CSI_MAX : RVIN_ISP_MAX)
+	 (unsigned int)RVIN_CSI_MAX : (unsigned int)RVIN_ISP_MAX)
 
 /**
  * enum rvin_dma_state - DMA states
-- 
2.39.2


