Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE757560B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGQKkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGQKkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:40:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D196A83;
        Mon, 17 Jul 2023 03:40:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83B8821923;
        Mon, 17 Jul 2023 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689590403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUec1+EitZahVX/PmsSDqXXCbGH3k6qkThntzyMYwBE=;
        b=PdA1u9+ezNuB4QcKhWJap3NtjoAlviQRb5xVemfpfO+bu5sHORVeyTdMu/GR8a3RX75r9E
        2gngUyW3LB3wtjMLgHvY1JYkVLEXI4DhhalmyOZnEzhoxsArrFtHhPL9/l356Cib3QCrWl
        DeRHojVFtTl5zjZxB0ZN/1yJ6/2+pus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689590403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUec1+EitZahVX/PmsSDqXXCbGH3k6qkThntzyMYwBE=;
        b=zy2RnRLU6aR9cgMn1nERiTadxzietXO1gVmV8OQQ1VFNijHMWwy9iUcdY4mPy46I74P68S
        oxnMcEfRtVm/JhCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 2512A2C142;
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
Subject: [PATCH kmod v4 0/4] kmod /usr support
Date:   Mon, 17 Jul 2023 12:39:49 +0200
Message-ID: <cover.1689589902.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711153126.28876-1-msuchanek@suse.de>
References: <20230711153126.28876-1-msuchanek@suse.de>
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

With this patch the kmod tool can spit out a JSON with the tool build-time
configuration, and jq is used for getting a single value out of that.

I opted for this because crating .pc files requires putting the logic into the
autohell files which is very clumsy. Also pkg-config insists on hiding
the actual .pc file data and only allowing clumsy queries through its
commandline interface.

jq has its downsides, too. So far it is not used by kernel build, only
by other tools shipped with the kernel. This adds another dependency for
kernel builds.

It turns out that the kernel already does use pkg-config. There are two
alternate spellings: pkg-config and pkgconfig. Searching for the latter
gives a few matches in the kernel giving off the impression that it's a
thing but not really used.

Thanks

Michal

Link: https://lore.kernel.org/linux-modules/20210112160211.5614-1-msuchanek@suse.de/


Michal Suchanek (4):
  man/depmod.d: Fix incorrect /usr/lib search path
  libkmod, depmod: Load modprobe.d, depmod.d from $prefix/lib.
  kmod: Add config command to show compile time configuration as JSON
  libkmod, depmod, modprobe: Make directory for kernel modules
    configurable

 Makefile.am                          |   4 +-
 configure.ac                         |   7 ++
 libkmod/libkmod.c                    |  11 +--
 man/Makefile.am                      |  10 ++-
 man/depmod.d.xml                     |   9 ++-
 man/depmod.xml                       |   4 +-
 man/kmod.xml                         |   6 ++
 man/modinfo.xml                      |   2 +-
 man/modprobe.d.xml                   |   1 +
 man/modprobe.xml                     |   2 +-
 man/modules.dep.xml                  |   6 +-
 testsuite/module-playground/Makefile |   2 +-
 testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
 testsuite/test-depmod.c              |  16 ++--
 testsuite/test-testsuite.c           |   8 +-
 tools/depmod.c                       |   7 +-
 tools/kmod.c                         |  41 ++++++++++
 tools/modinfo.c                      |   4 +-
 tools/modprobe.c                     |   4 +-
 tools/static-nodes.c                 |   6 +-
 20 files changed, 169 insertions(+), 90 deletions(-)

-- 
2.41.0

