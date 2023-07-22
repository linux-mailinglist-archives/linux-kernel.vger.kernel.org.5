Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE375DE81
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGVUZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVUZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:25:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA3E53;
        Sat, 22 Jul 2023 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ckF5uzEFufQEKYVxqbdce/JxmD3mK6cI1pFBk6E9mkc=; b=Lwb7lND9giJ52mvXwwt1fOz/5u
        7pit70GJJg6Djs/am+jNOkek/6mxF5Plf+wEd+XfpYt9bsupz2NZU/hmAE52Qc01lYx5JHlFwbdQF
        ixBJefX2FNqG+7R8cmgdNmxNgsQnD5DNaIK2VQvBavQoTNLWcR4g3jiNkVh16XUe/4w+yipCZwwvj
        1guRxGeGE35iMYOUrutFCryB5WUL7/Zpav53dLbLqBjuI4aPjzkKVVW80urfmsoIQ8rJn1X1UkSlV
        iueSmXOeP6+wojXukF6ZgaKxImif7YfdXMnA7pyFfX9MI4xJj7TU197ui3eX454iC/az2Yiq16RD5
        Zm07eHMg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNJAj-00HFUy-20;
        Sat, 22 Jul 2023 20:25:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Tejun Heo <tj@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] um/drivers: Kconfig: fix hostaudio build errors
Date:   Sat, 22 Jul 2023 13:25:48 -0700
Message-ID: <20230722202548.24746-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "select"s to ensure that the required kconfig symbols are set
as expected.

This fixes build errors when CONFIG_SOUND is not set.

ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_module':
hostaudio_kern.c:(.exit.text+0xa): undefined reference to `unregister_sound_mixer'
ld: hostaudio_kern.c:(.exit.text+0x15): undefined reference to `unregister_sound_dsp'
ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module':
hostaudio_kern.c:(.init.text+0x19): undefined reference to `register_sound_dsp'
ld: hostaudio_kern.c:(.init.text+0x31): undefined reference to `register_sound_mixer'
ld: hostaudio_kern.c:(.init.text+0x49): undefined reference to `unregister_sound_dsp'

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: d886e87cb82b ("sound: make OSS sound core optional")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202307141416.vxuRVpFv-lkp@intel.com
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
---
 arch/um/drivers/Kconfig |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -111,24 +111,15 @@ config SSL_CHAN
 
 config UML_SOUND
 	tristate "Sound support"
+	select SOUND
+	select SOUND_OSS_CORE
+	select HOSTAUDIO
 	help
 	  This option enables UML sound support.  If enabled, it will pull in
 	  soundcore and the UML hostaudio relay, which acts as a intermediary
 	  between the host's dsp and mixer devices and the UML sound system.
 	  It is safe to say 'Y' here.
 
-config SOUND
-	tristate
-	default UML_SOUND
-
-config SOUND_OSS_CORE
-	bool
-	default UML_SOUND
-
-config HOSTAUDIO
-	tristate
-	default UML_SOUND
-
 endmenu
 
 menu "UML Network Devices"
