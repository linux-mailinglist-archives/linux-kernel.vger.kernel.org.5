Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A67F2557
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjKUFgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjKUFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:36:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1807D45
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:36:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C87C433C7;
        Tue, 21 Nov 2023 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700544975;
        bh=2hTiZxsT86X0oN/PSearw+dfIAhh29V867VL4eOG5r8=;
        h=From:To:Cc:Subject:Date:From;
        b=D6nVWtz74Snj6LQsOZed22kJrcYfOOgYEzM/3i+YkHfCZmhauAJx7p3sCWPmkqUZT
         +S9RB1X3HAlZGSQDqQkt+IoQZRP42JQxD+10JjolCfxKyMMlLFN+ki6Bu9mHIQpXWi
         McBkhAlEdsTrUaRbTH1lyXmWGsnIz55tK7TJV/xaTgoWXb4+SgZG8vweCqDFIu+Nvz
         tZ5dfUYZB+t+Nz/tP+1c5ttoqjr3pS0g16ro3IabH7HAEcVvhddyzfiuAuNYakoWcB
         5CTdxJsyMsfdPoT/fbyZ+zd76mKOiq9+q76NjH/GbN+xZKAJswD5ufN9CVkvsPks8B
         OokXxU/mf8+WQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] mm/damon: export DAMON symbols and add sample loadable modules
Date:   Tue, 21 Nov 2023 05:36:01 +0000
Message-Id: <20231121053604.60798-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON cannot be used from loadable modules since it is not exporting its
symbols.  This makes use of DAMON unnecessarily tedious.  For example,
we presented basic usge of DAMON at kernel summit 2021[1] by writing
simple loadable DAMON application modules in live.  Because the time was
limited (10 minutes) and the coding was to be done step by step, we had
to make a downstream commit that exports DAMON symbols.  There were
users asking why the source code is now not working.  It was mainly due
to the absence of the symbols export patch on their tree, but also due
to the changed DAMON interfaces.  There were also multiple users
requesting support of loadable modules for easier deployment.

There's no reason to avoid exporting DAMON symbols.  However, it would
be better to have concrete use cases of the symbols in the tree
together, for better maintenance of the interface and the use cases.
The kernels summit 2021's live-coded modules could be used for the
purpose.

Expose DAMON API modules for supporting the minimum modules and and add
the kernel summit 2021's modules that updated for latest DAMON API under
the samples directory.  We will keep update of the sample modules.  For
exporting more symbols, requesters would be required to merge their
modules using it in the tree together, or updsate the sample modules to
use the newly-exporting symbols in reasonable and still simple ways.

[1] https://linuxplumbersconf.org/event/11/contributions/984/

SeongJae Park (2):
  mm/damon/core: export symbols for supporting loadable modules
  samples: add DAMON sample kernel modules

 MAINTAINERS                       |  1 +
 mm/damon/core.c                   | 10 ++++
 samples/Kconfig                   |  2 +
 samples/Makefile                  |  2 +
 samples/damon/Kconfig             | 30 ++++++++++
 samples/damon/Makefile            |  3 +
 samples/damon/damon_sample_prcl.c | 98 +++++++++++++++++++++++++++++++
 samples/damon/damon_sample_wsse.c | 80 +++++++++++++++++++++++++
 8 files changed, 226 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/damon_sample_prcl.c
 create mode 100644 samples/damon/damon_sample_wsse.c


base-commit: 79cc930e5e3dc73c972d9e422b5e2ab3fe56dce5
-- 
2.34.1

