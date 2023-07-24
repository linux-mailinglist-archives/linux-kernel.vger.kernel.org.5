Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7975F812
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGXNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGXNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:18:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE55DDA;
        Mon, 24 Jul 2023 06:18:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AA09FEC;
        Mon, 24 Jul 2023 06:19:29 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.2.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DD9C3F67D;
        Mon, 24 Jul 2023 06:18:44 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kbuild@vger.kernel.org, masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Nicolas Schier <n.schier@avm.de>
Subject: [PATCH] scripts/kallsyms: Fix build failure by setting errno before calling getline()
Date:   Mon, 24 Jul 2023 14:17:40 +0100
Message-Id: <20230724131741.954624-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getline() returns -1 at EOF as well as on error. It also doesn't set
errno to 0 on success, so initialize it to 0 before using errno to check
for an error condition. See the paragraph here [1]:

  For some system calls and library functions (e.g., getpriority(2)),
  -1 is a valid return on success. In such cases, a successful return
  can be distinguished from an error return by setting errno to zero
  before the call, and then, if the call returns a status that indicates
  that an error may have occurred, checking to see if errno has a
  nonzero value.

This fixes the following build failure if scripts/kallsyms launches with
a non-zero errno value:

 $ make
 ...
  LD      .tmp_vmlinux.kallsyms1
  NM      .tmp_vmlinux.kallsyms1.syms
  KSYMS   .tmp_vmlinux.kallsyms1.S
 read_symbol: Invalid argument

[1]: https://linux.die.net/man/3/errno

Fixes: 1c975da56a6f ("scripts/kallsyms: remove KSYM_NAME_LEN_BUFFER")
Signed-off-by: James Clark <james.clark@arm.com>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 16c87938b316..653b92f6d4c8 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -129,6 +129,7 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 	ssize_t readlen;
 	struct sym_entry *sym;
 
+	errno = 0;
 	readlen = getline(buf, buf_len, in);
 	if (readlen < 0) {
 		if (errno) {
-- 
2.34.1

