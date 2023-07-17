Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE67C756B40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGQSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjGQSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02401BE1;
        Mon, 17 Jul 2023 11:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E44611D5;
        Mon, 17 Jul 2023 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2388C433CC;
        Mon, 17 Jul 2023 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617095;
        bh=z5xJPNvzuFRjo2lR/l/wLkVKNv1SHd09S5ncMfb7TjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYt2oIUYUT5pC68a8AdfGvE7WCB9HYuDQCTvgQXOZYLpS4p1Hxh4GFFaGy7Iuj2AT
         MAoo0tdMoFMV264r7XQFcDWalXuQqA/Tg2hd3g1obZ9k+DGOkOHT4bEEeyW4Usvy8Q
         PLAJcrOLgPZb9m40+DnRS7yEFB6BL5wcLYNYsfLen+9EpHRfxVZq36bPsRKOHlsMnK
         1bFVAiFBvrIA8UF17g6tw6Xw40hQGAN+4PceBM2Sx0egUp+QaJ9zs4OGrol7eA2mnG
         qNbZ0je4cj+eUqLh/tkOKAzZYlVun9e2B62ePPtJh2RnrmbykNJX46G+DIPj/86bhX
         03iiHStrPifgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5ED95CE0902; Mon, 17 Jul 2023 11:04:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of RCU Tasks Trace
Date:   Mon, 17 Jul 2023 11:04:54 -0700
Message-Id: <20230717180454.1097714-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
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

RCU Tasks Trace is quite specialized, having been created specifically
for sleepable BPF programs.  Because it allows general blocking within
readers, any new use of RCU Tasks Trace must take current use cases into
account.  Therefore, update checkpatch.pl to complain about use of any of
the RCU Tasks Trace API members outside of BPF and outside of RCU itself.

Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/checkpatch.pl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..24bab980bc6f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7457,6 +7457,24 @@ sub process {
 			}
 		}
 
+# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
+		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
+		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
+		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
+		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
+		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
+		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
+		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
+			if ($realfile !~ m@^kernel/bpf@ &&
+			    $realfile !~ m@^include/linux/bpf@ &&
+			    $realfile !~ m@^net/bpf@ &&
+			    $realfile !~ m@^kernel/rcu@ &&
+			    $realfile !~ m@^include/linux/rcu@) {
+				WARN("RCU_TASKS_TRACE",
+				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
+			}
+		}
+
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
-- 
2.40.1

