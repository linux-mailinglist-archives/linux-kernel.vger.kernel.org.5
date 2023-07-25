Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EDE7620E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjGYSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGYSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:03:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611361FDE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:03:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbc2e1c6b2so4550875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690308216; x=1690913016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3wk98CPhmXaucfW3yFy0X9veK7c7V/LOvkjR4lZXDk=;
        b=mdgqGoEyde5ufR0v0DwdbxwxdHa372uxZ0WCuZCPFnP2tWnW3cD+aRMsF3UhDkW2W8
         JRNRLtjBkoPm/8J+2v8HL3qRmFef49+Bom+JO5Ec/knUI7wtUTiCn7WGM+yUu0pprK9T
         lf5uswnmIi0XpGMFOBgRcHhnhqrYFfANyRFJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308216; x=1690913016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3wk98CPhmXaucfW3yFy0X9veK7c7V/LOvkjR4lZXDk=;
        b=TbLYKz23yAIFe0FTjYthClu4bmY8uO5Gvu2IYnMaPz4w5wuyN2uSf4DzWjcAOYuaL2
         r3GdbT9KByRUBe5X7BFwKFu2QNNuGkDHIOJur+cijzsTbQeWHBLFTqjRQegB20WIjUjD
         u2ZbqV2QVOOcAPQnR01pcxQVC2vaIi2mEPLcYWDa0Xk/HQwC/mEgsw6nwTLu66fWhQ0e
         QhTuagWh41KSQ1Cu+zXfpY41o6iZfqTE21M/2QM4IperMb7xrPpJxjLts9n+Nm2p8Z93
         QFeBkY84hDuPBKLxndhhIpGAv+yQ4iVnsGeb9woHcUGVwslZa0RQVnpi9ErkKFpGzHo0
         EX0Q==
X-Gm-Message-State: ABy/qLZda9OtWv2hG6Pc3Y+iEJDSILaKcvgOvdaVBncBi0VVYv2+PGgj
        59L9NzBDzPzFYcrlkgRxa6VXlg==
X-Google-Smtp-Source: APBJJlHM3LA5e8y9FJWQ5S6qBfzNrEBCpsSXTklOVDUtXJMwIuGCv66gAUEtztxROBRKSmqdn+oUoQ==
X-Received: by 2002:a17:902:d487:b0:1b8:8069:d432 with SMTP id c7-20020a170902d48700b001b88069d432mr23474plg.16.1690308215805;
        Tue, 25 Jul 2023 11:03:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c363:4681:f5b8:301])
        by smtp.gmail.com with ESMTPSA id jl14-20020a170903134e00b001b54a88e4a6sm11305254plb.51.2023.07.25.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:03:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that aren't multiples of 4 bytes
Date:   Tue, 25 Jul 2023 11:02:26 -0700
Message-ID: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
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

The Qualcomm QSPI driver appears to require that any reads using DMA
are a mutliple of 4 bytes. If this isn't true then the controller will
clobber any extra bytes in memory following the last word. Let's
detect this and falback to PIO.

This fixes problems reported by slub_debug=FZPUA, which would complain
about "kmalloc Redzone overwritten". One such instance said:

  0xffffff80c29d541a-0xffffff80c29d541b @offset=21530. First byte 0x0 instead of 0xcc
  Allocated in mtd_kmalloc_up_to+0x98/0xac age=36 cpu=3 pid=6658

Tracing through what was happening I saw that, while we often did DMA
tranfers of 0x1000 bytes, sometimes we'd end up doing ones of 0x41a
bytes. Those 0x41a byte transfers were the problem.

NOTE: a future change will enable the SPI "mem ops" to help avoid this
case, but it still seems good to add the extra check in the transfer.

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index a0ad9802b606..39b4d8a8107a 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -355,10 +355,22 @@ static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
 
 	for (i = 0; i < sgt->nents; i++) {
 		dma_ptr_sg = sg_dma_address(sgt->sgl + i);
+		dma_len_sg = sg_dma_len(sgt->sgl + i);
 		if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
 			dev_warn_once(ctrl->dev, "dma_address not aligned to %d\n", QSPI_ALIGN_REQ);
 			return -EAGAIN;
 		}
+		/*
+		 * When reading with DMA the controller writes to memory 1 word
+		 * at a time. If the length isn't a multiple of 4 bytes then
+		 * the controller can clobber the things later in memory.
+		 * Fallback to PIO to be safe.
+		 */
+		if (ctrl->xfer.dir == QSPI_READ && (dma_len_sg & 0x03)) {
+			dev_warn_once(ctrl->dev, "fallback to PIO for read of size %#010x\n",
+				      dma_len_sg);
+			return -EAGAIN;
+		}
 	}
 
 	for (i = 0; i < sgt->nents; i++) {
-- 
2.41.0.487.g6d72f3e995-goog

