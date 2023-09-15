Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999E7A27A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjIOUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbjIOUGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:06:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37542D62
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:05:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fb85afef4so2464036b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808345; x=1695413145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aR/iTkKbSTclF/9WdaJ898o9CruV7+egFFYPhFiTMFM=;
        b=gvE10czIM9ByiLJOmSDTl3YUa30w7UJ22m/5Zza04SqWhJf8qy0hcG4ruP32iD8Wq5
         mNptVI4hKJjBuT7PZEJbHDtrGUiUAl1wPtRPzytUizdLJ5kv+mO2tgco8S8q3Mm4olxO
         znPLBtx2bx/XZNJumXUMNSMNrKteIPmei3j+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808345; x=1695413145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR/iTkKbSTclF/9WdaJ898o9CruV7+egFFYPhFiTMFM=;
        b=ojZ1vax4cifc7GtaR8ZewzBkyM/ETYr0UZWeYk6zIe9MBEbFZAepnin6MaOjEmNJti
         PoLCg/R6iWP0qEuGYf7ZfEKEiBensjCAw9FTcpNae23JB1OECeQjVndqlC6qVsrsB1ZZ
         nc3FWOPmQHr8UPdgPvXfLv4aLy2QwxYT8ouEIsIqhRQCkE9l4W76b61gs1PvFmrXyQwb
         Cu86DcXc05Dv7+jwu30ugUu3Xyxg/QtJoI+D3EnwilMj3DILpS8LFJe+f5PkJl+cKWM9
         fJnghefcoG6X6dVuiPvMq17N4kMkWh5JmW90ZWBC4jA84lUdidl4M+1vvphqMADpDzCY
         xfRg==
X-Gm-Message-State: AOJu0YzyO2tnpBlAC5uppVpCsd935TeiuOs0C9nQQd0MbzyWQxoRPthb
        DADDDnUMSPxQpeBiNcQHGxb4kQ==
X-Google-Smtp-Source: AGHT+IEZDR1AoY5UWqDU+jRetwQmtXAdu3l+PFJzjRCOiZPs15rVbHlQyEYRMe3e/PSnUxZpPrijug==
X-Received: by 2002:a05:6a20:1608:b0:159:c918:1016 with SMTP id l8-20020a056a20160800b00159c9181016mr3227733pzj.49.1694808345500;
        Fri, 15 Sep 2023 13:05:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b00573db18bca2sm3132905pgc.33.2023.09.15.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:05:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: Annotate struct brcmf_gscan_config with __counted_by
Date:   Fri, 15 Sep 2023 13:05:43 -0700
Message-Id: <20230915200542.never.417-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=keescook@chromium.org;
 h=from:subject:message-id; bh=X4WmyrGHDGI0lmYXa9tAqxY62elCP40zpnliUt752qk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLkWpwM2ImPrvmH3OQf9Pk/Lq94hutLw0lb0x
 lB0vtONpvuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS5FgAKCRCJcvTf3G3A
 Jq9tD/4knDbJaYtMtmuYbl+odY+xjGbWr7tfc54DKzFfAwSZYR6unzGPjAzlJBE7cQE4ZO8Vbtl
 JUU4R+2Qg0vz23t2n+W028mcnONszI6s/3g9oYHuVegLZWU16CPk1j81mijiKzwn9RA7Ogbf6RL
 laxCscdtdC0J/iOedBEHdrXlf0nB4pVhCwuwuIWhyp8nLTx9jsrSHVft0uiBD7NdUt9PR4M6miY
 tQzXpXWfCMpsXR89UnT/FfFh4W82tpEKqnFrJavIrJNwbRPEnmM4z4J6mT/QNu1GVqidKJlL7wE
 e5OSd7C5rHWBwZlSRe3z7L+hTLT8kgLSkXG98yxVC5GQigByn34AEuQC4oneqZpZngynNc/YRiF
 HcS0QAMnmk4jdmeft8ebAE8kuT+7cbkSSn059qlldfKHmZ8XSzQZRqAADPFHPP5TxGr/lCJAbrW
 2QQAfO4VbyApM1J/yqpjZ39cz0o9/b0AMi7Ymynfl4cjCo3qdpU/u3Te6MvDSUiNEfkoNkY/xq0
 6/TYWQSmE1SQ0dKAZeu7Nm0PUlUTKkCb51Ui5oKCctV1X5noukQJc8IIFihqllWQEUm41RP+4VU
 EUEtOI+5Zhzud+k6ldz8ExSqDFfyMBxm6EZwNl7J8VgUvfyTPLsITFGcEZaCCX9OG4WKwkHISwv
 YwOYvhG lChfhSQw==
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

As found with Coccinelle[1], add __counted_by for struct brcmf_gscan_config.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Hector Martin <marcan@marcan.st>
Cc: Ryohei Kondo <ryohei.kondo@cypress.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index bece26741d3a..6eef6bc430e2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -1209,7 +1209,7 @@ struct brcmf_gscan_config {
 	u8 count_of_channel_buckets;
 	u8 retry_threshold;
 	__le16  lost_ap_window;
-	struct brcmf_gscan_bucket_config bucket[];
+	struct brcmf_gscan_bucket_config bucket[] __counted_by(count_of_channel_buckets);
 };
 
 /**
-- 
2.34.1

