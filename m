Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEEA759AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGSQXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGSQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B454B6;
        Wed, 19 Jul 2023 09:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB3361786;
        Wed, 19 Jul 2023 16:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11562C433C7;
        Wed, 19 Jul 2023 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783775;
        bh=k0K6ocifQ0ciwTzxXH7M8DUDHsKfrzNua/KxUjjXkFA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=T2LZDWcO5puV7VRCOsBgGotJisgKYwNNFQPAB/HDRTnd0Ladvgmjla4PWV4BzPlYt
         i5xnpx5OP7rCjVfadkGllgwQuwN/eKoDlsQBe22il4LQzHMWer1aApYyMMSLWl93nH
         ipkU+jYlLEzhSpmE5oJlURyvBuQEhyZpl47om/5yysQ7Smn3Qg6szrq4OY1rk6R1EV
         QNdrGIH+VXh0LsjbUaXTquUsLvNjePH8ah6azGRLt7xXZoIqNaXR0lBsG3js4uYk2S
         CLddkeUGPjnORTEJfT5D7Vsoy7rZaCAVSD6xKsOKY0hZtNWJtHMp3p4k1rOqqKOdt3
         VtNvQayijlXaw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 16:22:33 +0000
Subject: [PATCH v4 4/4] fs/9p: remove unnecessary invalidate_inode_pages2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v4-4-a3cd1cd32af2@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v4-0-a3cd1cd32af2@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=k0K6ocifQ0ciwTzxXH7M8DUDHsKfrzNua/KxUjjXkFA=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkuA3ZNyXqWHLoseJ3EWeJrogkDkPGJ82+WR+E+
 0fnABkiAwuJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLgN2QAKCRCI/9X7Sl//
 mH8ND/9VN84P0uGYO69TQEHK08nFdvfeZKbb3riQpl7CAFJtG+EtOYdws4XwZ8FUHomM1KMghDr
 dPYNggkxw5oDu+dtozFz92PR9eBD8Ip+DBFPoilAM/x4/Z1Uq2emVkldZYVIPu6ry/DxZ+Safne
 pWnMVYb1tK6e8gHgUL85BLi+r4koXFs7GZBtQzjGyiKGE5ruEPgc2/wRuf8z2lceXBVAwjdRvAa
 h2mvQ314jDebSO2w2eBREQvuy2BiylBEHvUHebN/agJpNSeh420tc9N/We9aiybdxflBv777gTq
 Wi3hytnPFjfErlzhhLs0wV1ZOw40DHbMSdlIfUpRg/6JcXmAZF7NEAjmysyMuf1+xtERKNjYFu9
 T2K+G1lQc0oACO07LebKqrY+aOrAYco8FZ9lEiKcnUWGEACgYiJgMIHJso9CCHY9+BM006uCuOW
 nJyWFxuRMYyYVKOh5w9jeKn3xXbx+rgTv4Fyy6Issr0hfD5+vUIckGIX36kaf1FfbsETlkzKrZI
 F1wQGbO466Ji+hjUYC5NpG5IduYMELK2gD5DrPck47M1BbGYhlO0poXe2HY2vRA0yojTLF9D7kd
 qe/S3ODW3fInC1vZsOPDoPtqGpbkF8LuX/G46f/kXVzW0Njm5eExaauysApKAC40+8cztAVmmiL
 ylMKFr4wG2hvSEg==
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

There was an invalidate_inode_pages2 added to readonly mmap path
that is unnecessary since that path is only entered when writeback
cache is disabled on mount.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
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

