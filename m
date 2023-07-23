Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01675E22E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGWN63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGWN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:58:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620510DE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:58:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b96789d574so44959871fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690120705; x=1690725505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx+BOxtIPU8gktzCgzqrNzfYg5FyuT1kOcOCTJVEq+Q=;
        b=olxlfNMXs/3xj8GgHWqHm0coAHVLgDCi7z0EckxdIutSFknLv7BAYyDzd/ydfqGUTW
         VP4J9bEJ+aUPI1cS/6kP0a7oqZHqDqEL851y5nUudVJbXQi2MK+1sQw5s1vbyN1tCk/M
         xghZQ+hVNVNY2zgAeNLnlZb20vrQiNItkAgaJRQGEOlmxxOtmUMLFOgHPsj7YZoTlRHc
         uxemQRGNxvXgra5r6bHwRszl+/LDX2/hUAgYcGopvdazmKbZxqK8C5txEEBxHrDeE9Qp
         XzKvoe+5D7Cz9/KO7wgghptYCJescba05f8LPFEyMTZ2tndXFSEXI/xmM4RDAlMZ2rdU
         xN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690120705; x=1690725505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sx+BOxtIPU8gktzCgzqrNzfYg5FyuT1kOcOCTJVEq+Q=;
        b=L462z1to1rlD4iZOn8Nud5Ld7a3VDYp1xfkNDu393Wnr4E6Bje+ajIx7Zrygqh4tMK
         5d+ugZhK+fhQOEz/LzlntudABEjWjJyrgNonq+tHvXH9pDGMxZTiQSyOY/epSatHL6Hb
         xRhPft+eeSe54sXnd++BxOGahXQ7wTWaDRpmEJRVB8i4GJzs+6eS044qt3LfEDjjpJ32
         QQIcM0a+yd8iSfn5/ZIHqcMMjYsXxx2f5jwCYxeD3aclODhbsJuTAhVjrFO1r18JiZJe
         MHH45UvQUsXiS3u9650ctAneqWvrAUONJ9vvCKqf7YR7/u8LNOptgenvvWXJWmlOiy92
         IWWA==
X-Gm-Message-State: ABy/qLYMAfV9pf4EUzDjef9UKag5Pg2a8oKAHT4HROTTKovkgY1B8ZpG
        1qyJftLHhm1m1zIVJObwH34=
X-Google-Smtp-Source: APBJJlEmfCuINVDwQK6PzXOtJaD8Cxiu+IUL+Vl6kTMD49A3y63OG/0dbTkKlZoa6RN9fd+LJox/Wg==
X-Received: by 2002:a2e:9b15:0:b0:2b4:7f2e:a42d with SMTP id u21-20020a2e9b15000000b002b47f2ea42dmr4390680lji.41.1690120704584;
        Sun, 23 Jul 2023 06:58:24 -0700 (PDT)
Received: from halip-Pc.42.fr ([93.188.41.70])
        by smtp.gmail.com with ESMTPSA id r17-20020a2eb611000000b002b6daa3fa2csm2091579ljn.69.2023.07.23.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:58:24 -0700 (PDT)
From:   Aleksei Filippov <halip0503@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     halip0503@gmail.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: [PATCH v4] jfs: validate max amount of blocks before allocation.
Date:   Sun, 23 Jul 2023 16:58:22 +0300
Message-Id: <20230723135822.5362-1-halip0503@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023072335-penniless-coleslaw-3aac@gregkh>
References: <2023072335-penniless-coleslaw-3aac@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Filippov <halip0503@gmail.com>

The lack of checking bmp->db_max_freebud in extBalloc() can lead to
shift out of bounds, so this patch prevents undefined behavior, because
bmp->db_max_freebud == -1 only if there is no free space.

Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
---
Changes:
Fix commit message.
 fs/jfs/jfs_extent.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index ae99a7e232ee..a82751e6c47f 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -311,6 +311,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 	 * blocks in the map. in that case, we'll start off with the
 	 * maximum free.
 	 */
+
+	/* give up if no space left */
+	if (bmp->db_maxfreebud == -1)
+		return -ENOSPC;
+
 	max = (s64) 1 << bmp->db_maxfreebud;
 	if (*nblocks >= max && *nblocks > nbperpage)
 		nb = nblks = (max > nbperpage) ? max : nbperpage;
-- 
2.25.1

