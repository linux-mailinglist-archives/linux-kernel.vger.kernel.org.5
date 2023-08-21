Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89378343F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHUUzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHUUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:55:03 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C79A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:55:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56385c43eaeso4010477a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692651301; x=1693256101;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kxBzNRuKT3FK2xpnd0zI9fHxTniHJWyags4nIBlfqGo=;
        b=VapQsrLTsIuBdCvmJlnkDnAHLl9uwXYyl4pfelPDhgZfBCaf5UuJw/4Df69B1daF5W
         gCChcu7YIx6NYtBnd3VU2xjT4LtJH6C/uxHDF7ZH/XP0VUHjmQ+px5zJGjW8u6Pyo3Oj
         yj/4S4uWg7n3+4ebepXr/CillPdeCpQ5UBCWFWdu+mHPXoiOzfNDuksE7H66dECQgKT6
         m1AWJKvfJ8wt7vsYfZxBy4KRUdv08ei+xhliPGh0s3uythMQplNFuk0BbdjYyAumUH0L
         lIyQdhxBjiYhgCOEDtvGnrQH3rbPBra4M16LsQzP1POusk9aDfzM4/jaIedXoVa+MnbM
         DV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692651301; x=1693256101;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxBzNRuKT3FK2xpnd0zI9fHxTniHJWyags4nIBlfqGo=;
        b=XASUw+BwY5XiZu3J6Oipnmi7esZqCh/Uj/V4tS4vR+GGYIUmZiP/d4vZ0yZZvAu8b4
         QShhXQCj0S1FD7nXCyobSkrH2TixuP+1h+UcnGJC8LGh5bTdenCcnueykinltkEGzQvc
         Gzt4aZpHLFHPbhhucjs92tSwykq3UcfFcW1dA/ZnE68MH6gkxR724UsjlM0MkaMc7JlH
         v31nsGe8MS/J0o2J9ZQv/1qZoxa+ozORR8m/fu5gqBvBadwlSaRX3Tq4BX5CfwbHAooo
         4By0hME9+T1G/6qU/AOK6HtTVdeAUOVLOawHOn9wQZyQb6OoGhTKOIvcMbgDkz6JuYOt
         mepQ==
X-Gm-Message-State: AOJu0Yy0+dZKeWcVRi1ECwuFBLK0Q07Hwehel8vxYrFPMlKbgyQBStse
        yU6FtX5+nBuX7t92ZFk3gvSEa1Zthl84dMmJ
X-Google-Smtp-Source: AGHT+IGm4+gLgX0J8HWzAgZ1L2jlPh7tsMAE98z+t4zMYWWyBe2ouAbZ7MlyET/FFgHamToA8Hug4lBE2hC2cTf8
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:4ac1:b0:269:84ec:7140 with SMTP
 id mh1-20020a17090b4ac100b0026984ec7140mr1536395pjb.2.1692651301416; Mon, 21
 Aug 2023 13:55:01 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:54:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821205458.1764662-1-yosryahmed@google.com>
Subject: [PATCH 0/3] memcg: non-unified flushing for userspace stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

[1]https://lore.kernel.org/lkml/20230809045810.1659356-1-yosryahmed@google.com/
[2]https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/

Yosry Ahmed (3):
  mm: memcg: properly name and document unified stats flushing
  mm: memcg: add a helper for non-unified stats flushing
  mm: memcg: use non-unified stats flushing for userspace reads

 include/linux/memcontrol.h |  8 ++---
 mm/memcontrol.c            | 74 +++++++++++++++++++++++++++-----------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  4 +--
 4 files changed, 60 insertions(+), 28 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

