Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72D812CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443594AbjLNKTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443555AbjLNKTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:19:49 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC788106;
        Thu, 14 Dec 2023 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702549194;
        bh=pjC6AgncqA69AxQ0TJR0swcPyuKAW1TG7xIWc+P76j8=;
        h=From:To:Cc:Subject:Date:From;
        b=oP+MrIZcGjD6oX9TyNQE6+NQ/JFU1CVpxFDvx6nr7YJl7+DRT3PdKJiuepIyJDaUf
         MbM0byta1XsLrImto2gzclOwmEtBn/k9ODy4gMG5FaP8B/P0h4Peop4B18SkusUFWS
         7BZuCmrkhFBwPo1acs4NWLmZbk/fMmlF6Phu8J3W/uxeQ9Wjnxd1UMPnMwZLBFB4/D
         XEA8yUvcuOU36g5zm3l8G8dCihrtnYUzHMhKA5JmDGsO+U/xX/0URnf7sx0xDLhVsm
         VPCZ73AYN37QJZdK2p9+LkAnbVz/lgw5b4VmRmsoO5momu+h13m5z0xcannUzrdoeG
         wLIYBrpwEPVzQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id E1EE7378000B;
        Thu, 14 Dec 2023 10:19:49 +0000 (UTC)
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, "kernelci.org bot" <bot@kernelci.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: secretmem: Floor the memory size to the multiple of page_size
Date:   Thu, 14 Dec 2023 15:19:30 +0500
Message-ID: <20231214101931.1155586-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "locked-in-memory size" limit per process can be non-multiple of
page_size. The mmap() fails if we try to allocate locked-in-memory
with same size as the allowed limit if it isn't multiple of the
page_size because mmap() rounds off the memory size to be allocated
to next multiple of page_size.

Fix this by flooring the length to be allocated with mmap() to the
previous multiple of the page_size.

Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/memfd_secret.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 957b9e18c729..9b298f6a04b3 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
 	char *mem;
 
 	len = mlock_limit_cur;
+	if (len % page_size != 0)
+		len = (len/page_size) * page_size;
+
 	mem = mmap(NULL, len, prot, mode, fd, 0);
 	if (mem == MAP_FAILED) {
 		fail("unable to mmap secret memory\n");
-- 
2.42.0

