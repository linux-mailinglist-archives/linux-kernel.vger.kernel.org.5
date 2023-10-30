Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098607DB52B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjJ3Icg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:32:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE51A7;
        Mon, 30 Oct 2023 01:32:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 88B1E21981;
        Mon, 30 Oct 2023 08:32:29 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id C0B232CAD5;
        Mon, 30 Oct 2023 08:32:26 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: dummy-tools: Add support for -fpatchable-function-entry
Date:   Mon, 30 Oct 2023 09:32:18 +0100
Message-ID: <20231030083222.28509-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
         ARC_NA(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         BAYES_HAM(-0.00)[13.15%]
X-Spam-Score: 5.49
X-Rspamd-Queue-Id: 88B1E21981
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dummy-gcc does not produce the output
gcc-check-fpatchable-function-entry.sh expects. Add a base64 encoded
output of the second test.

Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 scripts/dummy-tools/gcc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 07f6dc4c5cf6..8ab81a905cc2 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -73,6 +73,25 @@ if arg_contain -Wa,--version "$@"; then
 	exit 0
 fi
 
+if arg_contain -fpatchable-function-entry=2 "$@"; then
+	base64 -d <<-EOF
+	CS5maWxlCSI8c3RkaW4+IgoJLm1hY2hpbmUgcG93ZXI4CgkuYWJpdmVyc2lvbiAyCgkuc2VjdGlv
+	bgkiLnRleHQiCgkuYWxpZ24gMgoJLnAyYWxpZ24gNCwsMTUKCS5nbG9ibCBmdW5jCgkudHlwZQlm
+	dW5jLCBAZnVuY3Rpb24KZnVuYzoKLkxGQjA6CgkuY2ZpX3N0YXJ0cHJvYwouTENGMDoKMDoJYWRk
+	aXMgMiwxMiwuVE9DLi0uTENGMEBoYQoJYWRkaSAyLDIsLlRPQy4tLkxDRjBAbAoJLmxvY2FsZW50
+	cnkJZnVuYywuLWZ1bmMKCS5zZWN0aW9uCV9fcGF0Y2hhYmxlX2Z1bmN0aW9uX2VudHJpZXMsImF3
+	byIsQHByb2diaXRzLC5MUEZFMAoJLmFsaWduIDMKCS44Ynl0ZQkuTFBGRTAKCS5zZWN0aW9uCSIu
+	dGV4dCIKLkxQRkUwOgoJbm9wCglub3AKCWFkZGlzIDksMiwuTEFOQ0hPUjBAdG9jQGhhCglsd2Eg
+	MywuTEFOQ0hPUjBAdG9jQGwoOSkKCWJscgoJLmxvbmcgMAoJLmJ5dGUgMCwwLDAsMCwwLDAsMCww
+	CgkuY2ZpX2VuZHByb2MKLkxGRTA6Cgkuc2l6ZQlmdW5jLC4tZnVuYwoJLmdsb2JsIHgKCS5zZWN0
+	aW9uCSIuYnNzIgoJLmFsaWduIDIKCS5zZXQJLkxBTkNIT1IwLC4gKyAwCgkudHlwZQl4LCBAb2Jq
+	ZWN0Cgkuc2l6ZQl4LCA0Cng6CgkuemVybwk0CgkuaWRlbnQJIkdDQzogKFNVU0UgTGludXgpIDEz
+	LjIuMSAyMDIzMDkxMiBbcmV2aXNpb24gYjk2ZTY2ZmQ0ZWYzZTM2OTgzOTY5ZmI4Y2RkMTk1NmY1
+	NTFhMDc0Yl0iCgkuc2VjdGlvbgkubm90ZS5HTlUtc3RhY2ssIiIsQHByb2diaXRzCg==
+	EOF
+	exit 0
+fi
+
 if arg_contain -S "$@"; then
 	# For scripts/gcc-x86-*-has-stack-protector.sh
 	if arg_contain -fstack-protector "$@"; then
-- 
2.42.0

