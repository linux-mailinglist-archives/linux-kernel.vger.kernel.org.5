Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7178024F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356473AbjHQX7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356364AbjHQX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:59:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185033A98
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68866e64bceso263598b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316745; x=1692921545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBjA6KErHDu0Uq7ocuNM+LgPWR0uNQWWk8bvJOF1pHA=;
        b=ipztNTVV3yAPojkuInZpeWP55VSHmCKMjx7Qw3GONj5VQVfyNCIgFM+g/LHs8z+Hpj
         mvoPqpGTxMMOouc1tIoedViD6LGP0PvFCe5rYSoNm3ANbBT1TrL/LATtS/QqzzC46abi
         T4wZKcYxOxH5lsvuitKrmsY0fxRQPS5Jzk5pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316745; x=1692921545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBjA6KErHDu0Uq7ocuNM+LgPWR0uNQWWk8bvJOF1pHA=;
        b=kdMbIhbWWwFjXtskdlhoCIFshqpetJ+lyzpd28hfFOGlDu6FLhZQkWTy69pmocwAW+
         Oo901eGe6UuGkRdQvG9kuEYF3cYEf8Hv9Ux/V6IHet1MZU/B2U4saiygMq6mbX9UxMFL
         z5DhpaMKvouFmMVEzC8xu9DDFD+iiZwE3EcrpN+hWpnO4FQULSchNYGmcCzkcJ6upf1O
         jUgCsJBVncVG21j41LsCRoAT7WFh6tt+LhKLU4yuMlyAPrgksVvypJUyRcMJtAJM3obY
         5kcN1EvGSC/xNxpP3wTTy2L3wxLwE9reR/A1B43OgvwORQJ3LZt3tBQ9b47ONFwpToiv
         uwXw==
X-Gm-Message-State: AOJu0Yx/ZqpGeGXiVJ3mLBChJNwP3sYn88TzItD9+/hLsguz4+E8VQqr
        89zZB5nD3B+Hc3H/0DY2wVS4yQ==
X-Google-Smtp-Source: AGHT+IER/QCxL/LyPPuwtZ5fJJ0VY7Pw/rhGOAVFZGQWf10lLKJNQ6c96NXosk6/Ent/I/AwzA7fWQ==
X-Received: by 2002:a05:6a00:cce:b0:686:5a11:a434 with SMTP id b14-20020a056a000cce00b006865a11a434mr1288402pfv.3.1692316745516;
        Thu, 17 Aug 2023 16:59:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b00686dd062207sm303138pff.150.2023.08.17.16.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Green Wan <green.wan@sifive.com>, dmaengine@vger.kernel.org,
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
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 09/21] dmaengine: sf-pdma: Annotate struct sf_pdma with __counted_by
Date:   Thu, 17 Aug 2023 16:58:46 -0700
Message-Id: <20230817235859.49846-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=keescook@chromium.org;
 h=from:subject; bh=dwauH20Q6xP+4LjfvKyJpROFf0PoQOEsyr9XswCqTTo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAkodXaKGN3V1cUAy87CQjDpadxCYl1kOBd
 DBX6VSqtKqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A
 JhaWD/0XQBG0IAu8uYIo6t2lBljNvRssqu8rPbwygr+clzyF6mT4ykHSqyehzafLdrnxfXUPnQy
 7BXo7qTX/oOe1mMmwnZYjE73otVC/9AG7HD+0i1rpKjSIX1y0le1b27SkDT1VdkFNlTusQCkHFg
 N3qVIdjMWBWwJkTzFR9rfsDQ6XzoTOw905VArPKp6G9jxz7DuCezAKXTuv4BpHoiKAZDDh2vuLz
 enaGQRuFi2KS4XamCm/yHnJAuch2CCUiMdV67KWMK21AjDP+MBiMpySm50hyDgoa+xj7Luu0FFE
 qsPtCNeN4wS0lLVMcqh7o8Trt0KEmujaOHtO7RTEoaMPkF5tDXDbc6VRyZTmQ6mtSfZ7nwzqhCi
 1PW3zrheQxQAES85LM8xFRwN9g+ziQ36L5iJzjYXN0KBMovPVI0h7NiFtKGVCh7ky3Jljdi9Ukv
 Alk4rWFr8Za6dePWPce8DRR6N5QhqfRajF8DekFiE3w38UdfEjjTY1xybDZ2AogeV7rkyLtxPyc
 3a6W2kiYw8Z7qmcKgsC5yF//aE5NhmtceubIVx0OhZwyljwhIJfjee+SSLqXrFmkeyn42jMoxKx
 Pa7DzAc6Kq8z1tUF8leTymViabKoo6SP81mWA3tXaPNpW0RNU6FkA5BfjD1MQgRH4Y3D0t14ieo fgf64ePLeCeyjxg==
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

As found with Coccinelle[1], add __counted_by for struct sf_pdma.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Green Wan <green.wan@sifive.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/sf-pdma/sf-pdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 5c398a83b491..d05772b5d8d3 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -113,7 +113,7 @@ struct sf_pdma {
 	void __iomem            *membase;
 	void __iomem            *mappedbase;
 	u32			n_chans;
-	struct sf_pdma_chan	chans[];
+	struct sf_pdma_chan	chans[] __counted_by(n_chans);
 };
 
 #endif /* _SF_PDMA_H */
-- 
2.34.1

