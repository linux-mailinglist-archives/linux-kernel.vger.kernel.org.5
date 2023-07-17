Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE59756BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGQSYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGQSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B48818B;
        Mon, 17 Jul 2023 11:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C2F8611F0;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897C2C433C9;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=GArP46UHcP0/syJ9tA7kCUoRFHn+NxiDlARBBLRzqlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5BlG2BYfXv+uFaKXM6SZpOQywVb+8jUu1geyGyFU79KUtcTTtRmxACiLoCe4K9Pj
         zn/Vv3EA9KVH7pfz2wEXOmVbUQO2UXrJSB0YDigCrIXncqyUjqjW9lceIrjtuMGJgH
         B8u7xHiZQJ6VuMuYNq7kdpjKMy5dNBMHR+LCelnq0WJSaKaTK8Z7fxUvcC82hIiomB
         MR+Xbx5tJTPuAQChc3n9iyhylfasq6yRGKBzqzKozwRjqFUJJRN/11PyH3vp3im4Ip
         MRuRvHzC41Cme8ir74IqnAFlYYuh5nXXIDZ0meSZKd27yqCumXILM/rUqjNM2WruIF
         GsQKvrUfqqvLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2529ACE0806; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/18] torture: Add "--no-" as synonym for "--do-no-" in torture.sh
Date:   Mon, 17 Jul 2023 11:23:22 -0700
Message-Id: <20230717182337.1098991-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop>
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

In order to (for example) omit the real-time testing that torture.sh would
otherwise carry out, you put "--do-no-rt" on the torture.sh command line.
This works, but it is all too easy to instead type "--no-rt".  This is
unambiguous and easier to type, so this commit therefore allows all
"--no-" arguments as synonyms for their "--do-no-" counterparts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 5a2ae2264403..c3190ca9c96f 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -73,18 +73,18 @@ usage () {
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
 	echo "       --do-all"
-	echo "       --do-allmodconfig / --do-no-allmodconfig"
-	echo "       --do-clocksourcewd / --do-no-clocksourcewd"
-	echo "       --do-kasan / --do-no-kasan"
-	echo "       --do-kcsan / --do-no-kcsan"
-	echo "       --do-kvfree / --do-no-kvfree"
-	echo "       --do-locktorture / --do-no-locktorture"
+	echo "       --do-allmodconfig / --do-no-allmodconfig / --no-allmodconfig"
+	echo "       --do-clocksourcewd / --do-no-clocksourcewd / --no-clocksourcewd"
+	echo "       --do-kasan / --do-no-kasan / --no-kasan"
+	echo "       --do-kcsan / --do-no-kcsan / --no-kcsan"
+	echo "       --do-kvfree / --do-no-kvfree / --no-kvfree"
+	echo "       --do-locktorture / --do-no-locktorture / --no-locktorture"
 	echo "       --do-none"
-	echo "       --do-rcuscale / --do-no-rcuscale"
-	echo "       --do-rcutorture / --do-no-rcutorture"
-	echo "       --do-refscale / --do-no-refscale"
-	echo "       --do-rt / --do-no-rt"
-	echo "       --do-scftorture / --do-no-scftorture"
+	echo "       --do-rcuscale / --do-no-rcuscale / --no-rcuscale"
+	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
+	echo "       --do-refscale / --do-no-refscale / --no-refscale"
+	echo "       --do-rt / --do-no-rt / --no-rt"
+	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
 	echo "       --kcsan-kmake-arg kernel-make-arguments"
 	exit 1
@@ -126,22 +126,22 @@ do
 		do_kcsan=yes
 		do_clocksourcewd=yes
 		;;
-	--do-allmodconfig|--do-no-allmodconfig)
+	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
 		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
 		;;
-	--do-clocksourcewd|--do-no-clocksourcewd)
+	--do-clocksourcewd|--do-no-clocksourcewd|--no-clocksourcewd)
 		do_clocksourcewd=`doyesno "$1" --do-clocksourcewd`
 		;;
-	--do-kasan|--do-no-kasan)
+	--do-kasan|--do-no-kasan|--no-kasan)
 		do_kasan=`doyesno "$1" --do-kasan`
 		;;
-	--do-kcsan|--do-no-kcsan)
+	--do-kcsan|--do-no-kcsan|--no-kcsan)
 		do_kcsan=`doyesno "$1" --do-kcsan`
 		;;
-	--do-kvfree|--do-no-kvfree)
+	--do-kvfree|--do-no-kvfree|--no-kvfree)
 		do_kvfree=`doyesno "$1" --do-kvfree`
 		;;
-	--do-locktorture|--do-no-locktorture)
+	--do-locktorture|--do-no-locktorture|--no-locktorture)
 		do_locktorture=`doyesno "$1" --do-locktorture`
 		;;
 	--do-none|--donone)
@@ -157,19 +157,19 @@ do
 		do_kcsan=no
 		do_clocksourcewd=no
 		;;
-	--do-rcuscale|--do-no-rcuscale)
+	--do-rcuscale|--do-no-rcuscale|--no-rcuscale)
 		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
-	--do-rcutorture|--do-no-rcutorture)
+	--do-rcutorture|--do-no-rcutorture|--no-rcutorture)
 		do_rcutorture=`doyesno "$1" --do-rcutorture`
 		;;
-	--do-refscale|--do-no-refscale)
+	--do-refscale|--do-no-refscale|--no-refscale)
 		do_refscale=`doyesno "$1" --do-refscale`
 		;;
-	--do-rt|--do-no-rt)
+	--do-rt|--do-no-rt|--no-rt)
 		do_rt=`doyesno "$1" --do-rt`
 		;;
-	--do-scftorture|--do-no-scftorture)
+	--do-scftorture|--do-no-scftorture|--no-scftorture)
 		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
 	--duration)
-- 
2.40.1

