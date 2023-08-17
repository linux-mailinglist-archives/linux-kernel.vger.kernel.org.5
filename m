Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94D4780237
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbjHQX7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356350AbjHQX7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:59:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07A3A89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b3f4d3372so262526a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316743; x=1692921543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLiCnBbyPzaic/GZ7z4G3P0cbvM2XGBwdo50oYhUApk=;
        b=P5Pp0wwT5nzP3n43DVWzU0GTRLBYDoDSQDfCmbHmbAyHke8vM3wJwLlQCndFTYZ7KE
         ZVi1VZoSjZdpJ+Cv7UQqBsqf+jX/87/JGb0fruxGutn29PXRZMDB9jPSZIrj3VxbaicZ
         bNJeGzg/zR8SLlYCw17rI+RJwBXQBpyTYDPlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316743; x=1692921543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLiCnBbyPzaic/GZ7z4G3P0cbvM2XGBwdo50oYhUApk=;
        b=D3T5eq2UAxwIcUAcGE17qvYxaxIQs6rcj3sRiGdP6xDCEJVv/KVOPQDDcbBGIqb/N/
         yoaV0NUD/JUm2KmWWf9htvGLW3uzfbl9slQVqrKHb5Dy0AO3pF++ShxpnKzEN+xCyZPG
         8wazgN7f6OPnbJI6vxE/YQSagrZ9zTpETPQnvsc3GfUs0vrHEIKoMWU64ctvxX5ZqIlM
         /nH9iABdHeQ6APvbQL29go8de3Hf0LXOmpNQeuSg5vjJtNos5yZX/N/jbSjqO+mgkxED
         Pi1higMXmZLN8hRzu8Ax7Hb2lC0E8UEcD9p0VnHpb1AD4GGxXJrZNGDMjV7yRYZS3PqW
         y/QQ==
X-Gm-Message-State: AOJu0Yzo+n6bpezz5YFC0ZTdmhdahNovhEXpFZGtj965TwzzL1FjSXCx
        KR9YExWhF2igrVzZiIrrpeGXwQ==
X-Google-Smtp-Source: AGHT+IG7Ur7jvG1Cor78dTTxi94xoQ0HyBPagkNa35jw/ciTiPyRGRuVsIer724v3p+TKZGgt/zcZQ==
X-Received: by 2002:a17:90a:7564:b0:262:d7db:2520 with SMTP id q91-20020a17090a756400b00262d7db2520mr994346pjk.26.1692316743403;
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a948a00b00263cca08d95sm2101254pjo.55.2023.08.17.16.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 00/21] dmaengine: Annotate with __counted_by
Date:   Thu, 17 Aug 2023 16:58:37 -0700
Message-Id: <20230817235428.never.111-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=keescook@chromium.org;
 h=from:subject:message-id; bh=X+13aptrkzlZofkuldd+d07374jzvU5KMGSMFeBiQiA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rQ/Y/4ffzo1IbZvWMUH7ld52PtnkCTORxyHK
 CIS35jFSfGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60PwAKCRCJcvTf3G3A
 Jmk6D/91xaM88OIg15Z+90cr21kEhBomkBw2kzWyeOFGSeWZfWBT9v5HW3rrVN64Q7kDB9XAJal
 nI4M0KHJ8cUO6Y8Oww5+x4tmVhFS+/yiSYyxDNbGtiEP8zwAJazWBFG/VAIXoqJgr65f9N5MrMB
 tpMNT5QDBa+NOdvwfEWIqptgdiUfftpp3/JCQpoUJZ4170WFUNdylNkOKOPlZWzpB/Z7GOnXskj
 Y1F1IK0F8spqaHu/QGQTnrZa1o6gGjKYuxFrbZ4zlMZRP6cXwRZ0m6mDTeTaaItw3X13J97fgUo
 +KCUF1tsNSs50HZwRVPdXjSJj7iidcnHdBsGgUJixBqnHI+eUuwI/fXIEDWrZi5f6nl8i+4okPg
 VnbPoCI4gD1g9nfDtXklxQcCpgY6Jz519HM0b2UWNjQi8Nwc4DAovAEsCwLNvgdZtD+p832lPfn
 YSpjXkaDWrfN2tgUC/YmPkkuGyybh/vqVuNhp78qD1aXxmydmnU5+5WL2AyRzmP6Y/xlHa5wO4g
 b/PSScMBx7nKATYBufXnhc8uQfrucLW4+GkmubGiNp03RUxPh5cKo2hoJtIZWTZCsuMKQhS8gdD
 YLlNjS9qafx1FicrUpVmxB5pFplJDCN/02onKYItefjjDduHSTMCC4tIJ//0yRQN+DfP5lzceR4
 h6gsvBD jioTUffw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This annotates several structures with the coming __counted_by attribute
for bounds checking of flexible arrays at run-time. For more details, see
commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").

Thanks!

-Kees

Kees Cook (21):
  dmaengine: apple-admac: Annotate struct admac_data with __counted_by
  dmaengine: at_hdmac: Annotate struct at_desc with __counted_by
  dmaengine: axi-dmac: Annotate struct axi_dmac_desc with __counted_by
  dmaengine: fsl-edma: Annotate struct fsl_edma_desc with __counted_by
  dmaengine: hisilicon: Annotate struct hisi_dma_dev with __counted_by
  dmaengine: moxart-dma: Annotate struct moxart_desc with __counted_by
  dmaengine: qcom: bam_dma: Annotate struct bam_async_desc with
    __counted_by
  dmaengine: sa11x0: Annotate struct sa11x0_dma_desc with __counted_by
  dmaengine: sf-pdma: Annotate struct sf_pdma with __counted_by
  dmaengine: sprd: Annotate struct sprd_dma_dev with __counted_by
  dmaengine: st_fdma: Annotate struct st_fdma_desc with __counted_by
  dmaengine: stm32-dma: Annotate struct stm32_dma_desc with __counted_by
  dmaengine: stm32-mdma: Annotate struct stm32_mdma_desc with
    __counted_by
  dmaengine: stm32-mdma: Annotate struct stm32_mdma_device with
    __counted_by
  dmaengine: tegra: Annotate struct tegra_dma_desc with __counted_by
  dmaengine: tegra210-adma: Annotate struct tegra_adma with __counted_by
  dmaengine: ti: edma: Annotate struct edma_desc with __counted_by
  dmaengine: ti: omap-dma: Annotate struct omap_desc with __counted_by
  dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_desc with
    __counted_by
  dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_device with
    __counted_by
  dmaengine: usb-dmac: Annotate struct usb_dmac_desc with __counted_by

 drivers/dma/apple-admac.c      |  2 +-
 drivers/dma/at_hdmac.c         |  2 +-
 drivers/dma/dma-axi-dmac.c     |  5 ++---
 drivers/dma/fsl-edma-common.h  |  2 +-
 drivers/dma/hisi_dma.c         |  2 +-
 drivers/dma/moxart-dma.c       |  5 ++---
 drivers/dma/qcom/bam_dma.c     |  2 +-
 drivers/dma/sa11x0-dma.c       |  6 +++---
 drivers/dma/sf-pdma/sf-pdma.h  |  2 +-
 drivers/dma/sh/usb-dmac.c      |  2 +-
 drivers/dma/sprd-dma.c         |  2 +-
 drivers/dma/st_fdma.h          |  2 +-
 drivers/dma/stm32-dma.c        | 11 ++++-------
 drivers/dma/stm32-mdma.c       |  9 ++++-----
 drivers/dma/tegra186-gpc-dma.c |  2 +-
 drivers/dma/tegra210-adma.c    |  2 +-
 drivers/dma/ti/edma.c          |  2 +-
 drivers/dma/ti/omap-dma.c      |  5 ++---
 drivers/dma/uniphier-xdmac.c   |  8 ++++----
 19 files changed, 33 insertions(+), 40 deletions(-)

-- 
2.34.1

