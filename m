Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7C7BFFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjJJPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjJJPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:08:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3593AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:08:43 -0700 (PDT)
Message-ID: <20231010145130.987300357@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=prHCTxNxZ5B1ZFd6qhXarZL1ID3t1WRHiphgWL880RQ=;
        b=YtTHQmcUbg8vMxIhnSh9eukJugWmXDm/8qz4rNPvPrV9zCKFMJMiVaRxnQFn/JQcxZF3M5
        SFJsYjBgsB/kih0GtE2ZRXD+I7t3absx9HrLHgPxIVSKow32y4SbwDgiaJ7Hr6aNfrcv/F
        HFPF0ScbHfKczTNbY4GK1nZEHQ2BSJKeaH2qzfHjLiQ9ECxtKp3UCXh0Vy+leFEDHlFdmk
        ykLfUSRhzvNIlb/lahfHJ/DrpWwAmPbE2kvqQs0c7Bgkqvo1kbflBnCJQSS65woRutLGIB
        QCAgm/0cDZf7ubLMeyuUxqDGCE7keXa0/JtvtiWz9nZLOA7etHXwJZLierxtew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=prHCTxNxZ5B1ZFd6qhXarZL1ID3t1WRHiphgWL880RQ=;
        b=+GBzg72sZ+zLY/HxaPfUX616ePveXSjzQ5+IY3p4T1Ide3+YnRCWkrRyGje5Vvcs74wCVJ
        wgj/w/rGwyUwTECw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch 0/5] x86/microcode/amd: Use cached microcode for early loading
Date:   Tue, 10 Oct 2023 17:08:40 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Borislav applied the microcode overhaul series:

     https://lore.kernel.org/all/20231002115506.217091296@linutronix.de/

he partially reverted patch 15:

     https://lore.kernel.org/all/20231006132617.GOZSAK+YCEwVsEuUdr@fat_crate.local/

to keep AMD suspend/resume working.

After looking at this in detail it turned out that AMD does not use the
microcode cache for the early loading during AP bringup and tries to find
the microcode in builtin/initrd.

That in turn requires to have a CPU hotplug callback for late hotplug which
ensures that the microcode is updated. That's actually too late as CPUID
bits are evaluated already before that callback is invoked.

The reason why this was done is the horrible 32bit hack which invoked the
early loader before paging is enabled.

That's gone now which in turn allows to remove all this by initializing the
microcode cache before the APs are brought up and use the microcode cache
for early loading on APs during boot, manual hotplug and resume.

This gets finally rid of the hotplug callback and the ugly initrd_gone
hackery which was required to make the post init AP loader work.

The series applies on top of:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode

Thanks,

	tglx
---
 amd.c      |   34 +++++++++++++++++++++-------------
 core.c     |   44 +++-----------------------------------------
 internal.h |    4 ----
 3 files changed, 24 insertions(+), 58 deletions(-)

