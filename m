Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249677BC930
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjJGRE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjJGRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6921B9;
        Sat,  7 Oct 2023 10:04:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F07C433C8;
        Sat,  7 Oct 2023 17:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696698295;
        bh=5rWN3r1QrWbZPdwY53XXoqrpI9vkxw4GAZMoimstNTU=;
        h=From:To:Cc:Subject:Date:From;
        b=ne3VlCVVWtdJlPXT1Sksj5UMIr8o7iegZVtoYOu+WNb8oD72PHoQ0DS3n7xxd451P
         dKdElA/aK5liU8cGmISK7mIQ9tWuwrGKuVcwzRtyy7sOXQ8HMMOE/ptiKzqX7HTmTW
         Ki0wW+XN3u0oZ1BDbkug60VpfBjvKSyWoH2aE0nXbf45BHbWtmw7WcA3mreTtwoLea
         85+bV00WxR29ecLxzHVzx/s36oLAQ2oZbHqIs6fwmQY1K4q+ynlVtxQf+p+FRy1lpG
         blsa/RQzXTZe2pisEPrHwh3T9zohUTugXF2q9o1uW+YHKhrolJy1lBesq+GXCoJzLO
         WiWvd4yF+jkgw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/5] modpost: fix tee MODULE_DEVICE_TABLE built on big endian host
Date:   Sun,  8 Oct 2023 02:04:44 +0900
Message-Id: <20231007170448.505487-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MODULE_DEVICE_TABLE(tee, ) is built on a host with a different
endianness from the target architecture, it results in an incorrect
MODULE_ALIAS().

For example, see a case where drivers/char/hw_random/optee-rng.c
is built as a module.

If you build it on a little endian host, you will get the correct
MODULE_ALIAS:

    $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
    MODULE_ALIAS("tee:ab7a617c-b8e7-4d8f-8301-d09b61036b64*");

However, if you build it on a big endian host, you will get a wrong
MODULE_ALIAS:

    $ grep MODULE_ALIAS drivers/char/hw_random/optee-rng.mod.c
    MODULE_ALIAS("tee:646b0361-9bd0-0183-8f4d-e7b87c617aab*");

This issue has been unnoticed because the ARM kernel is most likely built
on a little endian host (cross-build on x86 or native-build on ARM).

The uuid field must not be reversed because uuid_t is an array of __u8.

Fixes: 0fc1db9d1059 ("tee: add bus driver framework for TEE based devices")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/file2alias.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7056751c29b1..70bf6a2f585c 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1348,13 +1348,13 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 /* Looks like: tee:uuid */
 static int do_tee_entry(const char *filename, void *symval, char *alias)
 {
-	DEF_FIELD(symval, tee_client_device_id, uuid);
+	DEF_FIELD_ADDR(symval, tee_client_device_id, uuid);
 
 	sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
-		uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
-		uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
-		uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[14],
-		uuid.b[15]);
+		uuid->b[0], uuid->b[1], uuid->b[2], uuid->b[3], uuid->b[4],
+		uuid->b[5], uuid->b[6], uuid->b[7], uuid->b[8], uuid->b[9],
+		uuid->b[10], uuid->b[11], uuid->b[12], uuid->b[13], uuid->b[14],
+		uuid->b[15]);
 
 	add_wildcard(alias);
 	return 1;
-- 
2.39.2

