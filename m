Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF777D5D70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjJXVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJXVsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:48:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8791B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:48:27 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
        by smtp.orange.fr with ESMTPA
        id vPGBqZo62QRiPvPGBqyjSG; Tue, 24 Oct 2023 23:48:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698184105;
        bh=1yYR+ID0Mz0XbBfGN+NzNx5JNviXZsmBmncVbRmUG7g=;
        h=From:To:Cc:Subject:Date;
        b=RyiQB+iFm3iOfwasBnQWnJn1ove8eCS7mgflHV15KRBlHBVJtSCA4HkPhL1LZTQ3E
         VxHDWNKDd+hpHmWlDx9ATTHXlVRRieE4SDUaHYD93pzWE00pvmJf9+O5fPAXr4zAdm
         GwhCULy2kBImzbQsRMHIo7tdR9ws4d+DvbitdaXzei91gkp8rmxwUdqodV82z0smqX
         nJKGQM8MpNFoUuV2lgLH0CGyyJK9JjLnK06mSQvHuyaCFMvV7QJXJOrfZqqJs2u67z
         Q5uKZvCXF9fZscpRJw22480bt5mkw0d1dfSPinDZjX8k7sodRCUdAfuiUAKY0B6+6j
         8OZasVVLpv4rg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Oct 2023 23:48:25 +0200
X-ME-IP: 141.170.221.62
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] NFS: Fix an off by one in root_nfs_cat()
Date:   Tue, 24 Oct 2023 23:47:42 +0200
Message-Id: <7f97bb62c4e8137c5d7f7a7a30789440a5102b3f.1698183837.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent is to check if the 'dest' is truncated or not. So, >+ should be
used instead of >, because strlcat() returns the length of 'dest' and 'src'
excluding the trailing NULL.

Fixes: 56463e50d1fc ("NFS: Use super.c for NFSROOT mount option parsing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/nfs/nfsroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 7600100ba26f..432612d22437 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -175,10 +175,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
 	size_t len = strlen(dest);
 
 	if (len && dest[len - 1] != ',')
-		if (strlcat(dest, ",", destlen) > destlen)
+		if (strlcat(dest, ",", destlen) >= destlen)
 			return -1;
 
-	if (strlcat(dest, src, destlen) > destlen)
+	if (strlcat(dest, src, destlen) >= destlen)
 		return -1;
 	return 0;
 }
-- 
2.32.0

