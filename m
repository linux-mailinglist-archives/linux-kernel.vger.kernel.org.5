Return-Path: <linux-kernel+bounces-130333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D154A8976E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B2F1F2F946
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5316087B;
	Wed,  3 Apr 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXx2QfJm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B5153BFB;
	Wed,  3 Apr 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164768; cv=none; b=YIDwqQb1znp9DFM04mIUcQlAGk05/ir3wQTnwZI6b8AqQ+Zlg4zGeBFzB4arXrjO2DjzmUr1p7OrPBvp8v0KHChfDw0V5GURKZ1+6CL33ynxZly8n5wwI+Pkg6kmqZ4ChlGotQyG/2RCwNkV353TbyPclETy5csYVCHccIMTc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164768; c=relaxed/simple;
	bh=rkdrY2LF4GdETO5e/zz4hoWXxAzJWl/x8KvSmA0Xhqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq+Vkccuqg/xdYaPtwVFeZZOl1obmSS9Nd035PaUvxxKuVD6xv2V1ZqPMUZSy4RVNO02E6OY9Tg+dAmExIx1EDydd0R7qy4tNdpixQgRRar1fGdopOVGD2OWI2JsJC+2M/sKDzrCtc8BhzF10BfPErI0sJbwp9yrWZWCTNN7UCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXx2QfJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1934EC433C7;
	Wed,  3 Apr 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164768;
	bh=rkdrY2LF4GdETO5e/zz4hoWXxAzJWl/x8KvSmA0Xhqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXx2QfJmawk9O13/5lc3vVdBeFN0UCp45LTWOxzwXrmaJXAlKQnhlJr+lbfDL4wAd
	 gZS3fV8jz1Z35hAXqUo0iB1nw8UH7w0W2lvY2FaXUGamHukStyA6+gL60NTDrwlK+Z
	 lbsXWw0U/T+nqNFjRAVkW/VeiN68E3CdQTOfmE9rbgHIOBp1KiioEdKy/x/GvhVp/I
	 1CIufFL1jtowA0+C4ySudvrTsqSXddaWOoDAsdzbWB+itE6VRS6bo9VcZmLXCXpgWG
	 lG+ITMmjLsBOGF4vJp7I1yfaguczgSeHGLP4yuNLjm8pk/2G2HF/B3ZaFYygCgivHu
	 I273HLHLKKbQA==
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
Subject: [PATCH AUTOSEL 6.1 08/15] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:18:52 -0400
Message-ID: <20240403171909.345570-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
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
index b8b90eec91078..48478eb712119 100644
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


