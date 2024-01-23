Return-Path: <linux-kernel+bounces-34471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B2837CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DCA290777
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFE4155A4B;
	Tue, 23 Jan 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mSLykj4R"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C121155A33
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969722; cv=none; b=goQNHy2/TfGoFWr/ncFRYKyoZGOuZvviDhadfeuHTeuCxIKDn4q8uU7QpOcy4fyEUzZ5Jq2Ik7feAyuAWyy+rI6Ge/CkdPO/VqaAINo36aYZx/WhpBIY7kLygmfdw3vUYOofuImAwNdhVQ1kBgDskYeoDrsRJ3kJ8akGej/BsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969722; c=relaxed/simple;
	bh=l7HVvTdScmVUEBhzQFpCKcbiCA9potNAVoRVMmpE5Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJXu3PISv8dCjUWG6vI29jmcKCYFguTxXolwnuGOSJEJs8/vHwMdegFPdC7d/4LyY6ZWmr+Dfi9iH2UK+7iXlOl0lzFzELbfcHCr2JJTOJZ4yVpMzEMR0+yT5EeMZ36F7VWjbjhfiJtGdUCmVruURSAqRQRBgn+F7MgVCC6pzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mSLykj4R; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-599a5266066so48083eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969719; x=1706574519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JeEyKGn0lV8WeyRQc6wAgA/9wi6Y7j/WpnhdAob6+w=;
        b=mSLykj4R/hoz2kveKtbBhu0zXi+tfZGaVsKmdvKaMvnBiacg6+ZDXwmEQu/LbcW7aD
         R5V86tcbaasCiHyxVpbJNfehr6hrw52j/jzETUWVJzaqFKTEB/gs4Jacvdzp+jtmYSyO
         U462ee3VMJ5G/NyWTHO0KoyCmmmVdzWgEvhNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969719; x=1706574519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JeEyKGn0lV8WeyRQc6wAgA/9wi6Y7j/WpnhdAob6+w=;
        b=ioZ/ZwOGPYXBdoiuIJzgosif+HfLpokynDSRpkxGA3VdgIduAz55qW1fefh5e2gdOa
         FUIcnB1XZJG0kQgOb0ew+8lJ8CGJiOCLOTcKcPY7KsbLirXQpCe10QMaoYz8oXLkoVAl
         8iMhn1HuSpNGKMKKYFf/Fuli8FoC1xSmrQPVujDGlSNLll6URPse9KzeUiho0D4qw3ew
         dLlvEgcGMlufcycVe40T4kbSeJiz0X5Y7qxmWNJSGNU+42yIHi/DPLJzt6P/WwlQnfXp
         wf5eUTRsJhQocSGnIE/bU/TJFWhJIQsgEHm6mTSaZXXCNoPdb2kfG7k2+Xr07Vzddtuh
         dCxg==
X-Gm-Message-State: AOJu0YwwdKmr28mhPYzHaFIAETiF2LVjkK0MbHowYaa0RKuIG4wdwPes
	t7r8dOu8MShdJk4VmLDqoGa5ohbmZAb1ix7xMsk9bYy6S3uxfbWj9qGC+M0gJw==
X-Google-Smtp-Source: AGHT+IGXnjsVjmGefwUz4NLOYBkk1Pkgc02KLFnPxshR1dbCC7oBkGzlRDt2GgPOlPOZXTHSoOTbOQ==
X-Received: by 2002:a05:6358:ca5:b0:176:70d4:eb64 with SMTP id o37-20020a0563580ca500b0017670d4eb64mr388585rwj.10.1705969719547;
        Mon, 22 Jan 2024 16:28:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rs14-20020a17090b2b8e00b0028c465b050asm10217097pjb.54.2024.01.22.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	cocci@inria.fr,
	Bill Wendling <morbo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/82] cocci: Refactor open-coded arithmetic wrap-around
Date: Mon, 22 Jan 2024 16:26:40 -0800
Message-Id: <20240123002814.1396804-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=keescook@chromium.org;
 h=from:subject; bh=l7HVvTdScmVUEBhzQFpCKcbiCA9potNAVoRVMmpE5Cw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEsqMAH8qryJJXGj8e8QN0W9DMFFKrS9uda
 cVz4Vs0YzeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JsTiEACd8SkTPHWAe1kX56wx0lNF5c674TcY9C2ijoqRJGl/0QtJHQVrBWgFzStTMFRvdjVmSft
 OhisPGmKR6BjwIhxS8K5uADuSfceqnrcsSEq4gyGDysofHMym4LMXl0gyup0oUDHnTxmzDDExp8
 axLDbZ1DRxktaofds7/FAwvtSg9Npx8Xq5Zx4tpivhC+OR8ZgYaUX0FnfXi8mzwN5bhbZAMP3qH
 zi0ast7Pgu3OHTsqOvXYYT87SM3mnt0N24+ILjlZAdKkVKotxC/m33ndLhs9LII8dKzdCfL29Rs
 VdZmA4MtigsvUnzrrfEjFbZIMynSrgWPIUe2gFy1mJy2dkam07GXcuXbtLldd2EeuZN7D+r7RVd
 4+vlNouoeK8rsf39E9wUneF9w8ZEtnDG9Td4520g5ev1+d7MN2kp8jJVnYTIJLZFYRcpFk8LygE
 uf/9zPB/2zREBkdwxAKTln0vcFw6GHYhZi2F56FRL2tHXmxxw81CdKjM2fsB19JV5iG94WNZCGO
 Zu2C1agT5RsXzn+z37spD9fyW0/F1jNBMeiUiXU9IW8erIHEQqyA3HieDE8casRZj64hSFICMOa
 cLCu/yo1/gx4lr5s6qpSm4oZrC88HxZZVlZvy1WK6SRp2cGdT2tEJvOCA98bxxqAyXYYEoa1IrG FsID4fl2hSNgW1w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In pursuit of gaining full kernel instrumentation for signed[1],
unsigned[2], and pointer[3] arithmetic overflow, we need to replace
the handful of instances in the kernel where we intentionally depend on
arithmetic wrap-around. Introduce Coccinelle script for finding these
and replacing them with the new add_would_overflow() helper, for this
common code pattern:

	if (VAR + OFFSET < VAR) ...

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: cocci@inria.fr
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../coccinelle/misc/add_would_overflow.cocci  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 scripts/coccinelle/misc/add_would_overflow.cocci

diff --git a/scripts/coccinelle/misc/add_would_overflow.cocci b/scripts/coccinelle/misc/add_would_overflow.cocci
new file mode 100644
index 000000000000..b9b67c9c3714
--- /dev/null
+++ b/scripts/coccinelle/misc/add_would_overflow.cocci
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Replace intentional wrap-around addition with calls to
+/// check_add_overflow() and add_would_overflow(), see
+/// Documentation/process/deprecated.rst
+///
+//
+// Confidence: High
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@report_wrap_sum depends on !patch@
+type RESULT;
+RESULT VAR;
+expression OFFSET;
+@@
+
+ {
+        RESULT sum;
+        ...
+        (
+*       VAR + OFFSET < VAR
+        )
+        ...
+        (
+        VAR + OFFSET
+        )
+        ...
+ }
+
+@wrap_sum depends on patch@
+type RESULT;
+RESULT VAR;
+expression OFFSET;
+@@
+
+ {
++       RESULT sum;
+        ...
+        (
+-       VAR + OFFSET < VAR
++       check_add_overflow(VAR, OFFSET, &sum)
+        )
+        ...
+        (
+-       VAR + OFFSET
++       sum
+        )
+        ...
+ }
+
+@report_wrap depends on !patch && !report_wrap_sum@
+identifier PTR;
+expression OFFSET;
+@@
+
+*       PTR + OFFSET < PTR
+
+@patch_wrap depends on patch && !wrap_sum@
+identifier PTR;
+expression OFFSET;
+@@
+
+-       PTR + OFFSET < PTR
++       add_would_overflow(PTR, OFFSET)
-- 
2.34.1


