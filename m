Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5639A756BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjGQSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjGQSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2310D8;
        Mon, 17 Jul 2023 11:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059916121B;
        Mon, 17 Jul 2023 18:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273F5C433CA;
        Mon, 17 Jul 2023 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618220;
        bh=RCVifOKfIw+9aq0+FOvG0OI3UWiuO8vkL1zh9hG5PcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYHp/I7QhylSmFvPvYPbZ9iO/I8TbBUu/hPJWmauatStq3JEhsNn5Xn8KScysXZri
         +UtgETAoLmfseklJt9bY28Rjc9HnaiSyIz3COtR8riYxNV7BZXNzH1G2H9MNCrNm9G
         5HUEqkNsgKma+/kSMF0APGvVcaCs7QotmIkBKZey1YBoIVCpi+kwxsjTEO3BQ3exyV
         H94wg0nluAFQUzP70yaWStamUNme1inj/UpSNKHmMxdghIXPFh7oVzXtDW1O6T4UR9
         nN/pnslud5kt3tKQhn80cqIfTW4wmkeLHiUvLn/nZxNyxuu+k+24HFR1MOjZ5HUWNm
         U8UuVjj1eBEYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F0C9CE0ACD; Mon, 17 Jul 2023 11:23:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH rcu 15/18] torture: Add init-program support for loongarch
Date:   Mon, 17 Jul 2023 11:23:34 -0700
Message-Id: <20230717182337.1098991-15-paulmck@kernel.org>
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

This commit adds the __loongarch__, __loongarch_lp64, and
__loongarch_double_float targets to rcutorture's mkinitrd.sh
script in order to allow nolibc init programs for loongarch.

Cc: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 3af3a86a0091..e7e23615dbe3 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -63,7 +63,8 @@ ___EOF___
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
 if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
-           "||__ARM_EABI__||__aarch64__||__s390x__\nyes\n#endif" \
+           "||__ARM_EABI__||__aarch64__||__s390x__"\
+	   "||__loongarch__||__loongarch_lp64||__loongarch_double_float\nyes\n#endif" \
    | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
    | grep -q '^yes'; then
 	# architecture supported by nolibc
-- 
2.40.1

