Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1777C7D24CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjJVRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjJVRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3EF10C6;
        Sun, 22 Oct 2023 10:06:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02796C433CB;
        Sun, 22 Oct 2023 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994391;
        bh=jurkImcIT4LPjZwhzZI7kbU4mAhyNYbhidKTnt+0gBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tH0rGjJC4uaKV5yrD8YmJwuh79Hzuz290OkCqRxKkySACmjziCEns+4wJpIsOdUvI
         vwU0tvUrp+68CmJwwioLWLvhco++yaxJaZIZMB7vn/ue6jGIykzDIZCNS7s2iqbPuk
         Df09konjcm4LHj3wJugH4ewZ9dk6FEBC8iltR239qnSeWx9ucIVJZeeaGHa2CmK728
         4X8wPgGBChW9Zn9ZYbUSiiNrEzcGgqcr7U/rzs1osuW5jgLQLmPVoCwDtXdVrlhUhV
         5/Q79oI5NOKo0+2MW7BKbAQausgbQkpLFh+WeRxT5y5cf0+J2HoInhhDgMIgTJmo3X
         Pt+M5EqoBao5w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 10/10] modpost: squash ALL_{INIT,EXIT}_TEXT_SECTIONS to ALL_TEXT_SECTIONS
Date:   Mon, 23 Oct 2023 02:06:13 +0900
Message-Id: <20231022170613.2072838-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231022170613.2072838-1-masahiroy@kernel.org>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALL_INIT_TEXT_SECTIONS and ALL_EXIT_TEXT_SECTIONS are only used in
the macro definition of ALL_TEXT_SECTIONS.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e4eb989dc764..f27ea0b8531d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -795,11 +795,6 @@ static void check_section(const char *modname, struct elf_info *elf,
 	".init.setup", ".init.rodata", ".meminit.rodata", \
 	".init.data", ".meminit.data"
 
-#define ALL_INIT_TEXT_SECTIONS \
-	".init.text", ".meminit.text"
-#define ALL_EXIT_TEXT_SECTIONS \
-	".exit.text"
-
 #define ALL_PCI_INIT_SECTIONS	\
 	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
 	".pci_fixup_enable", ".pci_fixup_resume", \
@@ -819,7 +814,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define INIT_SECTIONS      ".init.*"
 
-#define ALL_TEXT_SECTIONS  ALL_INIT_TEXT_SECTIONS, ALL_EXIT_TEXT_SECTIONS, \
+#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
 enum mismatch {
-- 
2.40.1

