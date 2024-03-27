Return-Path: <linux-kernel+bounces-120375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362888D664
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A841C23C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B72C19C;
	Wed, 27 Mar 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt4Yuypc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362B28DC9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521125; cv=none; b=pBQ7BB6zGN9dLleC9FfO2da7GRpCNZYw+YplxqESX/YqtYHGObnzwC6n0QBsEUOEAmmyPHGvQ6nl1YV6pCZUzyftItB4fPpqS42Bpw06yCekNIlDSDZJ7M1Xxx33cyxpbpqvEVzey6ms5R089UiHhC5ZJHzM4UpxixqxEwvXqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521125; c=relaxed/simple;
	bh=g0sSGIMqyKUaiS52PdHmmBKpieJXgizPR34GFcX8YuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMAlQdH6PXlCELypUp8PEQT4rhN1yr6XgKB3p5UBpd3IBO9+bAcDMpZ+FUVUcPrdwXnrQySMpx2GMojcnS1+FeFzPhsbPAMxTHvxBU8ncWo+bj7hry2YJJjYB8dG/2qJN40JQUhmGheKVtrVAH8DEC0+gY+H9nn/yw+YznHgNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt4Yuypc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4149521d76aso979455e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521122; x=1712125922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whnwm9LIuo5d0uvegSBW2q/SblIdBsUkDXDYlxzepdo=;
        b=Gt4YuypcsLoJjObR6rJlYfW59uwz7e5EcVt8xb8B8pnZtO5gf/7hSrux1h7ARJUllB
         B8urv+0brhuJmcBPVWJr64F0hW2uKHcqQPOmpHn0teCo6O4DxWtoHY9faZUhDzccidS8
         OWY8Yg7V1VdffErN/44VvVOO0Dm18t+xfpws8FDD4298HAFIXPKojTo8LF3T3LuNRM1q
         svtFVlWvXh9JSmMqM+YAqUwaGyh4JWoTX9li1QqJ9KTloBgn3Hros+2JGRXbc5283IQv
         BxsW7lfk4j2aDsIHYAHYge0Lq1aPEOv99K6/CNiVMVC5p5lbQOIQP8pwLQlrrfBRVg5w
         ZIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521122; x=1712125922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whnwm9LIuo5d0uvegSBW2q/SblIdBsUkDXDYlxzepdo=;
        b=f7uzg4H/1y15pvdz9HNJhvXMs/P7lqWZcnAQlNbvpzXYbHzfeuQh1Di6OPk9w1eRho
         3sUflLeBrGSTutEK2fmT0kUK5NTDnKc5xDblnvlpd19cZ1ib9kw+rycuXeGX3Yf9D/jE
         3hgGXwq/DJp3dYTxHYIMww593Yvf6s6xQ+MmcBmYoOvoDQyGdT675Ty7MCCPaYnnOX3s
         BSvQelFF1eAG9ZRusb0lzvggPSjQBr/qTLqXTnWHvBmC8pmjq1AKOiM7KyzTQ98dLx9G
         hPAP+7h/s3M3uq54iyHdqXA5L/nyiDA6XSWyMgIp1C5EPzNTZP1G0nAit/REIaI6Is1g
         EUfA==
X-Forwarded-Encrypted: i=1; AJvYcCVvpUxjaSrxN+9YE2cXi1Yb8xWi4Bbc1+HnfvMbkHLf1JiPX2b+L1ilqc0wv6wo+RPs/NNuxVgoPj75CQPcAjOBIKNX27VNHlghB5Ak
X-Gm-Message-State: AOJu0Yys8oIDDIQY93kDHeqDP2YYbH1Cy80pEX+OCzq1MhnnLTAiIBQc
	WgDcyI3RXgvUsU7gNHO6tZxJ8oWxUcc4uyRCAHNSJAejnyKLGBBd
X-Google-Smtp-Source: AGHT+IGes5ccq4PCuu2spSfU5275eZvzHgzi4yKRnYKokfZdh61J8I6mlla6YrnebB3xll9qjGnxhw==
X-Received: by 2002:a05:600c:3555:b0:414:a8d:ca39 with SMTP id i21-20020a05600c355500b004140a8dca39mr2222097wmq.6.1711521122370;
        Tue, 26 Mar 2024 23:32:02 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004148d7b889asm1121360wmf.8.2024.03.26.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:32:01 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: pi433: Remove an inaccurate comment.
Date: Wed, 27 Mar 2024 08:31:55 +0200
Message-Id: <20240327063156.96307-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327063156.96307-1-ikobh7@gmail.com>
References: <20240327063156.96307-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment specified the wrong number represented by the macro.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
v2: Undo macro change. Remove comment instead.

 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 0c12b31c4642..ec9f07a4f769 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -47,7 +47,7 @@
 #include "rf69.h"
 #include "rf69_registers.h"
 
-#define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
+#define N_PI433_MINORS		BIT(MINORBITS)
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
 #define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
 #define FIFO_THRESHOLD	15		/* bytes */
-- 
2.34.1


