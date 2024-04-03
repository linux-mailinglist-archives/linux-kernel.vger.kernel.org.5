Return-Path: <linux-kernel+bounces-130344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E18976FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D931C28D96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1128C16C688;
	Wed,  3 Apr 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPX2/GBu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940516C459;
	Wed,  3 Apr 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164793; cv=none; b=IB3n9z/sS6nAJGCCzpRcwq8vsJppRKQgxmliY6BsxpYeynZEBc8NSs1fkcQ7XU4ArMw+v2pBdKjIhshxJn2xr5TILfzvozFtKzO9hg6gw/vGiEFFXo/wCkSYBEb+Ftg+JqnVqN6SsRvbugF+8PHQ3n7L96i7aYqvXsVR2EUS/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164793; c=relaxed/simple;
	bh=cxFHtwCOC32ukJTfuk0w2xaUECzsrt/GTn2WtXZd2DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCayemufMmVw9m6AiZ/SK7k4I+6bvPgCpsaXJxWR1aUyH4JUdPHUIioHN2f6e29kFikzGaqMyvMzAoXFVRm6VrjowZnDMxs+gWd6qi0/TgAVcjGm7Eoe7SeILvjhnRNUpqZsIpQkeewGWP1VD8wURGxRBNKzL5a665ts5f6kzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPX2/GBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF8C433F1;
	Wed,  3 Apr 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164793;
	bh=cxFHtwCOC32ukJTfuk0w2xaUECzsrt/GTn2WtXZd2DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPX2/GBuNBZR30M8VFIk6e+fBb2865NA5uPLXgsLcOgKJSD2ALyQs2kg2uf4nDrCF
	 /WU4we1IIK/djUcAtZx87dYjhxWGsxBpfjgZNHx+DPeEtizvdKXqOXtMyImWfIGI9x
	 FCrYO9huEhmoabT2pXGo2J2fvlUNJXsjU4laqXF9uWufZRUPTN96OScO7XMlxdqmMf
	 yFLqPMN5MV4E3cKcCMH+GdBz8b2Pt1VfQsGoPvYCoLb2dkpRcP3aIXl0tFVIaI8xJb
	 aUt4A1tMDOKRp2Hf08bnhXARSWPoJeLW4ix6mTkx7DTynmY7tZ8FDuKNxKxLsq5u01
	 ZE2r+145aRFQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 4/8] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:19:37 -0400
Message-ID: <20240403171945.350716-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171945.350716-1-sashal@kernel.org>
References: <20240403171945.350716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 12f371e2b6cb4b79c788f1f073992e115f4ca918 ]

Function checkdone is only required if QUIRK2 is defined, so add
appropriate #if / #endif around the function.

Cleans up clang scan build warning:
drivers/usb/host/sl811-hcd.c:588:18: warning: unused function
'checkdone' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20240307111351.1982382-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/sl811-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 825ff67273102..d3de9f47552d0 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -585,6 +585,7 @@ done(struct sl811 *sl811, struct sl811h_ep *ep, u8 bank)
 		finish_request(sl811, ep, urb, urbstat);
 }
 
+#ifdef QUIRK2
 static inline u8 checkdone(struct sl811 *sl811)
 {
 	u8	ctl;
@@ -616,6 +617,7 @@ static inline u8 checkdone(struct sl811 *sl811)
 #endif
 	return irqstat;
 }
+#endif
 
 static irqreturn_t sl811h_irq(struct usb_hcd *hcd)
 {
-- 
2.43.0


