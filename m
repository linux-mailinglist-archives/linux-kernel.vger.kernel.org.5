Return-Path: <linux-kernel+bounces-50083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E9847405
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99D71F2425B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E0151477;
	Fri,  2 Feb 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkc9Q6OS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BE15146A;
	Fri,  2 Feb 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889536; cv=none; b=KHPs+jMNNYWh/ls5ITFYvKqyZh8oZjnW/Nenk6hVzBOcSoIx11bwX7xigyrm9TCaWKmOtuGAaS8UJBTSljhwmCrqPOB25wAHmRXDtIrRsoz7+9WdJqtEgx4iCigBXwJ2aGSC+g9O+KS8z4QRFzaJfetGbeRmmQNzBpI06xBRoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889536; c=relaxed/simple;
	bh=LeeYFsCIF6jDZaXspMRRLlPcTtCrfxsxcxXxfVfjmc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIw0vTeqA0D/XXCm+xaCB/sq8kZZj4xMz0RCd0D8akkbcKjHjREX4DbIdYWCgP2BBS0Y3YkRAZQeROVB5rVA2bFfrDok3xz52jRsAN8NAzlImJolXD5vZHrmXQ5E4g4RWBnjKFwbkCGcPxSOgxdqNauJEqnfCaz62vggGxpTeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkc9Q6OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B4DC433F1;
	Fri,  2 Feb 2024 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889536;
	bh=LeeYFsCIF6jDZaXspMRRLlPcTtCrfxsxcxXxfVfjmc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kkc9Q6OSx+NQaYN1sXTTciCIjpY02DiMrnw3OleDHjk5VD+kSkBImHGMcgWf/1iDh
	 sMgA/LQnwK3mdSpWUsvTs5dmDQwX7R0MBhkIVfBqvnX9Qwl59R+jg4bXCKPvgeZVak
	 /S1sGv4hGcko/u24kLpl2bCnT5FLovzT5GUL0PWgbNme/msrogeqVc2S/NMxbCrvfw
	 1dTeNrlvZohRQ2iXm1aMuecrCBYziAbXPHt7e3bq/bDPD/WqW3XTAVfzK56Jkh/LO4
	 nolyr+Zxu2erGeuKFNyWtmzsTxP1ipokaw1q11yag58BiT0FBo+lby705ywg/QqqS9
	 p+LB6iGLYFwew==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 23/27] kconfig: move ARRAY_SIZE to a header
Date: Sat,  3 Feb 2024 00:58:21 +0900
Message-Id: <20240202155825.314567-24-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To use ARRAY_SIZE from other files, move it to its own header,
just like include/linux/array_size.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/array_size.h | 11 +++++++++++
 scripts/kconfig/preprocess.c |  3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 scripts/kconfig/array_size.h

diff --git a/scripts/kconfig/array_size.h b/scripts/kconfig/array_size.h
new file mode 100644
index 000000000000..26ba78d867d1
--- /dev/null
+++ b/scripts/kconfig/array_size.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARRAY_SIZE_H
+#define ARRAY_SIZE_H
+
+/**
+ * ARRAY_SIZE - get the number of elements in array @arr
+ * @arr: array to be sized
+ */
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#endif /* ARRAY_SIZE_H */
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 69b806a6d8b7..f0a4a218c4a5 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -9,13 +9,12 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "array_size.h"
 #include "internal.h"
 #include "list.h"
 #include "lkc.h"
 #include "preprocess.h"
 
-#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
-
 static char *expand_string_with_args(const char *in, int argc, char *argv[]);
 static char *expand_string(const char *in);
 
-- 
2.40.1


