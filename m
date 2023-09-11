Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FA79A2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjIKE7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjIKE7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:59:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E3138;
        Sun, 10 Sep 2023 21:59:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8414DC433C7;
        Mon, 11 Sep 2023 04:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694408352;
        bh=1sKqWrxuZZ/FU8NiZPNr1J2lRE5UCnUUAPwMbQ5ieAo=;
        h=From:To:Cc:Subject:Date:From;
        b=UMGDw9r37FVQoS5uJYfNjzGi1EpPlHfX1xuzY1CeE5zzVELAk5UtS1n1cPtFBZpqX
         QVcHNooVzNrbuMSAE2ygWmVIEr+qAFxx5XuqJsjriRp2zkQ04EXAZvf6fpmp9uesa0
         BC0qJXy9fBzlVM6Mec8GlZ0ybZdpPn04N3qbGInNi5CMMnRyQyPx2ZtYaxWRhArc4B
         7gOAmoj1uL5iyvITgICR7bFb6jCL3iCEynmOfErNMwFOovowCywu/7oyo0FFyObUwn
         ZyRIwu0nKmT3z9RA1A+cQjH1EiGmzY5KZdbmq3lpbGW8sy9SW9Bsyi9am+7cu8vcUu
         ZkgINsxEYw/kA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon: add a tracepoint for damos apply target regions
Date:   Mon, 11 Sep 2023 04:59:06 +0000
Message-Id: <20230911045908.97649-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Changes from RFC
(https://lore.kernel.org/damon/20230827004045.49516-1-sj@kernel.org/)
- Fix the 4 byte hole (Steven Rostedt)
- Add documentation

DAMON provides damon_aggregated tracepoint to let users record full monitoring
results.  Sometimes, users need to record monitoring results of specific
pattern.  DAMOS tried regions directory of DAMON sysfs interface allows it, but
the interface is mainly designed for snapshots and therefore would be
inefficient for such recording.  Implement yet another tracepoint for efficient
support of the usecase.

SeongJae Park (2):
  mm/damon/core: add a tracepoint for damos apply target regions
  Docs/admin-guide/mm/damon/usage: document damos_before_apply
    tracepoint

 Documentation/admin-guide/mm/damon/usage.rst | 37 ++++++++++++++++----
 include/trace/events/damon.h                 | 37 ++++++++++++++++++++
 mm/damon/core.c                              | 27 +++++++++++++-
 3 files changed, 93 insertions(+), 8 deletions(-)


base-commit: b4c5d592acb5a939aa4f6c08543daf6e2b435343
-- 
2.25.1

