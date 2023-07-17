Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D0756BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGQSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F9FC;
        Mon, 17 Jul 2023 11:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD0961210;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E18EC611A2;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=jmrnz++/EcvgINfY2j7V/y9cLT5lrTwNhewPXob4+Wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5Y9SiTaypxxAts2TNaDhaQQ0eXIVHQ0mytcm67ENSvL1F939yw7h9p1bFLO0N4qM
         oYxr+x2Uc1ehtuMXmBna5LdlU+8d355OW5x+VZYsTcvt70Qju15Gs4LyfKyMWbmpGG
         jYsWiRqz6Yvcu9hTstfYUPtACLRbdK0GyJxKV+gdhKSMoEVt650cr1GgJ1CwzU3O42
         +sFa554VipYJya6f6RWdEziQ8h5efKxHIamShftwajR+xsYo0AiqRZB3uS97Fn34Ku
         f42pfRKRyClGALtM2eelwXhNQr0ERoklRBypnHZI02fPg60npJHL9uCwaoXMLePMb3
         BtwwMxRKWsxzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 45531CE0AD7; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 18/18] torture: Cause mkinitrd.sh to indicate failure on compile errors
Date:   Mon, 17 Jul 2023 11:23:37 -0700
Message-Id: <20230717182337.1098991-18-paulmck@kernel.org>
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

Currently, if the C program created by mkinitrd.sh has compile errors,
the errors are printed, but kvm.sh soldiers on, building kernels that
have init-less initrd setups.  The kernels then fail on boot when they
attempt to mount non-existent root filesystems.

This commit therefore improves user friendliness by making mkinitrd.sh
return non-zero exit status on compile errors, which in turn causes kvm.sh
to take an early exit, with the compile errors still clearly visible.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index a5a483efa5ba..3e2d4ac9f338 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -75,8 +75,16 @@ if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
         ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
 		-nostdlib -include ../../../../include/nolibc/nolibc.h \
 		-s -static -Os -o init init.c -lgcc
+	ret=$?
 else
 	${CROSS_COMPILE}gcc -s -static -Os -o init init.c
+	ret=$?
+fi
+
+if [ "$ret" -ne 0 ]
+then
+	echo "Failed to create a statically linked C-language initrd"
+	exit "$ret"
 fi
 
 rm init.c
-- 
2.40.1

