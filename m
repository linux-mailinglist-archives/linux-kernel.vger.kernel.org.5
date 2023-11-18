Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D27EFE6A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjKRH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjKRH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:59:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47698D51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:59:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A797C433C9;
        Sat, 18 Nov 2023 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700294360;
        bh=JYJrXNFpHjgM9hzobfa0oay+OYFkHJDCeKRYtYSm0BA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dO8nnAy9OwYrA+7yb/7/G7ZlgLeEt/p5iY39MO0KMnqweiduZpzpDiySsbNtIuris
         3XRqXgjRWjdHgJ/yB+xjvPAdfA9KZQ6lk+V33CWAdWFeOFC4Ku25rt1uPTxijl0vFO
         3HzJHG3iWTcWokJY1ON/H0qoZQjNL1YMOzOd3LBOlaOdMyfyomdlJUlxI1GP2qd4w8
         3I+tv5NxJrGgUIjhD3u872dZjB3kohUSIEYOcGvcYEkrfi3OkFS4c0s+vQURYryrIr
         td0ypwhWx4E4vvqOn7LEqzCZDhuqpyO/2BS9uTBeLL/zzA+dIfsLiaSS2QGaoJepZ9
         qyQJJlqox5B6g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5/6] kconfig: require an exact match for "is not set" to disable CONFIG option
Date:   Sat, 18 Nov 2023 16:59:11 +0900
Message-Id: <20231118075912.1303509-5-masahiroy@kernel.org>
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

Currently, any string starting "is not set" disables a CONFIG option.

For example, "# CONFIG_FOO is not settled down" is accepted as valid
input, functioning the same as "# CONFIG_FOO is not set". It is a
long-standing oddity.

Check the line against the exact pattern "is not set".

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 795ac6c9378f..958be12cd621 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -454,7 +454,7 @@ int conf_read_simple(const char *name, int def)
 			if (!p)
 				continue;
 			*p++ = 0;
-			if (strncmp(p, "is not set", 10))
+			if (strcmp(p, "is not set"))
 				continue;
 
 			val = "n";
-- 
2.40.1

