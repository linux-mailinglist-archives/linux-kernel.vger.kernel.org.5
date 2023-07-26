Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8600763700
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjGZNBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjGZNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E112689;
        Wed, 26 Jul 2023 06:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3B6617A0;
        Wed, 26 Jul 2023 13:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBF4C433C8;
        Wed, 26 Jul 2023 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690376475;
        bh=KGJEEq13A9go4Yhd3XiG1sdw1r30ps972RCgI6Rs1/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLtG+6zVJFvWeSUaYKZadVKdntgfcrrog6jSXxIKWqkPk1S2ukerb1CcomtuIQNb3
         gmLsCCtW9lpiMpW/7SzbkVeVGmjVdECwlXNriH7acx8jplPEK3BzEBGynJaLJWxcUZ
         +euWgPGhCflOdMl5sxqXbeTrWfJ/hHM2O/l57ELU60f9yqazpOsYXNj852RrDPlXMJ
         fwm9KRMFe6pulQmqOscoFh1WOqa5LOkLWfiSg9z7ta0yaqlVxne414OXI8tME66quK
         5Wx0re1TKdRgJpkgFqbxpqlcqQFhr14K2LD84kPoGx64Z6I5CQFTZY/rNsEL/sVoEt
         9bh2KAH2bAeKQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 8/9] selftests/ftrace: Add BTF fields access testcases
Date:   Wed, 26 Jul 2023 22:01:11 +0900
Message-Id: <169037647132.607919.15889838982085210322.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169037639315.607919.2613476171148037242.stgit@devnote2>
References: <169037639315.607919.2613476171148037242.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases for accessing the data structure fields using BTF info.
This includes the field access from parameters and retval, and accessing
string information.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
Changes in v2:
 - Use '$retval' instead of 'retval'.
 - Add a test that use both '$retval' and '$arg1' for fprobe.
Changes in v3:
 - Change a test case with a numeric value.
 - Add a test case with mixed '.' and '->' operators.
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   14 ++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 ++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
index f34b14ef9781..4bfd2f45db42 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -21,6 +21,9 @@ echo 0 > events/enable
 echo > dynamic_events
 
 TP=kfree
+TP2=kmem_cache_alloc
+TP3=getname_flags
+TP4=sched_wakeup
 
 if [ "$FPROBES" ] ; then
 echo "f:fpevent $TP object" >> dynamic_events
@@ -33,6 +36,7 @@ echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg1' >> dynamic_events
 grep -q "fpevent.*object=object" dynamic_events
+
 echo > dynamic_events
 
 echo "f:fpevent $TP "'$arg*' >> dynamic_events
@@ -45,6 +49,16 @@ fi
 
 echo > dynamic_events
 
+echo "t:tpevent ${TP2} obj_size=s->object_size" >> dynamic_events
+echo "f:fpevent ${TP3}%return path=\$retval->name:string" >> dynamic_events
+echo "t:tpevent2 ${TP4} p->se.group_node.next->prev" >> dynamic_events
+
+grep -q "tpevent .*obj_size=s->object_size" dynamic_events
+grep -q "fpevent.*path=\$retval->name:string" dynamic_events
+grep -q 'tpevent2 .*p->se.group_node.next->prev' dynamic_events
+
+echo > dynamic_events
+
 if [ "$KPROBES" ] ; then
 echo "p:kpevent $TP object" >> dynamic_events
 grep -q "kpevent.*object=object" dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 72563b2e0812..49758f77c923 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -103,6 +103,10 @@ check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
 check_error 'f kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'f kfree%return ^$retval'		# NO_RETVAL
+check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
+check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
+check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
+check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
 else
 check_error 'f vfs_read ^$arg*'			# NOSUP_BTFARG
 check_error 't kfree ^$arg*'			# NOSUP_BTFARG

