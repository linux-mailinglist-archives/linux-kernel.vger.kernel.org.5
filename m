Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9FC7B325C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjI2MWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjI2MWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B4BE;
        Fri, 29 Sep 2023 05:22:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4B5C433C7;
        Fri, 29 Sep 2023 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990139;
        bh=ugQ9F3ldM7csW38i+MQy3kNJpEw3zpyEJXmBxHtDrDk=;
        h=From:Subject:Date:To:Cc:From;
        b=crqGo8h8ROzoByl/pDFh9RPHNK+Atf0NqYbPN4KUvJT9c/hDr86TosOsdpjGeaCmz
         pSYMefZekxpS1UKlMBSy8nNs39ZlKoQeVSZlb+tXupB2v0bRVLuCSnQgkdxW56RGfR
         ztm7l3b6cKgEFfwyfozZRgLJaRu14tmSToOdbR7F2fykzp3lP4QQThd02ax3EtNjl6
         3b0RyRSbz2MGu+AmRoPv7AM2dTwoEBQ86pwb8h8o3/GpKDhnUXh+B6cQxoPer2Wji1
         uZ7axsvwKoG0rhhfU2oV4xlT8JY5bfzPQrRxidnwHO72hudGUrpwmeq1sufqZt+o1M
         IsiuXnRjYhvoQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] clk: Convert Silico Labs drivers to use maple tree
 register cache
Date:   Fri, 29 Sep 2023 14:21:58 +0200
Message-Id: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbBFmUC/x3MQQqAIBBA0avIrBswbWNXiRaiUw2ZiUIE4t2Tl
 m/xf4VCmanALCpkerjwHTvGQYA7bNwJ2XeDkkpLowy6cOJlUyAsjH6ym1TOa08GepIybfz+u2V
 t7QOij+jRXgAAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ugQ9F3ldM7csW38i+MQy3kNJpEw3zpyEJXmBxHtDrDk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsF1fu8GuHMlxFE1Z+Wkz/7riyqSrP+fYLDIY
 GaF4I121CWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbBdQAKCRAk1otyXVSH
 0G2ECACB1gqYs21UPRIOj7efOBD/1QNyjB8FBrKzyBVxuDZ9581neiQsSUDaS43yYEOtPIO6STN
 Hb7aSL8bqpcfW6pGCsWQOnizkJIXk31uJxzD8lIQoriWELglsSKSbgks5g/Eg/dpk/RSYaWZxuT
 u4sixVSqsnBcQXNqJIVcJxwHSjl9P5mpma5zSPDrgDIEmLyNQxg7uMtUwm0WlNtP+npUXiot6qc
 kXacT/PWh+4mWvfW7GZb1RiAI9C0IwhKDbbVmQQU8MUpYWjfOatC9P1F4llCo26e/2ZPhnHHpLK
 1eJ9dCcdPotL3DGlJQf97CluQ8NK0/j/sQPhoDz9RBII+CVF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes implementation choices which are likely to be
more sensible for modern systems so let's convert drivers to use it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (5):
      clk: si514: Convert to use maple tree register cache
      clk: si5341: Convert to use maple tree register cache
      clk: si5351: Convert to use maple tree register cache
      clk: si544: Convert to use maple tree register cache
      clk: si570: Convert to use maple tree register cache

 drivers/clk/clk-si514.c  | 2 +-
 drivers/clk/clk-si5341.c | 2 +-
 drivers/clk/clk-si5351.c | 2 +-
 drivers/clk/clk-si544.c  | 2 +-
 drivers/clk/clk-si570.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-clk-maple-si-d4af02cd3de9

Best regards,
-- 
Mark Brown <broonie@kernel.org>

