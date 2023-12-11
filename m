Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043280CB60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjLKNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343695AbjLKNvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:51:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F57E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:51:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C94C433C7;
        Mon, 11 Dec 2023 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302712;
        bh=I+x4HFJYzeuO9JjMfAaQwpqHyc8BqsF1rrF2PgjyQB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiDVKv6GYETYFrTuxZwfibwaZubXxVjxUCO9KWFUyLeYGn+Z+VQgfI8FRphgJCjyX
         PY3STbdCxKIdVmyki/raEcAJupxViRhTh9gpIZAHHclZ2qX22JJsEqAgaLj0p2vLFy
         /491CTENZ5RTdJI+s9e0QDTysoVU7b089Yz3mi6+e26yDBe5dxEwkP/4B6FvVY6icD
         BH0u7H8JsyyJ2uj8qeV/4eTqKa4V36MczeU6jSO8Q6yhHKabAVT9wG6+MUVrhNZ4OZ
         eXQ+9PQsH2rVC2W+JZxZ01z4r0aGBMTSZ4BcPgQofnxu/3f39gM0e5IbE+BRYTuMaq
         JypN4TbBmREJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>, jonathan.cameron@huawei.com,
        alexander.shishkin@linux.intel.com
Subject: [PATCH AUTOSEL 6.6 02/47] hwtracing: hisi_ptt: Don't try to attach a task
Date:   Mon, 11 Dec 2023 08:50:03 -0500
Message-ID: <20231211135147.380223-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit aff787f64ad7cbb54614b51b82c682fe06411ef3 ]

PTT is an uncore PMU and shouldn't be attached to any task. Block
the usage in pmu::event_init().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20231010084731.30450-5-yangyicong@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 7d2127d86c728..1d066ce8358f0 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -1000,6 +1000,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
 	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
 		return -ENOENT;
 
-- 
2.42.0

