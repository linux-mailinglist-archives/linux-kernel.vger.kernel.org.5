Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F547BA75F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjJERMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjJERMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:12:10 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C661A3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696525241;
        bh=XJfHEXVj41opqthiiRW86PzlGVbMQ3PRnc0rzAP6Idk=;
        h=Date:From:To:Cc:Subject:From;
        b=D5TggrKaMcAdNTcxx5F0SX/IQZAbd3gtg8eGPFlTYef5oir06Yi7RDY8aUuRl89A/
         xF/+jFsoYqUmLex542nXQga1tdsPlcKk+U4ttiPo2IiQb7KUWgPw/VDqQducL9IK5H
         rw0iCc3bnAuTRaADwAbCZmAtErpVa2PKoH8kk3NY=
Date:   Thu, 5 Oct 2023 19:00:40 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

I'd like to test the current state of nolibc in linux-next.
Could pull the request below into your nolibc branch?

I'll do some manual tests this weekend, too.


Thanks,
Thomas


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next

for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:

  tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)

----------------------------------------------------------------
Ammar Faizi (5):
      tools/nolibc: i386: Fix a stack misalign bug on _start
      tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
      tools/nolibc: x86-64: Use `rep stosb` for `memset()`
      tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
      tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function

Thomas Weißschuh (9):
      tools/nolibc: add stdarg.h header
      selftests/nolibc: use -nostdinc for nolibc-test
      selftests/nolibc: libc-test: avoid -Wstringop-overflow warnings
      MAINTAINERS: nolibc: update tree location
      selftests/nolibc: don't embed initramfs into kernel image
      selftests/nolibc: allow building i386 with multiarch compiler
      tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks
      tools/nolibc: don't define new syscall number
      tools/nolibc: automatically detect necessity to use pselect6

 MAINTAINERS                                  |  2 +-
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/arch-aarch64.h          |  3 --
 tools/include/nolibc/arch-i386.h             |  4 +-
 tools/include/nolibc/arch-loongarch.h        |  4 +-
 tools/include/nolibc/arch-riscv.h            |  3 --
 tools/include/nolibc/arch-x86_64.h           | 42 ++++++++++++++++++++
 tools/include/nolibc/nolibc.h                |  4 +-
 tools/include/nolibc/stdarg.h                | 16 ++++++++
 tools/include/nolibc/stdio.h                 |  3 +-
 tools/include/nolibc/string.h                | 36 +++++++-----------
 tools/include/nolibc/sys.h                   | 57 ++++++++++++++++------------
 tools/testing/selftests/nolibc/Makefile      | 45 +++++++++++++---------
 tools/testing/selftests/nolibc/nolibc-test.c |  6 +--
 14 files changed, 144 insertions(+), 82 deletions(-)
 create mode 100644 tools/include/nolibc/stdarg.h
