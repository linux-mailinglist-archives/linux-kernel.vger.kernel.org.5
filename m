Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE47781AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjHSRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjHSRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 13:32:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4289EE6A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 10:32:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so207601fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692466341; x=1693071141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsby/C1UcyJ8rjbjsYf/N7EFvfuqmKzyTlBjmpiFcO8=;
        b=E7Ku42Dqqgf+CDj2pZlq2dk1dEzmqfhRCXS4NjHGquGpQgwu27YyTC3vKu6dAjIpkO
         O5MqfT4DIYHSlKUcQkXrIySHFbjhF8eUChSIeo0YVcKRnsp8pBas3HLi3bzaTnD+kRTn
         i1HzLj+Rx73kGlbEf9i5faRYtvXaXI/G63nYou/SaA+n1nnFwMdu+WOs+hTVbGAlIHCf
         /WIEDHLLlinLcAX4l2v3rSUGruvEUunI2VXGbaO48u61Jw2sjZZwUADznQC8/KG5r0d7
         5hn/XxUXkcWmmGRI8rV67PjnXcDUQN123YP16ntAkaJMrhdoYznI0lBIQhQ+53t/Mpl5
         sbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692466341; x=1693071141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsby/C1UcyJ8rjbjsYf/N7EFvfuqmKzyTlBjmpiFcO8=;
        b=IRBZNfLBUAItq2rPlrf0GkDIm+lCKpJRWMtEiG24c6G3i8L9Q5qptbrVzSry+gCiZb
         Nw7mFLUV+kqgOE+W66rdqE4aDg6xzDKU5cJDth8yS2kubF+cBjd27+b7gublmLvqY/EO
         VxdobGeI1ea7OFhHjb9cYzwapRpGGTn0DOmCTRJV8Lws2TVrShuhz4Pocdg7h5VFSrYC
         joL65ssHlXMWvk8fTrO8o19q4yjQlJceHa9lx947dG0hCrXvV6lbxjwT96Ff/wmSsMTY
         zA3Xqh/5G/FKIBOjRR7Rby0vkkhHUNxY2MVbYLPWFGA8ZKiN0NdawoIaE5005YM16qdC
         tGvg==
X-Gm-Message-State: AOJu0Yx37OwyzQG94haJwddY9hqulDz8WoEc0i4d5G6REK54Xsd4P/iY
        cJFjvY3pCp4UPX8NRS/HyvU=
X-Google-Smtp-Source: AGHT+IFZiCZgMXyyaT8bSAl0dN1Hov0jEgeh6KnXr88hNtN4pYLIACeBqwyy62bSqn/NXHHicik7aA==
X-Received: by 2002:a2e:9d81:0:b0:2bb:96de:f554 with SMTP id c1-20020a2e9d81000000b002bb96def554mr790077ljj.6.1692466341154;
        Sat, 19 Aug 2023 10:32:21 -0700 (PDT)
Received: from halip-Pc.42.fr (ip-95-221-49-4.bb.netbynet.ru. [95.221.49.4])
        by smtp.gmail.com with ESMTPSA id h16-20020a2e3a10000000b002b9ccbe074bsm1216522lja.73.2023.08.19.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 10:32:20 -0700 (PDT)
From:   Aleksei Filippov <halip0503@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     halip0503@gmail.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: [PATCH v5] jfs: validate max amount of blocks before allocation.
Date:   Sat, 19 Aug 2023 20:32:16 +0300
Message-Id: <20230819173216.6098-1-halip0503@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023072336-seventy-untangled-cbba@gregkh>
References: <2023072336-seventy-untangled-cbba@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
	-Commit message fix. Add Fixes line.
Changes since v2-v4:
	-Commit message fixes.
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

