Return-Path: <linux-kernel+bounces-79612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A118624B1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B131C1F22669
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA5481AD;
	Sat, 24 Feb 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE+dd33k"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEC45BF1
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775155; cv=none; b=cW+bcm+h+9AQ64WvlfKnC0iMhRp25W9KcrIakoP8nqRWBxVzfssNZocTe0kpX5xkDpxmlMpXit40BlJ93fiv5da1faex2Y1CC/FpXegggSDdJEm/0UksQPPwpe08ZGEFtdBKDZQKzR6ahyV2/lAY7bJLfXU6oNs2IRHF6V3914k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775155; c=relaxed/simple;
	bh=hRacKiyoOozAs2YwTKpgReT2IizopoY29GJ/KuQJzc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYp4QltMgeV6+ka//290v4J+I/q577Pzlor580DpP/BYPMKr8LLTixgWRXTJt7TBxl/Skf8bIaj+EqJUZrzxExgwjTqjAEOvmhFJSA7qUF8L82Ber7txWmyJarPB7QaSN1XpdH1rtusq+3bbaB+eYAzClOFNEMhMMwVPWTpFdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hE+dd33k; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e550ef31cso195951166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775152; x=1709379952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URkw6QL3Oq/n4HIqTGKXvI0jPn9hoyzzXsS9+93dgl8=;
        b=hE+dd33kQKPztXu216g7h+auQ4Ksw4lB4+8L7kLCuiDgiFNTFPcya9fK41lvXSHD0T
         i1eRyZ85TPPvgYwYLxb8e1yFcE2TyxTz2lk+gqAb40emLj3LSHGYqM4SzFJLT4uJc8In
         pkRcFSfuKw1JCNswKwIkAP/G7TOveShhKDHRgP5oeYHOCLmsvqNejhBFLHpXC1Ui3+/0
         GF/vKqEXGKZMPL39QKisWxLFw7uPnFr6TTaJTpF0b01/gEIciN1Ky38Gg57R/ebG331a
         r4Pg0QYSrEClVhkm/qVOjWdWEt6M5lz9t3kQLREjwaVytMN6x1OQlXnwFo6ZA1/UclQ7
         TSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775152; x=1709379952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URkw6QL3Oq/n4HIqTGKXvI0jPn9hoyzzXsS9+93dgl8=;
        b=XLp4qPsYaKwHA2m55oSDYrYhVhhcnEwpwEaCQNTCMJ0oakmYC27+jAd/4qObCsdCtq
         Vf69vW4Jupd+VWCKTpRLBqmQe4DjD4W0RGVgV+5V4om19tzJcor2B/kLNVXs3hzgPMcp
         3NfJcBuCNFWwKm2kv/0gdOJ6qayo3xlgFV2addQR/MPnkT3jaYVr3nQMXLXzmLV9Abb+
         bwiJeXcQCNZIl62gb/ZlRjXi3fGBShLety1VTCi6CfqiZPRuNG3Hq7t1PetrqsZbENFr
         w+u+T0TdGkHF+YvSpJZTvGiEHV2AjUb5cf04mTWRSJdpPt5zJ2lERhhuEH5IiylKN5C2
         exUw==
X-Gm-Message-State: AOJu0YyPQ5eqBe240D7duQSa9lJK1ltAVSbWoVOv+buuHYGMBJohTdH4
	MEKTDWtdNAjQNcRrI/Yf+CT3RAsJqm/8Wc2XqFYU5/b2xFZK0g4AlZqMFWA7rCY=
X-Google-Smtp-Source: AGHT+IF0j8mIW/j2kclvfhtXjlLffaGtRDDCesfO3dMw6hhzA7CsFPBjo95LFtlm93605AD9thPL6A==
X-Received: by 2002:a17:906:f15a:b0:a3e:66b5:d65f with SMTP id gw26-20020a170906f15a00b00a3e66b5d65fmr1364758ejb.67.1708775152267;
        Sat, 24 Feb 2024 03:45:52 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:51 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/11] nvmem: mtk-efuse: Drop NVMEM device name
Date: Sat, 24 Feb 2024 11:45:14 +0000
Message-Id: <20240224114516.86365-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=LEPiqIe9wBwdCEI4P2jYHCIQnpNr5K0HnCD0iOgejQk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbMfoh4mpVIdPSn++fEFATNn4svgaGXpjR3i vH8rIVjdSGJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWzAAKCRB6of1ZxzRV NySMB/0aBffAawyRKQzW4dVgLR2bNJiKwVW0LoncNsH7PKekAQXhPjEu7AWzYnCTo0zNtOldSE0 W+9wbQ6DDSCSqYmOcpd/UClepnkBIFypGGu4pvYMwcBHQRxy2NIHxxc2elcYjWLEljRsYTpp5UO LxgZT6fxqYCZPixHMAMGLLVb64GoNMq1HECZoLvU1o4XiAt6F2jyXvfdl9imIkJcoR9k2l19MeD CzTCUvpgltHd9ZrnqbGkscZ0h11KKsUqL3pfDgOUjUWibdsNHhtPq44c+oCrhR6YjiICTaSz12Z al0WW8sq52jyBimagdV9R3g9l3qTG3ISxvARLCYNiPX408Aw
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

The MT8183 has not one but two efuse devices. The static name and ID
causes the second efuse device to fail to probe, due to duplicate sysfs
entries.

With the rework of the mtk-socinfo driver, lookup by name is no longer
necessary. The custom name can simply be dropped.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index f5bebcecf9bd..9caf04667341 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -86,7 +86,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
-	econfig.name = "mtk-efuse";
 	if (pdata->uses_post_processing)
 		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
 	nvmem = devm_nvmem_register(dev, &econfig);
-- 
2.25.1


