Return-Path: <linux-kernel+bounces-37129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C4C83ABDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A32284966
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497186154;
	Wed, 24 Jan 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnknJpBn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654D86143;
	Wed, 24 Jan 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106534; cv=none; b=D5PAuIh/doSk0afXDNpWIYZrMaizdYXnbRPr8IOYU7mtnyRJveyb62iHqYc30Hzor2pCm53egRCXJ4LdbUiMDbhedy2vH7LvoFccVlqDQoS8IyUH50F5Kdeai2kff4AYDixwWo5a78VxSl0TDz48aXFnqYH87s3QVIGcedGne/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106534; c=relaxed/simple;
	bh=I6e+mVg1k6P5LlJmpJwxeylrZ7aVMIp7MSRGrtweMlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCk+I9koCbNG8TvBinFXIZNIq8Cyt3CJnFud9UR9hac/TZ4BlFyusW5G67le/QCMxTUmZDUrlZl/siDw3ucgjEtNqjgHAWOCBa7U3GedtluaS37Ov9+mYXX1q6oyFXUgMW/Vog6aOGNZkoWVxUgYepZHxkftuB8x6fl8QB2x0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnknJpBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E8C43609;
	Wed, 24 Jan 2024 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106533;
	bh=I6e+mVg1k6P5LlJmpJwxeylrZ7aVMIp7MSRGrtweMlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnknJpBnOk0HKHgt0ucEweC3V+eChMSee2RS4AqQ1AxhWqR08TnbLqPKWEiNd3bgM
	 OE+uZgOMq5JCF3H2aix53VbvZz6vwulvLLnCJgwTZ6PihZuU1m3RPgpX0cR1t17vTq
	 SRtE9aXyVK5M1L8ncqv9oUV++2mRzVyGKrjJaYmCF41dLIPWQeKrxKxqClIhpoIi/J
	 DlGMLS6Q0eiwBZMMCMQ+ptIICMevWanfYavEsnD305czqWLXeBU81m3ty9DJ4xpQ3P
	 sjRT+q4t1KcArtsd9NElmUXXVgzwoMBN0Xu+Dce6RdZINflSPGUSLE4SRHypY3HQ8M
	 TyOUYxYUgLjNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	Tushar.Khandelwal@arm.com,
	jassisinghbrar@gmail.com
Subject: [PATCH AUTOSEL 6.7 13/13] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Date: Wed, 24 Jan 2024 09:28:06 -0500
Message-ID: <20240124142820.1283206-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
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


