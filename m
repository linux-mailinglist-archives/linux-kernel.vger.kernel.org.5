Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99E7D24CE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJVRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjJVRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9DDD7E;
        Sun, 22 Oct 2023 10:06:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6FC433C7;
        Sun, 22 Oct 2023 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994389;
        bh=dd0s00G1J0MosUp3Ta0R979mrbMMhfnV4OD44YXCobg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1M6lbudSRRO5CTdiGZgmQoSyR284yHS7vAlfGh09/tq9595IRjm1QSwaoHKGjmb+
         HoBHbJLzmECxdfvmq/Hhb3SjB++UHtPtw/PpJxmnyu4AmMCQhqYAxWoaOGHv4F99Hg
         LGFTbRjGCWO+FUQLqJRcEHaK12SuQlpcqdoS6WGXcFS/kMuqujrm9P2TS7WsH9QiW0
         FJWEK60fGwUnG4arnbCNyDsxsgYWUPc/GjotFRM/7v6fAcakl3aCFKm/bYU200IvGP
         Ntazo8jvxUYC5ktKxKsqnKL3G8/ID5AgAbK2aTxHxm0u3iJaCXpmyBelwDTpxXmBTa
         N13Cdxp+ag+EA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 09/10] modpost: merge sectioncheck table entries regarding init/exit sections
Date:   Mon, 23 Oct 2023 02:06:12 +0900
Message-Id: <20231022170613.2072838-9-masahiroy@kernel.org>
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

Check symbol references from normal sections to init/exit sections in
a single entry.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c726383c1909..e4eb989dc764 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -823,9 +823,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
 enum mismatch {
-	TEXT_TO_ANY_INIT,
-	DATA_TO_ANY_INIT,
-	TEXTDATA_TO_ANY_EXIT,
+	TEXTDATA_TO_ANY_INIT_EXIT,
 	XXXINIT_TO_SOME_INIT,
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
@@ -856,20 +854,10 @@ static const struct sectioncheck sectioncheck[] = {
 /* Do not reference init/exit code/data from
  * normal code and data
  */
-{
-	.fromsec = { TEXT_SECTIONS, NULL },
-	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
-	.mismatch = TEXT_TO_ANY_INIT,
-},
-{
-	.fromsec = { DATA_SECTIONS, NULL },
-	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
-	.mismatch = DATA_TO_ANY_INIT,
-},
 {
 	.fromsec = { TEXT_SECTIONS, DATA_SECTIONS, NULL },
-	.bad_tosec = { ALL_EXIT_SECTIONS, NULL },
-	.mismatch = TEXTDATA_TO_ANY_EXIT,
+	.bad_tosec = { ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL },
+	.mismatch = TEXTDATA_TO_ANY_INIT_EXIT,
 },
 /* Do not reference init code/data from meminit code/data */
 {
-- 
2.40.1

