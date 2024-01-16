Return-Path: <linux-kernel+bounces-27914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4682F7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC291F25D59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB086137;
	Tue, 16 Jan 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1F1wgZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730D8614A;
	Tue, 16 Jan 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434575; cv=none; b=gcgb0ktNIyCC4S42QcX6SAq0dW57l+TWjGC4OYpBi13JDixYe4ixZElkTrBKSXF5NzvatQtpqiJ+smw7bEBd1SZ5r+Du3W9hQIVF9nKHmIZmFpJ/QmSXZ1ewbtIGTbA6DDTwpFFI9cZGky8qxuF5Lj7L8fTNPPQe62m3hDquQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434575; c=relaxed/simple;
	bh=G1hjk1Se7BSfSIIGM304vmD93OayUlAFLdmJ3oDFcjI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=MkL92aGa1jYRmvULnz9k9O20PMxz2llh0xEBs9W8wBTZSrnG/7sdb2EnNOOCAIGSZUb0SK2W4IIi9s41ZqPAG0wwABpS13pCbPRi6ADaj+S0WuFMoZBMfYJYsGo+i5e6yHeuHVjzFdb+vpZiOiJj1TdfgSy54xlPF+KqgA+Wlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1F1wgZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FCEC433B1;
	Tue, 16 Jan 2024 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434574;
	bh=G1hjk1Se7BSfSIIGM304vmD93OayUlAFLdmJ3oDFcjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1F1wgZAqf9GSoq4CewwIstv9B4jb/n479foK7GH4Y2c5GV/+8TAnToWB9Yg+cdC2
	 bWAH4fs+IepyYz1JJyje/le6i4jJiU9eODAlj4UQQMqiUlEoMe4ZrqCPDJYvTPi1HZ
	 WEUDBF6bJOxxRAsXKtkwGD2vHo8GxDsU+g/Fzi+H1RAL2tTzbFYqNQfac3iSNcn8Vj
	 K4haeIU7EjHudkppX6d2oP2FTvsTjfE5+/1LIQYwOcXT8cNVZUkppPYhfYf32vPsP7
	 ZMq4rIAwoB4+Cou8/JfpGld7gR2IUvMp5swxpBT5iY3tSKTrpA1dk+mBYawsRLTnT+
	 AZovHv3yjIu0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiji Yang <yangshiji66@outlook.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 007/104] wifi: rt2x00: correct wrong BBP register in RxDCOC calibration
Date: Tue, 16 Jan 2024 14:45:33 -0500
Message-ID: <20240116194908.253437-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 50da74e1e8b682853d1e07fc8bbe3a0774ae5e09 ]

Refer to Mediatek vendor driver RxDCOC_Calibration() function, when
performing gainfreeze calibration, we should write register 140
instead of 141. This fix can reduce the total calibration time from
6 seconds to 1 second.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e65cc00fa17c..c13ae87f94f4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8695,7 +8695,7 @@ static void rt2800_rxdcoc_calibration(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, saverfb5r4);
 	rt2800_rfcsr_write_bank(rt2x00dev, 7, 4, saverfb7r4);
 
-	rt2800_bbp_write(rt2x00dev, 158, 141);
+	rt2800_bbp_write(rt2x00dev, 158, 140);
 	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
 	bbpreg = bbpreg & (~0x40);
 	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
-- 
2.43.0


