Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B07BC931
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbjJGRFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbjJGRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0BBA;
        Sat,  7 Oct 2023 10:04:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDADAC433C7;
        Sat,  7 Oct 2023 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696698297;
        bh=13ShY6HnWg7Sx2I9hscgBsQOpo9Vq3faGjdLVYoBM5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUeSBoRC8ODJTmKIkYd6gNHF/IrKY8Gdzo0GJtWGKXvn/Gwxg66E66zwK+R+L641h
         RH91OtdShkzWHuMANps+J8Tk/390bUD43IXxpuXrUmzlZ05XTXonzNYEnWWPx7X41M
         2yz+S0Ez0O60sxYV+gxrOXChiiB5dI2NdlKFf2mSvqGCjH5w5iO1wDyObNm6wVEK1y
         8CafTp2S7rUo6l50QfyjmNHtmXI+FjjRaK7qOO11kQeSR4vpSHgoIaidgiPSnAlanS
         dThJcqOhH5Y0mQPS4fb8cu0vCfja+eoOcDBKuq1Iab/VnMOtrRwqUseRmQm0ueA0/L
         8jdcl8NIkKFpA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 2/5] modpost: fix ishtp MODULE_DEVICE_TABLE built on big endian host
Date:   Sun,  8 Oct 2023 02:04:45 +0900
Message-Id: <20231007170448.505487-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007170448.505487-1-masahiroy@kernel.org>
References: <20231007170448.505487-1-masahiroy@kernel.org>
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

When MODULE_DEVICE_TABLE(ishtp, ) is built on a host with a different
endianness from the target architecture, it results in an incorrect
MODULE_ALIAS().

For example, see a case where drivers/platform/x86/intel/ishtp_eclite.c
is built as a module.

If you build it on a little endian host, you will get the correct
MODULE_ALIAS:

    $ grep MODULE_ALIAS drivers/platform/x86/intel/ishtp_eclite.mod.c
    MODULE_ALIAS("ishtp:{6A19CC4B-D760-4DE3-B14D-F25EBD0FBCD9}");

However, if you build it on a big endian host, you will get a wrong
MODULE_ALIAS:

    $ grep MODULE_ALIAS drivers/platform/x86/intel/ishtp_eclite.mod.c
    MODULE_ALIAS("ishtp:{BD0FBCD9-F25E-B14D-4DE3-D7606A19CC4B}");

This issue has been unnoticed because the x86 kernel is most likely built
natively on an x86 host.

The guid field must not be reversed because guid_t is an array of __u8.

Fixes: fa443bc3c1e4 ("HID: intel-ish-hid: add support for MODULE_DEVICE_TABLE()")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/file2alias.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 70bf6a2f585c..6583b36dbe69 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1401,10 +1401,10 @@ static int do_mhi_ep_entry(const char *filename, void *symval, char *alias)
 /* Looks like: ishtp:{guid} */
 static int do_ishtp_entry(const char *filename, void *symval, char *alias)
 {
-	DEF_FIELD(symval, ishtp_device_id, guid);
+	DEF_FIELD_ADDR(symval, ishtp_device_id, guid);
 
 	strcpy(alias, ISHTP_MODULE_PREFIX "{");
-	add_guid(alias, guid);
+	add_guid(alias, *guid);
 	strcat(alias, "}");
 
 	return 1;
-- 
2.39.2

