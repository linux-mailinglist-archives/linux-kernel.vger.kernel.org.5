Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD3764F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjG0JO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjG0JN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC94495
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:05:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso7732045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690448702; x=1691053502;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+TJpGsr5IM3UwlN83UkiKZZOgjN39Pd4oXdaPn7gsc=;
        b=F1pHguc2cF4LAfYQDfFD2T6Cot0NAVdd21U8SN2xxoA79Fb+JzESp5zIBZGhgVutd6
         Q5Ha8Y7E52xHHQS/XbxqBf2dPmzqfzrvMvH5nBV6ngpzQQQp2ZSTB30sQT+OyrbqEopF
         GICfOyWWy6KBH6gerB48GJqVVay55RYXHEDIvMBca4qNgxH5iJvdBk+oohMhpbN+GvIp
         sDL2vCD6GRTeX3sZxjJL82JlHoSMddhg1zxtDif4g/Jn+AEFMGBkeF7MQuOJ9ze+MlLg
         wvhgP9qcjb40M/lusPera5yS3dpad8G80hNd/K59lAaLyd/hmIGO9q5x3mrQM1k4zgBo
         Ntcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448702; x=1691053502;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+TJpGsr5IM3UwlN83UkiKZZOgjN39Pd4oXdaPn7gsc=;
        b=d1gt/XsbvkCgKf2vwIGnPBcxaong+OYL+pmyjSW7jP/0TZ4eNCE+G8enzyRqICZowy
         0ZPltW+8ipaAkw/kKAnzZFGpCZ3uf6cSdj8ccTNEWo48aW5CYWAOqOs/Qh9Ie2akcQe5
         CiWeWoHNKP7mOfjwcOdR7YDj86FC74VcazAQuYRQRaTZkcGG4K42PbXJqEQnSrs28GId
         nJJOf2ajAzo8pvKStBAstK6phOS9PB2fIt72XgeIiOrLwtoBZFCSCdwzLP9GRWJMOSrq
         PjwvfW2fPDB1Dx7OIIhjWNpQtw3qBUJYV3AnGHd7A7F+VtBLCblq6hXxxhouG/uJp+vC
         +5OQ==
X-Gm-Message-State: ABy/qLZSuFHZMVeDta3D/ldKF93FylJ0WAqMc+4X1ieWNz1JzF/PuE1w
        FZEnOGEo+7J+a759BS32VHkBQoa/u28jH0AX3j10Cw==
X-Google-Smtp-Source: APBJJlHb7raNQew/S0J/M1dCSaAxdS0vzjJkoYMQnqmUAA4QpHAmLuVGgBcIK3qRuQyAkIJsvd2sCw==
X-Received: by 2002:a05:600c:2211:b0:3f5:fff8:d4f3 with SMTP id z17-20020a05600c221100b003f5fff8d4f3mr1253980wml.7.1690448702438;
        Thu, 27 Jul 2023 02:05:02 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:e0a:28d:66d0:1c67:2e1c:d093:e95b])
        by smtp.gmail.com with ESMTPSA id p3-20020a1c7403000000b003fbc9d178a8sm4108924wmc.4.2023.07.27.02.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:05:01 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
Date:   Thu, 27 Jul 2023 11:04:35 +0200
Subject: [PATCH] misc: tps6594-esm: Disable ESM for rev 1 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-tps6594_fix_esm_for_v1-v1-1-2adfdcad31c2@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACIzwmQC/y3OQQ6DIBQE0KsY1v0poKL2Kk1DQD+VpCLhW9LEe
 Pdi093M4k1mZ4TJI7FbtbOE2ZNfQyniUrFxNuGJ4KfSmeSy5p1UsEVS7dBo5z8aadFuTToLqF2
 rxDQg7/uGFWwNIdhkwjifHO2rxOsfwzvSltAssBgfIHeniAnL5u/K/XEcX67XZPqaAAAA
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Panis <jpanis@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=eblanc@baylibre.com;
 h=from:subject:message-id; bh=niwkhbOxpYJ1RnJZ6ZquiBrfskBde3+uYp5DP1sfZVc=;
 b=owEBbQKS/ZANAwAIATOnqtcZUUy2AcsmYgBkwjM2n7XrxLdItSAGCZSPHPa9h5bJUeCh60EywPl1
 1DPqBDiJAjMEAAEIAB0WIQQXbve4uGlGYIHwad4zp6rXGVFMtgUCZMIzNgAKCRAzp6rXGVFMtszTD/
 9Vnxgo/T1d3DdD8RN96nnWDYFq4OLikfOzvt7/mn0/c+xcoWXtWcNn6TO6Aqyg7zmsoiLdHaHwnv32
 wovLeLZd10Hgqxiw+Qdw1VwHOgcFVolIHK2dEV+0YIXD+s45ZI4GR09OLvy+qNLG5OLy4310NyDIGg
 efKa3D6m4Cp+ytPQWnl6wDwmt7NdWiygFo8mYvYfqG691FluHmuu2xiZ1pLGYKuosZyCeBnqVncJQW
 J4WA+KtbSu0vAMIlGy94UvKW27YGhXj0X4lhFrLoLxLPmZ3mfGmynSwMRIG+hopZeXwRC0bDKY6X7N
 0o69AbaLKmdbmJXNLai1IYjTLBQGZVlAT62FV2Xbj7t+9F7LaH8K26jQsZc5V8Ews3zbCpPPBAQI+P
 AVp6vqDhzmNckaLRkvrygrOSxEmJKiSelQuaIelG5+UaxLz8F0qRyj5L9Q3QhYSF8BYNBzTKjkU7BX
 i7A9Pand6Ye8+JyN6rPJHpj7QjSbVtqqSiZyfSLTr7yRb9Fcty63HDpkVvGyaCGELgx52TCl3XyX9+
 ms2asIMnRtBKtDVRjpAXqm99i3uL5dDw3aEb5fNsh29lQE9NisJphxHy55wxf5awnE24txNNmJl4XP
 fXkrNOAnqhC3nGYNbGy36pqtY8wBvLAbzLP3D2kxGeVYriO5//TNT8sUUbIQ==
X-Developer-Key: i=eblanc@baylibre.com; a=openpgp;
 fpr=185A32668351ABE95821FF4D589741A8B26DBD62
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a silicon bug, ESM on TPS6594 PMIC revision 1 is not working
properly. This patch keeps SOC ESM disabled for such PMIC.

Fixes: 875fdd0787e4 ("misc: tps6594-esm: Add driver for TI TPS6594 ESM")

Co-developed-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/misc/tps6594-esm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index b488f704f104..05e2c151e632 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -13,6 +13,8 @@
 
 #include <linux/mfd/tps6594.h>
 
+#define TPS6594_DEV_REV_1 0x08
+
 static irqreturn_t tps6594_esm_isr(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
@@ -32,11 +34,26 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 {
 	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
+	unsigned int rev;
 	int irq;
 	int ret;
 	int i;
 
-	for (i = 0 ; i < pdev->num_resources ; i++) {
+	/*
+	 * Due to a bug in revision 1 of the PMIC, the GPIO3 used for the
+	 * SoC ESM function is used to power the load switch instead.
+	 * As a consequence, ESM can not be used on those PMIC.
+	 * Check the version and return an error in case of revision 1.
+	 */
+	ret = regmap_read(tps->regmap, TPS6594_REG_DEV_REV, &rev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read PMIC revision\n");
+	if (rev == TPS6594_DEV_REV_1)
+		return dev_err_probe(dev, -ENODEV,
+			      "ESM not supported for revision 1 PMIC\n");
+
+	for (i = 0; i < pdev->num_resources; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
 		if (irq < 0)
 			return dev_err_probe(dev, irq, "Failed to get %s irq\n",

---
base-commit: 554ae3bee71e60e7278136f452da9a17c036bdcb
change-id: 20230726-tps6594_fix_esm_for_v1-3f561d9e0884

Best regards,
-- 
Esteban Blanc <eblanc@baylibre.com>

