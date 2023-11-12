Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523117E917F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjKLPsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKLPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:48:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771B3270C;
        Sun, 12 Nov 2023 07:48:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C83C433C7;
        Sun, 12 Nov 2023 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699804116;
        bh=JN7wJA9CtpvoZfbvM/IzDnWhbSnNlqcLwOqpyrdrisQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oVeuQpYNGd0AWhMoyMBrhpNi/V8PnylQGqHRJ1z//j0ZINrVm5BDECZRLCPVPFTuB
         idHjFb/VWGDz8uOAE37aNE6F5l99fT2LMgiMzxEt6rwP1SNWgWH4vw+jKkBlIaQbfM
         rXcquChsZSXNxWR4SCtfCwm/4xWjSyNcDq21/PTOEPJVZcqYT2VLNrXzb+TGl3qdNP
         SBQ15roj+2+FtG6pBFk2+9l2HE2qOK/8uM82ORh974TzU5BuT0IlzA5Us4fHZC2IAN
         qExpWfHhW4XiWsFi0INyLIH67TSgEqghnaJA2jUjkXjYGtqiS4QR4pHuf4J+08uifg
         k2R/Uqbk7AbpA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5] i2c: dev: copy userspace array safely
Date:   Sun, 12 Nov 2023 10:48:33 -0500
Message-ID: <20231112154833.229198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.11
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
index a01b59e3599b5..7d337380a05d9 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -450,8 +450,8 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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

