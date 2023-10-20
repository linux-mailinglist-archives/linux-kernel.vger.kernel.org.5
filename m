Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387DF7D152C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbjJTRvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjJTRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:51:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD741A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:51:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71747143D;
        Fri, 20 Oct 2023 10:52:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8360E3F762;
        Fri, 20 Oct 2023 10:51:31 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ilkka@os.amperecomputing.com, renyu.zj@linux.alibaba.com
Subject: [PATCH 0/3] perf/arm-cmn: Multi-DTC improvements
Date:   Fri, 20 Oct 2023 18:51:24 +0100
Message-Id: <cover.1697824215.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On larger CMN configurations with multiple Debug & Trace Controllers,
we've so far ignored the notion of DTC domains, mostly since they were
not software-discoverable in the original CMN-600 design. However this
means that if the user wants to monitor lots of individual nodes across
the whole mesh, we end up multiplexing events which could otherwise
happily run in parallel if we allocated DTC counters per-domain. This
mini-series finally bites the bullet to do that.

As usual I've only been able to personally test that it doesn't regress
any behaviour on a single-DTC CMN-600, so it would be nice if anyone
with a multi-domain CMN-650/CMN-700 setup could confirm that patches 1+2
alone do not visibly change any behaviour, and then patch #3 on top
works as expected.

Thanks,
Robin.


Robin Murphy (3):
  perf/arm-cmn: Fix DTC domain detection
  perf/arm-cmn: Rework DTC counters (again)
  perf/arm-cmn: Enable per-DTC counter allocation

 drivers/perf/arm-cmn.c | 154 +++++++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 69 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

