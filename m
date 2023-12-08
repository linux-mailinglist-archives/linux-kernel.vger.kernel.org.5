Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5980AA2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjLHRKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjLHRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:10:03 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAADF19A7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1702055399;
        bh=xBWo+VpmEkoOfW1CY3VNVI0J6iDIDAJWCe6gVJx783I=;
        h=Date:From:To:Cc:Subject:From;
        b=dkUFLNsqpZOvIGHfCS+RhPNem0hPP3BVvOEOgezW8gaYNuiZH3b+5sDB/wVq14isO
         lo6lDgKTVCIFcVJLwIo7JJVSehpOQquw6sny6e1l8ma1cFKA2Mddsqx8ytlzUxZT1x
         H2oBE0ONqcwQ62sT9uoM2L4rr/7YaI8E172GXLuM=
Date:   Fri, 8 Dec 2023 18:09:59 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: nolibc changes for 6.8
Message-ID: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Hi Paul,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next

for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:

  selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)

----------------------------------------------------------------
Summary:

* Support for PIC mode on MIPS.
* Support for getrlimit()/setrlimit().
* Replace some custom declarations with UAPI includes.
* A new script "run-tests.sh" to run the testsuite over different architectures
  and configurations.
* A few non-functional code cleanups.
* Minor improvements to nolibc-test, primarily to support the test script.

There are no urgent fixes available at this time.

----------------------------------------------------------------
Mark Brown (1):
      tools/nolibc: Use linux/wait.h rather than duplicating it

Thomas Weißschuh (21):
      selftests/nolibc: don't hang on config input
      selftests/nolibc: use EFI -bios for LoongArch qemu
      selftests/nolibc: anchor paths in $(srcdir) if possible
      selftests/nolibc: support out-of-tree builds
      selftests/nolibc: add script to run testsuite
      tools/nolibc: error out on unsupported architecture
      tools/nolibc: move MIPS ABI validation into arch-mips.h
      selftests/nolibc: use XARCH for MIPS
      selftests/nolibc: explicitly specify ABI for MIPS
      selftests/nolibc: extraconfig support
      selftests/nolibc: add configuration for mipso32be
      selftests/nolibc: fix testcase status alignment
      selftests/nolibc: introduce QEMU_ARCH_USER
      selftests/nolibc: run-tests.sh: enable testing via qemu-user
      tools/nolibc: mips: add support for PIC
      selftests/nolibc: make result alignment more robust
      tools/nolibc: annotate va_list printf formats
      tools/nolibc: drop duplicated testcase ioctl_tiocinq
      tools/nolibc: drop custom definition of struct rusage
      tools/nolibc: add support for getrlimit/setrlimit
      selftests/nolibc: disable coredump via setrlimit

 tools/include/nolibc/arch-mips.h             |  11 +-
 tools/include/nolibc/arch.h                  |   4 +-
 tools/include/nolibc/stdio.h                 |   4 +-
 tools/include/nolibc/sys.h                   |  38 ++++++
 tools/include/nolibc/types.h                 |  25 +---
 tools/testing/selftests/nolibc/.gitignore    |   1 +
 tools/testing/selftests/nolibc/Makefile      |  65 ++++++++---
 tools/testing/selftests/nolibc/nolibc-test.c |  51 ++++++--
 tools/testing/selftests/nolibc/run-tests.sh  | 169 +++++++++++++++++++++++++++
 9 files changed, 318 insertions(+), 50 deletions(-)
 create mode 100755 tools/testing/selftests/nolibc/run-tests.sh


Thanks,
Thomas
