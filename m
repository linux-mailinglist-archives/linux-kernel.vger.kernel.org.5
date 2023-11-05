Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEA7E15B5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKESLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKESLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:11:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA28DD;
        Sun,  5 Nov 2023 10:10:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E944DC433C7;
        Sun,  5 Nov 2023 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699207857;
        bh=mpoFT+sF50Go2QZkoZaiy6iHqvzaLfmudnHNvkJjZ0M=;
        h=From:To:Cc:Subject:Date:From;
        b=FF199295T+QngVfe3dCykm2QL3pOi50DD0yTbipcqRTQQMIzaCQERTqwE4jQ3C+cz
         vgVvm+MNjjXl4RgT2BTIXmECuI28soPzolp4Gj0GyV5njaVRNJvgH76ayat6spDTFe
         vZMqZEglfRJmpQv7PMZX6HAWAJK70OLWjrPWjt29hPkRzsjnOsfbcxlPXoY6cPgEdN
         eyZO+V9/rDXq8f2BpfNA0pIdDub7uNrd0UKReIpIf0UPb7zcrt6Y2YNYNTdeaZCIj6
         zimS/UksCQiryMrjBQrpuJMZGq7DWVTxUxk3/J31LTpoG9fekkiA6aL+zD7bxhJlDr
         UzP0PfNHsTp5Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: do not clear SYMBOL_DEF_USER when the value is out of range
Date:   Mon,  6 Nov 2023 03:10:47 +0900
Message-Id: <20231105181047.159441-1-masahiroy@kernel.org>
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

When a user-supplied value is out of range, (NEW) and an incorrect default
value are shown.

[Test Kconfig]

  config FOO
          int "foo"
          range 10 20

[Test .config]

  CONFIG_FOO=30

[Result without this fix]

  $ make config
  *
  * Main menu
  *
  foo (FOO) [10] (NEW)

[Result with this fix]

  $ make config
  *
  * Main menu
  *
  foo (FOO) [20]

Currently, the SYMBOL_DEF_USER is cleared if the user input does not
reside within the range. Kconfig forgets the initial value 30, and
prints (NEW) and an incorrect default [10].

Kconfig should remember the user's input. The default should be [20]
because the user's input, 30, is closer to the upper limit of the range.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4a6811d77d18..7fca9cc3ae74 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -594,7 +594,7 @@ int conf_read(const char *name)
 				/* Reset a string value if it's out of range */
 				if (sym_string_within_range(sym, sym->def[S_DEF_USER].val))
 					break;
-				sym->flags &= ~(SYMBOL_VALID|SYMBOL_DEF_USER);
+				sym->flags &= ~SYMBOL_VALID;
 				conf_unsaved++;
 				break;
 			default:
-- 
2.40.1

