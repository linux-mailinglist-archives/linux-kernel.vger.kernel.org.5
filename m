Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2B7CC5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbjJQOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:33:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8592;
        Tue, 17 Oct 2023 07:33:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC591C433C8;
        Tue, 17 Oct 2023 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697553227;
        bh=Md1yoB7CnP/OCO7Dq7WJ4rYYyE4bhXLe0LJv3Xd4MmU=;
        h=From:To:Cc:Subject:Date:From;
        b=PQEAqpnbfeSCRvNKTvHSIERCPbuZnKMhrJ/+ssd0LDNybpWChzonTWwHCMH03LfwT
         ChW9J2kt5KIFmaT28vd0g9mixQ9UJEpOpDlG1NXbA39bsCpvklrGtJGrene8m/5AKK
         8XFisogiVBc0TED2DvvvILH4Xrs9paz2eAsrwzlTu/pXzs0tMcl7cGt42kPb4mopfN
         dDF/a92TSKMZ4Wo5YtHMdlxkJ3lPvXq2BSUYV385mLBj0USWSqsZ2RJ5XwJr625050
         GuuouHEIJuVv2gFAx2ANBul9bsOAP9TuzPEgyZelYGEgiuY8Bhz/P+S/p0+BazA2OV
         Pw0uYMjhum2BQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] landlock: fix typo in landlock_append_net_rule() stub function
Date:   Tue, 17 Oct 2023 16:33:35 +0200
Message-Id: <20231017143341.2875980-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is an extraneous semicolon in the empty stub helper for
this function tha causes randconfig builds to break:

In file included from security/landlock/setup.c:17:
security/landlock/net.h:28:1: error: expected identifier or '(' before '{' token
security/landlock/net.h:26:1: error: 'landlock_append_net_rule' declared 'static' but never defined [-Werror=unused-function]

Fixes: 614d46b333ab9 ("landlock: Add network rules and TCP hooks support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/landlock/net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/net.h b/security/landlock/net.h
index 588a49fd69076..09960c237a13e 100644
--- a/security/landlock/net.h
+++ b/security/landlock/net.h
@@ -24,7 +24,7 @@ static inline void landlock_add_net_hooks(void)
 
 static inline int
 landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
-			 access_mask_t access_rights);
+			 access_mask_t access_rights)
 {
 	return -EAFNOSUPPORT;
 }
-- 
2.39.2

