Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163EF75E3B7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjGWQYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGWQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:24:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F501706;
        Sun, 23 Jul 2023 09:23:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-267fcd6985cso695312a91.2;
        Sun, 23 Jul 2023 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129407; x=1690734207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSNfH7WpcXj5Pi6KtTuPLxh+ad+PNqkkHK3RTVluyTY=;
        b=kFXQ41a5jgIKRgOBA3On6T+yIlbYoYtgwDSWCy7ssfCDJFHtVvhbN7Y8h1Hqbsik5z
         Yovs2M4Saz/27gadU07U1/C3d5cRvpdMXkFltYuTruJNjJNwkP2SBT7+tfC1AwB+AVcM
         xvWtyHLgBRE5XoGEUpWE1M4etpxS0XsNv7QPiPyAuBpgls9Nx0kl0F/cfxFcQoLbQ6Mu
         FR2CH94wYbaEjCY7ltFZ9SOM2NiMKIMru69CB+mNgQjVk0Hzoz9htVfpZMMrt3HdsLiD
         8fu8Skrflav14MrDHqTOBYgqXKVUvYGhxeuCqIKsPtrwca4jWMKCU3caiBBgMK09V4ob
         /q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129407; x=1690734207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSNfH7WpcXj5Pi6KtTuPLxh+ad+PNqkkHK3RTVluyTY=;
        b=gbwWNJhmQ50kE+Zc27oW61X/Xg3nJHNWH5oVkGSpkgjfyX07Z2aSlJkrz3z9ipe5oe
         V5e7tQP1+UCsiS1lOlF5jOVi87+RkMkHIfEjBLLA1fK1pRonlepkmanjGsjJ2xLn1jAj
         nJIcHVh1pxbyVjETzDa6+rIkCDKRVuu7P3MmN/RfU7wH1J2P6cwnA6aAuk6kKQOXlGf+
         FR8ll5zEEusK15NUdueUPnc+bqJfALNfn1SX+9EKmVbBFdEErikUy6sjd5MTpi+vOgHj
         015DjPt/EfA+jORy30u0vebS2/35f5NNsbihdxGNZPEvfH4DLSYJIvZNrklxdMFv+HWM
         w/zg==
X-Gm-Message-State: ABy/qLbJeYQoR12tdF5MCpKWnTZU3JL26zzPXhXV/u2ev62j4Ameq/hx
        AOozgwt7BFw8GQPPZCgxlbQLq5QwNlaBcg5q
X-Google-Smtp-Source: APBJJlFbt5Ym/sqj8JlSRFlLvb/KmyxsLBAFCaI10iYYjCKmzVP3kJznG+YbMNIHBjWURW13RXpqFA==
X-Received: by 2002:a17:90a:8b8d:b0:25f:20f:2f7d with SMTP id z13-20020a17090a8b8d00b0025f020f2f7dmr7524713pjn.2.1690129406801;
        Sun, 23 Jul 2023 09:23:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm6883787pjq.41.2023.07.23.09.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:23:26 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/13] clk: hisilicon: Migrate devm APIs
Date:   Mon, 24 Jul 2023 00:22:25 +0800
Message-Id: <20230723162245.35033-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.

This series is a partial improvement of [1]

v2: fix test robot error
v3:
  * size_t for all these num types
  * hisi_clk_unregister() change into separate patch
  * keep relevant header inclusions
  * split driver files changes into separate patches
  * explain hisi_clk_register_fn() checkpatch warnings
  * not fixed: MODULE_LICENSE("GPL v2"), as stated in SPDX-License-Identifier
  * not fixed: "hisilicon,hip04-clock" un-documented, as none of dts files in
    arch/ use it, better to ask hisi people why they pushed this driver
v4:
  * typo: hisi_clocks_get_nr() should check clks->nr first
  * unexport hisi_clk_unregister_fn() as no one use them outside
v5: catch up with remove_new refactoring

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230410110733.192151-1-mmyangfl@gmail.com
v4: https://lore.kernel.org/r/20230411174329.424763-1-mmyangfl@gmail.com

David Yang (13):
  clk: hisilicon: Add helper functions for platform driver
  clk: hisilicon: hi3516cv300: Use helper functions
  clk: hisilicon: hi3798cv200: Use helper functions
  clk: hisilicon: Remove hisi_crg_funcs
  clk: hisilicon: hi3519: Use helper functions
  clk: hisilicon: hi3559a: Use helper functions
  clk: hisilicon: hi3660: Convert into module
  clk: hisilicon: hi3670: Convert into module
  clk: hisilicon: hi3620: Convert into platform driver module
  clk: hisilicon: hi6220: Convert into platform driver module
  clk: hisilicon: hip04: Convert into platform driver module
  clk: hisilicon: hix5hd2: Convert into platform driver module
  clk: hisilicon: Migrate devm APIs

 drivers/clk/hisilicon/clk-hi3519.c        | 127 +-----
 drivers/clk/hisilicon/clk-hi3559a.c       | 252 +++---------
 drivers/clk/hisilicon/clk-hi3620.c        | 212 +++++-----
 drivers/clk/hisilicon/clk-hi3660.c        | 192 +++------
 drivers/clk/hisilicon/clk-hi3670.c        | 248 ++++--------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 229 ++++++-----
 drivers/clk/hisilicon/clk-hip04.c         |  39 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  98 +++--
 drivers/clk/hisilicon/clk.c               | 457 +++++++++++-----------
 drivers/clk/hisilicon/clk.h               | 141 ++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 171 +-------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 196 +---------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  42 ++
 18 files changed, 937 insertions(+), 1550 deletions(-)


base-commit: c2782531397f5cb19ca3f8f9c17727f1cdf5bee8
-- 
2.40.1

