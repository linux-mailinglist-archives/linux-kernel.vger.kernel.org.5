Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20081802256
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjLCJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjLCJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:49:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC3DA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:50:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099D3C433CB;
        Sun,  3 Dec 2023 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701597000;
        bh=3fREL+3pDb0+f3gpXJDWy/Z+fjSVV4sYVi1Ga8WtaHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNv2/I0y1QaQgNoItB2fCs1RK2AgJtD5NdVHjX92RWhrLjqitS+cRVeZ2kXIsGx8o
         QER7zjLtrPvCDVpDGyc3FQjR1VGYW3GSPNVdnBPNTd/weX/xjWmn3qQ+K1pop+vvcg
         GFEsnbwuHQbnxVpzlV+Nq196TtY3G02V8Ierf2Za1v9CKfTZdcZyFKZPK5izOAbYYl
         ZOpkXYUBx5i1XQIVUb6TT7YK1VqGX0xTOhvmbj9cb/vYAtzzh/DiO1FD7tn+eXX70Q
         AtM5DljHuHWcL9uKAyXzFm49NNpivgg0zf9/3DC1s2cXsmpzfMak3IwicdamK9Zc7m
         G3A13S5DzjkPg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 4/4] modpost: remove unreachable code after fatal()
Date:   Sun,  3 Dec 2023 18:49:34 +0900
Message-Id: <20231203094934.1908270-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203094934.1908270-1-masahiroy@kernel.org>
References: <20231203094934.1908270-1-masahiroy@kernel.org>
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

Now compilers can recognize fatal() never returns.

While GCC 4.5 dropped support for -Wunreachable-code, Clang is capable
of detecting the unreachable code.

  $ make HOSTCC=clang HOSTCFLAGS=-Wunreachable-code-return
      [snip]
    HOSTCC  scripts/mod/modpost.o
  scripts/mod/modpost.c:520:11: warning: 'return' will never be executed [-Wunreachable-code-return]
                          return 0;
                                 ^
  scripts/mod/modpost.c:477:10: warning: 'return' will never be executed [-Wunreachable-code-return]
                  return 0;
                         ^
  2 warnings generated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

Changes in v2:
  - Change the patch order
  - Update the commit description and add warning example.

 scripts/mod/modpost.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3233946fa5f6..e2bc180cecc8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -476,11 +476,9 @@ static int parse_elf(struct elf_info *info, const char *filename)
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
@@ -518,12 +516,11 @@ static int parse_elf(struct elf_info *info, const char *filename)
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

