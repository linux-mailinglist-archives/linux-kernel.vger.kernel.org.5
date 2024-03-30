Return-Path: <linux-kernel+bounces-125872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD133892D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A371C20B03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D847F47;
	Sat, 30 Mar 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAGToZ/t"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656455E7B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831423; cv=none; b=ucZwaTkNrzUTVm+A6ZfvOskfhOrZH3zm9NYt9hA3XEcBEm/clgPZ9hocGXbXVd7oxwnw6fPYy5aeBrx6qaxsWb7frljXLAPGdtC61o2w5fgS5XDGGA8Lt0J1536hlR5pDfQRAG7GqvsSwHCSEOSBU0kyYoKoiKNgxVhH/p0jTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831423; c=relaxed/simple;
	bh=uAy7H4eGCdk2E7sc7F+qp9jeOr5X36oynpik4Iml/WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dd90Jl5inE71Jb2VKmAUaH/gGcgrcmT1HFTy8Ore3PFGEBhywp60ALyQ5/uwybwCivFXXKCL2DG7BGG+Hq2Q5DkCfLiaZo57vpQaqvaV39EodXf1bGwFvaz/obH/1bMZJN3HhY3I6Mwf8D8/MzjCKd/G+pARM14VMluHnsL7MXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAGToZ/t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341cf28e013so1995526f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831419; x=1712436219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VY3Dmu4EorH40eckWnwkm3etCmE+/q9rUNJeyLZY5c=;
        b=eAGToZ/tr2c+fmf3J3m05jgEiSHdjCpwAfIVx1HWOueMkE1ZbEBKRRaKLG/Tvxra1l
         L2i0/kEN1NQmTGEztQJ4ZYWYzKQAgFxqkivopUkMpNQsrwfgXrqNIfx2y2EdcEkRseZr
         SD4CgXfSqmntJK6ac9nrhoAp552gzTOz0YTZuqfrYSbdzWH0GMvGCVfCmBPz5t93p/sc
         qSKzrgp0HiR6Jm7RLpPUDGwFxFKe2sKwHCnJX2PKGW3PQ+cUzF9x9K2WEmiCsVqPMOO2
         PWKVcxg5Ac97yEBEPNvCQ2jJQnUtrL/qJsPeEnQNCUmAh1YOOZk7RizQkA8ko3zcmzNR
         iLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831419; x=1712436219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VY3Dmu4EorH40eckWnwkm3etCmE+/q9rUNJeyLZY5c=;
        b=N272Ko/nAI3ZYvXeYya6Xmgb/cR8grxRPpR8E3+B9Ny4JvLj3+/1t50cxSHchwjSu4
         Svu68dvDSbqOAOJ7YT+sGMNzMxOBQuenF3u4sc8kdV/qYWjVg+muCJRu6qpYRMsVFFCK
         uVfxdgN5FmSRw1MSeQU4Kssbj0oeTdHa3AXbnkP/jMS52rLKEu0T+79lbfztKFSl1WOZ
         YQqMUJ+JW8AeL7FlbVGAQj8dT0eVPylAU9PpnCkFwaJ4uWS8yt5bTnjDkfICBcA0QKCb
         xyDnfceRBo9iOaChGNUpyqQquhI8HvLIkgefHtH7cFNMAdL4w0Gcl0tvIT+pKhpC/PGs
         KpyA==
X-Forwarded-Encrypted: i=1; AJvYcCU46VYzL2i/ccU2aAdvj6tyA2AAdYCL39mEgM3a2TITPnHFeQZyD8wNFEHmnlAuaJiKgmYIQw9scPNpB1lm8l8uWtMsv7g0Vq8g1mPr
X-Gm-Message-State: AOJu0YzmUtVkcExH92h8lh/mYCA6xG/bviYhJpRe1ra+zW8YfmsXMJz8
	+0KtHaNJhhmFxXZKx56cj3z6Pb4qYPJg+N7/0rNxCHYWzGbtwGif+1mYXkSKg9NrT1QYTbQOtag
	2
X-Google-Smtp-Source: AGHT+IFbOCs9TFu+n2kbIFtRw36Yy/n4grYGsiHavju/CpmA97FWAH4OFTc4Ow13LOgAlK4kyeKMcQ==
X-Received: by 2002:adf:a38b:0:b0:343:30a2:3a3d with SMTP id l11-20020adfa38b000000b0034330a23a3dmr3563635wrb.62.1711831419771;
        Sat, 30 Mar 2024 13:43:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:19 +0100
Subject: [PATCH 08/11] drm/mediatek: rdma: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-8-fd5c4b8d633e@linaro.org>
References: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
In-Reply-To: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uAy7H4eGCdk2E7sc7F+qp9jeOr5X36oynpik4Iml/WI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlrb77pr3hI7+1RouTIhAWQ+29VPx2IGr5m0
 aF4RIu/KVOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5awAKCRDBN2bmhouD
 1yUMEACHHdY0DRk43LPsx8K5J8nDnUK18mFIQbvuGtiJzvZikxyF3zwRok38O2UNaH5BC8WnRL9
 SknXjkKjO47v/ExyECq7PZCAlGbVP1UUOGZPOmLwqprakytYugm/F8warYH7pyWbJlpyL6LMKb9
 /7xmg/t2T7chRpKnRpchAm/6nmdpeInomU/50jeYZOSz5GHq0jQA3a94tyyOoojAXTpWGxhtpSJ
 LAqhvP33/QUq7MMfF2fbdorclE3UW7iUM/gmzGrUnQsrnl5SmBzGsspbn18ewr54P4a/UdyyTm/
 q1w4UxOuC27FK9XMWFNjt3m/gRfTfEA69wJlVIqa8Ea7xjQeGkt3YBw8M2wg44Om97ykwxhCeRv
 CkNA/cTN/sMne1Et/eyRcUgT+nxHgVSgEMjQwYWHd8Jqxzu3G8P/oW1ZADpufAeMJg+aW0oqh/Q
 FBmIDXT2H6rCIR5w4SYctLhfgUp8C8AiTCUYlCxvZaQZY/QU7znvAbdRXQvafwNfzCkZ8fAQEP+
 sAbxYfedxBQ4IPQTuaRa0/efLUFzBkkftsZOXfC01j8UqCg1N7DN7Es8A+TOsEasn83a5pqHTOG
 FgNcwKOb7b7dJqQopW9HrzSoDWRDhAf8RT8t+OQnWbEOGoYwQa2pBMMhNQKCBq+aFrD1c6Lg/xW
 1XF3oPaEZT3NTlA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index faa907f2f443..844f5c2b56b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -428,7 +428,6 @@ struct platform_driver mtk_disp_rdma_driver = {
 	.remove_new	= mtk_disp_rdma_remove,
 	.driver		= {
 		.name	= "mediatek-disp-rdma",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_disp_rdma_driver_dt_match,
 	},
 };

-- 
2.34.1


