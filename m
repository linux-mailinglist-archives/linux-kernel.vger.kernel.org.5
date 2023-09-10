Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA8799C69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbjIJDk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIJDk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E1818F;
        Sat,  9 Sep 2023 20:40:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF52C433C8;
        Sun, 10 Sep 2023 03:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317251;
        bh=YnN+3EEg+Kt4hqil0PHaLwXJvCyERiTOIWXnLJWZVHA=;
        h=From:To:Cc:Subject:Date:From;
        b=k0R1X6O8RtpH+OZ2kVJhQU38l8/QrE6lor2MzdhBIg4zhYkXb2jXTU6ZOJCRSCsoP
         na2pWCtgzkU9zCgjsPasZQ3ZyWGAZV7WCasVKZpgtQJvLwYMj/aklrd4jWTJr0Myrx
         hCKydtcy6X4yl58GEqmTZji1keb+mVB1oNYL1fe3HJsDTZGfUY7HQf3sQeL8XanFO3
         vZj6RWuo8LM/VS0rxTKJmLL/RZLNA/Hwl3p9GSpyptquRfAOhhZfkmybwoKLVZjG7K
         cuoHbxKUqEPhvgEPzVRHB65I8//yyFl7jzlz49BFiEhl78+BlOlEE2YIBknxwHQjFU
         uyW3FkLs//50w==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/8] mm/damon: implement DAMOS apply intervals
Date:   Sun, 10 Sep 2023 03:40:40 +0000
Message-Id: <20230910034048.59191-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON-based operation schemes are applied for every aggregation
interval.  That is mainly because schemes are using nr_accesses, which
be complete to be used for every aggregation interval.  However, DAMON
provides nr_accesses_bp, which is updated for each sampling interval in
a way that reasonable to be used.  Therefore, there is no reason to not
use nr_accesses_bp instead and apply schemes for their own time interval
instead of the aggregation interval.

Actually, the alignment with the aggregation interval is also making
some use case of DAMOS tricky.  Quota setting under long aggregation
interval is one such example.  Suppose the aggregation interval is ten
seconds, and there is a scheme having CPU quota 100ms per 1s.  The
scheme will actually uses 100ms per ten seconds, since it cannobe be
applied before next aggregation interval.  The feature is working as
intended, but the results might not that intuitive for some users.  This
could be fixed by updating the quota to 1s per 10s.  But, in the case,
the CPU usage of DAMOS could look like spikes, and actually make a bad
effect to other CPU-sensitive workloads.

This patchset makes DAMOS schemes to use nr_accesses_bp instead of
nr_accesses, and have their own timing intervals.  Note that the
interval is 0 by default, and it is interpreted to use the aggregation
interval instead.  This is for avoid making behavioral changes to the
old users.


Patches Seuqeunce
-----------------

The first patch (patch 1/8) makes DAMOS uses nr_accesses_bp instead of
nr_accesses, and following two patches (patches 2/8 and 3/8) updates DAMON
sysfs interface for DAMOS tried regions and the DAMOS before_apply
tracespoint to expose nr_accesses_bp instead of nr_accesses,
respectively.

The following two patches (patches 4/8 and 5/8) implements the
scheme-specific apply interval for DAMON kernel API users and update the
design document for the new feature.  Finally, the following three
patches (patches 6/8, 7/8, and 8/8) add support of the feature in DAMON
sysfs interface and documents it on usage and ABI documents,
repsectively.

SeongJae Park (8):
  mm/damon/core: make DAMOS uses nr_accesses_bp instead of nr_accesses
  mm/damon/sysfs-schemes: expose nr_accesses_bp via
    tried_regions/<N>/nr_accesses
  mm/damon/core: expose nr_accesses_bp from damos_before_apply
    tracepoint
  mm/damon/core: implement scheme-specific apply interval
  Docs/mm/damon/design: document DAMOS apply intervals
  mm/damon/sysfs-schemes: support DAMOS apply interval
  Docs/admin-guide/mm/damon/usage: update for DAMOS apply intervals
  Docs/ABI/damon: update for DAMOS apply intervals

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  9 ++-
 Documentation/mm/damon/design.rst             |  3 +-
 include/linux/damon.h                         | 17 +++-
 include/trace/events/damon.h                  |  2 +-
 mm/damon/core.c                               | 80 +++++++++++++++++--
 mm/damon/dbgfs.c                              |  3 +-
 mm/damon/lru_sort.c                           |  2 +
 mm/damon/reclaim.c                            |  2 +
 mm/damon/sysfs-schemes.c                      | 40 ++++++++--
 10 files changed, 144 insertions(+), 21 deletions(-)


base-commit: 2a43f312aed581fa5044c4a0c0d20cfd4e632aa6
-- 
2.25.1

