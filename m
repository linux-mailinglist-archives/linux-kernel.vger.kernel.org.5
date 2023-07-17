Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6097560B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGQKkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGQKkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:40:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9A98;
        Mon, 17 Jul 2023 03:40:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D67FF1FDA6;
        Mon, 17 Jul 2023 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689590403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MYNN4aTAxMD2vJ3pBJF0snRIYTMXy8161K7Aou3d2k=;
        b=WS+5eWNImhVBJDCDvkrVWBDV9HDJXR8+RiXQ52vFTNrM8DouECuewUsqnvOE9/5ROSZmL2
        xsUPKqi8YFL351X2icxjNodhEBmd7m+DdMhIOPNKpri4sw0ud2JSS4gTn4CGc2hVnGsiNO
        7Knp0Cb6Jdffub+rpZbDtGowCxP086A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689590403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MYNN4aTAxMD2vJ3pBJF0snRIYTMXy8161K7Aou3d2k=;
        b=rPUSu9vh1Cni+M1/kk2iOAcK2oLynaA/YbdmTW6Fjuy+EgW7CVYTj3O0+N62sTdoGk+C6d
        UPRynGrO9OrELmDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 827F32C145;
        Mon, 17 Jul 2023 10:40:03 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH kmod v4 1/4] man/depmod.d: Fix incorrect /usr/lib search path
Date:   Mon, 17 Jul 2023 12:39:50 +0200
Message-ID: <65045e219646b9398857fcfb99e9aefe76e3dbe9.1689589902.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689589902.git.msuchanek@suse.de>
References: <20230711153126.28876-1-msuchanek@suse.de> <cover.1689589902.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

depmod searches /lib/depmod.d but the man page says /usr/lib/depmod.d is
searched. Align the documentation with the code.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Fix commit message typo
---
 man/depmod.d.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/depmod.d.xml b/man/depmod.d.xml
index 76548e92a312..8d3d821cddc8 100644
--- a/man/depmod.d.xml
+++ b/man/depmod.d.xml
@@ -39,7 +39,7 @@
   </refnamediv>
 
   <refsynopsisdiv>
-    <para><filename>/usr/lib/depmod.d/*.conf</filename></para>
+    <para><filename>/lib/depmod.d/*.conf</filename></para>
     <para><filename>/usr/local/lib/depmod.d/*.conf</filename></para>
     <para><filename>/run/depmod.d/*.conf</filename></para>
     <para><filename>/etc/depmod.d/*.conf</filename></para>
-- 
2.41.0

