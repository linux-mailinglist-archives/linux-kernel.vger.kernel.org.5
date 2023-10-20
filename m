Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E77D14C5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjJTRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJTRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:23:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A41A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:23:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6732C433C7;
        Fri, 20 Oct 2023 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697822600;
        bh=9DTH2ejZ6gRx9v5Kr+Y3Lfgwo0SmTNuA/A5IR8D58/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=UQhrh7+6S/MSu4IcYRnXuy7EYcConABwkV5hydTwSyGaPGdbM+HMqPvgfmUEdx3Q2
         2pBWW6qmhoe340ImjiAKa6WW0FD71QgmiHBHceMfRdW4VLA1W3NQyHUjHIXN+eXJP/
         VlBL0uJMjRaOjf/o5PY5oVU6dzu7hzgNv6yKwCT7zH+CxhfMgHie2tydm/d+/n7S+N
         CZNwWgm3CF7e66+DDpUriULU2laVgMqusZkUK7RZkGYU/tb698rfmgSsfILGziBHQE
         brznPtN20sErmnwVXeT5lynnssIpxOJhevA05ao1A4x8QeQG4b4ek2Ioxqg1VwmSzs
         OZcVn5GEq5lGA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jakub Acs <acsjakub@amazon.de>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date:   Fri, 20 Oct 2023 17:23:12 +0000
Message-Id: <20231020172317.64192-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1
(https://lore.kernel.org/damon/20231019194924.100347-1-sj@kernel.org/)
- Add Reported-by: Jakub Acs <acsjakub@amazon.de>

The maximum nr_accesses of given DAMON context can be calculated by
dividing the aggregation interval by the sampling interval.  Some logics
in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
shouldn't be zero.  Such case is avoided since DAMON avoids setting the
agregation interval as samller than the sampling interval.  However,
since nr_accesses is unsigned int while the intervals are unsigned long,
the maximum nr_accesses could be zero while casting.

Avoid the divide-by-zero by implementing a function that handles the
corner case (first patch), and replaces the vulnerable direct max
nr_accesses calculations (remaining patches).

Note that the patches for the replacements are divided for broken
commits, to make backporting on required tres easier.  Especially, the
last patch is for a patch that not yet merged into the mainline but in
mm tree.

SeongJae Park (5):
  mm/damon: implement a function for max nr_accesses safe calculation
  mm/damon/core: avoid divide-by-zero during monitoring results update
  mm/damon/ops-common: avoid divide-by-zero during region hotness
    calculation
  mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
  mm/damon/core: avoid divide-by-zero from pseudo-moving window length
    calculation

 include/linux/damon.h |  7 +++++++
 mm/damon/core.c       | 12 +++---------
 mm/damon/lru_sort.c   |  4 +---
 mm/damon/ops-common.c |  5 ++---
 4 files changed, 13 insertions(+), 15 deletions(-)


base-commit: e845524c56a529768a8793e96304db09134eafdf
-- 
2.34.1

