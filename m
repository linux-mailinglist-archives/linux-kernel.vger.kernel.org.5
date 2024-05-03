Return-Path: <linux-kernel+bounces-167100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B298BA48B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9812F1F243B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9523CB;
	Fri,  3 May 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GD7nNy8m"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0328360;
	Fri,  3 May 2024 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695954; cv=none; b=txVnfT+BV8In7KSdbEA9q5ID2S/o6j7C9EfnLlFBbi/THteTXNrKB0hyJZkyaavlArOXxQHJrU8ii6V2vkYTxX0ht0Gf2POsdXif57Av8ImCocWoITmALt1yEKzkHmgva6h7Ck/9BC+oHAcc+aKYoplFT+aWDRtUXdvhl5o7A7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695954; c=relaxed/simple;
	bh=45KVsPavME0yOw6bhV9PeCuFeCcVsOu/mDbkZWY1lpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OFEJ+cIN90FUeKHP6OgVtjXKvsCMkjJ8ML2Z6NNKKI1G/LYcp6O96XkGsGXGcS/W8frhMxq/PJn18O2+nUvz+D10HLcTMSLNn7rCwpJyvYk5R1kgAYL+xKFqsIbevbugCGKoj42Outp5g4CREdjTPlM4XDIHQ1OJjPikidx7pNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GD7nNy8m; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AA47DC0000E3;
	Thu,  2 May 2024 17:25:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AA47DC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714695945;
	bh=45KVsPavME0yOw6bhV9PeCuFeCcVsOu/mDbkZWY1lpw=;
	h=From:To:Cc:Subject:Date:From;
	b=GD7nNy8mbdjF4vleiVXgns7rM2qUp1FeZdu7J6PELYcEHuOFChAG8UCkXbmjKn4wo
	 VoFwIBPSfDwJ5k08DII3Hhm6/hRkEZzZBUfoE5xLif33Z08Nu5bweDE66wVdq/gl80
	 Mzxs25lO/Zo8DKjTPp8jHeu6aqbdjfCt0TQeoeXU=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id BBE4B18041CAC4;
	Thu,  2 May 2024 17:25:43 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jgg@nvidia.com,
	leonro@nvidia.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tal Gilboa <talgi@nvidia.com>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
Subject: [PATCH net-next] lib: Allow for the DIM library to be modular
Date: Thu,  2 May 2024 17:25:40 -0700
Message-Id: <20240503002540.7154-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
module. This is particularly useful in an Android GKI (Google Kernel
Image) configuration where everything is built as a module, including
Ethernet controller drivers. Having to build DIMLIB into the kernel
image with potentially no user is wasteful.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 lib/Kconfig      | 2 +-
 lib/dim/Makefile | 4 ++--
 lib/dim/dim.c    | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 4557bb8a5256..d33a268bc256 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -628,7 +628,7 @@ config SIGNATURE
 	  Implementation is done using GnuPG MPI library
 
 config DIMLIB
-	bool
+	tristate
 	help
 	  Dynamic Interrupt Moderation library.
 	  Implements an algorithm for dynamically changing CQ moderation values
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index 1d6858a108cb..c4cc4026c451 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -2,6 +2,6 @@
 # DIM Dynamic Interrupt Moderation library
 #
 
-obj-$(CONFIG_DIMLIB) += dim.o
+obj-$(CONFIG_DIMLIB) += dimlib.o
 
-dim-y := dim.o net_dim.o rdma_dim.o
+dimlib-objs := dim.o net_dim.o rdma_dim.o
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index e89aaf07bde5..c50e5b4dc46e 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -82,3 +82,5 @@ bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	return true;
 }
 EXPORT_SYMBOL(dim_calc_stats);
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


