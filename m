Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010407C76EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442254AbjJLTcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442249AbjJLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E058DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A36CC433D9;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=2zdrvqX6eHp2JMB1DsMmil9YMiuDQoFujLFcSnnPv4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzyPPZ4E06GNvCU+7Yw/RWtIhawKMkoVDmgt81iT2PJm9QPFQ8V37kceQKMrl1GRQ
         Q6HO6X27QUUn7MWHqyhm/JXMt2LaDOvw/G/dtO6jrcB6FvG7xg38Cskw2QPfkvtlPX
         kqUdA4lg3F5QNu1siONTAgulDzFUsHDlWJFqQaJxVOxM+LeyVMe8E3rPYZ/Gp2A9ra
         rD4Q/H+nws+TJuidWpAooFFT5BJ+xjExzlCvd1TnFR0nSPejtWH5wkVxUyyC9lws1i
         FscHPgY+jDwZKMVBCu/ZQIwn9w8aNcfLnrLNX90PPuGUBaaqGlV9w2VXlxelnzibIB
         DuZ52Ibg+82Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F6A2CE0C3A; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH nolibc 08/19] tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
Date:   Thu, 12 Oct 2023 12:32:22 -0700
Message-Id: <20231012193233.207857-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This nolibc internal function is not used. Delete it. It was probably
supposed to handle memmove(), but today the memmove() has its own
implementation.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/string.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 1bad6121ef8c..22dcb3f566ba 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -39,16 +39,6 @@ void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
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
2.40.1

