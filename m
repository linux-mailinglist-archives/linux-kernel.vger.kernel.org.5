Return-Path: <linux-kernel+bounces-51637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C9848DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D761F21FF4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F78224D6;
	Sun,  4 Feb 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIq4csWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FA1642F;
	Sun,  4 Feb 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049916; cv=none; b=GeDvXFZDezAO/YN+MchVuRQVA/989vHNsaEWTVsezIxTB76nulTlWPr0bk4v6LjrL0D+H44KAlp7lrv06+bvDjwg4MizXOavEOUgdDg92OHTbT8dTG1wPywlp7LVdjEKoAhLoIl4hV++vz+MznsgXOYnnYyU++6eqFglXYZUIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049916; c=relaxed/simple;
	bh=vDBDZYzI/5OSxWeet1wmyNK83emKECxcsNO1ezZ40ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7nEPnGletoXXivc6Eoe7TFHX/KQw+QOWbrwbifuvDtzMmmbY4dunlm84GZwUbv7CJxWew7FsbmuH+ivH2rwcpiaxRXiSgXrV1GNeGFmLgdo0bJikpJZLzYr1f+jmAzlSZUNBMsDEn3pQyQ1ka62ptJZxm4Q3cpPUsrKoKJC+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIq4csWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021A1C433C7;
	Sun,  4 Feb 2024 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707049916;
	bh=vDBDZYzI/5OSxWeet1wmyNK83emKECxcsNO1ezZ40ak=;
	h=From:To:Cc:Subject:Date:From;
	b=nIq4csWA1HUpfBdPjf1xAVT22cLtTusYfNrZQUKZiX7VWI4PQZc/YRPbRVCsVC2iZ
	 gopPQRr21Z9X3pfQ8QYHRWPbdrQqG3gz0m0XwGBs3AAdQdh2CEoAxrPZYPYcqvImsY
	 V+6NabFIAaIdKH8IDU6Vf/oEi+HTtzPq74ynVFsB685Aj7Q/x89C/b6gik+UBuTq7A
	 co+RrTjYt1MkvbhLIu73kxi17Hd6IEbrdYk1jpLKnIbBv3epWxkDLHKZuKWYZ9OxnM
	 BEiFL4j4Lm2g6gnfFd/Da5So8vcNhit24p+cqjnuHy1A66q1aWMBipVP1yO1znM3q7
	 D7dQY70gLVueQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: remove duplicated CONFIG_SUNGEM_PHY entry
Date: Sun,  4 Feb 2024 21:31:51 +0900
Message-Id: <20240204123151.55005-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both drivers/net/Kconfig and drivers/net/ethernet/Kconfig contain the
same config entry:

  config SUNGEM_PHY
          tristate

Commit f860b0522f65 ("drivers/net: Kconfig and Makefile cleanup") moved
SUNGEM_PHY from drivers/net/Kconfig to drivers/net/ethernet/Kconfig.

Shortly after it was applied, commit 19e2f6fe9601 ("net: Fix sungem_phy
sharing.") added the second one to drivers/net/Kconfig.

I kept the one in drivers/net/Kconfig because this CONFIG option controls
the compilation of drivers/net/sungem_phy.c.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/net/ethernet/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 5a274b99f299..6a19b5393ed1 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -15,9 +15,6 @@ if ETHERNET
 config MDIO
 	tristate
 
-config SUNGEM_PHY
-	tristate
-
 source "drivers/net/ethernet/3com/Kconfig"
 source "drivers/net/ethernet/actions/Kconfig"
 source "drivers/net/ethernet/adaptec/Kconfig"
-- 
2.40.1


