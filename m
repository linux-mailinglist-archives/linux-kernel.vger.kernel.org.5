Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2C79A544
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjIKIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjIKIBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:01:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC159BB;
        Mon, 11 Sep 2023 01:01:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 749D11F38D;
        Mon, 11 Sep 2023 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694419289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc;
        bh=6itrlTfHSmO99MfE7NAbLdU9YS0CJgPDLtuNCYJ8Yps=;
        b=hSy/0bU2Gy29rUOLalrzqxje69Bm1z5bVULbGKS7lqVlECloMcxd0zHeD0c7qQ3R/87668
        chYbCHyKZiafZbyE2msUbuvLIe31xL0wAiH/9nBN/FRi23atmG4xXDPSU6rfabtWayLSOY
        +bHSGm2hwG/ydbCViO3M+AveQo+W8rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694419289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc;
        bh=6itrlTfHSmO99MfE7NAbLdU9YS0CJgPDLtuNCYJ8Yps=;
        b=wU1myPCNw6AJyFLjQTur+2NvESVhBCBdoG9uUVLTs1uBLEO8CMNUsgdTokpt6TN7mKloWn
        vSpP61/km5gix4BA==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn2.prg.suse.de [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 608272C142;
        Mon, 11 Sep 2023 08:01:29 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 38BA12016B; Mon, 11 Sep 2023 10:01:29 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] kbuild: avoid long argument lists in make modules_install
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230911080129.38BA12016B@lion.mk-sys.cz>
Date:   Mon, 11 Sep 2023 10:01:29 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make modules_install" may fail with

  make[2]: execvp: /bin/sh: Argument list too long

if many modules are built and INSTALL_MOD_PATH is long. This is because
scripts/Makefile.modinst creates all directories with one mkdir command.
Use $(foreach ...) instead to prevent an excessive argument list.

Fixes: 2dfec887c0fd ("kbuild: reduce the number of mkdir calls during modules_install")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 scripts/Makefile.modinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index c59cc57286ba..346f5ec50682 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -113,7 +113,7 @@ quiet_cmd_sign :=
 endif
 
 # Create necessary directories
-$(shell mkdir -p $(sort $(dir $(install-y))))
+$(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
 $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
 	$(call cmd,install)
-- 
2.42.0

