Return-Path: <linux-kernel+bounces-113142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B46F8881CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC21F1C21F6A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83616F27D;
	Sun, 24 Mar 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru6Pmuwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAD13C3D2;
	Sun, 24 Mar 2024 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319949; cv=none; b=rwMXYVNyI5vTag/Dgp5uXEK2SIDkWyOYSpAXCUksuHSXJq8/mda0T0HDYiOlgfQOfOmZpsbqqXRD/3HBcqziv+2AsJjwKJmwIEPdLXrM+0cxUHGiWezJmFL1cxb5HKeocdIz+YL1PPJf3m+GLzezu+Q+2Yg7kwMhk8LObOE1htI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319949; c=relaxed/simple;
	bh=NexbagmyqgKdVb4XpfNijJu/lL6hIr1kSEOaWacCw/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC/pxSCgYUt53U4hxY7QCJR1ADU391oAAmbgjpn7dKNO++LFlZHZ+qXlq/B/fqtL8d77kbQmt2HC8C/uX1G8cU29W0kPetsixT6YU0srHgFPx1d+3kfqb0ffutz/5Bg1PX03sqBmO4Zq6BnNWDV5YSpjc4URhBodk2SAN5Zla0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru6Pmuwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B76C433A6;
	Sun, 24 Mar 2024 22:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319949;
	bh=NexbagmyqgKdVb4XpfNijJu/lL6hIr1kSEOaWacCw/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ru6Pmuwfdko1BREqzTAb0r8/TcwrvDjxQkaaj0stU6H47USgjIj+NGj9kgCm/5K6n
	 Bl7EhL7R/9ga3iiCZtFek/z9QGjlTACU52G5RIZ4Hw11lROGwpLDudvW3IJZv/hCgx
	 ZPz+4mnbeW68ngn9Leg40m8WbHWhnBLdTF03R0RWjSPp01f6NgRbRhRdkEaqQQcIIH
	 tqaersiiXPEYgLUHaQSdUQWwWhWsOb+bjmT+5lO83TG2Y0hiPUbkK1XDOeNOh8xImv
	 LVH7ZJ4qmts84DUA+u209CjXRWWFzXlHyYjEQ1Mjbr/2uIbaRAMkYEa/utoXpc9yab
	 VD0WfXFV/imjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 255/715] wifi: mt76: fix the issue of missing txpwr settings from ch153 to ch177
Date: Sun, 24 Mar 2024 18:27:14 -0400
Message-ID: <20240324223455.1342824-256-sashal@kernel.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit e9a46175a79fbc591c48d433020444b8fa2750ee ]

Because the number of channels to be configured is calculated using the %,
and it results in 0 when there's an exact division, this leads to some
channels not having their tx power configured.

Fixes: 7801da338856 ("wifi: mt76: mt7921: enable set txpower for UNII-4")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ea7ffa16a4b12..ae19174b46ee5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2101,7 +2101,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		int j, msg_len, num_ch;
 		struct sk_buff *skb;
 
-		num_ch = i == batch_size - 1 ? n_chan % batch_len : batch_len;
+		num_ch = i == batch_size - 1 ? n_chan - i * batch_len : batch_len;
 		msg_len = sizeof(tx_power_tlv) + num_ch * sizeof(sku_tlbv);
 		skb = mt76_mcu_msg_alloc(dev, NULL, msg_len);
 		if (!skb) {
-- 
2.43.0


