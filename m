Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E3756B65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGQSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGQSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097799;
        Mon, 17 Jul 2023 11:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 207DE611E1;
        Mon, 17 Jul 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB43C433A9;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=N9K+fD3EFCsSjTZTUsdzLJiPJxPM1QAGdJD0a23WnpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7DsUuPadJm0BDm8NK9h1ln05KhLCAhlYqBXu/hQty300WAYdzBGEx2rG1p+0r29v
         xer+JPV5IGFeVJkJaoBr6vK8LjOXn99WhzbPIcfW5H4mCcR+fGY8fido2K2CYfu1gV
         m/+cHby9EP0HYX+W6S2tpbiC0lctt+ab19BKn/pT/THkFNBv0xW/5zJLeiLHfzJW5e
         H0rrNY1Epood0uZ/HUb44+YjzD5K8R85BOrQjOR5GczIK00mSArjD9EQO/alCarggU
         S4q8ekVvGcbYJc4F0xhlQgpBB3nb/qCw57puNgj+vdY9sZMQkh0gd+ELGzpOnDYFq6
         l7OMtMu1lPAcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE377CE093C; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/13] rcuscale: Print grace-period kthread CPU time, if recorded
Date:   Mon, 17 Jul 2023 11:11:33 -0700
Message-Id: <20230717181138.1098063-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
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

This commit prints out the CPU time consumed by the grace-period kthread,
if the specified RCU flavor supports this notion.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-recheck-rcuscale.sh      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
index b582113178ac..f683e424ddd5 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
@@ -40,6 +40,10 @@ awk '
 	sum += $5 / 1000.;
 }
 
+/rcu_scale: Grace-period kthread CPU time/ {
+	cputime = $6;
+}
+
 END {
 	newNR = asort(gptimes);
 	if (newNR <= 0) {
@@ -78,6 +82,8 @@ END {
 	print "90th percentile grace-period duration: " gptimes[pct90];
 	print "99th percentile grace-period duration: " gptimes[pct99];
 	print "Maximum grace-period duration: " gptimes[newNR];
-	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches;
+	if (cputime != "")
+		cpustr = " CPU: " cputime;
+	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches cpustr;
 	print "Computed from rcuscale printk output.";
 }'
-- 
2.40.1

