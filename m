Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F57A27A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjIOUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbjIOUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:06:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB930C0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:06:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so2114903b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808374; x=1695413174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NA1Kdxb7daymV0YxfPouFeomYl6O2u2EVjnI/tmIwsA=;
        b=Q1ojVrp61o1NMmfOUHB+383ZE0NJvaWN03BIYigZnGyB+tP6ep+s95LNYiJ6OnYwLT
         2uboiFQTTSsqWfKUsiYscjMumY5ln1U76vmX+JcRqxT0UMnOFI9wMoLglX+jHx0tNzQT
         ylyfblLl8ZTnyNnFjb6eeg2b5gL7qCEEPgaEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808374; x=1695413174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NA1Kdxb7daymV0YxfPouFeomYl6O2u2EVjnI/tmIwsA=;
        b=gzW3CcdsrGBWul2Xut96GbFBMMSFL9zJxwKkOwooMdpprqXdRwpdKMQmnDwnOAP0Nx
         NJMdca4CDvJPT/yH0JPHRce9TpZK5iV79z/yboAuQhdf/TCh4bj8Ao8LxWg9Fy28p3H+
         NGe2LRTAZ8WY+6TZZM1kuWkwaOypCKiN7Hyz9MIi4rdEFnwnuK6esbka22rwaNRtvWRW
         aqS/0+C+9mQz8SdNWqsNPG0ocFye0OLSRupEuAoyYa00QNVc442ZfRqAkUO8k32KM7G6
         k/wxbsDK6ylxxpLeGC7s/ArNjSi23GBFq2FFhYPvpNjBtNU0zEyXmXhclIEH+OWsI1WW
         O0WA==
X-Gm-Message-State: AOJu0Yy6PxKD9rue+QTvpwvZ2w01mkY2aAIDxweLzCwNd+rL4QEKSzZx
        ZC/9K4mJ8U2v9qt8hh4Il1DQ6w==
X-Google-Smtp-Source: AGHT+IFke9xOUg8o+dOHQMGmNXaiNCKQ4Q7uIE2umqN8LSN8Mp8jp4PO0FBx8ts/vz9hu+v/WYKIrg==
X-Received: by 2002:a05:6a00:148c:b0:68e:2c3a:8775 with SMTP id v12-20020a056a00148c00b0068e2c3a8775mr2968885pfu.33.1694808374440;
        Fri, 15 Sep 2023 13:06:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b0068fcb70ccafsm3331958pfu.129.2023.09.15.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:06:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kees Cook <keescook@chromium.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: mt76: Annotate struct mt76_rx_tid with __counted_by
Date:   Fri, 15 Sep 2023 13:06:12 -0700
Message-Id: <20230915200612.never.786-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=keescook@chromium.org;
 h=from:subject:message-id; bh=F+6DHSa+ER+x+MQqlg0EvaQeoh8qJvI3pA3g8dGL8RY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLk0Jorek+I1OQBAgJduc/L4Xg3jOs5WnEWt9
 MGRZATCBjSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS5NAAKCRCJcvTf3G3A
 JjWhD/9tOUC/st1EceKH0gvMzRBD27QO4Nk+fG6Y9rJZUv16gV9EFMsoYqUSuRwgZy8/P9I+BVc
 mkHZtoGs6fWhEJtny0ZlAMmZdUHnicF2M7xIxIb7tZFMp8ryHV7g7tiV44qtuz3uQN5OR5/G52S
 Bn/tXp6kou8NrfLsJt1aauJtm7CgcykOJt93RH8I49CjsLVQ0mYrF78RZc+bromdT1TGY3lCbYu
 YDSjb1YGbcNcpayfbzfJ5jPwJU1gQAn2ZxQWEyrqc2J7py+yj914/HyikOMrYaVlgUrqBoOQpYm
 l5vhqamxGJPeuQpBh4WtZukLo3z/zlEjghImla5afiElmNqimHsGWRI55luMz6VjGivM2ekVN/S
 OzaBZMte8ZaHt365A6WesjhOeByhDLffpDTS5K13NGnlNJQZchkZYpeoPEx5OT0frP4OOB9o8vr
 C3RTak4zrGO4iFO1qPK1oI0qgvYa6AsmHUgus5elElfv5xavrh7yAAOJsGsbDmCh3TmV8te0Zb1
 0/wQs/l4sO4COIHIOrBNqNqVd8eilEgy2mRzPiEdVkwor2g0GCSU0wZbw2TABQ0flcoKda5qOjB
 PpNql+uzB7LJjZUtMa8HdL83infm7t7Kex3RaoAOWdRDfWmcI7i1ap4tETW5nwk4KrP0kRt2sxt
 gysLmbT Unzq0a5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct mt76_rx_tid.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e8757865a3d0..03ef617b1527 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -376,7 +376,7 @@ struct mt76_rx_tid {
 
 	u8 started:1, stopped:1, timer_pending:1;
 
-	struct sk_buff *reorder_buf[];
+	struct sk_buff *reorder_buf[] __counted_by(size);
 };
 
 #define MT_TX_CB_DMA_DONE		BIT(0)
-- 
2.34.1

