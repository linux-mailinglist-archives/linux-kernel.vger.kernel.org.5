Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA377FC36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbjHQQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353207AbjHQQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:37:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0DAE2;
        Thu, 17 Aug 2023 09:37:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0BCC0210DB;
        Thu, 17 Aug 2023 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692290266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=td0f7jevWQxBd9vq5zSpNQzHmoLScSheWh9ycl64mF8=;
        b=qDWmAzp2NMrSIWXAggFQMwzT0ld/nIvwZL+Fx/zU/Hz8RwL1We+jL+4H3WaKbnii41Heja
        UnjkEWHoyH4LUoPVedEaXhWhNQwyjIhOe5H01JI/hwSbPkuH8gKVbjUMcola935WeNJ6ae
        mQxguiNaPUqghtjC0Yr39p9qy2hg9Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692290266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=td0f7jevWQxBd9vq5zSpNQzHmoLScSheWh9ycl64mF8=;
        b=xtiPNNnJVWFA3MbCAKg66OGsf9nwTY6gEMyc0NRGFme+ZwPtPDWS7PV2Wcbn3bxr2CmIkI
        zQNefaJYDND7dsDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA2A42C146;
        Thu, 17 Aug 2023 16:37:45 +0000 (UTC)
Date:   Thu, 17 Aug 2023 18:37:44 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v5 0/5] kmod /usr support
Message-ID: <20230817163744.GD8826@kitsune.suse.cz>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689681454.git.msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 18, 2023 at 02:01:51PM +0200, Michal Suchanek wrote:
> Hello,
> 
> with these patches it is possible to install kernel modules in an arbitrary
> directory - eg. moving the /lib/modules to /usr/lib/modules or /opt/linux.
> 
> While the modprobe.d and depmod.d search which already includes multiple
> paths is expanded to also include $(prefix) the module directory still
> supports only one location, only a different one under $(module_directory).
> 
> Having kmod search multiple module locations while only one is supported now
> might break some assumption about relative module path corresponding to a
> specific file, would require more invasive changes to implement, and is not
> supportive of the goal of moving the modules away from /lib.
> 
> Both kmod and the kernel need to be patched to make use of this feature.
> Patched kernel is backwards compatible with older kmod.  Patched kmod
> with $(module_directory) set to /lib/modules is equivalent to unpatched kmod.

The patch to kernel to support autodetection of module directory is
rejected. However, a workaround like

make MODLIB='$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'

is suggested.

Can you consider inluding the kmod changes?

Thanks

Michal

> 
> Thanks
> 
> Michal
> 
> Link: https://lore.kernel.org/linux-modules/20210112160211.5614-1-msuchanek@suse.de/
> 
> v4: set whole path to module directory instead of adding prefix
> v5: use pkg-config instead of jq, fix build on openssl without sm3 support
> 
> 
> Michal Suchanek (5):
>   configure: Detect openssl sm3 support
>   man/depmod.d: Fix incorrect /usr/lib search path
>   libkmod, depmod: Load modprobe.d, depmod.d from ${prefix}/lib.
>   kmod: Add pkgconfig file with kmod compile time configuration
>   libkmod, depmod, modprobe: Make directory for kernel modules
>     configurable
> 
>  Makefile.am                          |   6 +-
>  configure.ac                         |  30 ++++++++
>  libkmod/libkmod.c                    |  11 +--
>  man/Makefile.am                      |  10 ++-
>  man/depmod.d.xml                     |   9 ++-
>  man/depmod.xml                       |   4 +-
>  man/modinfo.xml                      |   2 +-
>  man/modprobe.d.xml                   |   1 +
>  man/modprobe.xml                     |   2 +-
>  man/modules.dep.xml                  |   6 +-
>  testsuite/module-playground/Makefile |   2 +-
>  testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
>  testsuite/test-depmod.c              |  16 ++--
>  testsuite/test-testsuite.c           |   8 +-
>  tools/depmod.c                       |   7 +-
>  tools/kmod.pc.in                     |  10 +++
>  tools/modinfo.c                      |   4 +-
>  tools/modprobe.c                     |   4 +-
>  tools/static-nodes.c                 |   6 +-
>  19 files changed, 156 insertions(+), 91 deletions(-)
>  create mode 100644 tools/kmod.pc.in
> 
> -- 
> 2.41.0
> 
