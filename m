Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F206F7BFA92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjJJMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjJJMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309C109;
        Tue, 10 Oct 2023 05:00:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98984C433CB;
        Tue, 10 Oct 2023 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939207;
        bh=6HRXnuZZAf08Uj6BoCK0KS/GQ+u3twUB+rz7vaUHqM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGu1acjQr68zRAdzvRvlJ0zXkBTnIfdZhKPJ64JvOkf7eY1qKpHrPcZ/Q4CTd3nCS
         ciPo7Ivo3sDwTvdmQbygXimMeJY2HpZj/YXC6tXyscOt3YO9CuJBTsURFIMQnvsyYk
         BSlQ6ecnu08bkaZD0+3UNdL4+kb3ZUvNrbKgQRuKftvMGsko6jL8jZmxgesc9u1m55
         HYJ8Fx3sxhRvYXjziLPp4EWsLRVd7DkIuNMMcf5JI75yLvdZrT4Yk2u3zK3fNCT2dG
         4T/jYXj0BeUopT92Xm/tQDvS75lTxALgio8xWk15+RmM+yljAd0poVFB4YJ5p95OO3
         CKNLkn/NizYpA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 12/23] rcutorture: Copy out ftrace into its own console file
Date:   Tue, 10 Oct 2023 13:59:10 +0200
Message-Id: <20231010115921.988766-13-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

When debugging, it can be difficult to quickly find the ftrace dump
within the console log, which in turn makes it difficult to process it
independent of the rest of the console output.  This commit therefore
copies the contents of the buffers into its own file to make it easier
to locate and process the ftrace dump. The original ftrace dump is still
available in the console log in cases because it can be more convenient
to process it in situ, for example, for scripts that process console
output as well as ftrace-dump data.

Also handle the case of multiple ftrace dumps potentially showing up in the
log. Example for a file like [1], it will extract as [2].

[1]:
foo
foo
Dumping ftrace buffer:
---------------------------------
blah
blah
---------------------------------
more
bar
baz
Dumping ftrace buffer:
---------------------------------
blah2
blah2
---------------------------------
bleh
bleh

[2]:

Ftrace dump 1:
blah
blah

Ftrace dump 2:
blah2
blah2

[ paulmck: Fixed awk indentation, input up front. ]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../selftests/rcutorture/bin/functions.sh     | 29 +++++++++++++++++++
 .../selftests/rcutorture/bin/parse-console.sh |  7 +++++
 2 files changed, 36 insertions(+)
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..6e415ddb206f
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,32 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output in the original logs look like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+	awk < "$1" '
+
+	/Dumping ftrace buffer:/ {
+		buffer_count++
+		print "Ftrace dump " buffer_count ":"
+		capture = 1
+		next
+	}
+
+	/---------------------------------/ {
+		if(capture == 1) {
+			capture = 2
+			next
+		} else if(capture == 2) {
+			capture = 0
+			print ""
+		}
+	}
+
+	capture == 2'
+}
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9ab0f6bc172c..e3d2f69ec0fb 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -182,3 +182,10 @@ if ! test -s $file.diags
 then
 	rm -f $file.diags
 fi
+
+# Call extract_ftrace_from_console function, if the output is empty,
+# don't create $file.ftrace. Otherwise output the results to $file.ftrace
+extract_ftrace_from_console $file > $file.ftrace
+if [ ! -s $file.ftrace ]; then
+	rm -f $file.ftrace
+fi
-- 
2.34.1

