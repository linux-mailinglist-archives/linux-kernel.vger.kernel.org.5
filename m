Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305E275DF86
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 03:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGWBEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 21:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWBEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 21:04:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845711BE2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 18:04:38 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a5a7ebdd9fso590068b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 18:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690074277; x=1690679077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye3LRGSURfy3VknXwfgBx3T/03XjBq/mir5HY2YR/bA=;
        b=cOXsJItF9H6s6DhK5XjwTXJryb5Jx/cV50cDU9tsS7ghKEvXwJ8i8Pue31j4Mn2AB9
         DkAUuqYzbCReROV+80XidrGtNDhzCT13ch43VrG6UkuKAyRQWhxtB/yPvTJTAs519t6K
         9f41aPVDentRsAl+sJOPnOvSw5vA0ekepbLJwHLD6o7ysozt5fzfr8Lff7MSzCmeI1te
         ufz0Wp2BpshQh8q2WZbUIZovmj0dZubvfz350sTRpxlPAmBm99YWaiNeasa0Xx/qsVAJ
         FU7pPxyW5weHXVoWjc55113w8u4OXd1OZ3+qaSMslLoe/7Jq5YrVAZWcqF2cP6YPhwSa
         2Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690074277; x=1690679077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ye3LRGSURfy3VknXwfgBx3T/03XjBq/mir5HY2YR/bA=;
        b=OkL7yvNFLyPhnC7AcCc3J59+xw9oNI17km9aSTwLqDvZZ/mY6EC4tI8OFCSh3iIqRV
         IDQkZkxs2L6x6kxPBfOXkSKF47sBYMtmCl5B3y1q2NCfB9KabdHvrmMZLmuiR8qi3KpX
         AmicPG1MLT2TkEVbF9gj3vrfj11tN9KLCBWfbgOXhULqrAsdMSMlGZvh4SfoEtqdWmTM
         U9tO+odTtQbCvwfwrZYNOPJVRi4cqmZU+ZTxiO+/vw3O4dPRB5I1yZEp56t/eMn1EAID
         sJGfXIrA/B8oga0MoHQe5fCnXO6ZT90csxkjSRhNUTjDXTT7D+ZnA/c2atx3nquWEZkA
         Q1Jg==
X-Gm-Message-State: ABy/qLaZKwEgrZtiNmJQ/AUNt703CKR87QnhSFMvZStYseeKpNzhJfKt
        +p+a6/DV8mRJYyXVlt+rycVBpQ==
X-Google-Smtp-Source: APBJJlEAVa6Ye+J7tbKUWQVmlUCvqtTBbnwc6koa7fYyl03zoal3Hl3hZMP3GdFWSAPzvdzbbY+fTw==
X-Received: by 2002:aca:120f:0:b0:3a4:5b8:76c2 with SMTP id 15-20020aca120f000000b003a405b876c2mr6407733ois.7.1690074276980;
        Sat, 22 Jul 2023 18:04:36 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1800:f680:2a8c:966f:392d:7230])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c15300b001b849932030sm5966160plj.198.2023.07.22.18.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 18:04:36 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Ian Rogers <irogers@google.com>, SeongJae Park <sj@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH] scripts/spelling.txt: remove 'thead' as a typo
Date:   Sat, 22 Jul 2023 18:03:30 -0700
Message-Id: <20230723010329.674186-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-Head is a vendor of processor core IP, and they have recently
introduced the RISC-V TH1520 SoC. Remove 'thead' as a typo of 'thread'
to avoid checkpatch incorrectly warning that 'thead' is typo in patches
that add support for T-Head designs in the kernel.

Cc: Conor Dooley <conor@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>
Link: https://www.t-head.cn/
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 scripts/spelling.txt | 1 -
 1 file changed, 1 deletion(-)

For example, checkpatch prints the following warnings for 89b0186ab532
("dt-bindings: riscv: Add T-HEAD TH1520 board compatibles"):

  $ ./scripts/checkpatch.pl --strict -g 89b0186ab532
  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  new file mode 100644

  WARNING: 'thead' may be misspelled - perhaps 'thread'?
  +$id: http://devicetree.org/schemas/riscv/thead.yaml#
                                          ^^^^^

  WARNING: 'thead' may be misspelled - perhaps 'thread'?
  +          - const: thead,th1520
                    ^^^^^
  total: 0 errors, 3 warnings, 0 checks, 29 lines checked

The 'thead' typo false positive adds noise to automation like the
linux-riscv patchwork bot:
https://patchwork.kernel.org/project/linux-riscv/patch/20230722-upstream-beaglev-ahead-dts-v1-2-ccda511357f4@baylibre.com/

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index fc7ba95e86a0..855c4863124b 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1541,7 +1541,6 @@ temeprature||temperature
 temorary||temporary
 temproarily||temporarily
 temperture||temperature
-thead||thread
 theads||threads
 therfore||therefore
 thier||their
-- 
2.34.1

