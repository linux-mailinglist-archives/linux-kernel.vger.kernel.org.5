Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925E07BF038
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379282AbjJJB0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379221AbjJJB0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:26:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773EA9E;
        Mon,  9 Oct 2023 18:26:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE93C433C7;
        Tue, 10 Oct 2023 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696901166;
        bh=HVAHuF8iokPA8ik12/+0QhZWW8DSLeiwct1MhJbYb0A=;
        h=From:To:Cc:Subject:Date:From;
        b=acJQ2yhRavHVHsPbpUF41TmXkc1AgwkBbFJXA6wIle+Jdj60Nkx6xAHUQ0fGosjV9
         kBcFM48iWNIxIoyp44s/fm7BnXrUhifKPLXdEhsxi8mOFVZTxGf+ciIcdTNrCgEyPj
         /5wdJVFbEf+uM90AXO/94wj6ZoQSNeSts9PMJOD5uetKJL28laITxL2u8Wtf1m+O29
         88NbK+BBWFMH0SYEuQ7R5UY9AE2P9MtsyWefzOa6E7FYJ1MhcAkfJZV5SW8Q2aXsUy
         PMtKS7Zq2udmeSthTvqTVW6yuI/v+xK7i7KgFyvZkhTBk/C5CLKYQ8uT7yhbv+VE1h
         LmRNR9jBjnGUA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] mm/damon/sysfs-schemes: Do DAMOS tried regions update for one apply interval
Date:   Tue, 10 Oct 2023 01:25:57 +0000
Message-Id: <20231010012600.83140-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMOS tried regions update feature of DAMON sysfs interface is doing the
update for one aggregation interval after the request is made.  Since
the per-scheme apply interval is supported, that behavior makes no much
sense.  That is, the tried regions directory will have regions from
multiple DAMON monitoring results snapshots, or no region for apply
intervals that much shorter than, or longer than the aggregation
interval, respectively.  Update the behavior to update the regions for
each scheme for only its apply interval, and update the document.

Since DAMOS apply interval is the aggregation by default, this change
makes no visible behavioral difference to old users who don't explicitly
set the apply intervals.

Patches Sequence
----------------

The first two patches makes schemes of apply intervals that much shorter
or longer than the aggregation interval to keep the maximum and minimum
times for continuing the update.  After the two patches, the update
aligns with the each scheme's apply interval.

Finally, the third patch updates the document to reflect the behavior.

SeongJae Park (3):
  mm/damon/sysfs-schemes: do not update tried regions more than one
    DAMON snapshot
  mm/damon/sysfs: avoid empty scheme tried regions for large apply
    interval
  Docs/admin-guide/mm/damon/usage: update for tried regions update time
    interval

 Documentation/admin-guide/mm/damon/usage.rst |  6 +-
 mm/damon/sysfs-common.h                      |  2 +
 mm/damon/sysfs-schemes.c                     | 93 ++++++++++++++++++++
 mm/damon/sysfs.c                             | 34 ++++++-
 4 files changed, 128 insertions(+), 7 deletions(-)


base-commit: 369359a808616f7f87172568da7933f65834caab
-- 
2.34.1

