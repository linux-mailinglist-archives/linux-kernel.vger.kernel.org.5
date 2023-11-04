Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F047E0F7A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjKDMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjKDMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:43:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6221D51
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:43:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a0907896so3707749e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101830; x=1699706630; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewDHm+e+GImvvqfDodwPgmnoPkNl83AA+pDa6pnzAe0=;
        b=qDROO+9sghjQ40J86626HOQ3S7Z/JyP9y5QuO8K6wG00WF1vvwMG6wuws5fSeTnLq1
         9wklQou2B1pjtvlK3J1BZnncRSA+w4czm0HrEVwoD3oPbWvbnrY6d2bLmDJ1wIKOFKZt
         Lk1XNVWgaMlKfZxQ0FNjKSmcOGIdgmF9w7PSQucREnWSPH2qtwKy2diciEBFVsQS21q2
         Mg4H3n5TEBf39SgRmHJDA+QCkBMUcO0WqZaB05yxRoXwTYiXEyGJZQVmol/V6nzO0/Yl
         Thh4l4HeDbv8sZZa2h5h7atJhAv4kux1ICWuEdbFbkkEqB7OwE9055NSKduUG+iKREjH
         utXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101830; x=1699706630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewDHm+e+GImvvqfDodwPgmnoPkNl83AA+pDa6pnzAe0=;
        b=Y726pQRxfTcxQ+StE7feum8ywGjLpzfR3Njt2mEsXiQH9Pn0n3gBoFSKySvWmQ7Mla
         4xtiDOM0HEpraBrFBhNHWLaxxkg7DSVksRoTIkjSRG6OiJYI+YY5b7AYbJHfDr5sIHum
         zh0G5w6+TBcDdv50WuKkWAia6mFFonytRJe0CHgZsd73M2jeGCLsgbwivkTVy5O2o+L2
         y7CkRf5rmAvpoZPk1nwbSIfHgxNTqinv7kuQPfwoSLqok1ZERmdr9kOV6V/OrJ+ucfAL
         F6hXGKm728yry95lJQKBEaj3Sdb2+sfWlqJX5WklTcCXHWthyh6mnSh1YFR6YPiAongI
         1EWw==
X-Gm-Message-State: AOJu0YyTAaOm7NOEJbr4R3AQUxsFT/xODtA9F5djMTxvXKtHFcEeiyiv
        Oghjsbc4QuSULemCSoZ6lFwaow==
X-Google-Smtp-Source: AGHT+IGGlkissxY+vBqmlLfCOeMTVSLvbUU0DrUKYcegqlRg5AhwssW3duvhu257rrYlLalqYiXfyA==
X-Received: by 2002:a05:6512:132a:b0:509:4559:27a9 with SMTP id x42-20020a056512132a00b00509455927a9mr7370477lfu.8.1699101829828;
        Sat, 04 Nov 2023 05:43:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net 0/4] Fix large frames in the Gemini ethernet driver
Date:   Sat, 04 Nov 2023 13:43:47 +0100
Message-Id: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIM8RmUC/x2MwQqDMBAFf0X27IIblRZ/pXiI8Zku1Fg2Ugriv
 xs8zsDMQRmmyDRUBxl+mnVLBaSuKLx9imCdC5NrXCvSdByxalL+eItYzK/gRf8cpGtnFx5PmXo
 q7ddQ9P19UcJO43lejY1NxGwAAAA=
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>
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
Linus Walleij (4):
      net: ethernet: cortina: Fix MTU max setting
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Protect against oversized frames
      net: ethernet: cortina: Handle large frames

 drivers/net/ethernet/cortina/gemini.c | 32 ++++++++++++++++++++++++++------
 drivers/net/ethernet/cortina/gemini.h | 10 +++++-----
 2 files changed, 31 insertions(+), 11 deletions(-)
---
base-commit: 90b0c2b2edd1adff742c621e246562fbefa11b70
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

