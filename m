Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF37F4B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbjKVPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbjKVPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:38:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6F30C1;
        Wed, 22 Nov 2023 07:34:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89376C43395;
        Wed, 22 Nov 2023 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667296;
        bh=faClR3R2fzmL7AJjFZwWrlq97qch8VdDc7zsL2khTwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncu6Xcel4sM8jAf8losxfwH7SHfyG1S/04vwXxHnF9vw0aZgm/jYRapdThrow2w06
         XCZhHEs5uA5xfJVWeQZM7nW8KlbMp9UlF+cLlGlxcbSRPcQRgZg08jKA3Wxw8czkXB
         W/LfzuBKxhH9qyh5+wdvpsnvhOVRfw5DmX13WYpUmORPamiikUQcuzfVw8jGDWFobq
         ZwdfjiVM8198SnXizgP5or14reTTIUrpHUY/vZ9UjADzrQRoEJ4nq1ukxI4RXx/q/X
         JrP7VJY2/Z3YSwwORySdNTMGhQTHliHyMJRujD+MNAm8qoUXarASZ8t+wPfS50B1lh
         MbI5KqVRlvIBQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Terrell <terrelln@fb.com>,
        syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 5/9] zstd: Fix array-index-out-of-bounds UBSAN warning
Date:   Wed, 22 Nov 2023 10:34:29 -0500
Message-ID: <20231122153440.852807-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153440.852807-1-sashal@kernel.org>
References: <20231122153440.852807-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.63
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
index 2c8bbe3e4c148..f37b7aec088ec 100644
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

