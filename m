Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6C78F17F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjHaQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjHaQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:56:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D43B8F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:56:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58f9db8bc1dso13232657b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500973; x=1694105773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gOQaXSmI19T3CmRXHqALPzLoBcwM1iddQy4gNQ1FwHI=;
        b=3Mk6IsV5i8zXUYIam0xe89FspudrAHmbi76z1/AanIj7zaz/8mf19LVT95ZWrINPCt
         tVTgT6Cp102pT6jPl9hG0OLr8kkiLjBOLEAxB2fhaXVxfPKMBx+3nOidqUbxG0pxf0O8
         h+kLxR0bvZQ3OHizNZbxM8FAW2896SZIvhizip2lcHbTSugx0UlfamoiPOCr69PDrRUB
         vyMkIx1fYNvFXBIafiDNwUBDlOaOQUskoTd2fjpsHRQ46GCk6FVbLRjRvLYXb2/Fc2wn
         3YuX7VPQlsNjYXdqNTOzTL053ujzxwzWa4rKLV/+h6oXpSypwRrbbBZBfFQkZjhW7a/2
         r73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500973; x=1694105773;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOQaXSmI19T3CmRXHqALPzLoBcwM1iddQy4gNQ1FwHI=;
        b=a8+K+3szNdDcwNY4VwG0yMsfDfR8/NBAXizDBylKatj9IGlos/p6CPw84ytuEOwfvC
         zEQqVkcJLU9XXqQy6hIGcegA4rpUMcUJYRKUfCQkvTD1Gui0JGHGa4r3sU4CBvWHrDwJ
         PVC3p4hwPMDDaN0vz7wknjX/+P/5MaRPaoOA1XSz2+nh1Kl+VeW1eqAMAvn6rEEYio1V
         n3htOoeYbA28mxJNDI47cIsoktC1WpahsxjOv2hwNAzYDAqFryqly2RvcVFUIUGpQ11I
         kbD++R3RgTstXnqtZ8NK1r2GuRw/SGFXdPZax3cGfVmsobyWK4A5jbxZJm8h5Yqyus2c
         qS+A==
X-Gm-Message-State: AOJu0YxLryWTn0mvYS0jRGyMdEbfzH2TLB3Upz/52An3wefp6/mR/bV4
        NOa/DsgZcT+bF66mjkHVPDf/v417/NWZuoZX
X-Google-Smtp-Source: AGHT+IFfZn2v6d2Ro49b+XHsKpTrNfM17Oft9zmXMB+ZfxC8MxeQy1a4OGUZlaj0AzNO9izDZCKRRyy9ddFAznDW
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:ae45:0:b0:57a:e0b:f66 with SMTP id
 g5-20020a81ae45000000b0057a0e0b0f66mr157969ywk.7.1693500973593; Thu, 31 Aug
 2023 09:56:13 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:56:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831165611.2610118-1-yosryahmed@google.com>
Subject: [PATCH v4 0/4] memcg: non-unified flushing for userspace stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most memcg flushing contexts using "unified" flushing, where only one
flusher is allowed at a time (others skip), and all flushers need to
flush the entire tree. This works well with high concurrency, which
mostly comes from in-kernel flushers (e.g. reclaim, refault, ..).

For userspace reads, unified flushing leads to non-deterministic stats
staleness and reading cost. This series clarifies and documents the
differences between unified and non-unified flushing (patches 1 & 2),
then opts userspace reads out of unified flushing (patch 3).

This patch series is a follow up on the discussion in [1]. That was a
patch that proposed that userspace reads wait for ongoing unified
flushers to complete before returning. There were concerns about the
latency that this introduces to userspace reads, especially with ongoing
reports of expensive stat reads even with unified flushing. Hence, this
series follows a different approach, by opting userspace reads out of
unified flushing completely. The cost of userspace reads are now
determinstic, and depend on the size of the subtree being read. This
should fix both the *sometimes* expensive reads (due to flushing the
entire tree) and occasional staless (due to skipping flushing).

I attempted to remove unified flushing completely, but noticed that
in-kernel flushers with high concurrency (e.g. hundreds of concurrent
reclaimers). This sort of concurrency is not expected from userspace
reads. More details about testing and some numbers in the last patch's
changelog.

v4 -> v5:
- Fixed build error in the last patch with W=1 because of a missed
  'static'.

v4: https://lore.kernel.org/lkml/20230830175335.1536008-1-yosryahmed@google.com/

Yosry Ahmed (4):
  mm: memcg: properly name and document unified stats flushing
  mm: memcg: add a helper for non-unified stats flushing
  mm: memcg: let non-unified root stats flushes help unified flushes
  mm: memcg: use non-unified stats flushing for userspace reads

 include/linux/memcontrol.h |   8 +--
 mm/memcontrol.c            | 106 +++++++++++++++++++++++++++----------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |   4 +-
 4 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

