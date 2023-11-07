Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC57E4509
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjKGQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbjKGP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9F72BC;
        Tue,  7 Nov 2023 07:52:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3735C433C7;
        Tue,  7 Nov 2023 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372323;
        bh=mkk37DpoUpPoDjSWnvbdSNbSxO0JGzJx4NpLJi6p1Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LD9ya4F+LWU+2WwlhQy39KEvL7qFURenNcDV/d1DeJVo7OVK4QSsi0SfBW9XUbjGr
         tjRtR5IG7qqC2jwQUN4jNP2ZV1kAYdpH1kDX1js+xLH2kEnw8cSrMC0mynm6jX13rK
         r6+wjHraiX56r5yEvwFFrlG1CMAtGPwbSkqQcuym6LCsazaawW/+uZKsbT23dEnCDb
         eZX6WoqEsY7rrCjIj+mjlJdwkS51Y6Jgu2UrZzMg1jETrxqhw/Rp00Y1oicP5sJWPZ
         nA0J8YS5uSGDzWjupJvbUcVFOn/JvrRG2XdyYFXlPDsRovD5NrGu7uO5piT89BImMW
         BbFFP/ix51+Og==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        liushixin2@huawei.com, wonguk.lee1023@gmail.com, code@siddh.me,
        ghandatmanas@gmail.com, yogi.kernel@gmail.com,
        andrew.kanner@gmail.com, jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 07/22] fs/jfs: Add validity check for db_maxag and db_agpref
Date:   Tue,  7 Nov 2023 10:51:16 -0500
Message-ID: <20231107155146.3767610-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juntong Deng <juntong.deng@outlook.com>

[ Upstream commit 64933ab7b04881c6c18b21ff206c12278341c72e ]

Both db_maxag and db_agpref are used as the index of the
db_agfree array, but there is currently no validity check for
db_maxag and db_agpref, which can lead to errors.

The following is related bug reported by Syzbot:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:639:20
index 7936 is out of range for type 'atomic_t[128]'

Add checking that the values of db_maxag and db_agpref are valid
indexes for the db_agfree array.

Reported-by: syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=38e876a8aa44b7115c76
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a700950429c5f..217a673b751ef 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -195,6 +195,12 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
+	if (bmp->db_maxag >= MAXAG || bmp->db_maxag < 0 ||
+		bmp->db_agpref >= MAXAG || bmp->db_agpref < 0) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
-- 
2.42.0

