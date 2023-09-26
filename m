Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A2A7AF409
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjIZTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjIZTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:20:22 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908E92
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:20:15 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 52CBC180BFA;
        Tue, 26 Sep 2023 21:20:13 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695756013; bh=QmHO9guWcCdGsga/mvVCpATrxgl+h8uqruAwQ/x5zz0=;
        h=From:To:Cc:Subject:Date:From;
        b=jwZySkMf1YnyvpaKRAfRHZYU0aa0zIFhZiChoRv/2j8VSSGYbpSxRA7GgwQYtbtet
         GSM4IpPJWuNFjJyRf12RisgrRGZyZKHesQZgUBcv0IHS2+VTBiWq4zw8L+b8zpAVMt
         kZp10Gj01ovcNEjuKBXAPfr9XHdWKFMIrrvW89otdA3HXv+r6dY892VOaHv1wqcVLD
         EMU6UEBTxxLN7iusEMi6YnLynJRNd/MW0rBeROTVMCMF5AJHIA70Vmsqg/C1IVD+fg
         zWeN7CCKjkgmvce34CNs6/ettzrCKppcSoyKi347e0O+Roc+eKmH7P+dFCPZHyCpfy
         ErXfZqz2lrEdQ==
From:   Petr Tesarik <petr@tesarici.cz>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH] checkpatch: warn about multi-line comments without an empty /* line
Date:   Tue, 26 Sep 2023 21:20:06 +0200
Message-ID: <20230926192006.18351-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 7d16f863edf1..0fc3427a9ec9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4006,6 +4006,14 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
 
+# Non-networking without an initial /*
+		if ($realfile !~ m@^(drivers/net/|net/)@ &&
+		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
+		    $rawline =~ /^\+[ \t]*\*/) {
+			WARN("MULTILINE_BLOCK_COMMENT_STYLE",
+			     "multi-line block comments should start with an empty /* line\n" . $hereprev);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
-- 
2.42.0

