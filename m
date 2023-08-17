Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10584780258
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356584AbjHQX76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356409AbjHQX7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:59:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CF26AA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-689f1e81293so298320b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316753; x=1692921553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXeYLQ2GewHlFPJZC58ZRexUVly60i4L9KNCW0nx6Zk=;
        b=E4MvOk7kozY7pHeqkqrSE6Fx+b5wPjyeaDrCH6cnZYBce235iu8L1ggSupORngM/8A
         l9Kk472IVYyHtUHSiQfr/qQxVCPz6cZa2dg6Po2U7LJdTM0a9vhPIc9OjPFnWaVjufYH
         eZ+T3G7d6GgLHEUVUwZwmsqNG0lsBG9OxXjaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316753; x=1692921553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXeYLQ2GewHlFPJZC58ZRexUVly60i4L9KNCW0nx6Zk=;
        b=TxLeR9X6zRZuT+uQq9Qt5bCMEOZRWXLypdp1v5lqyDwxPzdS14hg8QZtJRSa1UOMUY
         TZvyT1Q4nJMaX5wMdMW6yIm1K7c520QvVCTUXDGNTFpYQhCsmWDK5LF4dqnf2p1zh4um
         V2orwEjK3z3J633dEo9gpdypQVPDSxpNZQatsTLhjFwDROh5yZk4n8ufzIlrIWKRHxe1
         ZUiBorCTU7qGfdBDzNLAgdmPzQMt5Uy8ewJ7R97MeN2kaPcvtmxGifeoLqVHdlWgTqBH
         EQUAdCPmLs4Cf2xjDPaLigXllHmvEfKdAdloEVjpZskcqlAmmwT25uJH/k0BVUzhmsQN
         n5Jg==
X-Gm-Message-State: AOJu0YyVCbs9ERLydKq8D11TrNVPEo1EXgB+iWMDplZyxQt8ApdpRjc/
        10i3Y6CTFAiK0TLx5W+8qM1uSw==
X-Google-Smtp-Source: AGHT+IH7ceqgTswqXpviM1ijV38NbJuVRRwA3pV9NT6hwNEYJSniFiTqu2wXcbZdz+XyqunOp8AoPg==
X-Received: by 2002:a05:6a00:22d4:b0:687:60bf:aed9 with SMTP id f20-20020a056a0022d400b0068760bfaed9mr1146482pfj.24.1692316753316;
        Thu, 17 Aug 2023 16:59:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b00682b299b6besm313473pfn.70.2023.08.17.16.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
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
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 16/21] dmaengine: tegra210-adma: Annotate struct tegra_adma with __counted_by
Date:   Thu, 17 Aug 2023 16:58:53 -0700
Message-Id: <20230817235859.49846-16-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=keescook@chromium.org;
 h=from:subject; bh=7gJaGyTVYHakfTQ8Pwi03jgdcg+IqGAMLg/jFJNW6ns=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRBFwQjEveal+Z/8kFZsr8NHcKbhAWN9xXW2
 2bm6PiyF6eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QQAKCRCJcvTf3G3A
 JhWBEAChmToUXNsq2WvY5LWUYGOYXucQ4BBFAeyV8EU/Ph5YetkT1Ejxps0eeDDEL+L9UUpivSe
 +C9l1acyX7jUmoO7g3LI7ofXC9DYH/FlJ+tFAV7eWeP7LLjdgrBYyHMmSddzaCznsZ9os4v1ub7
 Rdl+oRzDK//T++/1p19ABdLdwYob+S6o0ePH/GR338wixR2TmmypIBYnp6yrrw4YlLjUE/NlJ2b
 Yu7U19kEiykr6dGefEteYvSZk1Hp62ql7B+hmLY3EeychRlJcdqcOrMofQLZ1VIESaMlC5XU0X1
 hEYiKuEB22Uj0FPrF8P8q3U2w5qzFfQ4MPVi2rL6KIOiZUN8KJyoJGJlT4eyDcWMSmy5M7Ya1NE
 tXCXuIFbd3kJu/chRYDvGHx1SOCiLUMveo8wvJDL3FzaSOmFqMMx5CyDWMHhMVPGsod/y5u0csZ
 ehv9PysR1Vi53+riCsyVXtqI/GGdCI8SHEeRUiHyxGQ6h3aZsOGerZtfL93rwVJLxHApgWWC4Mb
 8TiDejq/mug5sOGQ+2vL1ae8SqkF+00KLgem2JFhPfET/9dbSOlo81vYhJnS94VtB5wYwz4cMNA
 Hd4PZfscGp4gmCe3nDVghWnCrDMnx+SIX37w7Hj63aAOU3ZzYj4Gh7cfWGp40ESzjtcx4c4tRKH Fw8k579f9tNlntw==
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct tegra_adma.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/tegra210-adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index e557bada1510..cea33912a4c9 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -162,7 +162,7 @@ struct tegra_adma {
 	const struct tegra_adma_chip_data *cdata;
 
 	/* Last member of the structure */
-	struct tegra_adma_chan		channels[];
+	struct tegra_adma_chan		channels[] __counted_by(nr_channels);
 };
 
 static inline void tdma_write(struct tegra_adma *tdma, u32 reg, u32 val)
-- 
2.34.1

