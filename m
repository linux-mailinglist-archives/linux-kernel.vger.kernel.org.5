Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9267E8058
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjKJSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344605AbjKJSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1F3304A;
        Fri, 10 Nov 2023 04:14:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 90AEA1F8BA;
        Fri, 10 Nov 2023 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699618453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX78m2JYGrcXwvspyj484zbVEclz63Eiy31NhDT1SqE=;
        b=gz1b7hYgVM8aTGLAO9EXAnuAVrRCsOXzuoaxKeBcYbA+BGx1eIboZbd/4IXe9JXqnaa/9D
        44ZoRU58k+QpTCi4eYEZOT49G8gv7WiQHsL3AQwrs4ftfAdgLZovDEmunM0rR+BCCvpf7R
        9cWTcDyo6dMgO1AiSQtm9um+GSvHe0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699618453;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX78m2JYGrcXwvspyj484zbVEclz63Eiy31NhDT1SqE=;
        b=rTSBa9WaqhbHY9bRIESTtwbSEBeyelSuzacqbhDKRwodTmmZIdlcfZqCTq6dTRcg0LkrQj
        ai3HigrTzvAP4vBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id E0CB42C29B;
        Fri, 10 Nov 2023 12:14:12 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kmod /usr support
Date:   Fri, 10 Nov 2023 13:13:53 +0100
Message-ID: <cover.1699618135.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
References: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
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

Hello,

This is resend of the last patch in the series that adds prefix support
to kernel module location together with additional patch for validating
the user supplied input to options that are interpreted as directories.

Thanks

Michal

Michal Suchanek (2):
  libkmod, depmod, modprobe: Make directory for kernel modules
    configurable
  configure: Check that provided paths are absolute

 Makefile.am                          |   3 +-
 configure.ac                         |  24 ++++++
 libkmod/libkmod.c                    |   4 +-
 man/Makefile.am                      |   1 +
 man/depmod.d.xml                     |   6 +-
 man/depmod.xml                       |   4 +-
 man/modinfo.xml                      |   2 +-
 man/modprobe.xml                     |   2 +-
 man/modules.dep.xml                  |   6 +-
 testsuite/module-playground/Makefile |   2 +-
 testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
 testsuite/test-depmod.c              |  16 ++--
 testsuite/test-testsuite.c           |   8 +-
 tools/depmod.c                       |   6 +-
 tools/kmod.pc.in                     |   1 +
 tools/modinfo.c                      |   4 +-
 tools/modprobe.c                     |   4 +-
 tools/static-nodes.c                 |   6 +-
 18 files changed, 124 insertions(+), 84 deletions(-)

-- 
2.42.0

