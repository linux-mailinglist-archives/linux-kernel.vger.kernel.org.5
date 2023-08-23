Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC7785683
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHWLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjHWLMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:12:18 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC53CEF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:12:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [85.89.126.105])
        by mail.ispras.ru (Postfix) with ESMTPSA id AD9C240F1DF3;
        Wed, 23 Aug 2023 11:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AD9C240F1DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692789134;
        bh=Eq/2d0b3fZr8eykDlfJX8IdWZxAOS0Pw+Jr4AnPl8sM=;
        h=From:To:Cc:Subject:Date:From;
        b=CZSh1fNsS6ttfthHFLcf3nztNY39T9xKdrH6FMPgSatyAmqAyKQZkMvM10dcLUgsg
         YP6WnKlPCES10QJFE3kMhS52i3mFkY4aNo3QRGf8dSR3LwMK0DDkdGEZ4GW4vwaySa
         b0P4k7ZCzDn3qtkZaMQb09W5HDSm7+2kda0PjAiw=
From:   Pavel Sakharov <p.sakharov@ispras.ru>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Pavel Sakharov <p.sakharov@ispras.ru>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()
Date:   Wed, 23 Aug 2023 14:14:38 +0300
Message-ID: <20230823111440.219242-1-p.sakharov@ispras.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'attr_b' has not been found in repack loop, it is dereferenced
at the end of function after 'goto out'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 fs/ntfs3/attrib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index a9d82bbb4729..ebc934ac5cf5 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1737,8 +1737,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
 			if (!attr_b) {
-				err = -ENOENT;
-				goto out;
+				return -ENOENT;
 			}
 
 			attr = attr_b;
-- 
2.41.0

