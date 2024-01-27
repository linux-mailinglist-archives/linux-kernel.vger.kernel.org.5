Return-Path: <linux-kernel+bounces-40932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312383E847
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D3D1F25502
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694BBE66;
	Sat, 27 Jan 2024 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWk1iTHz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D820FB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314790; cv=none; b=hnwE0OVKGCQwIUSpUFbrdlrIa2Uf3qV/O1mwoGEvLV6WdXzcjVKHbuEjji5hxtObH4Q/cybnIL/IHr+aDLbv9j6jlkBktybjR+UgvMczSxq5HxmzQmpKWt0xaKxLqtQ1xuwGunCNKODiEpyB+j9OaSpcxLnd+nYkjJQOGWltZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314790; c=relaxed/simple;
	bh=uTi26V2MzJtJNZVNk17iXxL86RmaAHxtWr8TzutnTS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgfO0fbTyUHAVlZa8K1BWmcAnBORA3jYn0Iawp/T61oQ5pNqnzq8NlsO1MM/GpdAIE5rcnuvT/s1R6ADxrt10nHv1XZF5PAjeyd2R6myDrPxl0yJ3AplYb8tJGKanU/HlDJszM+cB2GyGaBw0RjjGhBQUqRGpWiTE51j+BupROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JWk1iTHz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5101f2dfd97so1230329e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314784; x=1706919584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RijGLQFZHcqv92gTLyle4UGWg8cGZKgYkgyYQE7GkCw=;
        b=JWk1iTHzJzpglp6l5Ay3dUG9fjksSE5ZItlFnPVNkkwUuzq7y8r5N41VM3RW//NM2n
         690WtqLbGJahlImP19V9N7V85pFjDipX5V1ldh2Rimt2A6jkxobMrUl44hItci0KBRyT
         yI7btL0D+LRv3f62FOvSQk93ZV/EOkyXuZKbh3kbaiMfYWQybltZ65ZxYQnaqqsgb087
         icuffZZHBbzZIr6frqG82Wnk8XdTNTzH5Irid1laafN2YK8ykGtqFFQlVqoutQ9V5U0b
         LdO7Ro+wjd50RsKRAWa/kAvTXpff+l35vwY+ywigo9jh0/DBnQrF++eweihV+ItK0gaB
         S+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314784; x=1706919584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RijGLQFZHcqv92gTLyle4UGWg8cGZKgYkgyYQE7GkCw=;
        b=c8ufTcPo5DxdXKL01SdhEYxJjkVKgF7uJ2en+RWP4vfVLbb/ltiVvJs8Q4xLYOMEwV
         8jrxCPkcuRxRxFNnyGl1BKLsBpbNxPJDwq14DiU77AXn9xWKJ2LP886u6f2fg3HeDSe+
         Do78GXskLswew1eeyvR4W4xbFokNhzGT9kuLDXrHEAH7EtZPEzpBSdLPRYp0XVmvYS1k
         b9bs+bJvvh+B5c243E+olwPICxCK0p4t/WBMDZGskcEMM4r9Wv3eBO2Z7ppNZxthYEYj
         44WGmy/BLhqD6XQnWu30WZDHn4n48Ver/jfcjIyF2suGrPBRQECjFgCA1EipvtWZINT4
         rcJQ==
X-Gm-Message-State: AOJu0Yza70SlkcExbRFvMkJqh8Tn8ggsdvcd1eIlZ4D7FhQQQCt2rZlt
	w7w28DyhM42sVAXWY7J03gAk7i2TknMqhDe++SUuBe3bnkaEgJX+IOUJKi62ND4=
X-Google-Smtp-Source: AGHT+IHXhvQ39nd+PSqqSqJd/nBtIFloGi99hX7CfKfchouqertJrL/Z5QqUIu501Bbs0iC6wDC36A==
X-Received: by 2002:a19:4f53:0:b0:510:d4a:d367 with SMTP id a19-20020a194f53000000b005100d4ad367mr270843lfk.2.1706314784131;
        Fri, 26 Jan 2024 16:19:44 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a339d705a10sm1141359ejb.80.2024.01.26.16.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:19:43 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 9/9] clk: samsung: gs101: don't CLK_IGNORE_UNUSED peric1_sysreg clock
Date: Sat, 27 Jan 2024 00:19:13 +0000
Message-ID: <20240127001926.495769-10-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240127001926.495769-1-andre.draszik@linaro.org>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we have hooked it up in the DTS, we can drop the
CLK_IGNORE_UNUSED from here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 7f6c3b52d9ff..d55ed64d0e29 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3393,7 +3393,7 @@ static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK,
 	     "gout_peric1_sysreg_peric1_pclk", "mout_peric1_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_PERIC1_IPCLKPORT_PCLK,
-	     21, CLK_IGNORE_UNUSED, 0),
+	     21, 0, 0),
 };
 
 static const struct samsung_cmu_info peric1_cmu_info __initconst = {
-- 
2.43.0.429.g432eaa2c6b-goog


