Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BD7C99AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjJOPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:07:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E238C1;
        Sun, 15 Oct 2023 08:07:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4ABC433C8;
        Sun, 15 Oct 2023 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697382461;
        bh=dU1+zDYs7o2q2RyXQXfsLvbPI75qe4jPmXKLwqHpNjs=;
        h=From:To:Cc:Subject:Date:From;
        b=kUDwoaquaJQbE1ONP2vp9wPrN7ncHWGBFL6m91dmVUkxlJ3uAmC2KBxoDytDNlWcE
         CEIPSbmIUYSy4DAwqAqfwoBwLkCl5JHKbZGx7ERjEud6aR7JEIE5VubhWnTqFmj8W/
         NZJ37GeaQPocx2XDwTjSDabpSsCfdc7f+2czlO2ou7pg62/RkWeHEoVP/r3Evo+4/m
         JVeylgrrKMt85nJrfbqKJiNJhguFN3EZX4Yg0Eq5oNuk/9GOl+GdrgzmqB84i1+fF+
         hEFQCN9YOuzsVPrzzraEcVKTki/j42HLNF5y/VQm0D8+/ZJwdjNhZyveazDNhIWJMV
         GvBHcipTN38/g==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, alx@kernel.org,
        mtk.manpages@gmail.com, alx.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] set_thread_area.2: Add C-SKY document
Date:   Sun, 15 Oct 2023 11:07:32 -0400
Message-Id: <20231015150732.1991997-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

C-SKY only needs set_thread_area, no need for get_thread_area, the
same as MIPS.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 man2/set_thread_area.2 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/man2/set_thread_area.2 b/man2/set_thread_area.2
index 02f65e0418f2..c43a92eb447a 100644
--- a/man2/set_thread_area.2
+++ b/man2/set_thread_area.2
@@ -26,7 +26,7 @@ Standard C library
 .B "int syscall(SYS_get_thread_area);"
 .BI "int syscall(SYS_set_thread_area, unsigned long " tp );
 .PP
-.B #elif defined __mips__
+.B #elif defined(__mips__ || defined __csky__)
 .PP
 .BI "int syscall(SYS_set_thread_area, unsigned long " addr );
 .PP
@@ -42,17 +42,17 @@ These calls provide architecture-specific support for a thread-local storage
 implementation.
 At the moment,
 .BR set_thread_area ()
-is available on m68k, MIPS, and x86 (both 32-bit and 64-bit variants);
+is available on m68k, MIPS, C-SKY, and x86 (both 32-bit and 64-bit variants);
 .BR get_thread_area ()
 is available on m68k and x86.
 .PP
-On m68k and MIPS,
+On m68k, MIPS and C-SKY,
 .BR set_thread_area ()
 allows storing an arbitrary pointer (provided in the
 .B tp
 argument on m68k and in the
 .B addr
-argument on MIPS)
+argument on MIPS and C-SKY)
 in the kernel data structure associated with the calling thread;
 this pointer can later be retrieved using
 .BR get_thread_area ()
@@ -139,7 +139,7 @@ return 0 on success, and \-1 on failure, with
 .I errno
 set to indicate the error.
 .PP
-On MIPS and m68k,
+On C-SKY, MIPS and m68k,
 .BR set_thread_area ()
 always returns 0.
 On m68k,
-- 
2.36.1

