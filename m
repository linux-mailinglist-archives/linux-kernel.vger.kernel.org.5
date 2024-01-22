Return-Path: <linux-kernel+bounces-33267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA828367AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FE41F277DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578858101;
	Mon, 22 Jan 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sietirHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A15787A;
	Mon, 22 Jan 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935525; cv=none; b=UDkiIScX5Q4340F6CGLgXpHv+vNUWK6E36N8dPAY73fKrS9agSDMRa9vZli3dtRbE+TZ03UxkiUtwkKdKPnCw9NeCK6icC6djJyN1oaIWs5kR1uOIw16qNiuyrXYk7G2dvjobKydl3mtw0k6+CDqn2ruiNFrEMobYlK3aQOHkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935525; c=relaxed/simple;
	bh=Mak+Lj5rUfA9eGs0UEJTZqDvCPi0Bu/m7ejQSQMOZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCNmmyBsIPjRCUo9pyzPQV3rSOcG6aaP3KgonY/xPdq5cDKMPSoFJho0hR6A2TwV/KO5Oh4BBA3LBHcgNA2R/qxrdUSu7o8OOtSQGryo1bTHuCtoauMW+/iWsI19rVZlqOy8EitLMQtJWCLjbj4hMs/EpcHYZsnD2YiMmkv9lpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sietirHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FB2C43390;
	Mon, 22 Jan 2024 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935524;
	bh=Mak+Lj5rUfA9eGs0UEJTZqDvCPi0Bu/m7ejQSQMOZKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sietirHhmJDSYyRtAjSfjov9Fyp5uytr+fm6JuQzaEDh5aL+DVhKVaAgTkqTxLnQM
	 I25PV6k5Rkjx2D8mF1Wx4qc0e/ZhffFAEuoIuKavj+F/QDqz0g1d7UQwWSS2d07+Yn
	 8y+3u5m2OKWXgn8oin9bhJ1oouvFSw9Mz8SwJP6kY27ZiNXRVOXazndTgy9dZBfXnZ
	 Gf8MTvy+FW58yBS9cAnq14zt50E58lZnvmunlO+T/9WTw2IHtm/1mocf6dOJIoOuAJ
	 U6YFvkFsh4Fe7O9/DPOCmAEonmTzZhMvKmyTh98dQzh2n+ndpNsNALDvRzsVEQmlKC
	 vl9N/6q1kQWrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 47/88] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 09:51:20 -0500
Message-ID: <20240122145608.990137-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 91733ab9f58c..363badab7cf0 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -238,7 +238,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0


