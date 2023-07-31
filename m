Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDEB769379
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGaKuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjGaKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:45 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1511FC6;
        Mon, 31 Jul 2023 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690800557; bh=CtmLGedeOhA+k4A2HHh192GITcfJNCuswikbzDnlh0o=;
        h=From:To:Cc:Subject:Date:From;
        b=nmmSZgYoGKlfewgxbHrjHsFasD/kNYgxsclpfDhrCmkn6zr+sXls2Y3iouqqyh1VM
         MhIkMGG62Ql7CvuMK1rblBGp6re+F4blCWPrXjspeAS39figEBqUjdVVNgw/5hnKFl
         FfTrbvw42iK0f4Xyj9XRelzuOSkbvv1g3QnBuMmI=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id CA165600A6;
        Mon, 31 Jul 2023 18:49:17 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 0/5] raid6: raid6test build fixes and cleanups
Date:   Mon, 31 Jul 2023 18:49:06 +0800
Message-Id: <20230731104911.411964-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
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

From: WANG Xuerui <git@xen0n.name>

Hi,

While working on porting the RAID6 math to the LoongArch SIMD
extensions, I found out the raid6test tool build is broken for some
time (seemingly on all arches), so I took some time to fix it and did
some cleanups while at it.

Before the fix:

> In file included from ../../../include/linux/export.h:5,
>                  from recov.c:16:
> ../../../include/linux/compiler.h:246:10: fatal error: asm/rwonce.h: No such file or directory
>   246 | #include <asm/rwonce.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> make: *** [Makefile:58: recov.o] Error 1

After the fix I was able to build and test it on x86_64 and loongarch64,
with clean `git status` output after building.

WANG Xuerui (5):
  raid6: remove the <linux/export.h> include from recov.c
  raid6: guard the tables.c include of <linux/export.h> with __KERNEL__
  raid6: test: cosmetic cleanups for the test Makefile
  raid6: test: make sure all intermediate and artifact files are
    .gitignored
  raid6: test: only check for Altivec if building on powerpc hosts

 lib/raid6/mktables.c      |  2 ++
 lib/raid6/recov.c         |  1 -
 lib/raid6/test/.gitignore |  2 ++
 lib/raid6/test/Makefile   | 50 ++++++++++++++++++++-------------------
 4 files changed, 30 insertions(+), 25 deletions(-)
 create mode 100644 lib/raid6/test/.gitignore

-- 
2.40.0

