Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA77C9C67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjJOWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 18:25:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96FC1;
        Sun, 15 Oct 2023 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697408724;
        bh=z5KXjjPVrLjRebSzXXdn6DFLWUKznuVXuDGh7BkTaQM=;
        h=From:Date:Subject:To:Cc:From;
        b=gRkST88HLzafee30Sfe4sNkU5qdDyRymPoayJRt6pZkztLNWms8JtDkynPcUDOYz+
         vIXr63Qf9Hk9Gz63CZiA4MOYigfHg9elucheXqNV69e3SKRFTkgbziZertXw7muEIP
         j5fMQP1VsrHMqkASk3IdyGEkOCPGeLAM59ZpddTg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 16 Oct 2023 00:25:14 +0200
Subject: [PATCH] rcutorture: add nolibc init support for mips, ppc and rv64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231016-rcu-nolibc-arch-v1-1-391af51b129b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMlmLGUC/x3MSQqAMAxA0auUrA10UBdeRVx0iBqQKimKIN7d4
 vIt/n+gkDAVGNQDQhcX3nOFaRTE1eeFkFM1WG2d0aZHiSfmfeMQ0UtckVIyKWjXda2HWh1CM9/
 /cZze9wOHkAjxYQAAAA==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697408724; l=1257;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z5KXjjPVrLjRebSzXXdn6DFLWUKznuVXuDGh7BkTaQM=;
 b=HrVnh6LrdqOofTiC7I1zFYHe9Olvgc1I9UJMSNMqxll6F13tg6HjEmvEff/8C+hhzlB0tuvrL
 yk5KEi5sJdFDb235pedugKYwemyuBHknOMAdKbFr/Z/ix8H1GG5DPpC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use nolibc for all support architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 212c52ca90b5..f3f867129560 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -67,7 +67,10 @@ ___EOF___
 # build using nolibc on supported archs (smaller executable) and fall
 # back to regular glibc on other ones.
 if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
-	   "||__ARM_EABI__||__aarch64__||__s390x__||__loongarch__\nyes\n#endif" \
+	   "||__ARM_EABI__||__aarch64__||(__mips__ && _ABIO32)" \
+	   "||__powerpc__||(__riscv && __riscv_xlen == 64)" \
+	   "||__s390x__||__loongarch__" \
+	   "\nyes\n#endif" \
    | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
    | grep -q '^yes'; then
 	# architecture supported by nolibc

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231016-rcu-nolibc-arch-edd1db03554a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

