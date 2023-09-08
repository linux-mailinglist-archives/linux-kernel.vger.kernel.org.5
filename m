Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB8799048
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbjIHTi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbjIHTiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BBA2127;
        Fri,  8 Sep 2023 12:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4411C113C9;
        Fri,  8 Sep 2023 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201798;
        bh=qolxTgZUgbllgyJ01CCZ5WCfRWTxBtzSJ4F5lmg0HCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFUk9/v+5Odr1ITT/dhTwdQRN4xoqoDL04nDJth1p8zjKf608jRT7S4aSvTPhbNIE
         rMBJIinBGDcTkjpTXEDculxcYeuJ1U1hmlzqCh4ekpA4Xgh1kxioAhVYbBbkH6c4d0
         cwMtZRhFXinduuoPS21cyMHm+tz7pnW5d9kaPu16/pur5pljuqmXUK6lh5TOFEK1in
         M7nmR7H79+1FNvQ7aM5T1kOBwFbShg9DD2h6ht8ymmwYOLrGhlJL+ZO39FwKIKRiEc
         56r5VSWG2TIW27zOBC4j7J65xLw19ENeJGGVVvFI/3ooPuguPvdMdexIO1i4NwLHoh
         z3qgK6rxb6rNQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/9] md: raid1: fix potential OOB in raid1_remove_disk()
Date:   Fri,  8 Sep 2023 15:36:09 -0400
Message-Id: <20230908193611.3463821-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193611.3463821-1-sashal@kernel.org>
References: <20230908193611.3463821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 8b0472b50bcf0f19a5119b00a53b63579c8e1e4d ]

If rddev->raid_disk is greater than mddev->raid_disks, there will be
an out-of-bounds in raid1_remove_disk(). We have already found
similar reports as follows:

1) commit d17f744e883b ("md-raid10: fix KASAN warning")
2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")

Fix this bug by checking whether the "number" variable is
valid.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6b5cc3f59fb39..25be491c1a6ac 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1791,6 +1791,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r1conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
+
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	struct raid1_info *p = conf->mirrors + number;
 
 	if (rdev != p->rdev)
-- 
2.40.1

