Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CDA756BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGQSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGQSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202910E6;
        Mon, 17 Jul 2023 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CED426120A;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE87C433B9;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=heNT/lSSnYq3bKY/yJjM4QyFofD0HNiN0LSfuMDoBiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fl6/K8EZaAHe+MXSTws2+lVU0pZSFF0NAGHY5gcjBpYUXwuWmoD2+7qDrd7ddCIf0
         OuYU63wEVKv5YY+gYdqzovdectgSbATuAsFCqcSA5cg3K1+CeyHgDZQ5IjOAl/jIT1
         R6cINHwJuDadSKU6xHQmKlzibueu8Y5/hvz4LprZTOfaSguXRSB60LjYDlxAjPO8DF
         ucWHfvQmbLg3YrhNMfGQ9RgkCzuXbFDTbmZBq6gPWZZJ8owUN6ptD0ZRZnD4EMx3AQ
         fAoYRNu1z1a/Oh3ZB1BXAoT1ZgASDnO+okYoGN3UuLzQulPEXJ5ci17UhbxxMBezck
         OROOseJO8IjIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 36772CE0A0F; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/18] torture: Make torture.sh summarize config and build errors
Date:   Mon, 17 Jul 2023 11:23:30 -0700
Message-Id: <20230717182337.1098991-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
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

If some of the torture.sh runs had config and/or build errors, but all
runs for which kernels were built ran successfully to completion, then
torture.sh will incorrectly claim that all errors were KCSAN errors.
This commit therefore makes torture.sh print the number of runs with
config and build errors, and to refrain from claiming that all bugs were
KCSAN bugs in that case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index dd3bfadb0639..d36b839bf586 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -582,11 +582,23 @@ then
 fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
+tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
+find "$tdir" -name 'ConfigFragment.diags' -print > $T/configerrors
+find "$tdir" -name 'Make.out.diags' -print > $T/builderrors
+if test -s "$T/configerrors"
+then
+	echo "  Scenarios with .config errors: `wc -l "$T/configerrors" | awk '{ print $1 }'`"
+	nonkcsanbug="yes"
+fi
+if test -s "$T/builderrors"
+then
+	echo "  Scenarios with build errors: `wc -l "$T/builderrors" | awk '{ print $1 }'`"
+	nonkcsanbug="yes"
+fi
 if test -z "$nonkcsanbug" && test -s "$T/failuresum"
 then
 	echo "  All bugs were KCSAN failures."
 fi
-tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
 if test -n "$tdir" && test $compress_concurrency -gt 0
 then
 	# KASAN vmlinux files can approach 1GB in size, so compress them.
-- 
2.40.1

