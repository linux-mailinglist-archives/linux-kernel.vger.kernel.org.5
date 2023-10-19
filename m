Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766567CF173
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjJSHjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbjJSHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:53 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D23C124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:50 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 3BBC012000D;
        Thu, 19 Oct 2023 10:38:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3BBC012000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697701128;
        bh=8EUTHmA8KnT2ITQYRQVP7dMugb9aOlZWZtyYH44SnBU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=RJqzeRRENG7CfJEsIsI0BPnh5KtG1+wukdYnK7byqgLTlFaupDaqKma3G7URgTM9C
         wCmSQJvYf3YEb+FY7krEBmJIz53ud6CA0apGGhJABXEYd8FB9B2vq3LFfR9XDtv9mT
         WxJ/D+b6Qyp2rRRQAUPQLG1OIvF79Nkf+D47uGn9v4R+1astZEwtOansqJLyNXsTu0
         7b3158RxtGXZ3eIfk+fUr/xKzFimL2q4evzH6uNbTsa0dkN09akJv1RZHrsMoacf0T
         dq1R9L1MYZaP1hLFDtgEQEAkjS4L/FqL8nzl7MVE9GaxldL0dMnKDj2bgSo7BzNOQd
         7fXkG7gx4Md+Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 10:38:48 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 19 Oct 2023 10:38:47 +0300
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Yu Zhe <yuzhe@nfschina.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 2/2] jffs2: make cleanmarker support option
Date:   Thu, 19 Oct 2023 10:38:38 +0300
Message-ID: <20231019073838.17586-3-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180720 [Oct 19 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 541 541 6f62a06a82e8ec968d29b8e7c7bba6aeceb34f57, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/19 05:18:00 #22229383
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch support for disable cleanmarker option. This is useful on
some NAND devices which entire OOB area is protected by ECC. Problem
fires when JFFS2 driver writes cleanmarker to some page and later it
tries to write to this page - write will be done successfully, but after
that such page becomes unreadable due to invalid ECC codes. This occurs
because the second write necessitates an update to ECC, but it is
impossible to do it correctly without block erase.

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 fs/jffs2/Kconfig    | 10 ++++++++++
 fs/jffs2/os-linux.h |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 7c96bc107218..8a66941d1e93 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -29,6 +29,16 @@ config JFFS2_FS_DEBUG
 	  If reporting bugs, please try to have available a full dump of the
 	  messages at debug level 1 while the misbehaviour was occurring.
 
+config JFFS2_FS_NOCLEANMARKER
+	bool "Disable cleanmarkers JFFS2 feature"
+	depends on JFFS2_FS_WRITEBUFFER
+	depends on MTD_NAND || MTD_SPI_NAND
+	default n
+	help
+	  Do not write 'CLEANMARKER' nodes to the beginning of each erase block.
+	  This option can be useful on NAND flash where there is no free
+	  space in the OOB area or the entire OOB area is protected by ECC.
+
 config JFFS2_FS_WRITEBUFFER
 	bool "JFFS2 write-buffering support"
 	depends on JFFS2_FS
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index c604f639a00f..ea42964d8118 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -109,7 +109,9 @@ static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
 #define jffs2_can_mark_obsolete(c) (c->mtd->flags & (MTD_BIT_WRITEABLE))
 #endif
 
-#define jffs2_cleanmarker_oob(c) (c->mtd->type == MTD_NANDFLASH)
+#define jffs2_cleanmarker_oob(c)			\
+	(!IS_ENABLED(CONFIG_JFFS2_FS_NOCLEANMARKER) &&	\
+	((c)->mtd->type == MTD_NANDFLASH))
 
 #define jffs2_wbuf_dirty(c) (!!(c)->wbuf_len)
 
-- 
2.40.0

