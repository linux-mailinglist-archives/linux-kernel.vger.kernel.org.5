Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCE80DADC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbjLKT13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjLKT12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:27:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A46199F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:27:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B82F1007;
        Mon, 11 Dec 2023 11:28:21 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D7A53F762;
        Mon, 11 Dec 2023 11:27:33 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ilkka@os.amperecomputing.com, renyu.zj@linux.alibaba.com
Subject: [PATCH] perf/arm-cmn: Fail DTC counter allocation correctly
Date:   Mon, 11 Dec 2023 19:27:28 +0000
Message-Id: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling arm_cmn_event_clear() before all DTC indices are allocated is
wrong, and can lead to arm_cmn_event_add() erroneously clearing live
counters from full DTCs where allocation fails. Since the DTC counters
are only updated by arm_cmn_init_counter() after all DTC and DTM
allocations succeed, nothing actually needs cleaning up in this case
anyway, and it should just return directly as it did before.

Fixes: 7633ec2c262f ("perf/arm-cmn: Rework DTC counters (again)")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 86d970e74129..c584165b13ba 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1816,7 +1816,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			idx = 0;
 			while (cmn->dtc[j].counters[idx])
 				if (++idx == CMN_DT_NUM_COUNTERS)
-					goto free_dtms;
+					return -ENOSPC;
 		}
 		hw->dtc_idx[j] = idx;
 	}
-- 
2.39.2.101.g768bb238c484.dirty

