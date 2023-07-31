Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D558768A39
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGaDHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGaDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:07:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4DE6F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1ASI3dTvTFjELAY28G3zljY/LYDRlKcao8RliNhXMtg=; b=v+9b2XT0KEohT3hzCXWGxh6gqs
        4EMPer3bScbQGIZPFYggeNlguBtZF/3rxeaX4a+dz86DNMeDRgPqZuQluRIrpkIksOiO1I425T/Ji
        mXIhlzOu+MAdC+NsmoBZ/VHurpdF4RUk5y64TvTwFWbz5VTd2/zWcki8MGwY93qKZgYqSSpucfVNX
        jj7iFZtnh51icvh+9jwn4oV/k8c/nVoU1ISvq1lyaVzem76ob239fWrO4ib9rbs5noP9Ds7yenLDD
        xmopntIrurW5tJebH0gj9Eq0ERwvs95oXUlFrlzXvAeb9zGIcZ9a55dESoR8E06KOdt+Hh+Qdnd7x
        CspAEaeg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQJG2-00DeqE-2l;
        Mon, 31 Jul 2023 03:07:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PSI: select KERNFS as needed
Date:   Sun, 30 Jul 2023 20:07:40 -0700
Message-ID: <20230731030740.12411-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of KERNFS should select it to enforce its being built, so
do this to prevent a build error.

In file included from ../kernel/sched/build_utility.c:97:
../kernel/sched/psi.c: In function 'psi_trigger_poll':
../kernel/sched/psi.c:1479:17: error: implicit declaration of function 'kernfs_generic_poll' [-Werror=implicit-function-declaration]
 1479 |                 kernfs_generic_poll(t->of, wait);

Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI trigger polling")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -629,6 +629,7 @@ config TASK_IO_ACCOUNTING
 
 config PSI
 	bool "Pressure stall information tracking"
+	select KERNFS
 	help
 	  Collect metrics that indicate how overcommitted the CPU, memory,
 	  and IO capacity are in the system.
