Return-Path: <linux-kernel+bounces-58667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F150E84E9AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC0128E9EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DFB38DE9;
	Thu,  8 Feb 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moaMQX58"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796D383BB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424075; cv=none; b=IiT6vnHUtMFgr/4vgTSiWRakYkkI3Hd57yBj8eOh5/dISs1Opa5JBi9cBrKvV5VXihEkY2zDJJLRybK3v4d1sl6sQQty2DrSJg05FF9Y3agUurVwMIpaNDCXCotA4TeaGcfgJk6hoVea9KFX0obQVGLS1nmNzrfWSA7p6t0+LL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424075; c=relaxed/simple;
	bh=vFxXV0CMitFA5HtWV0cE6DuKRu++Rris7YbjEufvo3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtyKgMUamkzSdqAh6NrgYe5UAszNwquPt0ZFwFjh3RdHf5Pf2DJRa60I3EFYtr7QwRbI7YyHOeaYs5DRAjtLpZuAbM6JAfM9QtylRGEeFZAgIl5UJIYYKE8o/PvwzygHWCkm18BJHmRlSs93luzjhl/xX/2p3KRtxYAODgOBgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moaMQX58; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so2241395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707424068; x=1708028868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JuiKd4Pqu+cNXuLAtoDDjFiKegltder1S+vVqg9Rbg=;
        b=moaMQX58ofWGF0zC2+Kql5ILkzmCYwS1sUVwT3uG/MMtZPbmdt6kQg9IXFmpynFijZ
         CZ6Y8dik8WtylJ0T/qByUNT3zmE/5cnlrFoBoii6LoX3jQKurkw5x6g2/KUZ7QzhCzB0
         m4F7liWYu8ep5mwGN2XlPWemNuVKng99Nx4kzrU1cOn/CQK98EibSS+OqRidz3XbmyK5
         Kn0ECEej+qaec3vY/o5/NzsKnMRCHjfqf+9yLmRKTkuhUpbX8hSYRL3MLHVL2RthVSaQ
         GClFpkREHU7f2gjHjAf+JHjiZ9fPsxNiJQ5yUbO8HqiMOuxEcIfpOKQTM8AIDuSggJtF
         MXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424068; x=1708028868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JuiKd4Pqu+cNXuLAtoDDjFiKegltder1S+vVqg9Rbg=;
        b=VD5j/isrinCPnYigjN+uNkPBC9ehw6w6osshGOqog3FvrqW8KhG7uZ9ofaNf90+9Ji
         YQ0KAxbC7YRPOFqVWGkqZB9hCjdZcbm5ePYgZAOsuf+B4AqSPXPXV/L33eCvanRQoj+Y
         PbHqi+y88KCyczG0W9U2FHzNnNcPZYSFVDplZVMrDbWEgi7a9GIxBY9OWiN38kDAEMXs
         15wLaeA+IYZWujZBFPVLUkqDAzsq/8pxIVn4KC9CNZwMgKqRgnd5u9mSazxBW/4GZZcU
         /EnNlu/1ZnVAOrCWsS+FH+k5cFqtf1nnqb0vLytziu8aPF9YsEkc8+oPAnhR5k1rK4+1
         qZNA==
X-Forwarded-Encrypted: i=1; AJvYcCXu4D/wVOCxAHftnHbVoPMnw008zgab9piBIsfHKOwM4km+a4tjsk0IMwlvES5tuXwkmKMQsP6nAuACqVmn77ikhd0dmCpfAWhnXEP1
X-Gm-Message-State: AOJu0Yx0goHpSHCu7vphd/oMx3JVNZMjHVbV1OJzSY7GWyFE70TwQFax
	ullUKPDM1I9U0iRRKyJ4a9mDZFTFsafYh/euewfR2jy2Oo8UeIvkt0y4mpeBw416F/RWnf8atFL
	0
X-Google-Smtp-Source: AGHT+IHrg09/crGsPn7Yv0ifeRJcFeNOIWdggXx/AD6AvYfYliE0xR5RyJWvAN1mLuWDbNUmwria2Q==
X-Received: by 2002:a05:600c:4f8d:b0:40f:b166:7688 with SMTP id n13-20020a05600c4f8d00b0040fb1667688mr339622wmq.15.1707424068763;
        Thu, 08 Feb 2024 12:27:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhjwHl5cnxJuvqsCCefS/vwqiR7V/KJk9qJX1AzhVUqLI1edCldqbn/2tW2G4yxAwdmnkRVixnmeP9M2toQqqYF2wGMygKsdGyxfogumQ+mwUcpQqbeE4zGvhPGMpK16a/bu/ubuQo
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0040fa661ee82sm368027wmq.44.2024.02.08.12.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:27:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dmaengine: of: constify of_phandle_args in of_dma_find_controller()
Date: Thu,  8 Feb 2024 21:27:42 +0100
Message-Id: <20240208202742.631307-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
References: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_dma_find_controller() does not modify passed of_phandle_args so the
argument can be made pointer to const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 775a7f408b9a..e588fff9f21d 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -29,7 +29,7 @@ static DEFINE_MUTEX(of_dma_lock);
  * to the DMA data stored is retuned. A NULL pointer is returned if no match is
  * found.
  */
-static struct of_dma *of_dma_find_controller(struct of_phandle_args *dma_spec)
+static struct of_dma *of_dma_find_controller(const struct of_phandle_args *dma_spec)
 {
 	struct of_dma *ofdma;
 
-- 
2.34.1


