Return-Path: <linux-kernel+bounces-114015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD58887EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AA61C26E77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC711FB085;
	Sun, 24 Mar 2024 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6rH/Igy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0912FB17;
	Sun, 24 Mar 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321300; cv=none; b=RfmgQSM3m4vFsb20woHiky13zV2HSmlQBYFw2Z/cm6vPdbFP9FSd7dl2DJ+BpZi0iowSTh+hn/fKZ239tzfZCbqKkFiS1p/arTbkobxIiErRfW4kZNB8wAMdwSsFSkg1KBVJ5h3r8LahBJMULJ7sE4m5MphSfxKgHeX3ZN7XOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321300; c=relaxed/simple;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo+FA53DnUyhsBR0Wp3dq0tPDt+2CJmHwI95BWtouBfyZV58sqrJoi2j1JdVaCtQi/r5/LeRF4okBAh0CQwLa/hOIMMxLbWAvt6CvqtAyyMuZoCD+UOU9zqZf3tfTs2SSgzZEehWzyAngxcbLHJ8qMhj8q+szT6H10kwrarcO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6rH/Igy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCFDC433A6;
	Sun, 24 Mar 2024 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321298;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6rH/IgyYAtU6ihcspC2Fsp3TS5+2jM7qR8qFXbTMnd8Hw9UN62Q37Q9nTWRVNsYF
	 8OaSfwuhhuD+L/KHrxZswDYIoQIqlG4IewwEm1MPYI4HaHLPNC0IbQbK98JXS/uglb
	 JBCpGnIP4oGinzKTyYZemXS+6iNDMawBrAG+zLoYAvGOAceMajHPQRQpG7xJqTOD55
	 tOUi1+iYvPX3Tf35NMR3HhTDZCY3kCwn+1UW8jH0NepQSe++Iqo2zi0YbXwduHWKMO
	 inwMaPkqdwb7ykj4Xnr2Z4OBIORx/E/QM7JJT03zitVC8o2gxsuNhhz82b47eH6aka
	 0qdR42QSwADGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/638] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Sun, 24 Mar 2024 18:50:58 -0400
Message-ID: <20240324230116.1348576-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6dd9a236042e305d7b69ee92db7347bf5943e7d3 ]

The symbol's prompt should be a one-line description, instead of just
duplicating the symbol name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index eb656b33156ba..f19e74d342aa2 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -1,5 +1,5 @@
 config POLARFIRE_SOC_SYS_CTRL
-	tristate "POLARFIRE_SOC_SYS_CTRL"
+	tristate "Microchip PolarFire SoC (MPFS) system controller support"
 	depends on POLARFIRE_SOC_MAILBOX
 	help
 	  This driver adds support for the PolarFire SoC (MPFS) system controller.
-- 
2.43.0


