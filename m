Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC0776AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjHIVKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHIVK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C8BE76;
        Wed,  9 Aug 2023 14:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676366456E;
        Wed,  9 Aug 2023 21:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E93C433C7;
        Wed,  9 Aug 2023 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691615427;
        bh=1Bz4ua4tQI2OB7DE+aHiPdC2coqzRjymHyknz6o31/M=;
        h=From:To:Cc:Subject:Date:From;
        b=evaSqc4qbKrEEfvl4mpOPS1eNCF2T1pUZUoNfWeZKX2Wbn+iC4YAy1WEQKartH7wP
         HuuJosOSEvZqslFGnJuUM8W7u0yfGwq9sO85fHVbCAvnT3V7YwKz1Hnm9GE2A5ib3z
         oZtduAjlsUfsFGmEdfUYEAW8Toheednlce6lGw/2f3KJCA3GO4/6Pt/y44hFRBSYYP
         aqkhHy/TXnT7YOPG9BYMF0Zds3Uqth+6K6wt/w5zbU4NYi+m72N9HrgeYyE/AoF1CW
         q5nTigF10jTCkVpL7iUs3v8B41wRg3IA20bQ70uwfXFxr+9hsQw71iwcgIpbexnJYO
         e7Vkh2TIQ/kUA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.5: 3rd batch
Date:   Wed,  9 Aug 2023 18:10:19 -0300
Message-ID: <20230809211019.121189-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
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

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.5-3-2023-08-09

for you to fetch changes up to 487ae3b42d1040b4cd5ff9754e7516b409204029:

  perf stat: Don't display zero tool counts (2023-08-08 14:33:57 -0300)

----------------------------------------------------------------
perf tools fixes for v6.5: 3rd batch

- Revert a patch that unconditionally resolved addresses to inlines in
  callchains, something that was done before when DWARF mode was asked
  for, but could as well be done when just frame pointers (the default)
  was selected. This enriches the callchains with inlines but the way to
  resolve it is gross right now, relying on addr2line, and even if we come
  up with an efficient way of processing all the associated DWARF info for
  a big file as vmlinux is, this has to be something people opt-in, as it
  will still result in overheads, so revert it until we get this done in a
  saner way.

- Update the x86 msr-index.h header with the kernel original, no change
  in tooling output, just addresses a tools/perf build warning.

- Resolve a regression where special "tool events", such as
  "duration_time" were being presented for all CPUs, when it only makes
  sense to show it for the workload, that is, just once.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      Revert "perf report: Append inlines to non-DWARF callchains"
      tools arch x86: Sync the msr-index.h copy with the kernel sources

Ian Rogers (1):
      perf stat: Don't display zero tool counts

 tools/arch/x86/include/asm/msr-index.h | 1 +
 tools/perf/util/machine.c              | 5 -----
 tools/perf/util/stat-display.c         | 5 +++++
 3 files changed, 6 insertions(+), 5 deletions(-)
