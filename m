Return-Path: <linux-kernel+bounces-33419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF88369C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A67B26EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930F81AB4;
	Mon, 22 Jan 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev7CI+fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630781AAC;
	Mon, 22 Jan 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936242; cv=none; b=ii3BSHb1zC8DWPrF4fRF2r4xwhN6PX8z0lO+AUJpR8mOeXniesTZbZoUZ8JZgbVTanV7tTtLliUhvpqz6KOX/RNYfPu6GndVz6f59vSP+yZ61lrvGzGRjPF5U30PzyPg12Vh+J4pQLV9u0+JERufgsGKJXmHfFrjbtCkwORSxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936242; c=relaxed/simple;
	bh=WSnveHPssNRx7TdCN2Ea+FpbjEEUboBjA/H5N671na8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=as0ppLshYWqYEz2ZjHyursfPyLJ7Uf++EMPRYvrRVF1UAQh5ysMGl3vSYTg7Vdrp93r9f+ii2LSQzvuURgilui1lquD8ckSZ/sFlTFRrE+zBt86GC4kb+b1Y2MnEzMpMLc42hHwK7aILQbkOm2DkTQW8afBHRQZMs7ABjDLfufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev7CI+fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDD2C433B2;
	Mon, 22 Jan 2024 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936242;
	bh=WSnveHPssNRx7TdCN2Ea+FpbjEEUboBjA/H5N671na8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ev7CI+fpW+vJGkWiLH1N+GnEX0pgUmL9uPG8S7K3ABJQraHneyBalYKj16pkNYS1N
	 IxI38C4bE2FjirO9Pvd7KYc+RVduzixYo+7lVIoPDk5JqeBbvDIRVpPcRpMhr9XZSM
	 ECFNkFzjHbqSoVviqCWZW32LSiJdEuSki0VA5jVXQVXbO9E2opP86i4821DcwEXjoh
	 EXbsfZuCY7id7KcFYQoYDknuLNUXl+rgsIdgpilJPM1Faqxzpx4XYe0fbO/VRw3JRb
	 ScftcJXY4KhL1YOiqp+E2Qp34NVAa9wv75oiU6+NvdvSPLfbE/VGet+IlSJ3siBgvG
	 FPNKO9tpVlpgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	ezequiel@vanguardiasur.com.ar,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/53] media: stk1160: Fixed high volume of stk1160_dbg messages
Date: Mon, 22 Jan 2024 10:08:20 -0500
Message-ID: <20240122150949.994249-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit b3695e86d25aafbe175dd51f6aaf6f68d341d590 ]

The function stk1160_dbg gets called too many times, which causes
the output to get flooded with messages. Since stk1160_dbg uses
printk, it is now replaced with printk_ratelimited.

Suggested-by: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 4e966f6bf608..366f0e4a5dc0 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
-- 
2.43.0


