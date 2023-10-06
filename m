Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A57BC0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjJFVE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjJFVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:04:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C021C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:04:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5046bf37daeso3319422e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696626261; x=1697231061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unO5+OwTpqcdKwNk0P0czzkhYjqFhgQGJfILd9g1TMg=;
        b=s6uAvr7a0hgIYiJg/21hJU9IeiRfLD4mi/YogfnPr09c2GZram5pZ0M+nSJtcRtCoI
         u2p6Gtx6ZSI9mh+ekeZybLV5rc4Exi0T1FnqKuspGErecZ+BXCSoy9v9siuqBKtkxiO8
         K285V3GF/QrU7rC8Rt4TFT8PeKzLq8/j7gTG60v7xxcQRZYGrf+3DMoq0s+GhjkDhn5W
         4+ytbTBcggebzhgqa61mwlb4VodPZe21fpjRLqkGpOht8Vq7V1osy/IUQhcYu1vmDhKz
         uYEXLAH86GqBIbXi0mALaz6HAUmHTfJhIoF6oDqJy/9SsCc9JZ08KTYiNZV9k4kZsC7I
         0Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696626261; x=1697231061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unO5+OwTpqcdKwNk0P0czzkhYjqFhgQGJfILd9g1TMg=;
        b=qVEJNlnsSmTkkedknAigmEkGiyN7tCXayOs4auT7S9LLNQ6HwbD+4Bl/zucgSwuZBo
         bfGaiXYz4aY92fCZ+7dhzrwNZ6f3WrbxT/rAIb9rYaCY+0487BF1TUA02ABMlo92GFCw
         2hgfBCt0sfl21GixsMBVkzpVDFdfEYYqrPejS4KRiD3Tno45Ejpi/fCjosZ9sGRBq4Jm
         Pkdba97AfkHtP09MHuNzzG0AncOveTKuoGL6pdCKR7Fh3rVECOJxMyDjpjP2cbaidwr4
         7dcUGQGQkgWDa0fBdzOSY2iyeMgu/PmevCQXu8+MK6weZVR7XobqHQtfwnhBl+SIAqSc
         8dQA==
X-Gm-Message-State: AOJu0YzPQgiSaLOesVwN4mw1cDW0z50Xj++WqYw2rL6wqihRWbpquvY0
        74p2/yvIQ9x1iITVhmbUlvHpnyia0/6d6ouHF1s=
X-Google-Smtp-Source: AGHT+IGYMNMsu4G1N4jaaEGhlkJIUX3v4ADaKW/BFO/sleuZ3Ib55Vio/pzcRauVvrf/AwlHh4iZPA==
X-Received: by 2002:a05:6512:4011:b0:501:bd6f:7c1e with SMTP id br17-20020a056512401100b00501bd6f7c1emr11091519lfb.33.1696626260738;
        Fri, 06 Oct 2023 14:04:20 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d25-20020ac25459000000b00501ce28db76sm432993lfn.291.2023.10.06.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 14:04:20 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 06 Oct 2023 23:04:19 +0200
Subject: [PATCH 2/2] pinctrl: realtek: Fix some NULL dereference warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-fix-realtek-warnings-v1-2-09af253312ba@linaro.org>
References: <20231006-fix-realtek-warnings-v1-0-09af253312ba@linaro.org>
In-Reply-To: <20231006-fix-realtek-warnings-v1-0-09af253312ba@linaro.org>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Tzuyi Chang <tychang@realtek.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just inspecting the code doesn't convince me that this is a real
issue, but the tools complain that it is so I will just handle it.

Cc: Tzuyi Chang <tychang@realtek.com>
Link: https://lore.kernel.org/oe-kbuild-all/202309270234.aJGlDE0P-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/realtek/pinctrl-rtd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd.c b/drivers/pinctrl/realtek/pinctrl-rtd.c
index bafe27face80..fc27e4f61be1 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd.c
@@ -165,7 +165,10 @@ static int rtd_pinctrl_set_one_mux(struct pinctrl_dev *pcdev,
 		return 0;
 
 	if (!mux->functions) {
-		dev_err(pcdev->dev, "No functions available for pin %s\n", mux->name);
+		if (!mux->name)
+			dev_err(pcdev->dev, "NULL pin has no functions\n");
+		else
+			dev_err(pcdev->dev, "No functions available for pin %s\n", mux->name);
 		return -ENOTSUPP;
 	}
 
@@ -177,6 +180,11 @@ static int rtd_pinctrl_set_one_mux(struct pinctrl_dev *pcdev,
 		return ret;
 	}
 
+	if (!mux->name) {
+		dev_err(pcdev->dev, "NULL pin provided for function %s\n", func_name);
+		return -EINVAL;
+	}
+
 	dev_err(pcdev->dev, "No function %s available for pin %s\n", func_name, mux->name);
 
 	return -EINVAL;

-- 
2.34.1

