Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D47E16A9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjKEU5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKEU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:57:32 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C1DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:57:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50970c2115eso445154e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217847; x=1699822647; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFkRCO5Gr31wYYObvH3M58yivJORulviaRB/LYrXXJQ=;
        b=T71nTGc3Okg3dJ2uwL1PBI2yihVsH1WUU6wVIvBV6MsY1JdiYlECtNF4NDGUuM90C/
         JaXDu8k4/NHYkMWT3+aa+ejrB1nwZ7pWusxsNO73UpxUc16lEoNfNoOdzeKLJ7q0Sci/
         KYFIc/DlCNcNumSnbqPCPW9LuO4xLBXzPQ68uKDkAQ4/f3cUoGK25k+4kuvjlo9roDUj
         83/LItQaChogLOazxOFYrTWGpQmhR5tGbfQl0apg2DABFlkMMQoT1lsHvm1xNoZp1R4W
         0+Whe8mumr2gdnYVFUmBYp6JhsBlnqoe0NC78Ci6Zu1dbqYuTvmbrVAyLGLMZkLTUS6a
         fZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217847; x=1699822647;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFkRCO5Gr31wYYObvH3M58yivJORulviaRB/LYrXXJQ=;
        b=PDnxaAarkRf2p8+I09mLGnbLBFf2iz4jhpsReaoJ0QD6iWJTHUmK5COYrHggWDUVBC
         z2OjE/uO6ufAY+es6FpAqY7psHcDzj+bIDgxQPZTdj9+vW0RJh+n+qlhM3LuqO/8R+ph
         wkHi+QXkhAWf6PoHd6i6aaoZO8/TPYj+H6msvtwaBHFO2C+M3pRd9Ea6od2wNUclcbDC
         LIu4CJwoOHeoycXHqju1bM1NuH5IAA/lvM4MAA6W2zTOyYlneGFoaTtfZpSZcsestfae
         +A4o9zVn+cW8B300/ShbNXeevBb/qXQnGk1uK2yRgw4ijI60MJVpemZpw78owRAxiKkQ
         iyzg==
X-Gm-Message-State: AOJu0YzGJSRDN6W6bT7DZOFb57Zlw44X9tg3FIMsbxqD3IoBH5DjH3rH
        dUh4KZr27mxA6PUJYvpT/jcGXg==
X-Google-Smtp-Source: AGHT+IGGCnq8W4xy+A703Avtfw1jtmjghCdQJdWIjjPpOpvf4AdSuEWf3pw2aCu+fr2p82NwWqsyhg==
X-Received: by 2002:a05:6512:969:b0:509:377a:26d9 with SMTP id v9-20020a056512096900b00509377a26d9mr10364957lft.8.1699217846755;
        Sun, 05 Nov 2023 12:57:26 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:26 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v2 0/4] Fix large frames in the Gemini ethernet driver
Date:   Sun, 05 Nov 2023 21:57:22 +0100
Message-Id: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIBSGUC/4WNTQqDMBCFryKzboqTKP1Z9R7FRRoncUCTMhFpk
 dy9wQt0+b7H+94OmYQpw73ZQWjjzCnWoE8NuMnGQIrHmkG32iC2nQq0cGQ1WwnkxS6kPH+Uw86
 M2l2u+Oqhbt9CFR/eJ0RaYahw4rwm+R5fGx7VH+2GqlU31/dovNbemMfM0Uo6JwkwlFJ+9/O3g
 sAAAAA=
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the result of a bug hunt for a problem with the
RTL8366RB DSA switch leading me wrong all over the place.

I am indebted to Vladimir Oltean who as usual pointed
out where the real problem was, many thanks!

Tryig to actually use big ("jumbo") frames on this
hardware uncovered the real bugs. Then I tested it on
the DSA switch and it indeed fixes the issue.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Don't check for oversized MTU request: the framework makes sure it doesn't
  happen.
- Drop unrelated BIT() macro cleanups (I might send these later for net-next)
- Use a special error code if the skbuff is too big and fail gracefully
  is this happens.
- Do proper checksum of the frame using a software fallback when the frame
  is too long for hardware checksumming.
- Link to v1: https://lore.kernel.org/r/20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org

---
Linus Walleij (4):
      net: ethernet: cortina: Fix MTU max setting
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Protect against oversized frames
      net: ethernet: cortina: Handle large frames

 drivers/net/ethernet/cortina/gemini.c | 39 ++++++++++++++++++++++++++++-------
 drivers/net/ethernet/cortina/gemini.h |  4 ++--
 2 files changed, 34 insertions(+), 9 deletions(-)
---
base-commit: e85fd73c7d9630d392f451fcf69a457c8e3f21dd
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

