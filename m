Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17509803C34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjLDSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjLDSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:04:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310F5B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:04:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FCCC433C7;
        Mon,  4 Dec 2023 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701713071;
        bh=5uILUttJEnB7yuvoHAjCIDDFlCw2Yu+1VyECoAyrkIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Px+gBEtB5gOIxbUSaHIJWKJfoWuoWSWnf7cNY1RJkYdRobSfs0sVl4iE/qxgEtBeC
         5EkByepKhfdqd782afxg8sn7qQ9SgjZqXqgTD1CmLpXx5NyNMIINjUeXi16A6M1Qud
         S2t0nAjbzFCinfGqKkxBKhqXqWMKZfmG0lBUkIl+zn7TK5Y0kddtUEukKPNSgRDwu1
         C1XqibzWN3PfcchsBmRftLKw51hSZMR8IwVhMNlSjq0l++nP9xOGm3IMwqrI8j9dj4
         Y1htIwkHuZKcIZToWAm1OTPtzVntKrS5hS1ol1m/eIpqrBo8bnZUXlfmCty/tS+wVj
         E1rYcTfM4OFBQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: fix write pointers on zoned device after roll forward
Date:   Mon,  4 Dec 2023 10:04:26 -0800
Message-ID: <20231204180428.925779-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
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

1. do roll forward recovery
2. update current segments pointers
3. fix the entire zones' write pointers
4. do checkpoint

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 16415c770b45..d0f24ccbd1ac 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -917,6 +917,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

