Return-Path: <linux-kernel+bounces-37140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FFF83ABF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5481C2422E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6711129A97;
	Wed, 24 Jan 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3pdxly9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E46129A83;
	Wed, 24 Jan 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106579; cv=none; b=WLKhS6Scxi/PXdo4RUuxoreA+BoUO3T/3CodD8Nd0mqg8aGWmRX0dWu9K1xG5y3jTyv/4at2w+8hpqzWAUjOQtHJgTOwiLEfAfRmnNDPKLRKfFNSsMabBWOSwzLvFHhnyrzAENCtS3GMpp6VZy7czhdip5kTQzfA05KBCyU2YgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106579; c=relaxed/simple;
	bh=I6e+mVg1k6P5LlJmpJwxeylrZ7aVMIp7MSRGrtweMlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEA/XTQ0QaWPLmX96CLC0Max/JOtr4DVEFKrl6XXE7MMqwaWnDUK5GgNwHJjImuVuqcYmKevVCK9lKpyPkgUuEhcL6qvxDB6bUZXc1zB7iHjPFpv9pnWXbED9OySIOm3FPD3LU/TbClS3ZjWn88JD3ScDL1zRpg4lQxqSJtZUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3pdxly9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3E6C433C7;
	Wed, 24 Jan 2024 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106578;
	bh=I6e+mVg1k6P5LlJmpJwxeylrZ7aVMIp7MSRGrtweMlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3pdxly9fD6GDFl3HxCdrzldWo1vEzFxxYXDEV99PoV47SQ9Twb2t8BUUkClhJ5Kb
	 nu2WyT0UQ1+MUAgeNCNa6ru6AY5fRdTmn20SuSE6gZmwF9vqx9X/OLNP9okXruLZTj
	 5f1HxA5igXI7umm4zwYLWPi9e56Rlhov0w/6EyyIwWeVOXVPtHXvXqt6lmQNbqBhpX
	 2uRbZbr/YBPZvMeNscr+AMzHZE0p33XM2EcghemEImfTox8qnG2gW6eRLAPTvZ0MCi
	 PHdZqku3W+srh3CF/cFwFMH0p9JO4ubJD0QPuVpro6VhO0iXrFO9iyEPR2Uokt+P75
	 p8Dz3731Rx+TA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	Tushar.Khandelwal@arm.com,
	jassisinghbrar@gmail.com
Subject: [PATCH AUTOSEL 6.6 11/11] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Date: Wed, 24 Jan 2024 09:28:54 -0500
Message-ID: <20240124142907.1283546-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142907.1283546-1-sashal@kernel.org>
References: <20240124142907.1283546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>

[ Upstream commit ee01c0b4384d19ecc5dfa7db3fd4303f965c3eba ]

Message Handling Unit version is v2.1.

When arm_mhuv2 working with the data protocol transfer mode.
We have split one mhu into two channels, and every channel
include four channel windows, the two channels share
one gic spi interrupt.

There is a problem with the sending scenario.

The first channel will take up 0-3 channel windows, and the second
channel take up 4-7 channel windows. When the first channel send the
data, and the receiver will clear all the four channels status.
Although we only enabled the interrupt on the last channel window with
register CH_INT_EN,the register CHCOMB_INT_ST0 will be 0xf, not be 0x8.
Currently we just clear the last channel windows int status with the
data proctol mode.So after that,the CHCOMB_INT_ST0 status will be 0x7,
not be the 0x0.

Then the second channel send the data, the receiver read the
data, clear all the four channel windows status, trigger the sender
interrupt. But currently the CHCOMB_INT_ST0 register will be 0xf7,
get_irq_chan_comb function will always return the first channel.

So this patch clear all channel windows int status to avoid this interrupt
confusion.

Signed-off-by: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/arm_mhuv2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index c6d4957c4da8..0ec21dcdbde7 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -553,7 +553,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	priv = chan->con_priv;
 
 	if (!IS_PROTOCOL_DOORBELL(priv)) {
-		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
+		for (i = 0; i < priv->windows; i++)
+			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + i].int_clr);
 
 		if (chan->cl) {
 			mbox_chan_txdone(chan, 0);
-- 
2.43.0


