Return-Path: <linux-kernel+bounces-112624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9061887C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB141C20D58
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B45179A8;
	Sun, 24 Mar 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP20/q8m"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A3171D1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711272735; cv=none; b=YOwaF8Mx5tfwMULLEeEoAc8IC39Mm4QIvlU4Tw9/WzkbrZzjVIlXIWMWgUtdIrJOGcz5lj2f6AToEvnCwFsR9XHC48OvGsDiDXbFKTIawp5aiEcbg2rsuhRDvY5hC5A8h8OOwZB+gFL8UOJFGvwxN56QfeX+Pa64iM01ex+scdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711272735; c=relaxed/simple;
	bh=VT0EkNrQhjDBbAPpzVyUfpRwQiQqlFeykNPMlZxlnAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p91QSJ2KVxX7hhXpbTlPyN20XlrTM527KpUkUv51UPGHK1fDeleJGsksZjsmt7E/3AL52goJY00R9H3hxMWm+PdsnvVdH6ywQ8s8/zCeCmfdg5N95tHI8trQ1i3pAwNIdou7qu3QXy3fUFHr62Eevg+2ZTJYqxcN/z+tyOSytYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP20/q8m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so22304285e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711272732; x=1711877532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6o+af74WSP97HZ3puohPzQ1dX5G0dkc3ZQTYmDMAGE=;
        b=dP20/q8mJbHx8pWOFqzeAcLXhJ15cwt/FNg0/PpObP7cxc47G9GnOSp3xiV+C3Wi1k
         WzG2wlVljgS8wu+ux7jfNG4/XWH2AghWRgVgoJLze2Q8a/LxcuoyQXnWnTfENNr3Zzga
         aItVfMrn89IlTb2cO7HMGnzSm6aR2CJk1YoykrPCMwjPOfKFQJsHaHEEiEXFqEIDp2KM
         mujwby9KQjcV5FUfv5M5YcSs+CgVGvqR57fXAIxpHYO9hTpnZozPfGTOgfqeGqZebWsi
         RNWuyUjhFX1Yi410PbwYErPgWEu9c6XDL19rjbvs6GTUPR+VeSHPoTxQmFW+Tker8UJY
         TmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711272732; x=1711877532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6o+af74WSP97HZ3puohPzQ1dX5G0dkc3ZQTYmDMAGE=;
        b=axxDm+e936aSlNUDK3B7wU7oQ8yYTLLwSXPypKUTEbisHyATECdNeKT5ZLnGXGjBRH
         5stE2sclemSQyyIAI9OWeHtkP6S2rh5yZQYt/yvCMb1/yaReV+UTqs8/tCRF/1dgD7iD
         EOrCTlucuJqdShsF1AfDFQFiUBq2apd7xw9MigjId9/dWW04m8viekpmkAKbKqf6P2t0
         RsCoUL+VrWAG8DF2OFajoifU02/HIBlPBTkH1KI+Re3H1WQ8lh2Nfb2XsWnZuIcZ/rj9
         YsoUthMc3t6ubA3VTvhR7Rt54o7FOmwVSq1ZPs+UIRSF3HDWmn+Oo2e8UQPW1n55N/sS
         Evow==
X-Forwarded-Encrypted: i=1; AJvYcCVxFaWsna+pF7GNd99x+q0gbX9SCDItTi4pY13O32z8zdj2747iGCJXKmYgfFPZ2t6XAJ9JmoGaG8BszLlAvIpzZ6v6LSCuIsfLm4h4
X-Gm-Message-State: AOJu0YwXj/uJ4Wqd6RyV5U8e1Is9NoqONRbV1kej/TXtNJmhKxBkadSk
	0dpOQFAmz1IBWVBrMp+acBT0PD+aq50pJTvoY4vROHRYpX2VVHSB
X-Google-Smtp-Source: AGHT+IEcC/5j7E19kInkz6JcOC3nZEaLiAPqs7fStpTxOCqmWu64LIxS1gCBhb1GmJrsFvK69qshSA==
X-Received: by 2002:a5d:42d1:0:b0:33d:7e9:9543 with SMTP id t17-20020a5d42d1000000b0033d07e99543mr2605274wrr.32.1711272732281;
        Sun, 24 Mar 2024 02:32:12 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:42b5:8c78:fc9d:7600])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b0033b87c2725csm6490711wrb.104.2024.03.24.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 02:32:11 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
Date: Sun, 24 Mar 2024 11:32:00 +0200
Message-Id: <20240324093201.793485-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324093201.793485-1-ikobh7@gmail.com>
References: <20240324093201.793485-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver can't actually support 2^20 devices.
Current RasPis GPIO pins can actually support only 1 device.
Other or future platforms might support more.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index a351b7acfcff..9fc93fa454b1 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -47,7 +47,7 @@
 #include "rf69.h"
 #include "rf69_registers.h"
 
-#define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
+#define N_PI433_MINORS		32
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
 #define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
 #define FIFO_THRESHOLD	15		/* bytes */
-- 
2.34.1


