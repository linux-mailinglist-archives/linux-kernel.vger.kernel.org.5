Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F384875CB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGUPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjGUPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:21:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D64691
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:20:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad907ba4so12557045ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689952802; x=1690557602;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=FGQb7KpZNRpkho8cgTr8i+WhDErsFNhD07P94FZeYEg=;
        b=jyGW0VROISNel3ta/haidB7fgiMqP0Zkmj+6DUV0U7xOMbyjTGO4zqz+UmikA0arDq
         G1XP4wsJy/uW/lCh6p+t3AF2zpxi3bX5eIP5MvGsGL/s6wIpcIQFKGkDcCKmE5bAc7XX
         2I7Lc7jgkq9tCmnpQapaKNEPFPpvKnZsZ1VTaMmoLQMuQUwcnXFFUuBwS9EE27hi1V/K
         x7X6eSi01HV7s3y4QlE43UmyszzSF9coNM4P2xz91MRaQXyJzKS52FqI/z7s7qKvuffo
         1F2GDRay3xUjIDDDh+e079CtbD/2llPbTo/blF3uIunNuI5jYSlvNDLuFfyC4bJiA9nI
         Hc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952802; x=1690557602;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGQb7KpZNRpkho8cgTr8i+WhDErsFNhD07P94FZeYEg=;
        b=i40axh9Hcl8gxKwHeuct1950a9inwfTUh6wJsd0IzmzteZyZ3LmVb1R8fOlXLheAOJ
         DGS7WwBJiRkx24JCC7wpfTJm9gKj3xKayTQEjzGkv7AxOofnR/pIGiXnIfiaGnUQhwp7
         +mybMZRVikOnayxc3ErujpMNrPzLQz0gWpEEPSvLFSZrXCC7aaQLwGybFkNzn8n3ar36
         VvjYL3cl0WT72DUNGrP6GUDfEV8Pp9ES3mZAjYpt9MheoJTh8zK/9YgJBxdW+KcN7bnx
         5xsleXfDSPthqXR7mPojbgxyc3GTx60RjnpE6n4PRS+jHI7PKK7M5oywVMW56u1d79up
         AexA==
X-Gm-Message-State: ABy/qLbLSdB5pUcidSMyZV0DplEanvwkkVWZVmNV1bCUN5c9sIvVePsS
        pwtSqg6nbE+8g6Cwj+hx5a3rSQ==
X-Google-Smtp-Source: APBJJlG6GgiEc98hunrP1hfoR2yOoKJPDjPA4NwGb4Tj9nP0mHHeF6RAEjvKUb7PpLJBrmKu+6FLog==
X-Received: by 2002:a17:90a:7c0f:b0:262:c212:9898 with SMTP id v15-20020a17090a7c0f00b00262c2129898mr1515120pjf.26.1689952802429;
        Fri, 21 Jul 2023 08:20:02 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id g13-20020a17090a290d00b0025eb5aafd3csm2830783pjd.32.2023.07.21.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:20:01 -0700 (PDT)
Subject: [PATCH] modpost, kallsyms: Treat add '$'-prefixed symbols as mapping symbols
Date:   Fri, 21 Jul 2023 08:01:48 -0700
Message-ID: <20230721150147.11720-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-kbuild@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     masahiroy@kernel.org, wangkefeng.wang@huawei.com,
        mcgrof@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to restrict the '$'-prefix change to RISC-V caused some fallout,
so let's just treat all those symbols as special.

Fixes: c05780ef3c1 ("module: Ignore RISC-V mapping symbols too")
Link: https://lore.kernel.org/all/20230712015747.77263-1-wangkefeng.wang@huawei.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
It wasn't clear if we should just revert the original patch and spin a
new one, but looks like this is in at least some trees so I sent a
follow-on patch -- at least this way I can make coffee before forgetting
to send it ;)
---
 include/linux/module_symbol.h | 16 ++--------------
 kernel/module/kallsyms.c      |  2 +-
 scripts/mod/modpost.c         |  2 +-
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 5b799942b243..1269543d0634 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -3,25 +3,13 @@
 #define _LINUX_MODULE_SYMBOL_H
 
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
-static inline int is_mapping_symbol(const char *str, int is_riscv)
+static inline int is_mapping_symbol(const char *str)
 {
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
 	if (str[0] == 'L' && str[1] == '0')
 		return true;
-	/*
-	 * RISC-V defines various special symbols that start with "$".  The
-	 * mapping symbols, which exist to differentiate between incompatible
-	 * instruction encodings when disassembling, show up all over the place
-	 * and are generally not meant to be treated like other symbols.  So
-	 * just ignore any of the special symbols.
-	 */
-	if (is_riscv)
-		return str[0] == '$';
-
-	return str[0] == '$' &&
-	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
-	       && (str[2] == '\0' || str[2] == '.');
+	return str[0] == '$';
 }
 
 #endif /* _LINUX_MODULE_SYMBOL_H */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 78a1ffc399d9..ef73ae7c8909 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -289,7 +289,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * and inserted at a whim.
 		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_ENABLED(CONFIG_RISCV)))
+		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7c71429d6502..b29b29707f10 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1052,7 +1052,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 
 	if (!name || !strlen(name))
 		return 0;
-	return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
+	return !is_mapping_symbol(name);
 }
 
 /* Look up the nearest symbol based on the section and the address */
-- 
2.41.0

