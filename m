Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB962756D37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjGQT2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGQT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:28:34 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA5E1;
        Mon, 17 Jul 2023 12:28:32 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 729DD58780BF4; Mon, 17 Jul 2023 21:28:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 708FB60D4A023;
        Mon, 17 Jul 2023 21:28:30 +0200 (CEST)
Date:   Mon, 17 Jul 2023 21:28:30 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
In-Reply-To: <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
Message-ID: <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <cover.1689589902.git.msuchanek@suse.de> <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 2023-07-17 12:39, Michal Suchanek wrote:

>modprobe.d is now searched under ${prefix}/lib, add ${module_directory} to
>specify the directory where to search for kernel modules.
>
>With this distributions that do not want to ship files in /lib can also
>move kernel modules to /usr while others can keep them in /lib.

This patch breaks kernel builds/installation.

 * assume $distro has given me a kmod that has your submission included,
   and such kmod was ./configure'd --with-module-directory=/usr/lib/modules

With such a kmod, the module installation of current and past kernels
is not possible, in other words, ** bisecting kernels ** is broken:


$ make modules_install INSTALL_MOD_PATH=$PWD/rt V=1
[...]
# INSTALL /tmp/linux/rt/lib/modules/6.4.3/kernel/virt/lib/irqbypass.ko
  mkdir -p /tmp/linux/rt/lib/modules/6.4.3/kernel/virt/lib/; cp virt/lib/irqbypass.ko /tmp/linux/rt/lib/modules/6.4.3/kernel/virt/lib/irqbypass.ko
[...]
# DEPMOD  /tmp/linux/rt/lib/modules/6.4.3
  sh ./scripts/depmod.sh depmod 6.4.3
depmod: ERROR: could not open directory /tmp/linux/rt/usr/lib/modules/99.98.6.4.3: No such file or directory
depmod: FATAL: could not search modules: No such file or directory
make: *** [Makefile:1956: modules_install] Error 1
