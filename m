Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976437FD626
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjK2MAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjK2MAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:00:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A4DD48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:00:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8D1C433C8;
        Wed, 29 Nov 2023 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701259241;
        bh=n2nAGxbaM4bdUExVSTPbG6T9Ltt30lIhFwcPWN7vNO8=;
        h=From:To:Cc:Subject:Date:From;
        b=lR8pczz+YIOlEBwSdhbDA/LVQ12dQ2u9nO+Hghy/NF/HjnaDVkOfmyvbPCtzx7TKg
         tQWbDZW02R9WyulystAPJr+vQwm9E98sAFJv5kRXaIkXd+ZnPNAWfTEfzxWLqheHuM
         4XpHvHWTUBF6lNDHTpJYZlWvu2RQ8g81HvWYN5OM5uHsSub98AtYfGNS+Xi/NMqrw8
         uQL/2hZv4HFjz2qVRw77alR1CqHdnpi5FHjmogBrOj/ZkN8s1SdDRdkiqmdkbp9lAQ
         RCXD4F6J6Oa9zxjbVD6MCca/jPDdpkpwg1QIRtnAe+2uIjEcjJXTAe1YETnOo72cB4
         ySy5sSvZnSVWA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix btrfs_parse_param() build failure
Date:   Wed, 29 Nov 2023 13:00:29 +0100
Message-Id: <20231129120036.3908495-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With CONFIG_BTRFS_FS_POSIX_ACL disabled, the newly added function fails
to build because of an apparent broken rebase:

fs/btrfs/super.c: In function 'btrfs_parse_param':
fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this function); did you mean 'net'?
  416 |                         ret = -EINVAL;
      |                         ^~~

Just return the error directly here instead of the incorrect unwinding.

Fixes: a7293bf27082 ("btrfs: add parse_param callback for the new mount api")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 59fe4ffce6e7..022179a05d76 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -413,8 +413,7 @@ static int btrfs_parse_param(struct fs_context *fc,
 			fc->sb_flags |= SB_POSIXACL;
 #else
 			btrfs_err(NULL, "support for ACL not compiled in!");
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 #endif
 		}
 		/*
-- 
2.39.2

