Return-Path: <linux-kernel+bounces-52385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4E5849761
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B8C1F23C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1414AB4;
	Mon,  5 Feb 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7pQV5zs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148E13FE4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127806; cv=none; b=fYoBXNHHBKFIGxW8wwR/PVDMaZTte0lMCHRvbwIFuStrqplLWh7cOL6X5LFUVe+3bi8ojA5MFXfw0UAJvla2x2CNfYiMJnmFxkoO5DbAOQukRTUNZsdRQrIkPiX+Y8r0868uBQW7frQJDB40eBViYWs8R+BwaJK8pZe0bcGVCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127806; c=relaxed/simple;
	bh=e3w9hSsDT3FO8WPZhRfhMoOpgMXCC+pRKpqGj74t4+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gk39ny7R2//fC8k6dwUo5v0TRzuUCw05JUK1ZYQHzcWNwJ2lCfL+ZQLcxltBb6pNs9t/J4w604Bm0Yz3bmO+flJ3xD5gShDn0ZGI3UNvRfL8EU5E5lZiQq3x68+DPWfwSCF5DAUPGNDIX3CgoFobH9FlkuKJaZQAgjtPCPx3cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7pQV5zs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd6c24812so9061385e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707127803; x=1707732603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PM79ddFlM7URHKM92cg1UrBcIO6D7fI7h+zZ2IlfnwQ=;
        b=o7pQV5zsdYEfj3pmDtH5O/rrxDyg+XOxHg2F2XJk7vijxhGcR+q9122V8auWigEAza
         uq9uszadoZcjDgWQ0IYOJce2la+TTGdeJ+n3qD0CA3ducmgPeag//pxSfwTX3SrWCaSR
         3I97ETiMu1Dj6dJvoFeYpDrkoj5jlL+tCJrBsPHNa3IPI5q/LuK8VSIqKtg2Uz4Ktlzx
         tntbm+cz2GSodxjmAMOtjbKeOnG5Y5x8yylqqxY6c1fmNq0h4oKbPrYrT0ia14gtwHYQ
         bfMtWw6pjPKcJYdD2VxlFpUFeZuevk56VQb64Y4XwF+rMx1sauRmyA6jF4AM8cBGyee8
         EXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127803; x=1707732603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM79ddFlM7URHKM92cg1UrBcIO6D7fI7h+zZ2IlfnwQ=;
        b=mJ/jBT5qoqqOEVU8kNFzeGDdJj8wVSZ2/Ld7tNlxgBZ9y74DcVtLtG5Ov3Or3lxGKb
         BVKRK09bN6t/3B7gK2BxUABNRWeAh+OP7g2BQYtR7TXtE5SvtLySzK8mllWovnEQkplP
         p+BMnjqK8HSwRBlN33Li4DKehrxS1rjZuYyQekEumDylmJLn4EOMIf6U3hmK9moYbQFg
         tr03mwdTOTAlPDaLE78JTHZLvdAYskE6Q3krbU0h11FxMEid72+jpnIz1wdKWu/xcTbB
         HVbZOErgbLqgFtnzNSvI7nyAelV+j1AbsH9Cjq1hQdovcLV6/eN5f8aDzgqOU+4LGPzg
         lxlQ==
X-Gm-Message-State: AOJu0Yxr/61OSaGu8/LRcFVbGFffR7I5VMuP0mQtSfYJMviGnyChr1Xr
	ToyWjnJej19Roh76qBGNF5V1pC822JMF+trLnsJoUTZQcZ5BZBp0TCtEHHRoGh4=
X-Google-Smtp-Source: AGHT+IGgdKcnU5KmXqzxTG6IPmbKMzlO9O60tha1XABc6ryVGbd/dNZgL8d5b6WVkrriIAy7dazcuQ==
X-Received: by 2002:a05:6000:dd0:b0:33a:e6dc:2e98 with SMTP id dw16-20020a0560000dd000b0033ae6dc2e98mr8856744wrb.5.1707127802716;
        Mon, 05 Feb 2024 02:10:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6yDO2FBqezZlPU2JPGqbY4RTsKYQbF3YB8DM9gGdCdKm2bSUeD/4maLEXs2UxamIL7xdOQcolQWZ4yCw1xtCY4EdiNU7QeVQ5P7xya7yp5EEK6xZGwxdf7wru5wiNqd8IawTtUGfgbMH0+DV1JhVc3dY2gUCa0YQM+cadEOZGhG+p+vbID0Jpr3hzyGth9GkU5Qpk
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b0033af5716a7fsm7694395wrp.61.2024.02.05.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:10:02 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: miquel.raynal@bootlin.com,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Takahiro.Kuwano@infineon.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: flashchip: explicitly include <linux/wait.h>
Date: Mon,  5 Feb 2024 12:09:55 +0200
Message-Id: <20240205100955.149755-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=tudor.ambarus@linaro.org; h=from:subject; bh=e3w9hSsDT3FO8WPZhRfhMoOpgMXCC+pRKpqGj74t4+0=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlwLPz5xUk93u1ufsUid6bQ6qowIDwkHv5Mnolp 8Eknq+ko1CJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZcCz8wAKCRBLVU9HpY0U 6fxXB/95862mGGMlEovpodPY5k8h7gH4fQQXhXtYxFEQ/axPd02kxgryzHrF7JJ/KTk8NpJHTqJ XK3E2cgoMxNkdTuLd6tsvl5m3hiQY4jqZyJhrM2ia1PFnlDr9SBC/U8FSVDAz4dJDBtJb3FXc/V CVkxRyDtYkMU/iYuuZ/B9V3/uG2gIoW8qk94wKBSScf1GVmOHT/rzlnzLcOzUAyYXB/l6mKv71U oYxGNDy0YYXcJ1MYrYtBgaVC4ZrKrdWPydsDmBgz6T04RzS1i0GPN1REJqYrzI83GVT7Exb5nxm ku3qO4W4xukOHrbTc8Bk2bhhCnOShdRBpctIrhejwSw/fOo2
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

While reviewing the hyperbus sfdp proposal the following problem was
noticed:

In file included from ./include/linux/mtd/gen_probe.h:10,
                 from drivers/mtd/hyperbus/hyperbus-sfdp.c:6:
/include/linux/mtd/flashchip.h:77:9: error: unknown type name ‘wait_queue_head_t’
   77 |         wait_queue_head_t wq; /* Wait on here when we're waiting for the chip
      |         ^~~~~~~~~~~~~~~~~

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Explicitly include <linux/wait.h> in include/linux/mtd/flashchip.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 include/linux/mtd/flashchip.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/flashchip.h b/include/linux/mtd/flashchip.h
index c04f690871ca..9798c1a1d3b6 100644
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -13,6 +13,7 @@
  */
 #include <linux/sched.h>
 #include <linux/mutex.h>
+#include <linux/wait.h>
 
 typedef enum {
 	FL_READY,
-- 
2.34.1


