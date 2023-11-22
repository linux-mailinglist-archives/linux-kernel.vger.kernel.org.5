Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578C7F4B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbjKVPiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKVPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70210271D;
        Wed, 22 Nov 2023 07:34:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9B6C433CA;
        Wed, 22 Nov 2023 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667246;
        bh=So/9GrRh/OZlufeGqSzmuVGKco+2oz9nKxbxgGdG8tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnR8Q/XFvejO3ItFq+Rk6CmV1A81Pe4+HZ5gYbWBI8Sc4YFcL5gngT8h5kUXKT1I/
         RhtruxS7oVamlzs8gx/GSTy3+9xAKnYnu5TIQPNpAJIpFvlfmycEyVWiBYF/whqJ+G
         hGO0gSv/aiaYwBjeuIWch3sccsdIv0VDKIthVIEo+KiGJMxNu1ZL/afd69pv7wTVxZ
         VY/XXEWHYEO4KgClAgsaQSifMBurhvc1KGtxcJBztY4sTktQrF3uj/Xd1c3OZ45dgh
         oNc3kn21djbnWUIDDsggUyII212c0JI2R8+pBj7ROWJjcTf0OyQkeqI/BfaHspj8qp
         ktpzUlyN7HUyw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Terrell <terrelln@fb.com>,
        syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.5 07/15] zstd: Fix array-index-out-of-bounds UBSAN warning
Date:   Wed, 22 Nov 2023 10:33:09 -0500
Message-ID: <20231122153340.852434-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153340.852434-1-sashal@kernel.org>
References: <20231122153340.852434-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.12
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

[ Upstream commit 77618db346455129424fadbbaec596a09feaf3bb ]

Zstd used an array of length 1 to mean a flexible array for C89
compatibility. Switch to a C99 flexible array to fix the UBSAN warning.

Tested locally by booting the kernel and writing to and reading from a
BtrFS filesystem with zstd compression enabled. I was unable to reproduce
the issue before the fix, however it is a trivial change.

Link: https://lkml.kernel.org/r/20231012213428.1390905-1-nickrterrell@gmail.com
Reported-by: syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com
Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Terrell <terrelln@fb.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/zstd/common/fse_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
index a0d06095be83d..8dcb8ca39767c 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -312,7 +312,7 @@ size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc, size
 
 typedef struct {
     short ncount[FSE_MAX_SYMBOL_VALUE + 1];
-    FSE_DTable dtable[1]; /* Dynamically sized */
+    FSE_DTable dtable[]; /* Dynamically sized */
 } FSE_DecompressWksp;
 
 
-- 
2.42.0

