Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583427B46CA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjJAK3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjJAK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FCCD8;
        Sun,  1 Oct 2023 03:29:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D83C433C8;
        Sun,  1 Oct 2023 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156167;
        bh=k2kahuk7nZEVhkneKh7aevnE3QLGIEjKWlY1r+itt7Y=;
        h=From:Subject:Date:To:Cc:From;
        b=P8Ttlu6q6IGAzDDagWR4eFnP9CyvcqFL0Rmz6rUm9hgauzbI+Jkw/T/0cE60H3+gP
         eDpe9ucUzapb5BBBLK1sdOiIq6xvM0m9XibdlPa3ITGMEtNGUkbBhQ8pheqa5AIUzA
         TX9UNnYcDZeBaYQV1/40L7M1Cn5/Xnex4ZJYaKAvN6+bem2YutwcxPvRlImgQqLFA9
         ZcSJr9WiiORpVpsfWfKcJEl2cL5msTLpYTBhAXjbevsqnIzT/F+fAzCZoqZAXCnBeh
         oHZs3hqBAArGtHkbAsMJYqxAG4ueyY+U6VVGr6GSzAlpuStD48XRUuWroS2G54Q2EJ
         qo8pAPjaBZLCg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/7] mfd: ti: Convert to maple tree register cache
Date:   Sun, 01 Oct 2023 11:27:47 +0100
Message-Id: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNJGWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3dy0FN2STN3cxIKcVF1zI1MLEwuLZAMDC2MloJaCotS0zAqwcdG
 xtbUA/Mhqvl4AAAA=
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k2kahuk7nZEVhkneKh7aevnE3QLGIEjKWlY1r+itt7Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUn/Cm7fbi5Ocl1cZsNifh6LUoV52M1t9kDYn
 SV6BOPq1OmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlJ/wAKCRAk1otyXVSH
 0CTQB/sGm7/cg6MVEXap+k3e/fou9FSDFWWdw0GBHrngQih2RPiYEAa1p5Pp34s5/UyRlF3JxNm
 dRHsKmElFTsSq8LDJa+2knEZTVAxo7WK/R2pP2wb7YyJK/QbLvLPVZlWIaJ7yV7thWUG/bWiiqm
 xHrbZ/Q5XtUQzxOQL+QY3vWhsNqN3yfHiu0FEXC7BvaU4DJLq3CVA9BBA4NQH1sigxiBFYaDN0+
 48lKKRCqYTW5b47l9upmu8Fv+tkQWv30oq4STdz//THZgCegTOgrbZ7RC4a1/MzuWOfernRLPLg
 f0I7N/XL4bX/3YioShTGEF0SMQ0u7pxzm+5dzPaaHmASMv6Q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree based register cache is based on a more modern data
structure and makes more current implementation decisions than the
rbtree cache, convert the TI drivers that use rbtree caches to use
maple tree instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (7):
      mfd: tps65086: Convert to use maple tree register cache
      mfd: tps65090: Convert to use maple tree register cache
      mfd: tps65128: Convert to use maple tree register cache
      mfd: tps6586x: Convert to use maple tree register cache
      mfd: tps65910: Convert to use maple tree register cache
      mfd: tps65912: Convert to use maple tree register cache
      mfd: twl: Convert to use maple tree register cache

 drivers/mfd/tps65086.c      | 2 +-
 drivers/mfd/tps65090.c      | 2 +-
 drivers/mfd/tps65218.c      | 2 +-
 drivers/mfd/tps6586x.c      | 2 +-
 drivers/mfd/tps65910.c      | 2 +-
 drivers/mfd/tps65912-core.c | 2 +-
 drivers/mfd/twl-core.c      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-mfd-ti-maple-7258488c0083

Best regards,
-- 
Mark Brown <broonie@kernel.org>

