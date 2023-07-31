Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126F7695F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGaMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGaMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:19:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7B10FF;
        Mon, 31 Jul 2023 05:19:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686e0213c0bso2947176b3a.1;
        Mon, 31 Jul 2023 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690805951; x=1691410751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrQghpaqFi6Po+HbFQZHIgG05gOJBCUYvzEwIH+V8QU=;
        b=YR4VOumCo0hfXPc7+RMjq5z5oMBfWlLL1IN3ZmQHQkCo//tkh4BnYLYvGPfq7UDj64
         Ft2PtgzL3vtEKdBZoSX4Iilgg5nBzsXF+rB2ZE5Wh4MGUkFSrOF4KmCC2/E5eOFV5DnY
         zNrS9uoEC4YLySCgYM+8iJ10uHOL2w9hLi3OySp6nByrSQarqJkGsj0hxbkyYTxvzGTn
         VLuFKgk8oTX8IaMamizR9XEpibW61f+hQhwbkoG9Ksf9cTZS0ULackbe+Tkd2DZye56+
         nrHaMvuqS23YM1JteOQgKMRcMPKo604M61x8T6tVqhE0KnphY0ceditlJOspPMdG3iGW
         GFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805951; x=1691410751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrQghpaqFi6Po+HbFQZHIgG05gOJBCUYvzEwIH+V8QU=;
        b=GiexiakwP23ISevBsRPKdXbk04JCaKnAD3YNCPC7yvmceXpAQnhTRAh1x3+weQnNvT
         yXQraLx+EwW84Y5SEwvUNUKz1yyN2QQxMT9aQ1z9ypDUbOYHYmHCDN7xLlnV/LhhTmir
         WWiyvxAfQLFSk/c9MO2ME4FTODzgHQgGuqoE6TRYP9o+SUxSnc0f4jcRvNJY4KMifqc/
         9+35tDf7I5jwRpFV1jUSnMyUFHZTx5+vdNlpJxugnFWM+5AJ8quYzm7br0AgH3NP9J0m
         B7fVBr0ejECp6JHr2d4U+3XYmReMymARhwRR9Idz7M9x6u9dhwfwIuJ+lv9UfL0ru8Du
         GoDg==
X-Gm-Message-State: ABy/qLY+a3p/c+ffot/UMvppb67FftaDd+FEM0EVyMJgrBUxmvSARMnq
        qeyoH0nV7tHNuATeAhVPkHYvk8waQkSXw/gO
X-Google-Smtp-Source: APBJJlF6mQQzd24k/x9sY6TfjGIQGcR9Sr/1ZvwUCDjTHOToHe7PzT24wmMTvBHksV/D/uG6rFXm5Q==
X-Received: by 2002:a05:6a00:2481:b0:682:5a68:983c with SMTP id c1-20020a056a00248100b006825a68983cmr10746618pfv.34.1690805951273;
        Mon, 31 Jul 2023 05:19:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:19:10 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/13] clk: hisilicon: Migrate devm APIs
Date:   Mon, 31 Jul 2023 20:18:00 +0800
Message-Id: <20230731121821.22242-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
v6: fix compilation error and expand macros

Links:
[1]: https://lore.kernel.org/r/20230322164201.2454771-1-mmyangfl@gmail.com
v1: https://lore.kernel.org/r/20230326052757.297551-1-mmyangfl@gmail.com
v2: https://lore.kernel.org/r/20230329075104.165176-1-mmyangfl@gmail.com
v3: https://lore.kernel.org/r/20230410110733.192151-1-mmyangfl@gmail.com
v4: https://lore.kernel.org/r/20230411174329.424763-1-mmyangfl@gmail.com
v5: https://lore.kernel.org/r/20230723162245.35033-1-mmyangfl@gmail.com

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
 drivers/clk/hisilicon/clk-hi3559a.c       | 253 +++--------
 drivers/clk/hisilicon/clk-hi3620.c        | 212 +++++-----
 drivers/clk/hisilicon/clk-hi3660.c        | 192 +++------
 drivers/clk/hisilicon/clk-hi3670.c        | 248 ++++-------
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        | 229 +++++-----
 drivers/clk/hisilicon/clk-hip04.c         |  39 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  98 +++--
 drivers/clk/hisilicon/clk.c               | 490 +++++++++++++---------
 drivers/clk/hisilicon/clk.h               | 141 ++++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   | 171 +-------
 drivers/clk/hisilicon/crg-hi3798cv200.c   | 196 +--------
 drivers/clk/hisilicon/crg.h               |  11 +-
 drivers/clk/hisilicon/reset.c             |  42 ++
 18 files changed, 998 insertions(+), 1523 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.40.1

