Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E07D24C2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjJVRG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjJVRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E465EE;
        Sun, 22 Oct 2023 10:06:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20DEC433C7;
        Sun, 22 Oct 2023 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994380;
        bh=aTiLuP4Ust/jrgVbBMYTU3kLN1U+pxnaKRT4WTs91Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jg1DbiRh1IPvX12jNdpnak/QyZ5ZFyN8mhTCC/tRkLBZJ7Zl6krum94admfzOjbF2
         03KncXSoHzbgA10LiuocV6c9uwjMhSDExdWQsjEfoLbjxpoyY124uLqdHvGA9dPRYi
         asL6tVM7itdGLLRG8DYxhibwXqk6VZ3bPaZyEnClc8ZGCoQn6PEm7I+6SMJxiZGL+f
         GKR0NpucI7AguDOxFi5AJeTc3MvY8FNKZvBbP3kZtw9nUO5K4+yMZejfCKsGMf4hsT
         LfdWazAAiQJ2YSdQh3a283unvXZ/W3xKEXfddBEFnm7E7XAsRfRXbTbXRdLxf85Olo
         vY7j18pTmyHyQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 03/10] modpost: disallow *driver to reference .meminit* sections
Date:   Mon, 23 Oct 2023 02:06:06 +0900
Message-Id: <20231022170613.2072838-3-masahiroy@kernel.org>
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

Drivers must not reference .meminit* sections, which are discarded
when CONFIG_MEMORY_HOTPLUG=n.

The reason for whitelisting "*driver" in the section mismatch check
was to allow drivers to reference symbols annotated as __devinit or
__devexit that existed in the past.

Those annotations were removed by the following commits:

 - 54b956b90360 ("Remove __dev* markings from init.h")
 - 92e9e6d1f984 ("modpost.c: Stop checking __dev* section mismatches")

Remove the wrong whitelist.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bcc334b28a2c..792ba9da0f27 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1006,12 +1006,6 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 				    "*_console")))
 		return 0;
 
-	/* symbols in data sections that may refer to meminit sections */
-	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
-	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS)) &&
-	    match(fromsym, PATTERNS("*driver")))
-		return 0;
-
 	/*
 	 * symbols in data sections must not refer to .exit.*, but there are
 	 * quite a few offenders, so hide these unless for W=1 builds until
-- 
2.40.1

