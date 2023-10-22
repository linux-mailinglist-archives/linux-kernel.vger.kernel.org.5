Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A537D24C6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjJVRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjJVRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F9124;
        Sun, 22 Oct 2023 10:06:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D55CC433C7;
        Sun, 22 Oct 2023 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994383;
        bh=mnjPdsDS3enDm6WXK4/X4WMDdmcRPpl/JrVaMfXuHA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+votQPOQvger1N5hYN7MOnDeOx47VZpkOSweEfnd691hHxUNuOevb15IZhg0jsIO
         s4XfHcHt8+f+SIhUZ4nA08sTKbS/QaQ4S3SjMQsSYsZ3v8ACdJ5Yb/iZYf9w1ULBzj
         Q2c2PorpNQ1c2GOMo0hyAwi6ySlPBdUbkzM8JVnwNVtsxewBt+AVbJ4lgTw9q0QBFR
         gmMdOqVhZ40SSzwMQDziRAlDyP6qdtejWvWhWyIFMVhMrtmPIzUiN8r66zpRWtjfHE
         j98xRRzdrNfqEQ9Afsc3/O6VQIgiuoR3EQDSnJLCEXgUP9K6zN0pZFaD6FwSu0OGpG
         QM6ZLG3jZhqhA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 05/10] modpost: remove MEM_INIT_SECTIONS macro
Date:   Mon, 23 Oct 2023 02:06:08 +0900
Message-Id: <20231022170613.2072838-5-masahiroy@kernel.org>
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

ALL_XXXINIT_SECTIONS and MEM_INIT_SECTIONS are the same.
Remove the latter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 19b138664f75..626ab599eea2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -805,7 +805,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 	".pci_fixup_enable", ".pci_fixup_resume", \
 	".pci_fixup_resume_early", ".pci_fixup_suspend"
 
-#define ALL_XXXINIT_SECTIONS MEM_INIT_SECTIONS
+#define ALL_XXXINIT_SECTIONS ".meminit.*"
 
 #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
 #define ALL_EXIT_SECTIONS EXIT_SECTIONS
@@ -818,7 +818,6 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".coldtext", ".softirqentry.text"
 
 #define INIT_SECTIONS      ".init.*"
-#define MEM_INIT_SECTIONS  ".meminit.*"
 
 #define EXIT_SECTIONS      ".exit.*"
 
-- 
2.40.1

