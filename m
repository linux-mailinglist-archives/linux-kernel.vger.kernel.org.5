Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D9F756BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjGQSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGQSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893FDBE;
        Mon, 17 Jul 2023 11:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE07611FC;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB0C433AB;
        Mon, 17 Jul 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618219;
        bh=gX1dXu9EYUZnvZ5XI2EN0c4A9DLSR057l06Qh4PHOS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeWE05oJ5akiFA90dmI3+wYqRNNrHu1XIxW9/qcTx+MAvbrMYGYH8jsEWkgItT2J1
         cc1pperxE46mHQN9m6Awa3pVNb1Rpn1sEttmrWQlBJW7FBuJBdqu0glLEqc925SKPY
         b7PROTQPM2rf1eL28ndMc729DVv4iBoWbHjpDbRzLeXY5be0urr4Z2fmKsPDPB4O99
         Jq2IaBCGkKK0IyiefHrl6NvdLd5SK4NcGbT3N3eYFUKCj2qE8G+Nro7aqRy+wAUU+/
         8J11yydYqSRMlDH5A+meA/Z57KnQL2a+JZ6y1xm5ilPfVm335grH/KuIFFfJeD0CUX
         ZPuZ9/iqAlh2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2FFF3CE093C; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/18] torture: Make kvm-remote print diagnostics on initial ssh failure
Date:   Mon, 17 Jul 2023 11:23:27 -0700
Message-Id: <20230717182337.1098991-8-paulmck@kernel.org>
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

Currently, if the initial ssh fails, kvm-remote.sh gives up, printing a
message saying so.  But it would be nice to get a better idea as to why
ssh failed.  This commit therefore dumps out ssh's exit code, stdout,
and stderr upon ssh failure for diagnostic purposes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index a2328163eba1..134cdef5a6e0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -137,14 +137,20 @@ chmod +x $T/bin/kvm-remote-*.sh
 # Check first to avoid the need for cleanup for system-name typos
 for i in $systems
 do
-	ncpus="`ssh -o BatchMode=yes $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
+	ssh -o BatchMode=yes $i getconf _NPROCESSORS_ONLN > $T/ssh.stdout 2> $T/ssh.stderr
 	ret=$?
 	if test "$ret" -ne 0
 	then
-		echo System $i unreachable, giving up. | tee -a "$oldrun/remote-log"
+		echo "System $i unreachable ($ret), giving up." | tee -a "$oldrun/remote-log"
+		echo ' --- ssh stdout: vvv' | tee -a "$oldrun/remote-log"
+		cat $T/ssh.stdout | tee -a "$oldrun/remote-log"
+		echo ' --- ssh stdout: ^^^' | tee -a "$oldrun/remote-log"
+		echo ' --- ssh stderr: vvv' | tee -a "$oldrun/remote-log"
+		cat $T/ssh.stderr | tee -a "$oldrun/remote-log"
+		echo ' --- ssh stderr: ^^^' | tee -a "$oldrun/remote-log"
 		exit 4
 	fi
-	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
+	echo $i: `cat $T/ssh.stdout` CPUs " " `date` | tee -a "$oldrun/remote-log"
 done
 
 # Download and expand the tarball on all systems.
-- 
2.40.1

