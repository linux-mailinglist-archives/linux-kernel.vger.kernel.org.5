Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629088044E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376314AbjLEC35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346415AbjLEC3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:29:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5D119
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:29:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E64EC433C8;
        Tue,  5 Dec 2023 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743342;
        bh=WXN01WmS/1XYD2UM5/KTAA43TQV3rGLcmc9JJYlY+Zs=;
        h=From:To:Cc:Subject:Date:From;
        b=czDr4W1jJnUWy8kd3v9RRDgKXCXocS82Li0EGVZit+a+g8qXwzJK/05JuPU5p59uI
         mNL2MrdBevaxzcFe9SUk0wJieUBy2sg1eSkmpmOIA0Qc2ZRfkWt35h1cPGlJ69yRzW
         Sx9+/Cj13S5asDVBKZxroJPRmcx9LxxB2cUxHQvTPTgS3xFmZYnoGexnc7epPeac1S
         iThTWc/g1gGXleTQnCfBmYbFlU8i2+W1zghE1o3i30AaHfFXLgAEqusK8USGTudlis
         8/qlW4IkjWwilJQPhgrS73lm7aOE5DVGzPtJDrSMrCKjSD/X5JpHTufF3EgT47HfKN
         V0zZDLnwstUVw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon: export DAMON symbols and add sample loadable modules
Date:   Tue,  5 Dec 2023 02:28:55 +0000
Message-Id: <20231205022858.1540-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from RFC
(https://lore.kernel.org/damon/20231121053604.60798-1-sj@kernel.org/)
- Wordsmith commit message
- Use GPL v2 for Makefile
- Separate patch for each sample module

DAMON cannot be used from loadable modules since it is not exporting its
symbols.  This makes use of DAMON unnecessarily tedious.  For example,
basic usage of DAMON was presented at kernel summit 2021[1] by writing
simple loadable DAMON application modules in live.  Because the time was
limited (10 minutes) and the coding was to be done step by step, it had
to make a downstream commit that exports DAMON symbols.  There were
users asking why the source code is now not working.  It was mainly due
to the absence of the symbols export patch on their tree, but also due
to the updated DAMON programming interfaces.  There were also multiple
users requesting support of loadable modules for easier deployment.

There's no reason to avoid exporting DAMON symbols.  However, it would
be better to have concrete use cases of the symbols in the tree
together, for better maintenance of the interface and the use cases.
The kernels summit 2021's live-coded modules could be used for the
purpose.

Expose DAMON API modules for supporting the minimum modules and add the
kernel summit 2021's modules that updated for latest DAMON API under the
samples directory.  The sample modules will be keep updated.  For
exporting more symbols, requesters would be required to merge their
modules using the symbols in the tree together, or updsate the sample
modules to use the newly-exporting symbols in still simple but
reasonable ways.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

Signed-off-by: SeongJae Park <sj@kernel.org>

SeongJae Park (3):
  mm/damon/core: export symbols for supporting loadable modules
  samples: add working set size estimation DAMON sample module
  samples: add proactive reclamation DAMON sample module

 MAINTAINERS                       |   1 +
 mm/damon/core.c                   |  10 +++
 samples/Kconfig                   |   2 +
 samples/Makefile                  |   2 +
 samples/damon/Kconfig             |  30 +++++++++
 samples/damon/Makefile            |   3 +
 samples/damon/damon_sample_prcl.c | 102 ++++++++++++++++++++++++++++++
 samples/damon/damon_sample_wsse.c |  85 +++++++++++++++++++++++++
 8 files changed, 235 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/damon_sample_prcl.c
 create mode 100644 samples/damon/damon_sample_wsse.c


base-commit: 7fcebba4a540e4508b923f00a3e9c5e4710f147f
-- 
2.34.1

