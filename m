Return-Path: <linux-kernel+bounces-84112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33F86A23B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A95C288256
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F70159591;
	Tue, 27 Feb 2024 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwO5VmaO"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB16158D6B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071937; cv=none; b=mSB/nodSHmJVTWRc5SqG+xdSchPx4HL+Hq7HbSVhO7QGRK1I54wusU4xOhhL3TgASkJcHx9fmI9gTPJbIZALTVesuPRCaijpKdtJah497TeEeLngqQWdUfZ6bKqXEFX5c2AC3ShM8E38UiJ/BIRFvBn49xPgSWnpeT7zbWJdKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071937; c=relaxed/simple;
	bh=6ysg+o0Q0vjgeb3Ub2WmvlFjV3vQ+V2XEH/LWmQtAJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bMTr/mjdSXgqNvybbJUT2oO/o9DWAZxIZpD7PitxH+cc7IeWdQqou9Xxf41wkOO93rvB0aSEoucn5ILZXDPF+x5IlUyKI7nlZ6KAnLTPvAOc2zyaUMVDKasM0s+t0cF9e1nXKA+3d7k2exxYf51SObRvY0x91EI6ZMqurv2Skr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwO5VmaO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412b34fb36bso450755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071934; x=1709676734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j82VF811BuKi5ly+pi6Q+j5FxiMcza1ds+iHobKFqbw=;
        b=GwO5VmaOVg6arqUMgtH+wZBWMYlypq3cfFD2Uav+sRKBu4KMcrTA9r1y3GpZdDrAAw
         Bssq7TIE6OzQXPoPgIy2Af7vPHDLb9z58ghNiRetvv7exvDW8zdRZy/3bCyYaN31I0v8
         9O42aM4ag9hlUPQ/g+u39ci5kV3bj91xCPafQ+9dp/8vXuJOjgtKOzjfJWhOenkiz0PA
         TYz+NNaFgfnlPVBIka85I1rh6Pr8U4j0vj+RApjC4NC319EBj+nZQaO1KoUuxuHqfRXn
         n6BBHHUQg0mfeosmSSgcjX6CHGE7/OedBP/TuXmKTZp79XNZgK/Wcf3IitIOZjh8NM7h
         4Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071934; x=1709676734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j82VF811BuKi5ly+pi6Q+j5FxiMcza1ds+iHobKFqbw=;
        b=GC3x/iEgb0Ez3e6OMfNlK31nor8S348GR+I1lm2DsFH6f2sswPIAHLGqoudr1xuyqU
         wJWZTeOqYMNQzHlZTN5HnuPdjTG6H67sU/59ZjKnEly8C63+qsMAvbjDpQBmPqnsucvH
         F7Lho4QmmnmXcLblHHCYnjvPOC4ACXz3IMXPlrortBDe8C5w3wWShigZwa7uL2aneYQj
         P1EF7D553PlSqJwCqC4P0/Fpw3rAhqGarYWLLOwSnTLiEyUbZpUK0fr+FuT7PSrMzkvm
         inibF8pXhU2p80I/BaFUXRs4CcHprSN7Kk9Mu7EAhtjyn3povKVO92rnOFIQHHzTfGai
         myMg==
X-Forwarded-Encrypted: i=1; AJvYcCUoFahjyTfLUevxHOarMtocWcjMoRm3xdduAGrhA3BYyhSgAL8IXzW45fA/7bTy/oYxfAqoCGCaCE7yFCVq4EFgbAYMxuqViur+lzWk
X-Gm-Message-State: AOJu0Yw/mJQHLmpTzkOnPijjsw9ptbCsjHlSB9/8SsCq2+xFeZmDLPSU
	C+wqeYvI/xKQqPowwzqpB03Ol4phTUYt7t9WNJIXqQXsr/mZVE90
X-Google-Smtp-Source: AGHT+IGKOwBFZBio91HCw6G8GEOtwtrKmMJBdogmVmJ/wrYIKDudLLJDvyLlRZFFy9gkK+Mz6s+upw==
X-Received: by 2002:a05:6000:4e6:b0:33d:20d8:76fd with SMTP id cr6-20020a05600004e600b0033d20d876fdmr6793984wrb.28.1709071933801;
        Tue, 27 Feb 2024 14:12:13 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm12415560wrx.28.2024.02.27.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:12:13 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] staging: pi433: Move FIFO_THRESHOLD define to source file
Date: Wed, 28 Feb 2024 00:12:04 +0200
Message-Id: <20240227221204.534131-6-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221204.534131-1-ikobh7@gmail.com>
References: <20240227221204.534131-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIFO_THRESHOLD is only being used in pi433_if.c source files.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 0ec3130225db..b6c4917d515e 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -49,6 +49,7 @@
 #define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
 #define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
+#define FIFO_THRESHOLD	15		/* bytes */
 #define NUM_DIO			2
 
 static dev_t pi433_dev;
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index e63e87fd6cce..76f0f9896a52 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -12,7 +12,6 @@
 #include "rf69_registers.h"
 
 #define FIFO_SIZE	66		/* bytes */
-#define FIFO_THRESHOLD	15		/* bytes */
 
 u8 rf69_read_reg(struct spi_device *spi, u8 addr);
 int rf69_get_version(struct spi_device *spi);
-- 
2.34.1


