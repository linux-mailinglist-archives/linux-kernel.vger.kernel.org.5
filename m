Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2507A27C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjIOUK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbjIOUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F110C3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so2429637b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808622; x=1695413422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlByvIOdhm1BrLrYKlOSPCA/h/JQn1HfpIBfjQs7y9E=;
        b=KO+C4w7kTQ37/WFAtlhOF8VlCq/42oW1lbpwAkmDP/DsF48bMVHLQ3qyJegpelb0bK
         QdOPxw8izVt1lax+wWkhLI3jU/KNvAFZRyNiTkxhe4HDcQMtezTPYEWyRm1ekmvb2tL8
         eWypQ/Ot8USDPPDVQ7Swv1ZHujuoo4GtT7tH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808622; x=1695413422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlByvIOdhm1BrLrYKlOSPCA/h/JQn1HfpIBfjQs7y9E=;
        b=f5qGd03VU+5ZBIut/14k6I9fjzqT/eaco+zcuNKFsxPWZ2pU2UevScfi2lMgPcGswK
         fjy7TkcK6iYi8XB+aph6T62Q9sXBpkNuxYt/tVegsKJl1eFq1s+Koc39kGw6KfR0buHD
         JayZgBrrml0Qdw1GZM5acUxRhgYrJoSGV3G3DbOHMe7V55ydt8gUlVwOai/IsmdbyfE9
         FpGDaMg/7GHGhmWur6UPj2/cUJCoxkJ3tAJ1Q1OvDPFuQrCQISSpKnE+hWkjqMyf8gaf
         z3FBPycvFSYoXjuSr7iFtFoyOO73D0rwP5bZ2cPPh7pdBpRtkEYC3yLdOWfxhYwKjUmC
         sRwg==
X-Gm-Message-State: AOJu0YygYoOEVIGQso6vWEyqz3D4qHZiRUteTF7g4L9Q4ZPd6c6pRNi1
        XGit4KznNasNFpohWxLuJqWFlw==
X-Google-Smtp-Source: AGHT+IH97ZRMrx8Ht8kVmTlA+CCi+kBXT3NF6QKj9s4ZlPHyjWvdpu50pjC+R3DiD6+loNvwc9w5NA==
X-Received: by 2002:a05:6a00:178c:b0:68f:ba5d:c7c8 with SMTP id s12-20020a056a00178c00b0068fba5dc7c8mr3263085pfg.10.1694808622247;
        Fri, 15 Sep 2023 13:10:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a27-20020a63705b000000b00565d82769d1sm3161179pgn.77.2023.09.15.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:10:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: mt6360: Annotate struct mt6360_priv with __counted_by
Date:   Fri, 15 Sep 2023 13:10:20 -0700
Message-Id: <20230915201020.never.433-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=keescook@chromium.org;
 h=from:subject:message-id; bh=f+enA4agyImbFLGfdmWqtF1Ofn6ogLeO3YPTh9r2ypE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLosMDTNT9zkGuuSS5/v5hvLo56PnCLrNsfhH
 2XWrsY0ncyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6LAAKCRCJcvTf3G3A
 JuiBD/9EbeiE4dzQvBsNU8W+Ygxow9+F+K+56pj+lkkL8YD7G9ZLxoEIDtbuf64kthZKeEvjo57
 FTUv/48yOAUZDs2LU9/9qiFoSi8L0qj3gx/k1vcVDT/AYShIsS7MZ3/HQRvGeiiUbRHqAv034yb
 tDCakrDUzz+HFSbIBPQ3hTMf1LrLic/BS6/a9kR+7EerWW8Yc430bzBpznlnZvAvfyudwqApts0
 SYDaEwQY3GFNuWa7oZAZBRMc0FKcTHCVkTcQ7+Sz5PQoXaajs2eVpYcNfSrKxHqBVoh74gB8wIS
 fDSrAqGXttPXJRT3nIVf/NjG12MZ1zW24/t4bDYie6kU2aTNGM/ijQHVjZLDcXTHJXJ/Kbx2dM/
 7gzMy2HDEtF5Vp2mJWeVCfNAS9V80eQ4DGU0TnnWEx4LaQgh0TjoJLRkmZLfonk/Jaf/QTEETCM
 cIvZM3qzHy85LPkBOxvCtHjO48zKpAuM720fZaw1E0W8xqbkW7VMzWw3m3X/f+rzniUmuJhfHuF
 pXCw7jO7QP8gNO3BKGOH5MLx0+LBqeE9a8QydO/pnK/gwVGqWfWiuV50WWXFEQvriun5eAgjO+Z
 UQVj4Ce2Ywi4w5VkhFcUUeepfhCVLdfZN9t9cUXFykt+XBm+eXZJtog2PNj/28wtP32yiyPdLtO
 wcq5HsY mHeihMBQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

As found with Coccinelle[1], add __counted_by for struct mt6360_priv.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Gene Chen <gene_chen@richtek.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-leds@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/flash/leds-mt6360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
index 1af6c5898343..b70dc689b33f 100644
--- a/drivers/leds/flash/leds-mt6360.c
+++ b/drivers/leds/flash/leds-mt6360.c
@@ -91,7 +91,7 @@ struct mt6360_priv {
 	unsigned int fled_torch_used;
 	unsigned int leds_active;
 	unsigned int leds_count;
-	struct mt6360_led leds[];
+	struct mt6360_led leds[] __counted_by(leds_count);
 };
 
 static int mt6360_mc_brightness_set(struct led_classdev *lcdev,
-- 
2.34.1

