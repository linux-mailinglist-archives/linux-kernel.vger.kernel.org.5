Return-Path: <linux-kernel+bounces-51298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFEE8488F6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95BA1C21B76
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603812E5E;
	Sat,  3 Feb 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsUj8UgY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334912E46;
	Sat,  3 Feb 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995622; cv=none; b=rt4depdLe0Cmnw87IrgsvN/mw+65kZhkup/9tQupQiPpFdBZqt3qASZ5Ibw9w1J3sU/dusTiLadx5Ww31r8Y8OmMNbRrv3sJIWZK/jWf0nnt+7R9t1It2izKTILvLCNTJfh03HhA8NSiTXgwnok4318N3k4PUTaAe2J9OUY2r/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995622; c=relaxed/simple;
	bh=gWyRnU6/gqA0dpJAHLB4wOOqtz99R/Ha+Ue5rmGtoaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lAByS4nFEUd5igodlx/nVCffwuKJ43/EYsWeek7UkAO3VOZVDPPgqGmYJeJDMrUiqGAk/VhYwj5Ljqf+lBapwGGNNuc3PD9MH0zG6u6Vm/VQoJVwJOq68HOvr+w+/vB46WfDQkSzIsMSlbbR0ynS+jrvueV2s6BzJIgTp5APCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsUj8UgY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40efcb37373so29222755e9.2;
        Sat, 03 Feb 2024 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706995619; x=1707600419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6Y7+XPYPmbCAkQx9j5duSD/dFWM/YcSFb0QEVK+BJ8=;
        b=SsUj8UgYPdwlRGxOWUlNxjVCQ2BDJn67YyCPvJ757NI1EhqKWOTGU1daU4dlX6QOWi
         m1/r5guBGUpF3dE6qYiQJPNuBDGFbpfy7X3Fuj/w5dsuH7qHCmxLZE9DLDGMB6ejCgXM
         pDEV69GisOWjXOyRxtfS++DwVRhMZ5eGQhI+UY8vevagg0bva5tKYzexq56o96tuvkRa
         QUVCTYRgVOZpCipe8DLBav7xzz0t6nXRVNZyTQUA0whuoTHBqVQoFGZJqT9YfMxI9f0d
         +9UohMPFv2drygpQZswNFSedNCZ9dpfnwB+IXxEp/YVpIakBuL/kqIu4KehTC23PBRDA
         Ldag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706995619; x=1707600419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6Y7+XPYPmbCAkQx9j5duSD/dFWM/YcSFb0QEVK+BJ8=;
        b=pfLT1ozQCzjjKiWDdXjl0jMv3gQOD4WDLJeOb4xB40VDnhjVd3rD8t1ZYVRizYINLw
         j6Z0SQhORltxwMIxlgUOByhzZI8kTHeIPoSi4KGVgaY4kP9iAASYL0hA5JVhReeJ30Kt
         PNgE0/Fd6fc6kfXh1uv532Y89sjZMf/hH8uBtj5bqpnXFwGwBrZnX9tqgIjEOAQG5d11
         jJgA869T+Db9IKWCcP5Qcu2Z8+fWoMEE3lpBS41/5ux2dSjcamzRM+1eZCzLN8+Hzl2U
         G8HUBh85u5gCze9kNLcr2sZ46N3dCu1NKupXbdpiOX7X5P9dgZSGrjHKyHF/Ou4Ib+p7
         zEnw==
X-Gm-Message-State: AOJu0YwxdzTfxB7XNp0bJf/Ihfue0FhkKWlCFZ7q3NKJOcfqfWWKI1b8
	FuqEx7l5bn0DxgfQgczIUMQAxH4V4rXmMS2hfJA3u/B5g10weRMU
X-Google-Smtp-Source: AGHT+IHl332lB7I4w6kkAF8JX6knTYB1InBgu2tYeGKQrUDpG3gvhhkmTyHvV7sFy4+f04GKn6CSAg==
X-Received: by 2002:a05:600c:34c6:b0:40f:b79d:8f26 with SMTP id d6-20020a05600c34c600b0040fb79d8f26mr1670841wmq.4.1706995618887;
        Sat, 03 Feb 2024 13:26:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqnLwWYq/Hyd0WZBD8DHXU3p2pIPyRURF9CjiMZvwY6hAjDoAszNdnZzBP7ygHFMcsr91EyzYX4D7nYJuPwRycfmf+XBfxuTdcC7hXyGXyfq03Z0u3FiwrK5SR5oRL+do93G56/KFUadfArHZXafNJGUICrDMspG2qoP651B4P37l8QLlUo7BoIbIajX8tYT4EPGSJ58r0Uso2XorfITHgDUdRAp1MJXthr1orup21IMhfLwaY7nAvZXgn89u4jn0ynh2J3XIlvWAtUAtHygFVRdTZwOGvsqM/G6ypBIk/pqB0xkiVX/qAuJXcHbfFIQHy
Received: from prasmi.home ([2a00:23c8:2500:a01:c74c:5b2a:8ca7:1220])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d46c9000000b0033af4848124sm4715366wrs.109.2024.02.03.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 13:26:58 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH] cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_cache_wback()
Date: Sat,  3 Feb 2024 21:26:40 +0000
Message-Id: <20240203212640.129797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Align the end size to cache boundary size in ax45mp_dma_cache_wback()
callback likewise done in ax45mp_dma_cache_inv() callback.

Additionally return early in case of start == end.

Fixes: d34599bcd2e4 ("cache: Add L2 cache management for Andes AX45MP RISC-V core")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/cache/ax45mp_cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
index 57186c58dc84..1d7dd3d2c101 100644
--- a/drivers/cache/ax45mp_cache.c
+++ b/drivers/cache/ax45mp_cache.c
@@ -129,8 +129,12 @@ static void ax45mp_dma_cache_wback(phys_addr_t paddr, size_t size)
 	unsigned long line_size;
 	unsigned long flags;
 
+	if (unlikely(start == end))
+		return;
+
 	line_size = ax45mp_priv.ax45mp_cache_line_size;
 	start = start & (~(line_size - 1));
+	end = ((end + line_size - 1) & (~(line_size - 1)));
 	local_irq_save(flags);
 	ax45mp_cpu_dcache_wb_range(start, end);
 	local_irq_restore(flags);
-- 
2.34.1


