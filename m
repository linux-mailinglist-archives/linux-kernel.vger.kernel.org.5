Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971137DAEF3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJ2WzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjJ2Wy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:54:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C8C2;
        Sun, 29 Oct 2023 15:54:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A9EC433C7;
        Sun, 29 Oct 2023 22:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620094;
        bh=JmAbRc2bNxm64mujRiq0keRT7xLH5Et6Oi008/fCrMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uk2b7+T0ZHuBUzg8n82ML5+LpQ+NP5wQWAto2jtDrC16lccXU8QCho1sOU4o8EF65
         8yg6otrLkHz+zh0DYeYmz1zpxC2+MJ1Ll+v9Lxxiu8CwUNN7+yQXFp9FRUTmnDOIVh
         BunkXxhsAHceajUiQCEdfInMXgRCqJelRII15ExapHijjw7HTaCuPj2iSKdPsYyhF6
         giIz6Q91aitFsiwH2pzvqm3UpQFoHLYaKk2L935QR+kUhAwdJxCUNm/niEZTz0HFgG
         iaIWyRS8zrxyuBlZ59rIOhcxyf7u+i3sQSdCLkAo4clQfogqHdaAO93iP7AU8/UF1N
         vFJylDSc8kF+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        syzbot+e94d98936a0ed08bde43@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 06/52] fs/ntfs3: fix deadlock in mark_as_free_ex
Date:   Sun, 29 Oct 2023 18:52:53 -0400
Message-ID: <20231029225441.789781-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit bfbe5b31caa74ab97f1784fe9ade5f45e0d3de91 ]

Reported-by: syzbot+e94d98936a0ed08bde43@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index edb51dc12f65f..fbfe21dbb4259 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2454,10 +2454,12 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
 {
 	CLST end, i, zone_len, zlen;
 	struct wnd_bitmap *wnd = &sbi->used.bitmap;
+	bool dirty = false;
 
 	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 	if (!wnd_is_used(wnd, lcn, len)) {
-		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		/* mark volume as dirty out of wnd->rw_lock */
+		dirty = true;
 
 		end = lcn + len;
 		len = 0;
@@ -2511,6 +2513,8 @@ void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
 
 out:
 	up_write(&wnd->rw_lock);
+	if (dirty)
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 }
 
 /*
-- 
2.42.0

