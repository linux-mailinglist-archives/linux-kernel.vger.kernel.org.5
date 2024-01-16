Return-Path: <linux-kernel+bounces-27777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11882F5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702CD1C24057
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C0200A5;
	Tue, 16 Jan 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLj0H+mM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0581F946;
	Tue, 16 Jan 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434176; cv=none; b=ZQhdo5Lwp+V0pHnlwwLQhNcNEKmsxu9YU77fB6CTkJmg8NtH1a/QkNlScfoxu3btbj13QaASfSFfok8aS+QHxoBnnX5SamQNr68/IRnW21Mz+YSa3OD2rxqWxSpyY8oRyx8kyhnluijGK5GRGIcsE5mDerKg3fYaqrNaVEcpJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434176; c=relaxed/simple;
	bh=f4SemcyoAKYKb1kdaGvE8bYyWYbKpYGcJlAKWKO3hOM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=giJLZe+ckS9bAOj05BCHlPng7eshmzlFD1yckWsUypbVeZk8l1iHQwdderZNpirn2cZLsUwA61y2DNpYuu/LgRzx+Er8/cKRXXckMvKAWd92CENftFqKrCLJ8XesIRoSW/S/mbKrQ89HCW27jETxsD0YhB+amJuZ8yQEcRQLYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLj0H+mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD7EC433F1;
	Tue, 16 Jan 2024 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434176;
	bh=f4SemcyoAKYKb1kdaGvE8bYyWYbKpYGcJlAKWKO3hOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLj0H+mMSvXpxequanxA5GklMD9GMEifagck+XmYlmXFgCkR3I/vAIDgDZL4f1IiJ
	 Cz2N8VTa1tXK+ng7iCOpRkn4NQPR3W5s63XYLmZc58RjckUoEZqTxS73IkR2tYp2kA
	 jhWmIm3iOg+N4e1s/WSuBcwQ6FQ4nR+xI2uo/hw5uNe9bEQJdvInKscHR3cnOyJY1x
	 2hvvV7iR2BFpphuwFtcfq7ZCMkK+BLB8sFi2e+9tQ1dSD7aF4acyze/txDvqoeumdM
	 lIZW6n590gOmO2BLEf9Ktljh7/EpU6qJPwmzXI5d5uUyVPdN4sMM1VobrfsP+CZWwH
	 JXJC1TrqBIITQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiji Yang <yangshiji66@outlook.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 007/108] wifi: rt2x00: correct wrong BBP register in RxDCOC calibration
Date: Tue, 16 Jan 2024 14:38:33 -0500
Message-ID: <20240116194225.250921-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index ee880f749b3c..1926ffdffb4f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8659,7 +8659,7 @@ static void rt2800_rxdcoc_calibration(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, saverfb5r4);
 	rt2800_rfcsr_write_bank(rt2x00dev, 7, 4, saverfb7r4);
 
-	rt2800_bbp_write(rt2x00dev, 158, 141);
+	rt2800_bbp_write(rt2x00dev, 158, 140);
 	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
 	bbpreg = bbpreg & (~0x40);
 	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
-- 
2.43.0


