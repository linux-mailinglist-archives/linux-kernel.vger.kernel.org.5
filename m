Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2D7D1876
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJTV5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTV5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:57:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F0D45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:56:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33AAC433C8;
        Fri, 20 Oct 2023 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697839018;
        bh=xDC6o6RPYN1gPqtSBRN/GXlmvWxxI3SkJKxyGCFhJFA=;
        h=From:Date:Subject:To:Cc:From;
        b=RHe7/nFXdapi820jfmKYHztA9PyfDY90WWkpImAnoQWPEmNuRanzaZuw4ovxoOVAs
         e5HfBwegPY+kKYCl9lPgwt6nojHyUJ5Imirx+646NUVSfM6ZG9SsQc9wUB0qi0t5+p
         TLpX1Kuy1DmWJQKzkqNL4s9nLDzuZz8SyLGege/M0KmdgFn06+/5EovD0NppSRMBe7
         g/S2p/qH0SPaeLGdoxw8juBsjCODC97Aqr8+8NCCm6XVDSimEVNQLlXijuDUrTybb2
         pyBIJ2Xzq77bCSW6//BfQkyuGkVdOUpXobZvJEKOyacoxML+Msp4XkxSz9Jf1guwkU
         r+hdp7bby0grw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 20 Oct 2023 22:56:50 +0100
Subject: [PATCH] tools/nolibc: Add Linux specific waitpid() flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKH3MmUC/x3MSwqAMAwA0atI1gZiRfxcRVzEGjUgVVpRoXh3i
 8u3mIkQxKsE6LIIXi4NuruEIs/AruwWQZ2SwZApCzKEbt90tHiznodOOG+8BGyILdUVj23dQEo
 PL7M+/7Yf3vcDODgicmYAAAA=
To:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xDC6o6RPYN1gPqtSBRN/GXlmvWxxI3SkJKxyGCFhJFA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlMveomB0uo3CX0KIgKVOQwH24O8SFwb9KayG6lKLq
 8xsQJr6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTL3qAAKCRAk1otyXVSH0E+TB/
 9HSTYq+LBuNT/Pecv74WkJoN5JDaMLcaykBXwiI+VYcQTIe6N3TKMp9Qs836cZw8S872fNAFqnO8Lr
 alnrj3f3Ew4HodUa4I0M9cQ9aPmZKqRzTZh85rNXS5tFmipUsWRpmhCz5M2Fs/ZOaFaW4fycLi8r/x
 iO87d3LrRsDvknE0709pIMm5U9PJpSavjFEy6R/+vR5QdeGG3iCo7HlZCdlzhP1hT7kner1p8u6oNR
 H7SfjxQ5W99/2JWelLyXuryaU0kYTLmvR9tHnU0PAMNHK8dCLgnwDnypti5nyygcvCl/d6+KxM82qr
 1ZM0Q5LqW2uIIDaGsgCU9sVEyNaR5/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux defines a few custom flags for waitpid(), make them available to
nolibc based programs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/types.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 8cfc4c860fa4..801ea0bb186e 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -109,7 +109,10 @@
 #define WIFSIGNALED(status) ((status) - 1 < 0xff)
 
 /* waitpid() flags */
-#define WNOHANG      1
+#define WNOHANG      0x00000001
+#define __WNOTHREAD  0x20000000
+#define __WALL       0x40000000
+#define __WCLONE     0x80000000
 
 /* standard exit() codes */
 #define EXIT_SUCCESS 0

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20231020-nolibc-waitpid-flags-80ac075ab978

Best regards,
-- 
Mark Brown <broonie@kernel.org>

