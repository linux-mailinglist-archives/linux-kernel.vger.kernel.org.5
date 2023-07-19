Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD8759957
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGSPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGSPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830C7BE;
        Wed, 19 Jul 2023 08:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D85161759;
        Wed, 19 Jul 2023 15:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1355C433CA;
        Wed, 19 Jul 2023 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779844;
        bh=E6XjzAYb9Wv8oYLom3aRYwYdeEdNznryP3hobD0L6AA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CbHavf/cQw/xrJlvtM3ACNoao/JKPypDZv35q57vsOt11oXryHyVXIhg7rqCYegCl
         2LzXAH28+xVSLuy1j5g6NyJ2uZ0Es4NeqsoDjdYWabjKbQRXHO4PwFqOoKk2M4mmbH
         9hHRUW4s8FxVGA6HbuF088TbCSFfRWBFPsizt4r7jCY5G+OWGvHWkc7HvchkvGFP5s
         OEZP6mPDYVXT56i6Fz0eGtUjm6Zt8Kqezl6/P1kPeWOvi+jR1K0y/DXNx0lqHwEkhq
         EyOI1VriQRDO81Tr9GmNUPhjSWOouEDEVpOr6bmEN7pWaNSve8+7Dz5ZJuXJ3Y2trv
         LDeWzoVp5/NgA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 15:17:08 +0000
Subject: [PATCH v3 4/4] fs/9p: remove unnecessary invalidate_inode_pages2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-4-769791f474fd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=E6XjzAYb9Wv8oYLom3aRYwYdeEdNznryP3hobD0L6AA=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5/O/0AVC5JOGzadqwGbJJ1VIXriZIyzCt4q
 YAmlkbSB9CJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fwAKCRCI/9X7Sl//
 mI35EACitPglHMdcam1474rTYkZfuDo0JBuCs+MFd+lWN98XeGkTRk7hKEELWQIlnzFiHogaR99
 2jCVCuVR1zV9hcdTcc49gAwPqAJbc2uLjXkUAYsLECXzrK6Ow7nM5zDmub2meHGMrRj4PJfKVl2
 A4WkW3pgGaaAol8PWLJgmPCHaLxOY2HLr4u+rhn1LbjTJoW7hCQSt72WzFqUlZFGwbxyu8jmswR
 Ba60h6VUMVTzYI5AjGjA2Bfoc3X7G0Ls8KmuyugRQ1dxpKcR7pMqJbz8ktLYQwsEmMR3V5GdU/x
 T76NPEurUOV0VeBV5RIK8/Jr9CYfIYhw52TC82jx99RrEfJt6KBADEJUMRiWkMBmY7HL1FM7c2S
 Dgunry2SxIlEfY7PoiY7HW/nXKalrS32MZuUBi8O5JfP/N5nX9ECJrxZiRYh6hkz58gzcPlptHX
 kFEXPs7IuWAVwL67RPvNPkc5x+HegNUeNi76vswaRjlTyWVK9f2CmUdunJtiWrJxzGjVJQcNz6D
 icBiieMND9MYYnC10DVn5nhyKz0UIZRdD2UGb1G1SGg3ttYQ0wnVNj7Du1/IgP/xLHy70UnyPwf
 40OjowiBp0DkxsXVsuRgm29GTAwA6k4Jt0FzguDuQM+GLbEMo9y1iOXllGrKzBb8PKsWNcu88Mi
 sbjkcO9IeuCgCOg==
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

There was an invalidate_inode_pages2
added to mmap that is unnecessary.

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 9b61b480a9b0..11cd8d23f6f2 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -506,7 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
-		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}
 

-- 
2.39.2

