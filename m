Return-Path: <linux-kernel+bounces-130313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B628976BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A3FB31DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251615B0F1;
	Wed,  3 Apr 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adjdS4lK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AC15ADB6;
	Wed,  3 Apr 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164715; cv=none; b=jSu5c37adygTGBIEQKDnfuIOdj1i8ok9wAgtlDOrPrQmNdelEQ44IchxWbDBWwGSSutHv8P9VMvXYjW1gayqmtZFtvcUuLgswJJQDbKogaQwxHGH78BC8KWZZbr98A6FJHMiVnkgaUf9rG8k5Yyxp+W/TkdclHOWYufi+KC+6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164715; c=relaxed/simple;
	bh=Ju0dCUBj7c1xHR7bdmc+deBQzJoteCBjACIm80EKbcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=il9RJ44G1bbzdiEpbiTNMOwECHLRo1/CQsBxmRD+nL2BrXxA51ZLBeLfkKEFPmN4GPVs0gGgX29bPzvWQ5IwID7XgJKepa7LLq64cttW8lSCg+QMPdG+PlWypOnXLF2KMsWyAKHhtj/GMByQDL3jYHzJcQOgj/OHhsb7BO494OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adjdS4lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3817C433F1;
	Wed,  3 Apr 2024 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164714;
	bh=Ju0dCUBj7c1xHR7bdmc+deBQzJoteCBjACIm80EKbcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adjdS4lK8irX4fJPuvUblJfLtk/GJbVIc/JntA8K5OGOB1Rc1ZIZuUtYVdmXlznlw
	 T3IE/mFLdJ1zFtBLCYdNgaQaJ3ftyP1sdAhl7YN+ArxF8hkzioPeC5KRxTv12t787s
	 /0asA0cejJgS2H9a6cSuJwiQu2pKcx8Og0s7dfgSlmJoVmSGCf3nRVl7fRihcOI1ye
	 /rAmOYvm791J9WEK/+Fayoih9jA3aHcX8Rs8eivP86eNjwvb4Y/m1MgTL39fqb53xw
	 Ec30JaFb+y0N4Mb1HocloaNTnXR7Vm03e4+Xu2AUROcySATnzp/g5Q95njNZfrLtu6
	 ylfHx/o8V1SEg==
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
Subject: [PATCH AUTOSEL 6.6 09/20] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:17:50 -0400
Message-ID: <20240403171815.342668-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
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
index 0956495bba575..2b871540bb500 100644
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


