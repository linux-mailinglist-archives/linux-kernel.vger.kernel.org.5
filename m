Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A247620E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGYSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGYSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:03:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26D1FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:03:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89d47ffb6so30177195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690308217; x=1690913017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRQYZPtdJ90/O/wdYsOCcbEwOxH1iCaDxABLg2VMAnc=;
        b=O7H+ZLIoNcQEd+SafX694hZEyd6kL9iSaUGkuyFgwYR24O5btNklcnGPDRxAuZzppw
         qv5UqwC+rlTIxCGA2BxWpYz+A5cAw4KDBZ6eGs2c96kObajRC+mwS/ZAVnk9NEZD5z4d
         vrNIriah0F8xAYzNtiDgDB87bhkru80BZa6ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308217; x=1690913017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRQYZPtdJ90/O/wdYsOCcbEwOxH1iCaDxABLg2VMAnc=;
        b=cqQpk9FXpbCjiXO4btqItxJUHAPIhgWJT31Cf78m1+WvleNn9WDie3mXV/JcSTpvsc
         CNkBp1SbhcDW54PwpZna6wXkfxCJs2NP/HD0HD+vZhDifPctHQEj+LkfJKVIpZR2Ht+Q
         hSiIO4d5BLFtLN/9pPLsb+kiFvm2nyiVU1PoRiixB6W6syd0QHi9POGiedb10DQpHpSK
         EJm/rsfjI6d5KSNjhkEu+h6WGUmZEs5VtxFXwrG5uNLXY8ZdxnqlgDMfrpRvSBuOofP8
         k7WHtG3ORpCZKZ08SOGlaYlRYXGdehm7Xdrtm32RlLoFJfASeqjv2W8KsJw7QXDND+MB
         54NQ==
X-Gm-Message-State: ABy/qLZbashlo7LZ84r7YQWckGMP1cbP+niUKOJOZA+nFrgS+LopFp3O
        ilr6Dm7cPoinC5+un0Lfs/oEcA==
X-Google-Smtp-Source: APBJJlEsqf6G0ev6P/b6k5o3OywK6DpeA91QLSmSatgQZy4Y3+LKHFLS10qE4bOW2mdt0NxUKIQVfA==
X-Received: by 2002:a17:902:ab8e:b0:1b8:7d0d:5ac5 with SMTP id f14-20020a170902ab8e00b001b87d0d5ac5mr13716plr.50.1690308217621;
        Tue, 25 Jul 2023 11:03:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id jl14-20020a170903134e00b001b54a88e4a6sm11305254plb.51.2023.07.25.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:03:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for badly sized reads
Date:   Tue, 25 Jul 2023 11:02:27 -0700
Message-ID: <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("spi: spi-qcom-qspi: Fallback to PIO for xfers that
aren't multiples of 4 bytes") we detect reads that we can't handle
properly and fallback to PIO mode. While that's correct behavior, we
can do better by adding "spi_controller_mem_ops" for our
controller. Once we do this then the caller will give us a transfer
that's a multiple of 4-bytes so we can DMA.

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 39b4d8a8107a..b2bbcfd93637 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -659,6 +659,30 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 	return ret;
 }
 
+static int qcom_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	/*
+	 * If qcom_qspi_can_dma() is going to return false we don't need to
+	 * adjust anything.
+	 */
+	if (op->data.nbytes <= QSPI_MAX_BYTES_FIFO)
+		return 0;
+
+	/*
+	 * When reading, the transfer needs to be a multiple of 4 bytes so
+	 * shrink the transfer if that's not true. The caller will then do a
+	 * second transfer to finish things up.
+	 */
+	if (op->data.dir == SPI_MEM_DATA_IN && (op->data.nbytes & 0x3))
+		op->data.nbytes &= ~0x3;
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops qcom_qspi_mem_ops = {
+	.adjust_op_size = qcom_qspi_adjust_op_size,
+};
+
 static int qcom_qspi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -743,6 +767,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "iommus"))
 		master->can_dma = qcom_qspi_can_dma;
 	master->auto_runtime_pm = true;
+	master->mem_ops = &qcom_qspi_mem_ops;
 
 	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
 	if (ret)
-- 
2.41.0.487.g6d72f3e995-goog

