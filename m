Return-Path: <linux-kernel+bounces-33044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE78363B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB1B2F035
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F43D0D9;
	Mon, 22 Jan 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ahb0gW2h"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555D3BB53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927375; cv=none; b=B00HtxYsAbaLmsVn7bosVYxR+if3EcnzTTg+a8VZ5DJFj6xb+iL+tTF5NOr7oSwaRlTTpSH9wRKwT1OvovVhPyDDdrfhFCdi8oRqqgWOVgCa+tP7ynxeLRC/DqHLg3Wdq0QLpIKqwR69GgBFCUm/LtjS4Ui37cU0cNTk2RwkNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927375; c=relaxed/simple;
	bh=9fJ4/jNRWyPrbuUW72vI7e3jpNHnk7E37fo/n+TK37M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZicOzTg7PMAkWOzuoE7mkV/SnTFNu/jq+MFl/t5sQ4QmOi9tQ8VTopcGoYuQk1ctFxR4tVT2udSfENXlD5XpxqtQFZVXNEMjU5w4pAz2GxLlAty3Mi6WGCC95HnyiBrzeJQbLDw2AdF+cDiV4HbqmsKDgQOH50Toppr+DRJzzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ahb0gW2h; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337b8da1f49so2823357f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705927372; x=1706532172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MictaQTnmuvgryOODFf0I7jgiEaNRAnJ9k//p/ysG8=;
        b=ahb0gW2haOeMlYJt5yF1wDDHjMrVnkuCalbZq/lvGRfvLoWhU9c5CYQm6ZmYIDFuYo
         i/0fd9OcmHuvms/G8YAtZofSZCBgA+BftzszQ0wjFObugTlT3aF9SZI5T7liOqHkhP44
         1e0Wo5FI1hL1xLvMp4In4Rx7AfCPeNVY2nB5KFw6XfCztR0jJcM8ugISkTkHhfSTr+bh
         swTUPm6WZyxpEfeoY15adIMbPiwh0PtsqOxQPfTQdkVtXPN1m69Zmb8GDPSqibJkjkxJ
         hkoauhjVAazeeDePaE/y7JD3mHtSPx4OpYzG3wsTKSYKtXso+UWb93Ea3Ix0DHfXdY42
         117w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927372; x=1706532172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MictaQTnmuvgryOODFf0I7jgiEaNRAnJ9k//p/ysG8=;
        b=fzJs1AYwdAOPiqMa6tzxgM942mwQctBkfE4LT6B4EtExZPDsB5vvYOpQoFkUmSTjWd
         vVMXcihLOv4OJOJttrN+sB0aAmBEE4gg7PMnReIFtPQ5rgEhyCuqL2TNOfrQQQ3NHtdE
         FnqSQZONzJ2/jNthtmXA6hXVIEYg3ujKbwBXvwbATZ4Tr6ls2nD+46yupx35B/LlZJ1p
         ZXGHYkOOg3ixL5tidSRWOtAc0mi4tBKJIHYX0bPmS+6spA+2mjkmQoEjXKLTsa9M8U/D
         DCwbqRe1B9e151+voajAPHVGVbcM9y5RfyYnkWiKCb2IITUM992iSMevtU+u/kWYIOy+
         sRFw==
X-Gm-Message-State: AOJu0YysVkedXEWvwp2Q1yB/D+H1FLo9oNq2m5EGT4dhgRC3qkiVKBlG
	9c6uw8OmrpxWHbX2Kl0pX/4IsB+Z+mtvATopuxk1YIod+g1PVoEVSDrpSHSi8tGwq7L7GPPw4bx
	+
X-Google-Smtp-Source: AGHT+IE0+45bDml8pUn31f1SmdUtpKu3vmX9W3rERBPjH+HjfaGbgeJL0jzLzOvHzsTPy6WU1lPRdw==
X-Received: by 2002:a05:6000:71a:b0:337:9b5f:95 with SMTP id bs26-20020a056000071a00b003379b5f0095mr2234682wrb.133.1705927372693;
        Mon, 22 Jan 2024 04:42:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0033763a9ea2dsm4671771wrt.63.2024.01.22.04.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:42:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 3/4] genirq/irq_sim: order headers alphabetically
Date: Mon, 22 Jan 2024 13:42:42 +0100
Message-Id: <20240122124243.44002-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124243.44002-1-brgl@bgdev.pl>
References: <20240122124243.44002-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and maintenance keep headers in alphabetical
order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index f5ebb3ba6f9a..b0d50b48dbd1 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,10 +4,10 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
-#include <linux/interrupt.h>
 #include <linux/slab.h>
 
 struct irq_sim_work_ctx {
-- 
2.40.1


