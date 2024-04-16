Return-Path: <linux-kernel+bounces-146086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A38A601F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA721F2361A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284D5223;
	Tue, 16 Apr 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGvM8oGg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932994C7E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713230428; cv=none; b=Wq2FNu5oZ98KZugEKJe7qmcZKjXBLG6UimSpQ+b9no+EZttWEeXnhqVRSxpAaPJk5ecjduRpDxzYzJq2QVfbv9fW00Hw0quIykkuXlih1xpEjyV2K52bD5lXeDU3y9KD0C8puF0dMOsGQuQK/CUYoWv7QoqqIL1QoMo6ezGy2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713230428; c=relaxed/simple;
	bh=iTXC1HastUkjArtDpmP+czeqPs0RdtUw86qhG4JAjrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ffn5hji2P/F/sDYbeL03/JKxuIvVa4ao9j81ikQSvOc7HwDmtuM/ZYXw41aOZb3bK1ZrTABFqaTdFZaRboBIB493GuesZtPwcDmXrSBMHVJQZWC8BFNUp9pnXocrPI4sIc960ocWDJn0lGIdeF7jnMFZLXfHtwIEAjxzFOcDE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGvM8oGg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso2794838b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713230424; x=1713835224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcz+73pSqE9SfopeTAgajRWWiV1WsHA33Nl/GYOpK3o=;
        b=VGvM8oGgJMneFc/sRop+Sz87oJDotGvmwXHuj/qQUdjX93Nl7IdZvG20rnsd2b0cF4
         CHi2zBVDHd+GpQuxw0pYOaSuA2CZxniN8s2XRm2LrSauDX13DWtLESkJL+N9ky3vefBx
         Ld0Wk3eDRA6CP3Fd9PzUnHndF8QBOoPItjIWcw/iAg1zjlUx95mK350n27ASFvEbRGN2
         z/gbgbV9tHX24UE91Z1o7JbWKkBKV9WBaQphbNEJahHwE7lgIEkaRw/z22/wJbXSkOzo
         /GnegE8efLSKZlZUnZQdRkNuS1MncdK7sXBJJsQZPFizzl8dMli9rxoxUImgedEETy4g
         lRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713230424; x=1713835224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcz+73pSqE9SfopeTAgajRWWiV1WsHA33Nl/GYOpK3o=;
        b=Y3MWUdYr8FC7li/Csfc8y+h7nmd+5s+kkcW++t4BSuGo4DPdw+h5uOd1lubPkmwM+r
         O+I5qKiPo1pLjbHafAYkmHkRi+wOJGp301MbUxsrnFRgL3bs9Z5LQJ0oq9uLoWcn2Lo2
         FmOD8UzxodKRAki9k44pmgPfRhCHYJX0ky1r3rNvEG/irDwPcO8Jz0++1VbycF3LXRjN
         duYBYroF2Ov6aqQyMBy9hkASVjMLyAuMacDfvvpwKfqyw2h/OPuXLMLYRhR0s+oEkPJS
         sBVCTvqtjy2X1VXjWzRDaQp/tsO/O1kggkMyH6p8LBbYAgzne7MwW2rmWIjVgIJ0VDEm
         RoxA==
X-Forwarded-Encrypted: i=1; AJvYcCUB2YI1gO+duxIKm5Eqt3MJkzN2AAdNAHISMixGH8oyVgRj2UX//ppiFZzP20fZCPq1FUloIUslyajH9F73Lc1/9G/w9E5HFaaVYmKg
X-Gm-Message-State: AOJu0YysH2S5nhfAmPgBhA90LhJRD4G0KRqojvLYfWH7ZuaO3jYSFVxk
	Uwiln3UQnZINKf0Lp5smZfsvZYp4M3GQ9PBfEDAVyczahhqDUAYQ
X-Google-Smtp-Source: AGHT+IGKSm5nin6p9UNwnL1BsNEX4TIhlHRZpogTl4rQv960sLOS5qdNTVHqAH3CSeYwafOn5VBL6g==
X-Received: by 2002:a05:6a00:b96:b0:6ec:ea4b:f07a with SMTP id g22-20020a056a000b9600b006ecea4bf07amr11785479pfj.34.1713230423713;
        Mon, 15 Apr 2024 18:20:23 -0700 (PDT)
Received: from mari.. ([2804:431:cfd3:2714:2d55:751b:9f5f:563e])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a00181e00b006e6854d45afsm8061866pfa.97.2024.04.15.18.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 18:20:23 -0700 (PDT)
From: MarileneGarcia <marilene.agarcia@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: MarileneGarcia <marilene.agarcia@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: meson-efuse: Replacing the use of of_node_put to __free
Date: Mon, 15 Apr 2024 22:17:51 -0300
Message-Id: <20240416011751.93016-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free for device_node values, and thus drop calls to
of_node_put.

The goal is to reduce memory management issues by using this
scope-based of_node_put() cleanup to simplify function exit
handling. When using __free a resource is allocated within a
block, it is automatically freed at the end of the block.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
---
 drivers/nvmem/meson-efuse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..400a9a075e53 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -42,20 +42,19 @@ static int meson_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct meson_sm_firmware *fw;
-	struct device_node *sm_np;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
+	struct device_node *sm_np __free(device_node) =
+		of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 
-	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
 		dev_err(&pdev->dev, "no secure-monitor node\n");
 		return -ENODEV;
 	}
 
 	fw = meson_sm_get(sm_np);
-	of_node_put(sm_np);
 	if (!fw)
 		return -EPROBE_DEFER;
 
-- 
2.34.1


