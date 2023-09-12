Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654C679D823
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjILRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjILRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:55:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA3110D3;
        Tue, 12 Sep 2023 10:55:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A31C433C8;
        Tue, 12 Sep 2023 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541335;
        bh=rrwYR3/rqDwXPIcEZV4/pnPLM7oE/aWqYDmNh+JXXaA=;
        h=From:To:Cc:Subject:Date:From;
        b=mboLiXQHP0KBMCCt14sMYW/+pIam/h/U7/xcobZ6lEqrEw993BhQD+cDrERdJRs4R
         Cz+Opgs5wXVQEPUMxCKIRZYuZ+EzImcwDVA9bhEsz9u9atUquoxR2HEhAmit5Do77P
         24YFu98YvPZJBvw1q+1LhYX/Le/pLGO/TOmqEBVQe904avvh1nKq17kOi9F2TAYOv6
         0AM10A9qEStnIGYJldEHDyhR1zqeesqNsYeMRisrJ5gSJX6bYjdkvz/8uaD0si/SF+
         QKOvPCgr+SbkEq41pqpgohXL1FsDCuQeH54aitsYYStDkOVVxbz0RlpSediS2EB5c2
         EatiPcArOHtLA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/2] clk: Fix lockdep warnings in clk_test
Date:   Tue, 12 Sep 2023 10:55:29 -0700
Message-ID: <20230912175534.2427862-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a replacement for the series from Maxime[1]. I didn't want to
introduce more wrappers, so this series takes the approach of driving
the test from a clk_op instead. The second patch extends the test to
look at more determine_rate variants. We can probably extend the test
further to set or not set the CLK_SET_RATE_PARENT flag as well but I
didn't do that.

Stephen Boyd (2):
  clk: Drive clk_leaf_mux_set_rate_parent test from clk_ops
  clk: Parameterize clk_leaf_mux_set_rate_parent

 drivers/clk/clk_test.c | 130 +++++++++++++++++++++++++++++++++++------
 1 file changed, 113 insertions(+), 17 deletions(-)

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Maxime Ripard <mripard@kernel.org>

[1] https://lore.kernel.org/r/20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

