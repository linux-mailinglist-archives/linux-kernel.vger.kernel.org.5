Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0A7D02BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjJSTtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345366AbjJSTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:49:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76816CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:49:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79ACC433C7;
        Thu, 19 Oct 2023 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744970;
        bh=hrrza+crBd0RjMFZAgh+3yDyKNEWLMDaW4dbIT2n9jQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CuUPzS+NiENfFW4IGkmjF1bIWMGzjCQS3iWVUOePE5rhfXDWxQte786cYVifxeVzx
         GrusnsW84WOyMJCPzhi3dOzPjSZbDevDjkyXI7MCiqo08/rKT0phGUitlODzcDpPvA
         DvtSZBqIgt3a6OilHFjCisaHGwHT4q7him0DbNN7eSOLHYaW+xrQcm5RQ/gr255Wr4
         +idbbXK+i9HClhI5L3MD8qLFUwodlAdLn3hQC7Xp6A4mslYvrIeQv7J/RAgd1cYbh/
         +KhbQCiGeuMhqyTDT0vc5ilNhJwDrMG5lYAE3kylIerEvyFdvggU2shT/VU/IZ5SKA
         a7DlWTT1r0r6Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date:   Thu, 19 Oct 2023 19:49:19 +0000
Message-Id: <20231019194924.100347-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

