Return-Path: <linux-kernel+bounces-145154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF708A5033
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D83B1C22997
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9D130E44;
	Mon, 15 Apr 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPXHiZ/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95C130ADA;
	Mon, 15 Apr 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185449; cv=none; b=Uoicln7oxdxQqzTuF4vGJN9BwJtCL25f3nZB/5D4VxAu49/jcoab/gZ3JJFmfGfU4MERnSBvOoasUFok4t4FzzWlSRbkcn1RF9KYURE4TzmyvkBTC7gFwRLf9D9lOnDPzXvYYiH8ZzM3F90r7uhmPTbbhAW5FCrynjMjMAv+0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185449; c=relaxed/simple;
	bh=VUx+Ryq0/DaY8+8lA1oR+IfXPSFo+QmIcDIfSmWWue0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsXZcMKK6iKy4TfBh2HMHWLgJjinuoGAJ1HWwjjztBnvq32cIoY1yIts9KTe0/OcRwFZEuVwTiZKBi0Tuh9KMZ65Udkt6oLfEUYq+wlCUVYyBWpNqRjAM/T/7vIRCp1qD3vr6R5mwdUEuy/aBOPJE3DC35jnKkeuIEXpoFtVCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPXHiZ/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEF2C4AF0C;
	Mon, 15 Apr 2024 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185448;
	bh=VUx+Ryq0/DaY8+8lA1oR+IfXPSFo+QmIcDIfSmWWue0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPXHiZ/1Zp3WBTlUfxnZT6AM3boRJHJWCodq2DWTOK7k9saCkx5my3hHrO0ZhUgeG
	 bO5wwm/FIDT3viYTyb2ixq9YcNnLoqYHWk9y+pXb/VGC6GVULHGwssSmc1+6cQBRQm
	 NR5d+n45I7jC2ND44uIPKFB1DC1DbWBaAq5nc8lKyKm60viHPFIbVOtMR6KezcL5Yo
	 vzzZHz+0zkcDzlhrb6mZR12+Z4GC9ypi/bbyjxxLyDHib6iI/EA1X8R6cj7UjFEajv
	 8GBwo33VfWfgqswHdGmAGnyO8qUrp5wJvDciWR1GVBLE9PYK8G9dlS5Kw1N4OzZIfT
	 +cPbIwdKKQbnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/4] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:04:45 -0400
Message-ID: <20240415100449.3127574-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100449.3127574-1-sashal@kernel.org>
References: <20240415100449.3127574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.155
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit e85006ae7430aef780cc4f0849692e266a102ec0 ]

The call to clk_enable() in gemini_sata_start_bridge() can fail.
Add a check to detect such failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 6fd54e968d10a..1564472fd5d50 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -201,7 +201,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
 		pclk = sg->sata0_pclk;
 	else
 		pclk = sg->sata1_pclk;
-	clk_enable(pclk);
+	ret = clk_enable(pclk);
+	if (ret)
+		return ret;
+
 	msleep(10);
 
 	/* Do not keep clocking a bridge that is not online */
-- 
2.43.0


