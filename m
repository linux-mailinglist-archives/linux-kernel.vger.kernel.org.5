Return-Path: <linux-kernel+bounces-113423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302EA888434
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DC8B22682
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CC1A9264;
	Sun, 24 Mar 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSGBeBh5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2A1A8A7D;
	Sun, 24 Mar 2024 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320225; cv=none; b=PJqH4H0wpVCZtGnzbOwp83eiEwMIfAO9++z1D+CYDXPSUWU+QWq3VGd+HGjG620M8MPAU10K4eLatmoIFnfX27tA37/+Mdk9DCl+LKZNcBqkhgSLS0OYNE5/RaP+dPnJc6ft3LNcramPL83tR1j4DDTolCHblPbF+LYPJfiymv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320225; c=relaxed/simple;
	bh=Guj8lFMEqY5ifrWKIsG1QMseOz43FgxsdeGdH99gICg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/pQdfenEB5xJiNdba5R2vipKSgt1UjRDrQknqbO4HqOE3d6iIqrJ4R92HDuHve27FCdh1CHuJEvMSXXq/QLbS6MSZ3jcKnE+WZJTezeVbVeexFv+BrAqdBbP7pFMr27IWojRcCk8ElAADFDP0T0RnFir9esuE/KyBRnBSbkfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSGBeBh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FF1C433B1;
	Sun, 24 Mar 2024 22:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320225;
	bh=Guj8lFMEqY5ifrWKIsG1QMseOz43FgxsdeGdH99gICg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSGBeBh5h0CxeuTaIS3hL3LeSVU1UotpgzJ6s1r/zDhAsH1ALDZOn5IS3Q/Km1xhs
	 0Z0XwO60g5Lh4qcbB0NQoXH/cD4y3XxTBv97/qZVE6Q0EK9+suNUOB3iB8acuYED9x
	 owR55u96U6Sg+JIF5fnUybJhzIj59mrrzvB4mmbvC+nlE72nFINDVcwAGLH1k96OPE
	 IWI87keTvVTATiu4XtW6baK87WoZ//7BZBDkol+S+Rn9pYroNL8QzIC0ecLTv90pd9
	 nJx1E9w7zp9fGjn5XBN9JhTVbVG3l3ZQrZRRu4wnJBMmbTZCG3W8nzuLejGjADuHwK
	 8JUUHQB5nSkzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 532/715] sparc32: Do not select GENERIC_ISA_DMA
Date: Sun, 24 Mar 2024 18:31:51 -0400
Message-ID: <20240324223455.1342824-533-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sam Ravnborg <sam@ravnborg.org>

[ Upstream commit 99bd9a4f87926e12ce60796d7db1d6b226aca5e3 ]

sparc32 do not support generic isa dma, so do not select the symbol.

This fixes the following warnings:
dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240224-sam-fix-sparc32-all-builds-v2-5-1f186603c5c4@ravnborg.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0c5a98ef11440..37a1cfecd9c73 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -142,10 +142,6 @@ config HIGHMEM
 	default y if SPARC32
 	select KMAP_LOCAL
 
-config GENERIC_ISA_DMA
-	bool
-	default y if SPARC32
-
 config PGTABLE_LEVELS
 	default 4 if 64BIT
 	default 3
-- 
2.43.0


