Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A3E802288
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjLCK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjLCKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:25:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DDFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:25:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04F0C433C8;
        Sun,  3 Dec 2023 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701599140;
        bh=Lnc3/O+6CGAEAS2bB5Go5eHeE+xwqLvuu2/DPt0BL5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cO6ViyxeBuYd4k0wYeSUZ2wRRCgCArk8SlgrIlhwtkOCQuajWRfPbcE/PA68owivB
         qzSGcHRasVodTIV5akKFFbHJJerXJTboGgemSWzDxbcQWyj2BEUVp6Iytzg+doS3ci
         ChiV5qQaogDbCC4R/vZTLgoXSxUVHmqzpD1NO94CUSyUrtvWsVnCTVXSr1m0dyFhZc
         XBQwGJl7icuvWAQ3CSoyGadulYrl3B8bt+pFfA4qfQmW6GmZqNF2bT9ZtuSQM3p5gB
         AR4QDeP2XKfr5Fe3QfTWUWV8UGFNa1FeIapCUTirBFC+D+sr6GWALN7w/7cghSoXf2
         r48aKdBWseT4g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] kconfig: remove redundant NULL pointer check before free()
Date:   Sun,  3 Dec 2023 19:25:28 +0900
Message-Id: <20231203102528.1913822-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203102528.1913822-1-masahiroy@kernel.org>
References: <20231203102528.1913822-1-masahiroy@kernel.org>
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

Passing NULL to free() is allowed and is a no-op.

Remove redundant NULL pointer checks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 3 +--
 scripts/kconfig/util.c     | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index bd14aae1db58..f1197e672431 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -432,8 +432,7 @@ int conf_read_simple(const char *name, int def)
 		case S_INT:
 		case S_HEX:
 		case S_STRING:
-			if (sym->def[def].val)
-				free(sym->def[def].val);
+			free(sym->def[def].val);
 			/* fall through */
 		default:
 			sym->def[def].val = NULL;
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index b78f114ad48c..92e5b2b9761d 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -42,8 +42,7 @@ struct gstr str_new(void)
 /* Free storage for growable string */
 void str_free(struct gstr *gs)
 {
-	if (gs->s)
-		free(gs->s);
+	free(gs->s);
 	gs->s = NULL;
 	gs->len = 0;
 }
-- 
2.40.1

