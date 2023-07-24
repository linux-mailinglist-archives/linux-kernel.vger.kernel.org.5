Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17B760029
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGXT7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6451611C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D3E61355
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984CBC433C7;
        Mon, 24 Jul 2023 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690228740;
        bh=I7HE1Vuyn6NFH+9L/Nxorax52ASCtQoSy5QHBoB33wc=;
        h=From:To:Cc:Subject:Date:From;
        b=bkQms3eDYZ43wC6kjvZ+zpuL188LFkwigmDowb8l4RnjWLttRubKDE9cCkhIoY39t
         o6m3gPTfq3p63Kn/OFRcJbwNDvdfYDrjF4wx2SBSkwj1Wknx0chLpUcoioeroBwk88
         0uw0P5eORGOPGfR5zoY6eluIzMQXAPfvzqE3x2r2k/jDNTsoC9YuB1MlIXyfWL67vX
         /97cERJeZWXmczOFQqCqVb3p7MGjtGIfGp+uMqPRUXNBq+vzt8P5Qo58eAZ9NDRU/6
         NvJn9phR7bip05/9BB1XbPZNHCECRpm0DGgfKugQ3Y0ZcihNDcFZbb7dp3Vo9v8VEo
         BjV16NWCnJjFQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: make update_entity_lag static
Date:   Mon, 24 Jul 2023 21:58:29 +0200
Message-Id: <20230724195854.2491142-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced function is only used in this one file, so we
get a warning when it is in the global namespace:

kernel/sched/fair.c:702:6: warning: no previous prototype for function 'update_entity_lag' [-Wmissing-prototypes]
void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
kernel/sched/fair.c:702:1: note: declare 'static' if the function is not intended to be used outside of this translation unit

Fixes: 86bfbb7ce4f67 ("sched/fair: Add lag based placement")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b42e0a2cadbf4..7566e67e314b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -699,7 +699,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 lag, limit;
 
-- 
2.39.2

