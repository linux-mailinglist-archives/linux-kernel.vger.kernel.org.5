Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E54757B22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGRMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGRMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:03:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488CD1B1;
        Tue, 18 Jul 2023 05:03:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F12991FD9E;
        Tue, 18 Jul 2023 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689681806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+REwR7wsQIAE1ApjzI4HGQe8QfCO4TfvhKpuDdfqqrg=;
        b=HDu3x6bwe48ck+en1M6NG3glgR/hYvXUhPPLutDmYDhAJ5UvuwrJ0jVC04nu54ibRnVF6b
        ZUnRhNAJFDjUk+lpPlm/ZSpNXaDFsGklX/rUXv1gQhvH5CZZOnFZABZf+6qaQubYPz2O/k
        BzfGSkiInpH6ib1rONMKA0sYZNFjH1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689681806;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+REwR7wsQIAE1ApjzI4HGQe8QfCO4TfvhKpuDdfqqrg=;
        b=HDAsCxVbpCSeBSm67uJoz/0w1Y10TqyGXCUXgPmxSaiIdaXF1aJ/L90tXXjKz82eVNSwDe
        fBC2zdlFCKiI61DQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id DD7B92C142;
        Tue, 18 Jul 2023 12:03:24 +0000 (UTC)
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
Subject: [PATCH kmod v5 0/5] kmod /usr support
Date:   Tue, 18 Jul 2023 14:01:51 +0200
Message-ID: <cover.1689681454.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689589902.git.msuchanek@suse.de>
References: <cover.1689589902.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with these patches it is possible to install kernel modules in an arbitrary
directory - eg. moving the /lib/modules to /usr/lib/modules or /opt/linux.

While the modprobe.d and depmod.d search which already includes multiple
paths is expanded to also include $(prefix) the module directory still
supports only one location, only a different one under $(module_directory).

Having kmod search multiple module locations while only one is supported now
might break some assumption about relative module path corresponding to a
specific file, would require more invasive changes to implement, and is not
supportive of the goal of moving the modules away from /lib.

Both kmod and the kernel need to be patched to make use of this feature.
Patched kernel is backwards compatible with older kmod.  Patched kmod
with $(module_directory) set to /lib/modules is equivalent to unpatched kmod.

Thanks

Michal

Link: https://lore.kernel.org/linux-modules/20210112160211.5614-1-msuchanek@suse.de/

v4: set whole path to module directory instead of adding prefix
v5: use pkg-config instead of jq, fix build on openssl without sm3 support


Michal Suchanek (5):
  configure: Detect openssl sm3 support
  man/depmod.d: Fix incorrect /usr/lib search path
  libkmod, depmod: Load modprobe.d, depmod.d from ${prefix}/lib.
  kmod: Add pkgconfig file with kmod compile time configuration
  libkmod, depmod, modprobe: Make directory for kernel modules
    configurable

 Makefile.am                          |   6 +-
 configure.ac                         |  30 ++++++++
 libkmod/libkmod.c                    |  11 +--
 man/Makefile.am                      |  10 ++-
 man/depmod.d.xml                     |   9 ++-
 man/depmod.xml                       |   4 +-
 man/modinfo.xml                      |   2 +-
 man/modprobe.d.xml                   |   1 +
 man/modprobe.xml                     |   2 +-
 man/modules.dep.xml                  |   6 +-
 testsuite/module-playground/Makefile |   2 +-
 testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
 testsuite/test-depmod.c              |  16 ++--
 testsuite/test-testsuite.c           |   8 +-
 tools/depmod.c                       |   7 +-
 tools/kmod.pc.in                     |  10 +++
 tools/modinfo.c                      |   4 +-
 tools/modprobe.c                     |   4 +-
 tools/static-nodes.c                 |   6 +-
 19 files changed, 156 insertions(+), 91 deletions(-)
 create mode 100644 tools/kmod.pc.in

-- 
2.41.0

