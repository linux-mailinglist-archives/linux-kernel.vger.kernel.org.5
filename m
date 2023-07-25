Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2905761862
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGYMau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjGYMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A725C11A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ACC5616B4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D55C433C8;
        Tue, 25 Jul 2023 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690288247;
        bh=5eBs8PdJXRg5fyRZxKrJK1Hfaval0vFUdgh3dE+YiuY=;
        h=From:To:Cc:Subject:Date:From;
        b=tpe/KYFZ+zH6LHNBZoeC+oAkadPO+pXt5kv98U6ekk6q+utMGxiuP6kDnn4/lDh51
         ks3WLs9k3Dgx0zwD86KyU97rDeDpyMMdzSlh1s5lG9flSfYrdSgh+hUPzBuDhw/RZg
         f7zJggwfWpp41Gat3DFw9GA0yYrwU/mq5yjWaheTD12hoVMcEXsGCSsaPXXaBLGJJY
         hTGvZjuba/Gu8vF4qBCnwOSkt9bw4EAoYjob3RoJllYI16La/Jd0Dcw4X8EKFQGlg7
         UtM6XCsEKxZYee5uvSwqYQwxKh7MYP7JOxs7D7YYhxM/gJ/JpmUo6A/ueZda61B4ae
         L5JpCS6Ihjn+g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] gcov: shut up missing prototype warnings for internal stubs
Date:   Tue, 25 Jul 2023 14:23:38 +0200
Message-Id: <20230725123042.2269077-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcov uses global functions that are called from generated code,
but these have no prototype in a header, which causes a W=1
build warning:

kernel/gcov/gcc_base.c:12:6: error: no previous prototype for '__gcov_init' [-Werror=missing-prototypes]
kernel/gcov/gcc_base.c:40:6: error: no previous prototype for '__gcov_flush' [-Werror=missing-prototypes]
kernel/gcov/gcc_base.c:46:6: error: no previous prototype for '__gcov_merge_add' [-Werror=missing-prototypes]
kernel/gcov/gcc_base.c:52:6: error: no previous prototype for '__gcov_merge_single' [-Werror=missing-prototypes]

Just turn off these warnings unconditionally for the two files
that contain them.

Link: https://lore.kernel.org/all/0820010f-e9dc-779d-7924-49c7df446bce@linux.ibm.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/gcov/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index 16f8ecc7d8821..ccd02afaeffb4 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -3,4 +3,6 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
 obj-y := base.o fs.o
 obj-$(CONFIG_CC_IS_GCC) += gcc_base.o gcc_4_7.o
+CFLAGS_gcc_base.o += -Wno-missing-prototypes -Wno-missing-declarations
 obj-$(CONFIG_CC_IS_CLANG) += clang.o
+CFLAGS_clang.o += -Wno-missing-prototypes -Wno-missing-declarations
-- 
2.39.2

