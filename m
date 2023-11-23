Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1E7F6065
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbjKWNgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbjKWNg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:36:26 -0500
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [IPv6:2001:41d0:1004:224b::af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D77DD40
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:36:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700746263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HH76KM7ghHpttjrPF4dCFO56nBTHd4OZxFz/BIMAGKc=;
        b=GXVeyiK0rc7R4kF855jfXTv6slAM+iTN7yba/bhzrB51BelY7dLn+GMzVGY28gMMRACwqW
        wx6ZQf9hQFHsYu+ne6n85pObPvr8dJEkSruX6BUAdh8HNjSUAZECLbVBi3B9wZ2kh+GXGL
        8UNAScpbb/anNZvItz/59uFMT0Fsij4=
From:   Gang Li <gang.li@linux.dev>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation on boot
Date:   Thu, 23 Nov 2023 21:30:32 +0800
Message-Id: <20231123133036.68540-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gang Li <ligang.bdlg@bytedance.com>

Inspired by these patches [1][2], this series aims to speed up the
initialization of hugetlb during the boot process through
parallelization.

It is particularly effective in large systems. On a machine equipped
with 1TB of memory and two NUMA nodes, the time for hugetlb
initialization was reduced from 2 seconds to 1 second.

In the future, as memory continues to grow, more and more time can
be saved.

This series currently focuses on optimizing 2MB hugetlb. Since
gigantic pages are few in number, their optimization effects
are not as pronounced. We may explore optimizations for
gigantic pages in the future.

Thanks,
Gang Li

Gang Li (4):
  hugetlb: code clean for hugetlb_hstate_alloc_pages
  hugetlb: split hugetlb_hstate_alloc_pages
  hugetlb: add timing to hugetlb allocations on boot
  hugetlb: parallelize hugetlb page allocation

 mm/hugetlb.c | 191 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 134 insertions(+), 57 deletions(-)

-- 
2.20.1

