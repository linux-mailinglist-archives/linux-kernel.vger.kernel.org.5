Return-Path: <linux-kernel+bounces-113125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DF8881A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998E01C21C52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0415CD7F;
	Sun, 24 Mar 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB5hgmDH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280915D5BD;
	Sun, 24 Mar 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319933; cv=none; b=brc3zbJLLFfy2CNA9IJxnkeBq3FpK8pegki5jmP8hylojOmPuEopD+HakJT9p7GeAiuU4eRUziLrQxaF9gj2p6xRq7tbELOcjsQ9ghr2dcKsNjvzYr86bzsb/wzK2wlgYWtmy9ik4ajD2/+5OhrBzlJ6NaG8qHo6oRlmrqeah88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319933; c=relaxed/simple;
	bh=4DdoKp3nQAIVSuaDK5ih/GO5vNy63cJ29dxl7Kt/W/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJjmKpwSgKHl8vuWDBNqVYo+3ZgUD3kBwNeznNosBc7O8nYvFnxnKXUQ5OsPaAhxRlNmVjAQEPAkHmuEZGijRl2yu0pQNy35lfM6ISqoBs5IKWR9y2rEixcTPJCgleESZbjBGJKwOpiS66MP8WotPdFBAHHj7oQhRw9xzeBOcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB5hgmDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD93DC43394;
	Sun, 24 Mar 2024 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319932;
	bh=4DdoKp3nQAIVSuaDK5ih/GO5vNy63cJ29dxl7Kt/W/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cB5hgmDHHfWSwuWyQOd5ii+XLTs5QZHO19fgRlPa41hMyksy5DwPbRKgkWQVrRZoP
	 Ger9K+07dvVVkPkSrQxHi6eaqwe/4nJ71pPqB1ULOvB9f9Lhlv6q0RUGIVghiwcdRw
	 2SDx0GJv+leSdy8vN0plb9JOxlcXwj0YtdN4R9KhXv49NFVe4bCIZgBo8QPfo3mZue
	 RjiSJeJGZmConCS/18Mh6AgGU6reCkE5CIO2E0F9tJuJ5QasvEKy2+9L3ZTRmiuT4R
	 sp/PNVGNJGIOs6Y30GDT4ftVtWOt/ca5IGoO5FOLC+bbMr/F1ns8GiPIPH+tODPBJT
	 qu6fHSQfLS55g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 238/715] wifi: mt76: mt7925: fix fw download fail
Date: Sun, 24 Mar 2024 18:26:57 -0400
Message-ID: <20240324223455.1342824-239-sashal@kernel.org>
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

[ Upstream commit 6864bc734a48e90012cca8040cd0af72616666ca ]

Add an address of fw region for fw download.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 3a20ba0d24928..ea7ffa16a4b12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -66,7 +66,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
 	    (is_mt7921(dev) && addr == 0x900000) ||
-	    (is_mt7925(dev) && addr == 0x900000) ||
+	    (is_mt7925(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
 	    (is_mt7996(dev) && addr == 0x900000) ||
 	    (is_mt7992(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
-- 
2.43.0


