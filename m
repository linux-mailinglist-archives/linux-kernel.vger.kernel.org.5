Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41869756BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjGQSVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjGQSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A51E6F;
        Mon, 17 Jul 2023 11:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14CA1611F2;
        Mon, 17 Jul 2023 18:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450DCC433A9;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=qqTlwktI6OSX03JOvztECG/JCGyoxYMeQrtOwOhF5Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2yp0RhtxFwUC1EikIEwsrD/o8kGHqjtpCuNiJdG30UGGxELH7ue+o6jEklAGsuWr
         7fFTL9JdtyVzXQMRghNxDHag+0q13X4SP+Ii1L++gV3hAD2RiMqF8UOOSTQdlO29L4
         oR0Doym/d4Y0v8ECkyJh8TuGuJVPD9+QEJZQG0PbDS6u1lIpiHnn2SkIoH+vhBBjJl
         4KKzp9Ji6bDmw4WMX1BFj1eKj1OBY2aHoSxvqLGCFVSOCL08DMIcP3/hkbSVAvnLhE
         UIH/DwOYPCCDU+LRO4dDpVAKwUhrAwXSPJBkQyzVyguPhUuIh3wmCpcXSXLnepqq2t
         XXh5v4hO1nrAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 99236CE0930; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/9] torture: Move stutter_wait() timeouts to hrtimers
Date:   Mon, 17 Jul 2023 11:20:40 -0700
Message-Id: <20230717182042.1098651-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to gain better race coverage, move the test start/stop
waits in stutter_wait() to torture_hrtimeout_jiffies().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 3ab4930b9fdb..92704f04a141 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -745,7 +745,7 @@ bool stutter_wait(const char *title)
 			ret = true;
 		}
 		if (spt == 1) {
-			schedule_timeout_interruptible(1);
+			torture_hrtimeout_jiffies(1, NULL);
 		} else if (spt == 2) {
 			while (READ_ONCE(stutter_pause_test)) {
 				if (!(i++ & 0xffff))
@@ -753,7 +753,7 @@ bool stutter_wait(const char *title)
 				cond_resched();
 			}
 		} else {
-			schedule_timeout_interruptible(round_jiffies_relative(HZ));
+			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
 		}
 		torture_shutdown_absorb(title);
 	}
-- 
2.40.1

