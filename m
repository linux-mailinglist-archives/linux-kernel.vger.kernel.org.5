Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759477DCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbjHPIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbjHPIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07431198C;
        Wed, 16 Aug 2023 01:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9931D66345;
        Wed, 16 Aug 2023 08:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940A6C433C7;
        Wed, 16 Aug 2023 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692176006;
        bh=W6H+YmdxNnL5Y2clvk2f8BlKz84U9aaSlefeeFikQRE=;
        h=From:To:Cc:Subject:Date:From;
        b=F3rhb0tzadu2284PcYbX+zLkzqhCL6c//bRfYIALors43WF0RgNfJOXrvXChMOqcn
         G/GuNU0X+NOXjL79+Ln4GGOZMvaWNTYKzUJ2080CRpt+LmsEOmQd1dvKpM0ODW6kl0
         xnY2eAogaoLXyl/ZTjDSNDuwwQqTyASZzc+waYlbaQi1VirIq44jQAW3CbGdTophof
         K5O/Y6M2Sh+8A48fhDO+aTNtI+dRlD0gWF9Yla+c+uYuh/I8o+JSw1tX9DOZFDeR5N
         zNfKLk05mXwMS4N00Vv9jsgkgmK5HmpqF08LotDFdMT1PGVNkESelLIpyzuM4Qbegr
         XOpwtiJYNUFSQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tty: gdm724x: use min_t() for size_t varable and a constant
Date:   Wed, 16 Aug 2023 10:53:22 +0200
Message-ID: <20230816085322.22065-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My thinking was that ulong is the same as size_t everywhere. No, size_t
is uint on 32bit. So the below commit introduced a build warning on
32bit:
.../gdm724x/gdm_tty.c:165:24: warning: comparison of distinct pointer types ('typeof (2048UL) *' (aka 'unsigned long *') and 'typeof (remain) *' (aka 'unsigned int *'))

To fix this, partially revert the commit (remove constants' suffixes)
and switch to min_t() in this case instead.

/me would hope for Z (or alike) suffix for constants.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: c3e5c706aefc (tty: gdm724x: convert counts to size_t)
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308151953.rNNnAR2N-lkp@intel.com/
---
 drivers/staging/gdm724x/gdm_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 67d9bf41e836..32b2e817ff04 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -17,9 +17,9 @@
 #define GDM_TTY_MAJOR 0
 #define GDM_TTY_MINOR 32
 
-#define WRITE_SIZE 2048UL
+#define WRITE_SIZE 2048
 
-#define MUX_TX_MAX_SIZE 2048UL
+#define MUX_TX_MAX_SIZE 2048
 
 static inline bool gdm_tty_ready(struct gdm *gdm)
 {
@@ -159,7 +159,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 		return -ENODEV;
 
 	while (remain) {
-		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
+		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
 					sending_len,
-- 
2.41.0

