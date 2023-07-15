Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13F7546D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGOEYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjGOEYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:24:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5033A96
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DYlo/gupkfT8+nCJZO3u+QA1Fw3ZJMI4hDJgV++oyYA=; b=uPbNQDRuLMTYTNh4IPN0k4nXyf
        cztJQO56loYyT6Fmevl7HukuGMK7EDfp1TBNB1n00xT4UqNMmsf1J2qrIWIY27H9Kn1tc+l/oGwXG
        PpJiNknsWfWetPjqRYVdfBiSTH7aAXV6k5lPpUeXoSR4GbMGu6Uu/V7GcykkoMhWm39ygJygemRtp
        i07UZ32O4VQ6Pn2L+CtHKF7iGN+oXfkwXd5e/do2oeGCRnYiVBXbT/+GkBb8bq8s1nLn9FEqJ2R1U
        P8Vy5AooOOLqLyYEMiZ2XWIiE9AvU9tsjtZy7F22UJ8Zk3Be9dWagJX/YFKONxGBrwd5T/ZuwcCK4
        W3RBPAcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWos-001p3m-5e; Sat, 15 Jul 2023 04:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vitaly.wool@konsulko.com, cerasuolodomenico@gmail.com,
        nphamcs@gmail.com, hch@infradead.org, yosryahmed@google.com,
        akpm@linux-foundation.org
Subject: [PATCH 0/5] Followup folio conversions for zswap
Date:   Sat, 15 Jul 2023 05:23:38 +0100
Message-Id: <20230715042343.434588-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714194610.828210-1-hannes@cmpxchg.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With frontswap killed, it's worth converting the zswap_load() and
zswap_store() functions to take a folio instead of a page pointer.
They aren't converted to support large folios, but there are a lot of
unnecessary calls to compound_head() that are removed by these patches.

Matthew Wilcox (Oracle) (5):
  fix-frontswap
  zswap: Make zswap_store() take a folio
  memcg: Convert get_obj_cgroup_from_page to get_obj_cgroup_from_folio
  swap: Remove some calls to compound_head() in swap_readpage()
  zswap: Make zswap_load() take a folio

 include/linux/memcontrol.h |  4 ++--
 include/linux/zswap.h      |  8 ++++----
 mm/memcontrol.c            |  8 ++++----
 mm/page_io.c               | 17 +++++++++--------
 mm/zswap.c                 | 27 +++++++++++++++------------
 5 files changed, 34 insertions(+), 30 deletions(-)

-- 
2.39.2

