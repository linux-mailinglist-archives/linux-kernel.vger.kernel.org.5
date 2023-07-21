Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FAF75BF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGUHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGUHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F72A273E;
        Fri, 21 Jul 2023 00:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC515612DC;
        Fri, 21 Jul 2023 07:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FBFC433CB;
        Fri, 21 Jul 2023 07:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689923374;
        bh=C+hSLA99pkHkutteaL+7ugfOymbqI1rh00LNugXxXk8=;
        h=From:Subject:Date:To:Cc:From;
        b=rAya1kdnXPDmZtSY2+DBS12KXK317VALunTFx7o2wIXjLWxMHYIN7YiaH9eMx3kxo
         SYIWkbRVmVdJNpQ9NkGQAOWP86pmcoOjgADDJ6yAueBy4KJqPbyprGA8UlJXECbqqF
         SriZm6Lz2RqqBD7yH2EdKmS/LJ56P5TbLYtYaj1ERwuR9QKxwuMLSWCycroe86iONY
         EAXeOOo32mPEvjp94dAn73BGeHcJ+Bzn45MrVQuABxj8yiyxmOXlaawBem+7L6uJyG
         BAPG3o7k1wKsP8hai57YabillO1swJ/l05dbEeXZvIAFfQUJhwNCdPm8tRosz+F9zV
         Jj0hQQ0jXRgxA==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
Date:   Fri, 21 Jul 2023 09:09:31 +0200
Message-Id: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACsvumQC/x2M2wpAQBBAf0XzbMqMXPIr8sAaTKulXaTk320eT
 51zHgjiVQI0yQNeLg26uQiUJmCW3s2COkYGzjjPKiY0q8VJb7Sn0wPXzdhRdjSFlDwwE1ENsd2
 9ROn/tt37fp0ybF9nAAAA
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=mripard@kernel.org;
 h=from:subject:message-id; bh=C+hSLA99pkHkutteaL+7ugfOymbqI1rh00LNugXxXk8=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm79HV0V25qLbwkUS32L8Vu94l9USpui8vl+Rpkimbuf
 Lbu3RXfjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAExkZxvDf6/uBY83hPhdDLt2
 +3BSYmPKWZ9AtgtWRyedWHCkqrbG7gEjwyTvxGtmnqs/J5UayXy5bCDBe5Hpl9n9U/PkJXhZjJa
 a8QEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small series to address the lockdep warning we have when
running the clk kunit tests with lockdep enabled.

For the record, it can be tested with:

$ ./tools/testing/kunit/kunit.py run \
    --kunitconfig=drivers/clk \
    --cross_compile aarch64-linux-gnu- --arch arm64 \
    --kconfig_add CONFIG_DEBUG_KERNEL=y \
    --kconfig_add CONFIG_PROVE_LOCKING=y

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (2):
      clk: Introduce kunit wrapper around clk_hw_init_rate_request
      clk: Introduce kunit wrapper around __clk_determine_rate

 drivers/clk/clk.c            | 51 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk_test.c       |  4 ++--
 include/linux/clk-provider.h | 21 ++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)
---
base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
change-id: 20230721-clk-fix-kunit-lockdep-c5e62b221118

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

