Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710F7E9186
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjKLPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjKLPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:48:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18973253;
        Sun, 12 Nov 2023 07:48:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584B2C433CC;
        Sun, 12 Nov 2023 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699804128;
        bh=XPWJGZALjZK7J71TiOpQmIGmPkfODPV/wRHmnmjv6EU=;
        h=From:To:Cc:Subject:Date:From;
        b=t/vtTlKUvrShLvdKQug8GcH2Ccq02/Df+e/rMnxZMKuRJGDg73uUziKkA2Vn3BTDt
         qqpLjm2wBWVreTp9Kr86L8lL6mY4B6k0RQokKFsrEU/7EawcSlq/WqiZRi/8Hhshia
         TYTtCIizbKTtbOFG3QJtqVzY9qU2L9Sx7/KHcs1plZkEX2RIOF1fta54Z4lTxMZjQr
         OfMRISXfSBuGwSj/DuY9yj8rKEt+FhiQV1PxptKT8bGbUUDCLsOwJcdTfOmsc/E88b
         WdVzsCOaXe4cWzE7t2bXkKQ2ibO2xrxFZUnlEQUjut2vHAyH4L9bHpaJSa2ChFEtlm
         ePQkdJziZ4yjw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10] i2c: dev: copy userspace array safely
Date:   Sun, 12 Nov 2023 10:48:45 -0500
Message-ID: <20231112154845.229303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.200
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

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit cc9c54232f04aef3a5d7f64a0ece7df00f1aaa3d ]

i2c-dev.c utilizes memdup_user() to copy a userspace array. This is done
without an overflow check.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index dafad891998ec..eef58daf1f013 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -451,8 +451,8 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (rdwr_arg.nmsgs > I2C_RDWR_IOCTL_MAX_MSGS)
 			return -EINVAL;
 
-		rdwr_pa = memdup_user(rdwr_arg.msgs,
-				      rdwr_arg.nmsgs * sizeof(struct i2c_msg));
+		rdwr_pa = memdup_array_user(rdwr_arg.msgs,
+					    rdwr_arg.nmsgs, sizeof(struct i2c_msg));
 		if (IS_ERR(rdwr_pa))
 			return PTR_ERR(rdwr_pa);
 
-- 
2.42.0

