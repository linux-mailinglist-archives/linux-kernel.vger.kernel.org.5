Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE27AB89F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjIVRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjIVRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:54:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095FE4A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692ada71d79so759049b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405182; x=1696009982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9ccZOV4wJXlK1yFnxfHkMmpmm5GjHprdns1OiYQeHs=;
        b=mhDigjpMnPomAqxSjmthdpH57fBDW9P1d28FRVYKrhsE9Fjf4rPFmSmAPpXpb7VNy+
         rcomVXL1K8KQ4Cfbg1I0Ix6ytiNnv0AvuMhmPEdVrTxNNsfRN0/lLsfxZtlOeVe02qPF
         izoYuTErVI0eLJh6yS38YSJSU2Zo5YFyIt7LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405182; x=1696009982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9ccZOV4wJXlK1yFnxfHkMmpmm5GjHprdns1OiYQeHs=;
        b=FUvyuby+fi5M3KGyfpjCS+yrM4YISSru9cWOSDt8CXBprrAGhbhssfh0+KAE2jIwq7
         AVK+3IYf4j+FynZ5R/z/UfGWdIfR8VaixQKcvA/At0fF5tKCYU62u9fm+cTrU+FZQaf5
         QCExcxv6gEEypjgz8IYhGBYUKmA4S+g5YdtlZwc3BAO9iFSvw4VEffYJWn+vkfpzff3N
         QHtCkA8s9bTHp6iG5eIdGrSiDJgNJ3N7G/1M5Kxdh6/4O7Oz2rtKHxbBuwM1ixuBQcMS
         aLKyjlZcHDrgoaogeOAhiBqgRbrLkUkDU1jv27Ed4n0t5okadMzNy1hUGhIfhSWW9mKi
         NwVA==
X-Gm-Message-State: AOJu0YzqyC1zuR7kfm0BI/ZzfRTFWQQVVdpbMd41820/7FRSvMWASi93
        LAS/Odo7FhXd5TayO+gNplUOXg==
X-Google-Smtp-Source: AGHT+IGx6FFwhNIDtiz3Eh6ZVJ6C90R5aTRutPSfCddx1UXArpxi6YrkkUJNEQ35olAJkHw3WYli7A==
X-Received: by 2002:a17:90b:4b41:b0:274:24e2:ae6d with SMTP id mi1-20020a17090b4b4100b0027424e2ae6dmr488925pjb.0.1695405182538;
        Fri, 22 Sep 2023 10:53:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0026d214a2b33sm5282306pjv.7.2023.09.22.10.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bodo Stroesser <bostroesser@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: target: tcmu: Annotate struct tcmu_tmr with __counted_by
Date:   Fri, 22 Sep 2023 10:53:01 -0700
Message-Id: <20230922175300.work.148-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=keescook@chromium.org;
 h=from:subject:message-id; bh=FcaqXSByARe51bzBFiEiVh2BnnpT/BBlX8W8UQ0HgHI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdR8Qv/J3bqK5P7cmRhrII3B2LZASbyQAyA/V
 nNid9mBmhqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UfAAKCRCJcvTf3G3A
 Jro0D/9SbPtkx/9xM7Efr9UP/3joE2Y0lZEmWygmLAqD2wmplBii27xBBzcka9Uvlq1eDy6NPZz
 15amMxCkOxtoyTUxf2LYIBBwp8oQciqljhl1QavRXe6Kh7TQ5k3iicvPs6855GbkvKedFiZwwSj
 8yVK+Kr6dThjxAuB13jJJiG4GSLwNNY+aR/xd8mO8IRggrA6HKthh87050we6/xUIirr4NrP/as
 mj0sWZWn23E+oyDlEqYo9LfcWXK5wF1fufUtJI7gM3HGbno23z3KZj40UinLjjpWr7/+X3cuKqi
 tl4tAkLR4l8pJkbeae3XBKfldgCSlup5ikSsrs64Q9vizG2VDolJqvqsEId2nRDMq/jOPOEDj5n
 wC5TsygAg+uTkNInLbH/YrYCiQxS8GfDi1meIX/9fP+QYrUJZK9VY1NyIYNf6NKbOIn9J8pH1Ck
 nK4NzEzQ2JQxslkNUbKHZh+yxC9Hh3zGUXQufo+VPvTcj12siRravIlT+3aBOptBWk1Q4EKButa
 t2HY95XpdBSlIKQlWz5RfDhuBaJ/xSvIp8f0PFiHikB1k/wnh44KD50Fg3P7KznK8wt2u4CUJ25
 RU94tM9ytkUe0+jHbWeoNyE7yQF+VEqUGzugtV1DbEKOQj5A+P7rta6k/V+eddKflkPR4geULkM
 JLgPdRk HsTcVXeg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

As found with Coccinelle[1], add __counted_by for struct tcmu_tmr.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/target/target_core_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 22cc6cac0ba2..7eb94894bd68 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -201,7 +201,7 @@ struct tcmu_tmr {
 
 	uint8_t tmr_type;
 	uint32_t tmr_cmd_cnt;
-	int16_t tmr_cmd_ids[];
+	int16_t tmr_cmd_ids[] __counted_by(tmr_cmd_cnt);
 };
 
 /*
-- 
2.34.1

