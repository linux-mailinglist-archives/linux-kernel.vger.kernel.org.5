Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B5808ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443320AbjLGOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443327AbjLGOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:38:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7019AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7050EC433CA;
        Thu,  7 Dec 2023 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701959323;
        bh=D9nxTK7jFnq47guRUf7p0EWjiyZ4kSvltCqz6c9gFdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KvEIWJL0c28wOt6hHBfKl/PFvX4I9W4q4j9VYbk0kxQJe491uZumXJkhX1i+r+GP8
         I2wilQK7faBB+VJvr4Mf1o18lHzl91ZlF4S/QNwi5wBrCnIkXqZ1z5eaKTCAeMbtQ3
         yKh15zRX8v4GluMOVq5OlO5/SUneBNqaM6oLysbbs8aCucer28/qUTOVfkgIrtG53E
         CGuEXOGbGCnS6XveR81TVTler4TIgA3i6XQBk0PHEERImbffH+FK7d2wKTBWHzVgNo
         b6u+j0IUV4pkhj/c3Sp5WOn0ONwHhLnu4HQjguo7SMxUhHCamvFx8vHuQHSjTWoxL8
         e7WPw3726v4rQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs3: align struct ATTR_LIST_ENTRY
Date:   Thu,  7 Dec 2023 15:28:34 +0100
Message-Id: <20231207142838.960725-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

On architectures like i386 that don't enforce natural alignment of u64
struct members, so the recent change to remove the final 48 bits
reduced the structure size from 32 to 28 bytes:

include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct ATTR_LIST_ENTRY) == 0x20"
fs/ntfs3/ntfs.h:530:1: note: in expansion of macro 'static_assert'
  530 | static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
      | ^~~~~~~~~~~~~

Add an alignment attribute that makes the structure the same across
all architectures again.

Fixes: d155617006eb ("fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index c8981429c721..2d409ac94cbb 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -525,7 +525,7 @@ struct ATTR_LIST_ENTRY {
 	__le16 id;		// 0x18: struct ATTRIB ID.
 	__le16 name[];		// 0x1A: To get real name use name_off.
 
-}; // sizeof(0x20)
+} __aligned((8)); // sizeof(0x20)
 
 static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
 
-- 
2.39.2

