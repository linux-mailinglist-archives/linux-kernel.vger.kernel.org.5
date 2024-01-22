Return-Path: <linux-kernel+bounces-33480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AAA836A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFB1B26858
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A891350F8;
	Mon, 22 Jan 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPTtN6M0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC651C56;
	Mon, 22 Jan 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936448; cv=none; b=Va1M5IEny7KncYu/C/PDVT9Bgqya6lXdGL1ZfjMF7+hH2fyOpt3QQZUPhoMsN13TNZLXSioFu3h9BsW5lT37VLUMkGl2jkJEUoe0WIme3defo7bCkerB703aUpCJ4qMa3N99rVRf9+jAAzWSNho47T1Vopk2ciGlgbY+jfWLaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936448; c=relaxed/simple;
	bh=FWNWh8dLcOM4LpimapOwOnyzLuG2MZo3Uy6g263H8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKYmjHwzJGCanvtWHcNw6R8umKV+SMFCLTOhYMe1c9Kr+b3ldMOECzubAqgAm7ktQljuAKcPJP8L4ZQ3nkdG4Du7Y0+zyGdZ3/0kvoglxTqnnLOcoG+t/KVwTQsx00xd69R2r1eqnelSSjS54hKTaV8odkyPAbSlQkVL3c2+GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPTtN6M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6083C43601;
	Mon, 22 Jan 2024 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936447;
	bh=FWNWh8dLcOM4LpimapOwOnyzLuG2MZo3Uy6g263H8G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPTtN6M0EyIq+drvUFwbbahUkg/tCJ08yTTH/2tWT1V03YszTuHTYd8akMLB8DSrc
	 92b15WB2iR44OBrbZSwRj1qkg7LX92B9H56zHTozBhX3RlJcOpVW1n7/yhbgAFTIWy
	 BZvON/WAN8kESU6QoJPoL6O/Qm2dA5K/jEe12IrEbwfj83xUrQWVDB1OMib8jfuREU
	 CdRivrMQA25G3m2a1LZROJhoq6ZxnRZv1MgT/HsVUu+vHMa23S3NZj3HBRiMqYbKTO
	 ICf/bcuTtbxccjH23ax75bT+K3dImuUCyK7hwXn2Q+8DVpiwA71reG56tRXquQ4CEK
	 U+cWPBOeZtN1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 23/35] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 10:12:20 -0500
Message-ID: <20240122151302.995456-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 09b4195021be69af1e1936cca995712a6d0f2562 ]

Error code is assigned to 'stat', return 'stat' rather than '-1'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..bb7fb6402d6e 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0


