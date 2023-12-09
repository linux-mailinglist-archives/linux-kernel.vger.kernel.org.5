Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1451380B341
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjLII1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLII1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:27:32 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40471710
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1702110455;
        bh=1rHF5NqZZARdlfSL9jI3a4CrrhFF0Nl40Xro7fRISFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaIWMQBW/EdwCB+7vbyN6knhlSTUCEnZxFIH2XBm9DQ8tcFyWw0pBYNbHIiJCzsMV
         4vFeoHxFgEGqJUbl4U+6EWpmdSjo1y6z2AWLpgPOuHVtqwDfcpXRrH3nFNC01w4sfn
         tF4Bnn/nULiVkylw2bH/1DeU6spkSQvt6nJkqIYs=
Date:   Sat, 9 Dec 2023 09:27:33 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, w@1wt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: nolibc changes for 6.8
Message-ID: <263f4104-f6e0-4b09-84bd-42412ffeff24@t-8ch.de>
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
 <25a20ebe-e5af-4ba7-890a-6a9ab121e184@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25a20ebe-e5af-4ba7-890a-6a9ab121e184@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-08 16:02:27-0800, Paul E. McKenney wrote:
> On Fri, Dec 08, 2023 at 06:09:59PM +0100, Thomas Weißschuh wrote:
> > Hi Paul,
> > 
> > The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> > 
> >   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next
> > 
> > for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:
> > 
> >   selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)
> 
> Thank you!
> 
> I pulled this in and got the following:
> 
> make run:
> 162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> 
> make run-user:
> 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
> 
> This looks like complete success to me, but please let me know if this
> is not expected behavior on an x86-64 laptop.

This looks good.

FYI you could also use the new run-tests.sh script.
Prerequisites:
* qemu-user and qemu-system binaries for all supported architectures
* /usr/share/edk2/loongarch64/OVMF_CODE.fd for the loongarch system
  tests
* Pass "-p" the first time to download the toolchains.

$ ./run-tests.sh -m system
i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
mips32le:      162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
mips32be:      162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning

$ ./run-tests.sh -m user
i386:          162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
x86_64:        162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
arm64:         162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
arm:           162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
mips32le:      162 test(s): 159 passed,   3 skipped,   0 failed => status: warning
mips32be:      162 test(s): 159 passed,   3 skipped,   0 failed => status: warning
ppc:           162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
ppc64:         162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
ppc64le:       162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
riscv:         162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
s390:          162 test(s): 159 passed,   3 skipped,   0 failed => status: warning
loongarch:     162 test(s): 158 passed,   3 skipped,   1 failed => status: failure

[ Note: loongarch user is currently broken due to a QEMU bug ]

Thomas
