Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05078DF31
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjH3TIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244772AbjH3N55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:57:57 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86A1C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693403874;
        bh=cVbN3EplFTRxMSZG3fc6WmDpp7wPvxcyeQRTe1ZY1DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C4/5OtCGlK11vOW17d/9djJmGqftgbW7cqqBhK5B+Hp3Kupkb/Oq0Wo9YG0qDir+Z
         jU9kc5yu8OAXlSz0o7OpHIf6GhpL3YRkzrOznNDqWX8m8MXBv6+MVHb647Ubhdl/DP
         78lQ49/teaCfi71H+Iq72NJ7ip4IruqPUIGjZgQSSDcQv9zNGRk4N8w9ExpBKjSdhH
         1YY9CHrjvyYDE7k8w5HXpmIsdF9rzrDwTpkWAlS8Exukhtv6hbJrKkv6TTEMhusMwB
         6vxQYQSECRQ5VkarrwFQqa++b463eDCSGsWWcypllDDSmGbz+um7IGEOeiDRaf5lOQ
         XQ9HhSz9MVctw==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 5545924B331;
        Wed, 30 Aug 2023 20:57:51 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 4/5] tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
Date:   Wed, 30 Aug 2023 20:57:25 +0700
Message-Id: <20230830135726.1939997-5-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This nolibc internal function is not used. Delete it. It was probably
supposed to handle memmove(), but today the memmove() has its own
implementation.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/string.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 3c941289d5dd0985..b0d7d8e143f61741 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -41,16 +41,6 @@ void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
 	return dst;
 }
 
-static __attribute__((unused))
-void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
-{
-	while (len) {
-		len--;
-		((char *)dst)[len] = ((const char *)src)[len];
-	}
-	return dst;
-}
-
 #ifndef NOLIBC_ARCH_HAS_MEMMOVE
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
-- 
Ammar Faizi

