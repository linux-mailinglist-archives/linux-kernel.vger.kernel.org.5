Return-Path: <linux-kernel+bounces-163382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8D8B6A26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9441F2298C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A117BBE;
	Tue, 30 Apr 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdA3d/Du"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55E179BE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456968; cv=none; b=qiWgtioW0+E8E30gtQdc+9SaXhh+PFYSCZ7sd+KTqSoRkfpp29Bme0yXbG8DVSPRyTuZWdhbRCBdKkeW0b3m4REiKNQ7dcM+VvraiWrEDYrji/sk2MZzJjpt9M2Zeqbf7Ln+Y42qihJqGwL/8/SrJwXFwyllD0B2jn6Of0pcQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456968; c=relaxed/simple;
	bh=Gq7jK/rrX6lfM7UxNj8oRoe0bGGIkcp4pVEDXAFgAx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JurzDNrJ/vM9uhwa5BAa9xL1qor/mVFLbQZRFZzAqxal3jrO+6f7EF1XZZBzy2aVYxoDMpMYTGKZvIIHdVfLvFZ1Y6T+2MrwUEjhMmq85osXkJuAdmrhlX6yMqUOowzRN0u+aMrkOUAoDR/lHwS5N3at/YH2NAP2JQJgk77V5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdA3d/Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A19C2BBFC;
	Tue, 30 Apr 2024 06:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714456967;
	bh=Gq7jK/rrX6lfM7UxNj8oRoe0bGGIkcp4pVEDXAFgAx8=;
	h=From:To:Cc:Subject:Date:From;
	b=tdA3d/DuiHtI3iHxMvxUficnQHRO95jAObPCBNHgpkfJCtKTC/4DZ+TwdJFPDAro7
	 4+4l7gRpJmKTeXbPM85dTDlB7dCb4tSgjRW64P+sM3eOJCJ5XvJASo1hKcqvCPdGpc
	 xpICE6CqS94YzoxLDIxA/sIRGtXGrXQmdnDA1xIGXIzOJ+b9DvS7/ZDVnHdvLhjMaM
	 EOPlQ4pVrnmtB1wWDyc0Qr29hbsaJqwb80Mo9irE7wLAKiqEqZ/SVyqJLdNk1XDImS
	 xyiJE+1euIHK5GFhnL0jltCLFMvFaHSABUfORIAhM4m7rLLMks+PZ2mhHrCMRHNS9L
	 zOwh+hJyJ4qxw==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 1/2] watchdog: Handle comma separated nmi_watchdog command line
Date: Mon, 29 Apr 2024 23:02:35 -0700
Message-ID: <20240430060236.1878002-1-song@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the document, the kernel can accept comma separated command line like
nmi_watchdog=nopanic,0. However, the code doesn't really handle it. Fix
the kernel to handle it properly.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/watchdog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index d7b2125503af..7f54484de16f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -71,6 +71,7 @@ void __init hardlockup_detector_disable(void)
 
 static int __init hardlockup_panic_setup(char *str)
 {
+next:
 	if (!strncmp(str, "panic", 5))
 		hardlockup_panic = 1;
 	else if (!strncmp(str, "nopanic", 7))
@@ -79,6 +80,12 @@ static int __init hardlockup_panic_setup(char *str)
 		watchdog_hardlockup_user_enabled = 0;
 	else if (!strncmp(str, "1", 1))
 		watchdog_hardlockup_user_enabled = 1;
+	while (*(str++)) {
+		if (*str == ',') {
+			str++;
+			goto next;
+		}
+	}
 	return 1;
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
-- 
2.43.0


