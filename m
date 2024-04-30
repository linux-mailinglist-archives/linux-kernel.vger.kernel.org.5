Return-Path: <linux-kernel+bounces-164746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F68B81F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBD1B2202E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2391BED7B;
	Tue, 30 Apr 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jhwOjB2/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811F50287;
	Tue, 30 Apr 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513003; cv=none; b=XDGbQo5lzLUVxmWrNJzNX1xAla36+G0s7TD71hOGjGZUG60XKLepqKoxjHSu5IP6aRRtF56mz5tUCqJRwQNQfxZ5GcyA5fmzQs+AxVOMPdp9eDWRm9bq3WJZdxpZarY8NRiZD1BOtoolYk1giy+MILw1A17+qjLCRI0rSROU/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513003; c=relaxed/simple;
	bh=0Qj+D69jEcpqaHMFgZ7FoyOuv7/ML8F9fuodPYJB9X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq/JYKj89RsiX7Na5kQpwXlxRswsUMFTZMoS9qj/mH4nwUDjGQOlKy9LQ1LWsFsC2eIlcBj3J/QHhordfRW2RWMdPnlxKv2p3jsX5aKku2ssaVmHpunuUNM4DaHZLallkDOjpVVxMKsPvs0D3YwIfcmziHUOIFrzPGGVuL35/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jhwOjB2/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [109.130.69.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7CA0966F;
	Tue, 30 Apr 2024 23:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714512943;
	bh=0Qj+D69jEcpqaHMFgZ7FoyOuv7/ML8F9fuodPYJB9X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhwOjB2/QdCt3pb/4iqM21+Dd2f4UA25f9N0jpS19nz/XOZqWjsW78VJxUafll4+2
	 fHaBCkbVwYzmnSNDhTXm6V7x+My4iMitDGRTMG3DG/fi87msmsO0+QiNEsnwkN02XL
	 KkkHVaso2cwBUUW2SjUaY34/CZZyK2w/O3zLUZ6I=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: bcm2835-unicam: Drop usage of of_match_ptr()
Date: Wed,  1 May 2024 00:36:32 +0300
Message-ID: <20240430213633.23767-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com>
References: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using of_match_ptr() to set the .of_match_table field of the device
driver results in the unicam_of_match table being unused on non-OF
platforms, causing a compilation warning. Fix it by dropping usage of
of_match_ptr(), which can be done because the .of_match_table field is
part of the device_driver structure regardless of whether or not
CONFIG_OF is selected.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404302324.8aTC84kE-lkp@intel.com/
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index bd2bbb53070e..c590e26fe2cf 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2733,7 +2733,7 @@ static struct platform_driver unicam_driver = {
 	.driver = {
 		.name	= UNICAM_MODULE_NAME,
 		.pm	= pm_ptr(&unicam_pm_ops),
-		.of_match_table = of_match_ptr(unicam_of_match),
+		.of_match_table = unicam_of_match,
 	},
 };
 
-- 
Regards,

Laurent Pinchart


