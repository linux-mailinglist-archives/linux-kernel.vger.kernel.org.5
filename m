Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306B7E127B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjKEHwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:52:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95224C6;
        Sun,  5 Nov 2023 00:52:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6706C433C8;
        Sun,  5 Nov 2023 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699170747;
        bh=vGB0nDcdTA3XbEVZQznJAI0xImZuzvvObk2/Ib9/Z8s=;
        h=From:To:Cc:Subject:Date:From;
        b=f73iM5ATcGVFBCbtFfRSVMNGxmMdawdoxtcoXUTYimpaEd/j84m3utxfu9tfHRbHX
         Kg3n9qIR14zuaoSG6v4cUCpQWSw/qJIEWYMF7YIG2tSBvcM+fmCWohAE3gZJins7ab
         T7JlSs4xZm9+Hn+t3nriSjK3sfiUVuMxSDgDGfETws8wwEgKYJTlvyET2EBwfSgUYA
         SNpCdRTVceHMvbMQf2pL2EGIm8LLlH3MIiuLDI3i4gdImtTUNNb+HFWnqRff4P8V8l
         4Fwqj7i2b6T7/5uuMXYusmr9KUPG4AfbAt9t6+SPxrJ0Tg2brjJ4zniZ1g9TzrarWq
         Dx6jXJ32+/bJg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] genksyms: remove the remnant of the -s option
Date:   Sun,  5 Nov 2023 16:52:17 +0900
Message-Id: <20231105075218.61536-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 74d931716151 ("genksyms: remove symbol prefix support") removed
the -s (--symbol-prefix) option.

Clean up the left-over.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/genksyms/genksyms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index f5dfdb9d80e9..6636d5b30eba 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -719,7 +719,6 @@ static void genksyms_usage(void)
 {
 	fputs("Usage:\n" "genksyms [-adDTwqhVR] > /path/to/.tmp_obj.ver\n" "\n"
 #ifdef __GNU_LIBRARY__
-	      "  -s, --symbol-prefix   Select symbol prefix\n"
 	      "  -d, --debug           Increment the debug level (repeatable)\n"
 	      "  -D, --dump            Dump expanded symbol defs (for debugging only)\n"
 	      "  -r, --reference file  Read reference symbols from a file\n"
@@ -730,7 +729,6 @@ static void genksyms_usage(void)
 	      "  -h, --help            Print this message\n"
 	      "  -V, --version         Print the release version\n"
 #else				/* __GNU_LIBRARY__ */
-	      "  -s                    Select symbol prefix\n"
 	      "  -d                    Increment the debug level (repeatable)\n"
 	      "  -D                    Dump expanded symbol defs (for debugging only)\n"
 	      "  -r file               Read reference symbols from a file\n"
@@ -763,10 +761,10 @@ int main(int argc, char **argv)
 		{0, 0, 0, 0}
 	};
 
-	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:ph",
+	while ((o = getopt_long(argc, argv, "dwqVDr:T:ph",
 				&long_opts[0], NULL)) != EOF)
 #else				/* __GNU_LIBRARY__ */
-	while ((o = getopt(argc, argv, "s:dwqVDr:T:ph")) != EOF)
+	while ((o = getopt(argc, argv, "dwqVDr:T:ph")) != EOF)
 #endif				/* __GNU_LIBRARY__ */
 		switch (o) {
 		case 'd':
-- 
2.40.1

