Return-Path: <linux-kernel+bounces-20905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24B828735
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F260286C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E438F9F;
	Tue,  9 Jan 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTE00hu/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570C38FAD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b5c4f332so1315952b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704807412; x=1705412212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1OkkIDMSc8Q0KyW2jakNuTKvRC/V38TH1jOx19EXCA=;
        b=lTE00hu//yULAJtT0+gY0IvWIvKUhgz6YH22b9FfpuMjjfyhxPa4Ew/B/jn2VXVAoN
         duxAaZSqg8nNbnhg/nUdtJLi8o14MBp82Ts0Z9GB2+GMNLKXKoUej8P/z18dBCAb0CZn
         jkjKMYH0HvI7gwVWEILjlPb3iGg0FFHO9zK5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704807412; x=1705412212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1OkkIDMSc8Q0KyW2jakNuTKvRC/V38TH1jOx19EXCA=;
        b=V/FtarvyO85pgH3/4CzAv9y04Vo50MTIyb1a/dy0x2z897xFk91OyCQ7t0Z/5Hpbet
         J2vB/4jyWgqBLO6SmEXE85pqmRwpD6LViBOeIUa1Ej+jHZIicBJlwZ4O9B5sLUwUOhBm
         Q3wda4zHO0P0yLIHq861PTiinLoUmdRFxw72WzYyvmAsBIuez1gw5SUVGQy1YY23nX1m
         +Ku2dlKjJLKlZgqPCPFpIE2jFvsbc/Kd/x+1JhG23AhNgvYCbnXVK6VYJYkQTvoIeZ1q
         2xAFrT12n1WLyTkAERAtHxgyeiSGFhH8n8BHMSROu09++FAivAoDpye6ZHqMuUyrFVTX
         naqA==
X-Gm-Message-State: AOJu0YwIgHry9KK2imRWrxAdGb0zGXyT7cuLO6sEcZkAEpXTD3SJwrCt
	i3lRgICna1Ck0RtsPWObrYsMQbmP1L0q
X-Google-Smtp-Source: AGHT+IGjwjOduo3sVvMklylvN3XYhL/ktYo2abqFN5x1SN3P9np4ra0Um4OeWouTXow82nwY84Gm5Q==
X-Received: by 2002:aa7:8c18:0:b0:6da:27f1:b8dd with SMTP id c24-20020aa78c18000000b006da27f1b8ddmr2452353pfd.0.1704807412116;
        Tue, 09 Jan 2024 05:36:52 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e7f6:5139:c752:8303])
        by smtp.gmail.com with ESMTPSA id t185-20020a6281c2000000b006d97f80c4absm1727934pfd.41.2024.01.09.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:36:51 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Date: Tue,  9 Jan 2024 22:36:24 +0900
Message-ID: <20240109133633.1103876-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bump compiler versions, as GCC is expected to implement it
in version 15 and current clang-18 still has no support for
counted_by(). Also fix clang URL - the project has moved
to github.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/compiler_attributes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 28566624f008..1829c24c3357 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -95,11 +95,11 @@
 #endif
 
 /*
- * Optional: only supported since gcc >= 14
- * Optional: only supported since clang >= 18
+ * Optional: only supported since gcc >= 15
+ * Optional: only supported since clang >= 19
  *
  *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
- * clang: https://reviews.llvm.org/D148381
+ * clang: https://github.com/llvm/llvm-project/pull/76348
  */
 #if __has_attribute(__counted_by__)
 # define __counted_by(member)		__attribute__((__counted_by__(member)))
-- 
2.43.0.472.g3155946c3a-goog


