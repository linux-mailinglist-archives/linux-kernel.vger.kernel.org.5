Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A27D30F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjJWLED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjJWLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:03:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25810C9;
        Mon, 23 Oct 2023 04:03:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC50C433C8;
        Mon, 23 Oct 2023 11:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698059027;
        bh=pklDVZYAxLKOZK+8gcGmc6nJte6jXDPhoa1mHNgJuzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEz1JEDvjQaJCvm0F9LQymLd21rjf1S1DqR5Gi9cmP+YNr+w2pL7fjquHFqDs6IB+
         d6cIIZ47jqQn1L8WagjScNybKckrd+FXFcqqKLFzXoQKgvtNnlv3vFGsXSLXNWWsk4
         1bze2g38+kbHgBpuKxTulVPCd6rCF+NqMOrHc9myfAulikmaV7aShzYjrS3rYdT/gm
         gRMygzsnhkITq2leWaFOOORjdlTXknzCn/JSvrc9kpRkHpW68zf0YnqL5NGAFHWnGi
         lShoLPhiqVdbc6rtTEaWPlIocDVMUjtmb4ga3rhwU9g2gHeUXGkKOZK1oWGjSzmemf
         BbtYjDfrwkmkg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH 2/2] kexec: select CRYPTO from KEXEC_FILE instead of depending on it
Date:   Mon, 23 Oct 2023 13:01:55 +0200
Message-Id: <20231023110308.1202042-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023110308.1202042-1-arnd@kernel.org>
References: <20231023110308.1202042-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

All other users of crypto code use 'select' instead of 'depends on',
so do the same thing with KEXEC_FILE for consistency.

In practice this makes very little difference as kernels with kexec
support are very likely to also include some other feature that already
selects both crypto and crypto_sha256, but being consistent here helps
for usability as well as to avoid potential circular dependencies.

This reverts the dependency back to what it was originally before commit
74ca317c26a3f ("kexec: create a new config option CONFIG_KEXEC_FILE for
new syscall"), which changed changed it with the comment "This should
be safer as "select" is not recursive", but that appears to have been
done in error, as "select" is indeed recursive, and there are no other
dependencies that prevent CRYPTO_SHA256 from being selected here.

Fixes: 74ca317c26a3f ("kexec: create a new config option CONFIG_KEXEC_FILE for new syscall")
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/Kconfig.kexec | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index bfc636d64ff2b..51f719af10e79 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -36,7 +36,8 @@ config KEXEC
 config KEXEC_FILE
 	bool "Enable kexec file based system call"
 	depends on ARCH_SUPPORTS_KEXEC_FILE
-	depends on CRYPTO_SHA256=y || !ARCH_SUPPORTS_KEXEC_PURGATORY
+	select CRYPTO
+	select CRYPTO_SHA256
 	select KEXEC_CORE
 	help
 	  This is new version of kexec system call. This system call is
-- 
2.39.2

