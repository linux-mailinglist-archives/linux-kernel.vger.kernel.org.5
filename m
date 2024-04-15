Return-Path: <linux-kernel+bounces-145161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC98A5045
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A21C21E78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9AC132C37;
	Mon, 15 Apr 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU1sxCfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C154132C09;
	Mon, 15 Apr 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185459; cv=none; b=Avi2w2+3eoZYXimuxNGU42grw3L9o6jhgFbeyFrVoNZFqAnLCDNCutvlwJJO/Gv1pqfxxR55mOgmZO76Wm3vB5hHqmtZFKDRiHPMfxeOjLL6yie1pVE+1ms0jLQTzOJD5ln49BpgQzBuY6Nmui+Ihau7i+HXtpNuHOfG/t/ts/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185459; c=relaxed/simple;
	bh=VUx+Ryq0/DaY8+8lA1oR+IfXPSFo+QmIcDIfSmWWue0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce2ueiDq8A7hlT7DYCddZ6AxHvHydb4eyZsRK26xKuh0oxKaRLEXns0sIdZdkIDZ1H9OJlEW1gDNxayJahb/NofFscBuuNLFWkjL5rddLLXNKwTgU+U5Hl4gdRvrHNL/naqY57+kvdAuUgZhukJS6H32XuVkUUzY/IlnTvED/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU1sxCfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA77C2BD10;
	Mon, 15 Apr 2024 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185459;
	bh=VUx+Ryq0/DaY8+8lA1oR+IfXPSFo+QmIcDIfSmWWue0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SU1sxCfeKIkcjseDBcHZMptK+ny832/qqPyUYvAUvBCEL3cQRAmvBMOKoUES9iKGk
	 VIk+P2JGpuxa1CArK4apBq0bAAICnmlVUPwduZ6SCCfrRsq9Q/ExjZGdj5boFjH1FD
	 iju43JJqa/iyxh/JYbkTp0O70ss0ME8SF93GsmF1/A4sOn9juTIzV8KWw1f32zXPBb
	 fikMic7XQiwcZUM3BEnSkW6kaydxWOTIfkVbaffFrNYzFWomuv3hhro1Tot8lgFDq6
	 of28AJih/nkYSbM5N8jiGugJEeIwqlXCKTxSeAeBe2wgwXRUNPLyo3sD4yj/t2EZfa
	 0qEKPUo2XoGaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/4] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:04:56 -0400
Message-ID: <20240415100459.3127671-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100459.3127671-1-sashal@kernel.org>
References: <20240415100459.3127671-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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


