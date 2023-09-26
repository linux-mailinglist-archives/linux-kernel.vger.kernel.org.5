Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2667AF416
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjIZTYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjIZTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:24:14 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDA180
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:24:08 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 8CEA3181673;
        Tue, 26 Sep 2023 21:24:06 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695756246; bh=XruJiBHgq+nHTppk3DIZz92BSsLm3t0Pi2qS8t6/ImM=;
        h=From:To:Cc:Subject:Date:From;
        b=XQLB8Y3klEtZzr9+TDLL/x32AzWd7ykFiuSofy4z0VCJU+b/r9+4WWJ+2w01VsC5W
         XyPXB355gORURqgEPW+aMzIkVEwmK5LpFQCgQDzVOKbgXUQxxAJLnPjipFG9SnPdQx
         tAgMb9Xb1aZ5kE0MSfegv/aJy2i2FnKzemETj/usdg2TfyY0vldwUpUCLiiSmcfMxx
         MeWeD3RAGmb9tY/UdkgtKCB+S/pNsaytH29cqjRDYxWRdLHYJubZqARx6HJAk5iXc2
         /LE6Cg6pg/AUmMpWOcv5uL96piA4+keKQ9mbYMIVytbODjEYWsAHoFOZkEZuMIhTob
         g0I+slAax448A==
From:   Petr Tesarik <petr@tesarici.cz>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH v2] checkpatch: warn about multi-line comments without an empty /* line
Date:   Tue, 26 Sep 2023 21:24:00 +0200
Message-ID: <20230926192400.19366-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/process/coding-style.rst, the preferred style
for multi-line comments outside net/ and drivers/net/ is:

.. code-block:: c

        /*
         * This is the preferred style for multi-line
         * comments in the Linux kernel source code.
         * Please use it consistently.
         *
         * Description:  A column of asterisks on the left side,
         * with beginning and ending almost-blank lines.
         */

Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..e48e7b4d08c0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4006,6 +4006,14 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
 
+# Non-networking without an initial /*
+		if ($realfile !~ m@^(drivers/net/|net/)@ &&
+		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
+		    $rawline =~ /^\+[ \t]*\*/) {
+			WARN("BLOCK_COMMENT_STYLE",
+			     "multi-line block comments should start with an empty /* line\n" . $hereprev);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
-- 
2.42.0

