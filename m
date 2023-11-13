Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0EC7EA5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjKMWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjKMWDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:03:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FBD6C;
        Mon, 13 Nov 2023 14:03:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD99C433C7;
        Mon, 13 Nov 2023 22:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699913013;
        bh=eoPOFwQKBI5DH/2gslFAWw1LIbFtVuvG1rrdOcMjkuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnuG9IvL/cfjbq3+PKfG7YJgkpJMoQAeklUwZqrQWAv65hjHYmSrUDQ9Cxn3aNMg8
         zqrgtWB06wlWD7xEWqtP4YvcMu4YRw09MnCVwFjt6PE1BqCZ5sWgdmiqibDddNK3ep
         qXvxMTjomFmYW5/+KmVLm8/kd3LH+dWSJjtVulnzAtrTz8ZOvZ288auFM/3j6m4Y3H
         C7zJYHi4o1p5kGpgMr+JoE/BJhVs+e3hzg7XhVjK4LAhugdF4RNmivre6lQlu7dw83
         vFlvlYeLAEkPuKl0PxcjkLcfGQPN4H5nm8y3j4QvuH1D2Hfq1jGyTnIm1q1lv80i+v
         +O29HMB2R/bVg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] cpuidle: Remove unnecessary current_clr_polling() on poll_idle()
Date:   Mon, 13 Nov 2023 17:03:26 -0500
Message-ID: <20231113220326.7933-3-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113220326.7933-1-frederic@kernel.org>
References: <20231113220326.7933-1-frederic@kernel.org>
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

There is no point in clearing TIF_NR_POLLING and folding TIF_NEED_RESCHED
upon poll_idle() exit because cpuidle_idle_call() is going to set again
TIF_NR_POLLING anyway. Also if TIF_NEED_RESCHED is set, it will be
folded and TIF_NR_POLLING will be cleared at the end of do_idle().

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/poll_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..d5cb3eb85a54 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -40,8 +40,6 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	}
 	raw_local_irq_disable();
 
-	current_clr_polling();
-
 	return index;
 }
 
-- 
2.42.1

