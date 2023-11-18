Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC77EFE65
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjKRH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjKRH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:59:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD27D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:59:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B26C433C8;
        Sat, 18 Nov 2023 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700294357;
        bh=jauAd/DlIAxGRDHMhsV9eiDiF6QyHtLCAz+l36D7zjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjbwH44S8XJsybJbgN1uXro8sSssuv0tAW825PLtyijhAG8M7czDA+DWYy0tkE0Nf
         HHXKNdJn3E0ejeHOTC8pQ8gE5pJjf86hCY2uJTVB/OWyu/SGCjORkJP2iITAViUTZv
         mYekF/H72wCwzdaf3/RzGh9DqO7hMY6P73YYkRVuNYUf3sBajQsvlKU7ujoc9sI4A4
         kMwzbSPn/xf63v8TA+if0Xu0f8O+CrwyDl2Ns212Og0+48tyv6CkJ1vi/a+19lLkqf
         +mOU7YfpRHhm+kwJT7ikG5lOCRPJTHxgdflgisJAjZXabCJO0PvQX36EHw5XKQJiRX
         PsCS1nbyqmKfg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/6] kconfig: remove unused code for S_DEF_AUTO in conf_read_simple()
Date:   Sat, 18 Nov 2023 16:59:08 +0900
Message-Id: <20231118075912.1303509-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118075912.1303509-1-masahiroy@kernel.org>
References: <20231118075912.1303509-1-masahiroy@kernel.org>
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

The 'else' arm here is unreachable in practical use cases.

include/config/auto.conf does not include "# CONFIG_... is not set"
line unless it is manually hacked.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 556b7f087dbb..92e8e37aca4d 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -436,20 +436,15 @@ int conf_read_simple(const char *name, int def)
 			*p++ = 0;
 			if (strncmp(p, "is not set", 10))
 				continue;
-			if (def == S_DEF_USER) {
-				sym = sym_find(line + 2 + strlen(CONFIG_));
-				if (!sym) {
-					if (warn_unknown)
-						conf_warning("unknown symbol: %s",
-							     line + 2 + strlen(CONFIG_));
 
-					conf_set_changed(true);
-					continue;
-				}
-			} else {
-				sym = sym_lookup(line + 2 + strlen(CONFIG_), 0);
-				if (sym->type == S_UNKNOWN)
-					sym->type = S_BOOLEAN;
+			sym = sym_find(line + 2 + strlen(CONFIG_));
+			if (!sym) {
+				if (warn_unknown)
+					conf_warning("unknown symbol: %s",
+						     line + 2 + strlen(CONFIG_));
+
+				conf_set_changed(true);
+				continue;
 			}
 			if (sym->flags & def_flags) {
 				conf_warning("override: reassigning to symbol %s", sym->name);
-- 
2.40.1

