Return-Path: <linux-kernel+bounces-37163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D883AC99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A38AB275AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1C13173C;
	Wed, 24 Jan 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meg9b/OT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD313172C;
	Wed, 24 Jan 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106648; cv=none; b=PQ8KJ9WFKjz0Rpo4N77QcwgpST5vTJVlo4TyG8m5/G7jRvFt01vfZzlycEvV6u6wnZ/qvHWQK0/QqnChF9HI6z3rD8rDyOer2tVFtBH5M+lXMpWlMEBUkeOen4iSzkXxZQxAguIGszikyDJowcqQHkOMIMwJ74eaEhW79mbZAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106648; c=relaxed/simple;
	bh=cAChtuoyn7JFJc/X+ZnQajhvOoLJNOkikXCm2xXshMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU7hOaIa/i/NR/h3h/5mCnOqKXX6J2hx2lsV5zNdvyvE8CM7zWgtxNI8MQxlP1WpmgunSe46LAEd5yjBHbx60xWp63IXYR9970JDy81sanOlZgMEC8ISYpnONRs1RTrlsv149FxUc+p6sdhlYN//nod6kwBuyTxwkIkERB43Mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meg9b/OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB818C433B1;
	Wed, 24 Jan 2024 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106647;
	bh=cAChtuoyn7JFJc/X+ZnQajhvOoLJNOkikXCm2xXshMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meg9b/OTYUWD9ygKEZbcx9+fiILoLQT5hm5877vovU2oLSQVR9EBX5zP6zUi8SpiI
	 iMVv0Auj7oVMD/nsGaRT6e5Yg6q1WhRq83A/Je0tLYzqotGkNzAVtQSNDvfhhAPpue
	 ud86qz1vXncXc2uWp6GwKVlZGF02N2S/nS91vpsS9og0+abJoLYibg7/tybsSTi+cI
	 LvO5falBjbByXT7B11pesIK8WUICxAcJVXpAnJl4ecRlPbW+c+UuZQIVvjtpjPnSiw
	 TEbr8bBJ5Gkr/1p6wa8OVQiOZO+v/9pPF7Sd69J55TAp8w1bSYgjOhEVxEWi1+FKFt
	 8vSlUhjazgkoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	Tushar.Khandelwal@arm.com,
	jassisinghbrar@gmail.com
Subject: [PATCH AUTOSEL 5.15 9/9] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Date: Wed, 24 Jan 2024 09:30:12 -0500
Message-ID: <20240124143024.1284046-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143024.1284046-1-sashal@kernel.org>
References: <20240124143024.1284046-1-sashal@kernel.org>
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
index 3af15083a25a..68f766621b9b 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -552,7 +552,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	priv = chan->con_priv;
 
 	if (!IS_PROTOCOL_DOORBELL(priv)) {
-		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
+		for (i = 0; i < priv->windows; i++)
+			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + i].int_clr);
 
 		if (chan->cl) {
 			mbox_chan_txdone(chan, 0);
-- 
2.43.0


