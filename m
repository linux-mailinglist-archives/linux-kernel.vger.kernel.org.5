Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4A7A27D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjIOUOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbjIOUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:13:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781CB2D51
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so2431653b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808776; x=1695413576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BZJf9s84lU3CfTi9HxKXU6WVEhOLwpzo38ws2QVZ2w=;
        b=d1zi4gb7iZeE22DJcrfkwDtgaqpetFjzj59ItBO1A3Se0Is8x2VsDnSC/hkMPrLPw3
         OnyloemvgZOJ1PR6LBL2RQiAQBsvY2uOlh9W+jNTBGsejl46qYFqK+zkwDVIXfVsK/hF
         pwKR5ySPBttayWOkqcdl+5xusvFtWDxOjarzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808776; x=1695413576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BZJf9s84lU3CfTi9HxKXU6WVEhOLwpzo38ws2QVZ2w=;
        b=q1bsbxbAogOgnc7o1m5qVCnhrQsuFxP1QJjAolonnYHLQqlbPYLuuuTtqeA3rXHvmf
         tj4vKUrQZLi9zMp9onRqSCFKS79b54bGA53GQQ7F6qHKrDnrcGxre6O92DZpmcR2Hido
         kYTP0zhhcWqmjWbZ6TWijHhEyKOCV/DoXSSKCQN8NZg60TEjpuyu8yxmYCMp9NJbtJj7
         hEK02hmkKvdpad/UWPUrJHNx3cLojDjwiDlB/D2NCPeOps7IT7brIz2hN7f+o64lP+bN
         KBWcwkWCUL66Rn2hXt/gv+Ai4VunICiZqHOoZGaL6MxdEMm7kb9f4hMsPgbnDxYBbQGz
         ycjw==
X-Gm-Message-State: AOJu0YyGnEatdatO7+X1sWNlM9Q/dkBnTxJZlxAM8nxMtkdUbPkc4H4h
        XsYvewkWZDOceac5YuYp1ympew==
X-Google-Smtp-Source: AGHT+IHmQbOxLY0L8bXhn+zKOM/BnwaC8qXFTLFQ0kYWZVSH2PXuzlce8g/QsH9C+n/HCzeTj7zpsw==
X-Received: by 2002:a05:6a20:320d:b0:14b:8023:33c8 with SMTP id hl13-20020a056a20320d00b0014b802333c8mr2750657pzc.2.1694808776017;
        Fri, 15 Sep 2023 13:12:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z16-20020a656650000000b00565dd935938sm2758499pgv.85.2023.09.15.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:12:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: renesas: Annotate struct rnand_chip with __counted_by
Date:   Fri, 15 Sep 2023 13:12:54 -0700
Message-Id: <20230915201254.never.511-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0FPGmCgvWt7RjvkdTmKw5gfdGmdouZ3tE6ulzomUB2U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLrGeRmtf7v7PuHT27LUye5Sm4GLfRpWtonSx
 p2dIfmBTvuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6xgAKCRCJcvTf3G3A
 Jm5IEAC1QGXYJ9yOV0x64S8RCZrHbM5hI5qcR13CwhzHoqjMh2ZYHbyfI3r1NJdJai/+Lz6k2Qy
 mEzqHCjkI/Mub7jmWbQpzrff0loovqVfED8gwE3LDnt21UZALC2CHMhkeynTeqfx3blquFl/4/S
 2xcPtvU8OQdr4PA1CDlZv4sIuMDjCztn2Z379LJlimR60iSZgkxcdJGE81pVkF5tD8CRvh5ckn/
 JnHJ6MpjFjETsFnCbayrzEsvZTQXAA065p7EpTafPz7trWTN7hjj9nKUDG6aT8lnlALZDWgWf4v
 BWN3h57Y4cSYBG8z29PniByDsPlVzYfW3J9Lxd1C8430W9VDbH3xu/q957gWp4Bl5U7aQK8QsIJ
 dAf3OzpoL/ONx8PDuObWUgww//y8mHbjqvRqowuTA+VlchilOGBE0+qz4C6cxLvbBjTSm/XOW4W
 Q1R+0c+bJtRPYdANjaXw2lFzNTlXg+iHDbwsQsN/6BeNu06htsCNR+N9BpRebycxfmHrIqO86hb
 oluyC6avf43e1QhfZDl7ViR+6olmcuXajW1hbv4PdUXKzeEqvPZwfbcZzp4kFfYDCyMAV9oifxd
 yG29Z874XY7Xo5PDqIiflaj4hU2414puFaXtfq8yfQFSglCTM0E+X5RDD2qWfvNo2QdF212WR4F
 x/g2isV w/p8A3kA==
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

As found with Coccinelle[1], add __counted_by for struct rnand_chip.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/raw/renesas-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/renesas-nand-controller.c b/drivers/mtd/nand/raw/renesas-nand-controller.c
index 589021ea9eb2..c9a01feff8df 100644
--- a/drivers/mtd/nand/raw/renesas-nand-controller.c
+++ b/drivers/mtd/nand/raw/renesas-nand-controller.c
@@ -210,7 +210,7 @@ struct rnand_chip {
 	u32 tim_gen_seq1;
 	u32 tim_gen_seq2;
 	u32 tim_gen_seq3;
-	struct rnand_chip_sel sels[];
+	struct rnand_chip_sel sels[] __counted_by(nsels);
 };
 
 struct rnandc {
-- 
2.34.1

