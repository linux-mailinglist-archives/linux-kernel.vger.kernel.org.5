Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B17682A1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjG2WjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG2WjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 18:39:14 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Jul 2023 15:39:12 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59FC62D67
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Rjt1v
        462Ui9NyzNt3fQS7R0jI64RTz+z/nf5RjfQBSY=; b=Zt1IP8YAeKTkW1aC7SzaC
        xGh5SOPe5PSm7Ti5ylARHy1vFVRXICpvtoXPI18Iug9pVh5/in7Zv8DKnYcGO2n1
        JUNaB45up8CcavM/3wSHYDk9knXcN+Yep0yBadTQkN0lfmzjUyIj2pTbsjGe1ZWH
        l/82bNY5EvMQ/7q4vqip1s=
Received: from localhost.localdomain (unknown [222.244.204.172])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wDXDZYLkcVkPpaGBA--.36756S2;
        Sun, 30 Jul 2023 06:22:05 +0800 (CST)
From:   Bing Huang <huangbing775@126.com>
To:     dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: [PATCH] sched/topology: Covered all cpus of same node in asymmetric node setups
Date:   Sun, 30 Jul 2023 06:22:03 +0800
Message-Id: <20230729222203.5601-1-huangbing775@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXDZYLkcVkPpaGBA--.36756S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4UAF17Cr1ktrykAF1fZwb_yoWfXFb_Jw
        4rur1kWr1DZw18tr4fKFs3XryFqa1jgFn29r97ta47XryUtrn5Ar90yF95Zrs5GwnrJF9r
        Gw4Sq3Z0y3WkGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbJ73JUUUUU==
X-Originating-IP: [222.244.204.172]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbiJxG7r2G5Vb9oOQAAsB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in asymmetric node setups, if one cpu'sd spans is empty in some depth,
others in same node do

Signed-off-by: Bing Huang <huangbing@kylinos.cn>
---
 kernel/sched/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 7cfcfe5d27b9..8c5372ad7694 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1045,8 +1045,10 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		 * Domains should always include the CPU they're built on, so
 		 * check that.
 		 */
-		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
+		if (!cpumask_test_cpu(i, sched_domain_span(sibling))) {
+			cpumask_or(covered, covered, cpumask_of_node(cpu_to_node(i)));
 			continue;
+		}
 
 		/*
 		 * Usually we build sched_group by sibling's child sched_domain
-- 
2.25.1

