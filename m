Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC87F89F2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKYKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjKYKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:31:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14E10DC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:31:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9869DC433CB;
        Sat, 25 Nov 2023 10:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700908293;
        bh=UQohXr4Q1HYdYBXHCpAgYPqYqu05A8PQAIBFeD9Rs4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hy1V/roHQPewcPQbyO4u0xgO+U/7AUQ6zHeTG+3A4iGhHH8I2gAOF+bTlcFIZNaqy
         E6kbL5ccawosHgiy1iOLfy2rgMDXKQQzrflVIUepKiyjaRVORIA1uqy35KeyT2r41s
         CYCoiG1Hh8xCxCIEFCGr9INRlFd4O6FHtPAFPb4OO3t5vg+62alSTU1X1z9irnvnDw
         QrzXFlJpbkKY7fWGDNcxeOKUpbOwpiLwaswfOm0c59LIR7GOPVwT4FoUCaA7lg1YqO
         xAqtE4SqovC/rVLuV7UvFrY9+K9D/9Qwif8QwF7uF3pzDhDC83pyd8niOrKYqSUFze
         VLZZB6DeGtB3g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] modpost: remove unreachable code after fatal()
Date:   Sat, 25 Nov 2023 19:31:15 +0900
Message-Id: <20231125103116.797608-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125103116.797608-1-masahiroy@kernel.org>
References: <20231125103116.797608-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fatal() never returns. Remove unreachable code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ca0a90158f85..013fc5031bc7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -473,11 +473,9 @@ static int parse_elf(struct elf_info *info, const char *filename)
 		fatal("%s: not relocatable object.", filename);
 
 	/* Check if file offset is correct */
-	if (hdr->e_shoff > info->size) {
+	if (hdr->e_shoff > info->size)
 		fatal("section header offset=%lu in file '%s' is bigger than filesize=%zu\n",
 		      (unsigned long)hdr->e_shoff, filename, info->size);
-		return 0;
-	}
 
 	if (hdr->e_shnum == SHN_UNDEF) {
 		/*
@@ -515,12 +513,11 @@ static int parse_elf(struct elf_info *info, const char *filename)
 		const char *secname;
 		int nobits = sechdrs[i].sh_type == SHT_NOBITS;
 
-		if (!nobits && sechdrs[i].sh_offset > info->size) {
+		if (!nobits && sechdrs[i].sh_offset > info->size)
 			fatal("%s is truncated. sechdrs[i].sh_offset=%lu > sizeof(*hrd)=%zu\n",
 			      filename, (unsigned long)sechdrs[i].sh_offset,
 			      sizeof(*hdr));
-			return 0;
-		}
+
 		secname = secstrings + sechdrs[i].sh_name;
 		if (strcmp(secname, ".modinfo") == 0) {
 			if (nobits)
-- 
2.40.1

