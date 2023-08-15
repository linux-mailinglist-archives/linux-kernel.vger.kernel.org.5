Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3085677CC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjHOMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjHOMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:14:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E671733;
        Tue, 15 Aug 2023 05:14:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3197a71a9c0so1072139f8f.1;
        Tue, 15 Aug 2023 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692101688; x=1692706488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyXMRhOdLAsflsZxbsHhFbM6pTunAygx9wUZGK4+va4=;
        b=cDfuUZCgemlPICUotl9bXplDlFIT8Js96e3xxyay4LerLktDGKE65nSJp2VcKmtFd+
         y9z8GsltSobQ1/vXuZoc45l+lQDcjzQnMbDk3jvhWagXVlEKTYJJZNTXzCkmG9K2oPKT
         m2ZVs8o9DIW1exS7ixATKr4s7xPO1R+qbmGYfZlFyZg4zmMTiWggRutp8j41InW/yytL
         IVQAiYyhviYQZphveamqbRx6txd64xjktC4eLoblcXWmIv47pTirPEKuNaB4nKOWD5x8
         s2RmV4ClSaZRgtlV6lt5L0ISjD/mYEoTDmPcXXwfrpIQpKAkqxNeYOYwP3Z/ss9Jf8bs
         zsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101688; x=1692706488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyXMRhOdLAsflsZxbsHhFbM6pTunAygx9wUZGK4+va4=;
        b=Kj5qYRxy77AUNw1Hj1YKV8r73/CW4IBuu78AQjaGb1i1fgMm2nxB5oK8CVEDmaUVPJ
         tVkmleEfT3yaB0pU1RF64OpeVF1jriX06zrgcF4LZaIrfOhEhgy2ED4LxLrEf0EfaxrQ
         LtmxgeuvnoYBQ1rMb5pqj4H2yE6hyMILwcFTOQlVAEBhBvbkQCnPesnAA9XGwVST1vWW
         iE7cwe5BlAhOoq+i4BcTVxgxluarzIhmCDiCHV5Jk2HiNEyacPfJwiGW0DRGtKycy89n
         jMJbmjNCdWVCw4AB/IFRAfY/x4kLdKAzYxCtccxe6Wa+Zl3/i6KfYDl+Lq1gMMhl73RA
         y6bQ==
X-Gm-Message-State: AOJu0YzY1GuFqsGFlymXtHNOxXH+HkL411CBBDhnlyy4WXDpNAPUSzqi
        poj5iWlRN2TDcGvaSUw6iM8=
X-Google-Smtp-Source: AGHT+IEwMuqs1Ttrj7d7T5WLLsuOk7IcerlFOkms3rb9c6fPo6crXQko9+9C8C7o/m8iOzB7ZLRmew==
X-Received: by 2002:a5d:5292:0:b0:315:a235:8aa8 with SMTP id c18-20020a5d5292000000b00315a2358aa8mr1497503wrv.2.1692101687680;
        Tue, 15 Aug 2023 05:14:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c228800b003fbcf032c55sm20631723wmf.7.2023.08.15.05.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 05:14:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH][next] media: mediatek: vcodec: fix spelling mistake "resonable" -> "reasonable"
Date:   Tue, 15 Aug 2023 13:14:46 +0100
Message-Id: <20230815121446.742742-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of spelling mistakes in pr_err error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c   | 2 +-
 .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
index 9e744d07a1e8..6bbe55de6ce9 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
@@ -68,7 +68,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use
 
 		plat_dev = dec_dev->plat_dev;
 	} else {
-		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
+		pr_err("Invalid fw_use %d (use a reasonable fw id here)\n", fw_use);
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index 5e03b0886559..9f6e4b59455d 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
@@ -109,7 +109,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
 		plat_dev = dec_dev->plat_dev;
 		rst_id = VPU_RST_DEC;
 	} else {
-		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
+		pr_err("Invalid fw_use %d (use a reasonable fw id here)\n", fw_use);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.39.2

