Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14475E1A8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGWMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:02:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE3E59
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:02:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b708e49059so49532151fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690113746; x=1690718546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp84CK0/t53LIziRQtMnNYNguwF9Niz8BKJjpaj5EsQ=;
        b=SsQmrSLsSZj31ndKi/URN5NngEUc5GwOSe1IBIddkJfba3p0Hb+/I67WBvzQ8jg3lJ
         OJ1/XT8Yq3mhwdIdbGSxT/gY47hLyzA3nBssatWk2Z0TCiJ1Mo7RPqtAL5lOESKPB3HW
         KqOJ+8nLzr5KIEkhKWrq0CF6ofjSAAjwb6htrdorLUJqHNx5Iu/irqCwPXPuoAxUWtzs
         MK4yFmR8IjRKIQXrVgzfWEHGkANqurMz0GuZtYge5MA3iNDkko1+TAllLueMnlBmRwRX
         jV5nmde+YKtOAUdZw2PCXnXTcOme3rLSA1Ic6y+jRv+zPtrfXUf2gn/B7yeQAJ3lu3Id
         mj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690113746; x=1690718546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp84CK0/t53LIziRQtMnNYNguwF9Niz8BKJjpaj5EsQ=;
        b=iJ4MbHnAvCU7Nu3ykieDnSRtGYnDn+RLIJgLMT/jAawLpDMB0uY2o89L6CW7p3mEMc
         0phh0grZduP+t6vBw8whq5uX25YX0/HgaeHfWe+2QgTS9bvXWDL9Ato1lZAbFbb+3egB
         5s6E0wizadz9GMlg9wirwXnuGJK9wykA4jQuB9SSUeSVdzix6BSpsZOe2cX8aGG9PFF2
         +oMXMF9SuvOFaPjhY/K0S3tYdDJwRXQ8AVvDOtSNpRYictbkK4b/2zjdbmT+B4q9XZcx
         ijDEypjbF3vg8hq6jGbELTXOlCz2pV+m43MQqNsHb2IofKx6Jle38W8cMjMBchzXjJHd
         xOuw==
X-Gm-Message-State: ABy/qLYHIdCHyx+6aKHHmyOpm03Jn/6na7ysJ9/FfR4Y6VBZWeJUn9fm
        Dn/zTByzEiErXLSLP+1VdHk=
X-Google-Smtp-Source: APBJJlHRkKReSufvhMX5SHEhWtQf0LH13mHE4Jd7TZJ7Ubo6R/iTXzxsHoyuVRUdqaNc/tnft7iteg==
X-Received: by 2002:a2e:b0e2:0:b0:2b6:e13f:cfd7 with SMTP id h2-20020a2eb0e2000000b002b6e13fcfd7mr4575889ljl.4.1690113745934;
        Sun, 23 Jul 2023 05:02:25 -0700 (PDT)
Received: from halip-Pc.42.fr ([93.188.41.70])
        by smtp.gmail.com with ESMTPSA id 5-20020a05651c008500b00295a96a0f6csm2043034ljq.102.2023.07.23.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 05:02:25 -0700 (PDT)
From:   Aleksei Filippov <halip0503@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     halip0503@gmail.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: [PATCH] jfs: validate max amount of blocks before allocation.
Date:   Sun, 23 Jul 2023 15:02:09 +0300
Message-Id: <20230723120209.7963-1-halip0503@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023072251-spokesman-zebra-908d@gregkh>
References: <2023072251-spokesman-zebra-908d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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

