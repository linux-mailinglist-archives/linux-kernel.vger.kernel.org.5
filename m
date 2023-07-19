Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07A5759FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGSUbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGSUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D366269E;
        Wed, 19 Jul 2023 13:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E2F6182E;
        Wed, 19 Jul 2023 20:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B1EC433C8;
        Wed, 19 Jul 2023 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798599;
        bh=uZcDOpOUdyDuQ6U9ajuc/8Rc/FrXXXJ9LEX+YPZLWe8=;
        h=From:To:Cc:Subject:Date:From;
        b=T8PTeatTMnXI1ik7q5KxDNO7PK2m6GQnk+dA2RSt4zOyqj2dKTirSlNJbCPQqJDfi
         vdIs3pUHChOukxR8bOrDLEwjBgfCcvbGD8ziLJeaWm7PJ8t/1zW1n6/qk7qgKDu/tg
         OswoP47l2ElA92Wp+H2C3ni1sbUu2K6mdcWHieCYuZ493GL7WhyTzkQFWt9D/28WPz
         ba6wjE99jQ6AXMg7DIeH9h5cParinKHfoWJKkr6Cn+SX6GX956vrkx/L90cPJHG1K0
         wFtflZT1ULYizXOLQz8WWO5cXYt9DO/wZF70Nh94U3O1YpJaRpD+dMWVD0mv9GYoWL
         s0Dseud/r85ig==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCHES 0/6] Fix some 'perf trace' leaks found with -fsanitize=address.
Date:   Wed, 19 Jul 2023 17:29:45 -0300
Message-ID: <20230719202951.534582-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please review/ack, I put it as well on the tmp.perf-tools-next
in the perf-tools-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (6):
  perf evsel: Free evsel->filter on the destructor
  perf thread: Allow tools to register a thread->priv destructor
  perf trace: Register a thread priv destructor
  perf trace: Really free the evsel->priv area
  perf trace: Free thread_trace->files table
  MAINTAINERS: Add git information for perf-tools and perf-tools-next
    trees/branches

 MAINTAINERS                |  2 ++
 tools/perf/builtin-trace.c | 38 +++++++++++++++++++++++++++++++-------
 tools/perf/util/evsel.c    |  1 +
 tools/perf/util/thread.c   | 11 +++++++++++
 tools/perf/util/thread.h   |  2 ++
 5 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.41.0

