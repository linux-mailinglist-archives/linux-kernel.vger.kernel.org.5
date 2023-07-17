Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CCB75691F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGQQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjGQQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E651B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A31A6115B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34661C433C8;
        Mon, 17 Jul 2023 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689611345;
        bh=HtOElUNyoZNBTq+YJJPGA6QUAQwhzK9Ts0x7WmL3Ogs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hkI6fdXx+442oIfRvhPZtlwLRAzVGAH2TUWRkO0HgzibV3xnV7FtN3EEfECZKv1BD
         kotg7kLZd/xdqnt1cVqDuIvspSGamAURkn7SQFzKVPlt6a1ar2/QvMHVyIZlbWIci+
         /XvOh+MAV8tKYulIdNsNARGdQWzRPrZ27FzsUQi8DTZE5gpFHlN0onNHE5LHYodRa6
         2xddGuY49CzDvV0U5jomPjtnLsV3EbIWfYtg/lzuNk/AfLU/q6acEdXlMd8ZbFgWme
         C9sbZPEjrOHjPWg8T4T/tSCB7VgHsTJtDa47HHRSbaFdHPwiwA1QoIhKKMMe0Ys/vA
         z/7BQJS0AvIRQ==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Mon, 17 Jul 2023 16:29:00 +0000
Subject: [PATCH 1/3] fs/9p: remove unecessary and overrestrictive check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v1-1-0683b283b932@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=HtOElUNyoZNBTq+YJJPGA6QUAQwhzK9Ts0x7WmL3Ogs=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBktWxPX9pZef4TUTigWeU3IyymFufia++0mC0aA
 cCwpcYpqxaJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLVsTwAKCRCI/9X7Sl//
 mHmSD/9B8p6xF2EFjQMbCX6wfXlqLY72QBgwxjLmcSJNov5L0lYLkg0kzZxkqX9ayV24SkeXDww
 T7XYiKG5Z9fkofZ/MqLNgOOIxGOHu/e6XKt4e5NQ/KApJecLM0NdYGGbw3pLY7L9kfx6on+CCvT
 SBUcguO7Jra30yIewz5WLmc1S8kDQSPQ3qRz2MYOczeI+f7s7Bp1kQeh287QJOpbPNhyIpoqsja
 F5p3ggxbSlSzeoWj37gouzpQO8ETr7LLELU4UAr7VDXG2D4SJ08hftpnySiQN/ZSu5xrPC4fGlI
 CcHVa53YvOdfBSF7YDEaMonpmp5TxxzElDDoe6n7LHKIrB+n5tun/sN674PbHLmA6GLnDXaJQZ0
 MJ8OCc3dq5/nvSQQ2TeGOGrYWlB3elTKCMKwiqsT/eEM6gDoJv1OMcd5DJn839LtHPILc0wFZX4
 +81bV3bUvPLSiZsYBlNOyTWuyKEgcUDnoRPfP6tzzMyI5dIABO0zS280WBixurkxoE2PRmqvR1a
 YRzotcC3Y/YDeUQ9Sdr6wyAO4Nu/BDffvU5ibl+v/8/1UgtmMnSpVzl7nrxUIzx/6chKYOb7lqv
 pRHW8T/ltnnL5DF3PAEpXxc0tXMov5H+ro6DVNzlpjWWpye24gFmWcJ252FUwQENgQJmEyOFu/i
 MRll+XH93fvfmWA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates a check for shared that was overrestrictive and
duplicated a check in generic_file_readonly_mmap.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 2996fb00387fa..bda3abd6646b8 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -506,8 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		if (vma->vm_flags & VM_MAYSHARE)
-			return -ENODEV;
 		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}

-- 
2.39.2

