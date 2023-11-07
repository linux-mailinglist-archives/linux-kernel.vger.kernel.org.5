Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCE7E451B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjKGQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbjKGP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623408273;
        Tue,  7 Nov 2023 07:53:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E94C433CB;
        Tue,  7 Nov 2023 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372383;
        bh=0bwtTsVDxSCW5FTK2U8iuhN4M3Nv3/0UJrXwC5+g4Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXhdCRQCxxnGZWqEvRbOY3iEfAymiFRwL8e1NJrGRgnRWfaEEamZYIPMuY+9rYt76
         sOdBYso4H8uZxftFUSK60DBt7m0BROvz80hGCwDM64ZUJsPOVrkdddgbZueO493hJq
         R+GonTnavNDfcDgVJmUOUdihA7jzN1h/WLqYUI6Z4nF0tRiD4Pikw7Lkzy7yQFFTZH
         BPOfZaMZQq9EchG31jmxrhwNNP20PzCUrxZ1nYJONJVkQ/CsUY3a84awz2Ukevh3bg
         7ultyk78CxysKBqlEid3DQbJO3T2Itx/8+YBGm1CItIl/uvHrUED2SYP0SzAsZV4co
         OKLua72Jus74g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juntong Deng <juntong.deng@outlook.com>,
        syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>, shaggy@kernel.org,
        andrew.kanner@gmail.com, wonguk.lee1023@gmail.com,
        liushixin2@huawei.com, jfs-discussion@lists.sourceforge.net,
        yogi.kernel@gmail.com, ghandatmanas@gmail.com, code@siddh.me
Subject: [PATCH AUTOSEL 5.10 05/16] fs/jfs: Add validity check for db_maxag and db_agpref
Date:   Tue,  7 Nov 2023 10:52:24 -0500
Message-ID: <20231107155249.3768098-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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
index 06dda2c7a6e24..2ccb52371ceb5 100644
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

