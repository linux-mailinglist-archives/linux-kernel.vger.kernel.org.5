Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6243759954
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGSPRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGSPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78032CC;
        Wed, 19 Jul 2023 08:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0BC61741;
        Wed, 19 Jul 2023 15:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B2EC433CA;
        Wed, 19 Jul 2023 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779841;
        bh=WUnkwoYUUaeSflcgEirZoVzc0KTIoUWAOUey/F0595E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=J2fQqp+fG2a9bG2AbvMG+1AquX/HeauPeLpjDo/QiW2tWytYlMZTaDeYO1f1e2GCn
         cODJeQFzCtEeVP4k6v8KdsFloyH0ZtKW+hcvV0iPaKsmY6nLm5ZszYMBvrD4pGIQWA
         M7F3ODvF5ZCTp/wu6rShp4KRjVwBZHUTcGR7tNMIkDHlJUArUgqsszYvpW+4S1zc2s
         j7eBVU/2wGuHRKlO19C9mVf2/xOYN3P2SqYah8EsFj8lDZpWfF5sFw3lo+cB/KOQcY
         FgnlvPtaKFaA/DNBcEzwkl8gXGUXGqjGVsHBK3jRbcE0zg1B36AhJbhUHfmls3/ehD
         hVvGwULqQUo2w==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 15:17:05 +0000
Subject: [PATCH v3 1/4] fs/9p: remove unnecessary and overrestrictive check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-1-769791f474fd@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=WUnkwoYUUaeSflcgEirZoVzc0KTIoUWAOUey/F0595E=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5+sjS/J2eXctdnFkVSGorDfItoESVfVnLlO
 u1TSResKW+JAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fgAKCRCI/9X7Sl//
 mKnlD/9gTDICEgt4oNIktJwJ54LppB/+HdDJ3lrDEyTHtvDiG67S5Ch9+XTOM4+RwN6L86jYnLK
 Mybtaze2WRW1BDBy9X3P6zzptBG60z/F8Rue9pVC2VNc02MZ1/2kF9yMLvER2uPy0Wyw1Ngvonm
 FHAz9Ua5eIsJewOe/h239t7qsZ2SiP3FtBHI2sVk9XWa0LZG4lYwhqCO0gobnXqZ0I+oddvNRWD
 020NdzQekYrPGAQ+mHKYbBVvKCUq4IajQEltCOU6bMG1sTkkdMLuFqFunqwmtDKgb5ukgjafXbK
 jaY4g0kPJc6KefWoyNyskuP840uu957mED2MrA1+e3OuQOI4Tj5bnGqpMHsxYCF7FCPrGdP9nPs
 Bh9muCBdhe1oiG51rfB/9XQk01XBEGzbnfdc081sL9JYRII2mZSDmg3HsD5+Evb8AHQvaZq5lqx
 DNz9ayNhuHf0eenYlBFO+U5B4L17SPm596RydHEEs1Dj+vs269WbsPYZyKGFPb8Jd5JIyCZHIMD
 BLAzp0i/DoeBSft/PlWqci/Og7kTPLpC6iNv1QZwf/QW3cMaW0SR4uPoBKHRt7uPFlMW8PRCvnr
 oLoqyelLtyD5SR5xvPM+uexBu/25PNQB5PuiJKuZXyH7eHk13rFiMt/Rbfdn1dH+TUzBQtM0pZD
 SroebqlMCsc6LOg==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates a check for shared that was overrestrictive and
duplicated a check in generic_file_readonly_mmap.

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 2996fb00387f..9b61b480a9b0 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -505,9 +505,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
-		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		if (vma->vm_flags & VM_MAYSHARE)
-			return -ENODEV;
+		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
 		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}

-- 
2.39.2

