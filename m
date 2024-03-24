Return-Path: <linux-kernel+bounces-113136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31A8881BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE66B22033
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0F84D39;
	Sun, 24 Mar 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs0PRC+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65457899;
	Sun, 24 Mar 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319943; cv=none; b=BhhaUrOxOs9Kjsxz6qG1GPulachOXyHn8lHtEztN8rCDhjDYW/pjOBRNbJUvXUSfFaNosvCwyp6oM+RQtfuI4CsW+DbJqYkC483Q0Mg8gBN1WXI+yKJqvScLjyxewUX3k8jTso5KeNDZYAIqkeeMnEQuBo1cT0vE1LIMCQRYkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319943; c=relaxed/simple;
	bh=SPCV+ObubcSKVsfZuQiEsJDfvzkLinbGc8VIthJu8ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPrY8mF5mCZxugyxllY88GhiANjD3mq0P4PizMhIN/8EsD7oDPmHZpcAiC79DKBAqzH1nLS6scZJsGrxTGOz09hHtVHoiOd7noVzAVwMyNUqWzRRtIBlRbHrBMGag7YTfft0kyNhAnTxnTJx/4nICev1afUHkiNnwNX/z+iSuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs0PRC+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CFFC43399;
	Sun, 24 Mar 2024 22:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319943;
	bh=SPCV+ObubcSKVsfZuQiEsJDfvzkLinbGc8VIthJu8ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xs0PRC+BisyRCQH/7A/cGO/H8FrzZz5pv1UED1RzGo73ZdgOfVMrBPrqNgBXqN0FE
	 Gn/45yiIFiirP4zm5Gjwbsib6xwzRQKMgHJ5oipLld1tttkR4q05eklOVoU24x349i
	 5gIwZVpWD9ewqB+kT9r02pvk9F9iRIt5t+0Kmz2DyCQCay6w3xnHRZ/w/E8dtDmI8N
	 HqpBELu1GH5qExaTYeqG5lIUfKTIXKjzbQHiihDFBNUe0J/s5cO/GMLDRIVaMaaX77
	 Put2NLsJiAAq+GETtjRgOvZrHC5QnPIen/1gwzkv8q2uwSwogEg5trlan0MLC9Rg8n
	 5TuG5cUgaxa0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 249/715] wifi: mt76: mt7996: fix HIF_TXD_V2_1 value
Date: Sun, 24 Mar 2024 18:27:08 -0400
Message-ID: <20240324223455.1342824-250-sashal@kernel.org>
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

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

[ Upstream commit de8882775156682ba358afc82cb575c92cf3d092 ]

Sync the value of HIF_TXD_V2_1 with firmware to let it correctly fill
TXD values for HW path.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 1a1a60744272d..a929c657be1c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -493,7 +493,7 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 
 void mt7996_mac_init(struct mt7996_dev *dev)
 {
-#define HIF_TXD_V2_1	4
+#define HIF_TXD_V2_1	0x21
 	int i;
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
-- 
2.43.0


