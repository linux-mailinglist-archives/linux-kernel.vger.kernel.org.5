Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC07F533F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjKVWSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbjKVWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D401BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A14C433C8;
        Wed, 22 Nov 2023 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691504;
        bh=OEYsi17tOKR7Yn0RX96OmFEl8yOfWLgmEUuZLjzMjVw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d4Yov3+O5pJZYtO+vAquTnBX0iikeSqBxlGU2Gli2xi78IA03yNmk9fyQbbo1bUKy
         USXCZ0TgaqwsYqNgrN9RxOE/iLncTbx6jFokMFv7xi/puqkUnVBny2fLDJBlzBjEgd
         VNMknv62dWvQ4bduSYJIvxhYEqiyoAS68ikNdyJpKg5B1sqD0cEJntPOZX6eTEuKXm
         H4LAl9o7KqFrHVXUFXpSkYn/yymkDBfZhVFzA4Aj9+5xP4PT/dZK6VG4Q6yJvGVmw5
         PMhCtOZQzVPwHjoc+itTW0E6Qq+o2h8hFh4Yxo+ORbInR5eRhdlSP8Xw7NPsKYQ9MW
         im5YtndDD/e3Q==
From:   deller@kernel.org
To:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-arch@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/4] vmlinux.lds.h: Fix alignment for __ksymtab*, __kcrctab_* and .pci_fixup sections
Date:   Wed, 22 Nov 2023 23:18:13 +0100
Message-ID: <20231122221814.139916-4-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
(e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
64-bit pointers into the __ksymtab* sections.
Make sure that the start of those sections is 64-bit aligned in the vmlinux
executable, otherwise unaligned memory accesses may happen at runtime.

The __kcrctab* sections store 32-bit entities, so make those sections
32-bit aligned.

The pci fixup routines want to be 64-bit aligned on 64-bit platforms
which don't define CONFIG_HAVE_ARCH_PREL32_RELOCATIONS. An alignment
of 8 bytes is sufficient to guarantee aligned accesses at runtime.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
---
 include/asm-generic/vmlinux.lds.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..fa4335346e7d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -467,6 +467,7 @@
 	}								\
 									\
 	/* PCI quirks */						\
+	. = ALIGN(8);							\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_early,  _pci_fixups_early,  __start, __end) \
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_header, _pci_fixups_header, __start, __end) \
@@ -484,6 +485,7 @@
 	PRINTK_INDEX							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
+	. = ALIGN(8);							\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
@@ -491,6 +493,7 @@
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
+	. = ALIGN(8);							\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
 		__start___ksymtab_gpl = .;				\
 		KEEP(*(SORT(___ksymtab_gpl+*)))				\
@@ -498,6 +501,7 @@
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
+	. = ALIGN(4);							\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
@@ -505,6 +509,7 @@
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
+	. = ALIGN(4);							\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
 		__start___kcrctab_gpl = .;				\
 		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-- 
2.41.0

