Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778877A8E0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjHMQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjHMQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB7358B;
        Sun, 13 Aug 2023 09:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1766383D;
        Sun, 13 Aug 2023 16:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86217C433C8;
        Sun, 13 Aug 2023 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942779;
        bh=uIkzi3MpeaquzFsir9NCDcM8HNJILcdPwSbHMHvylpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0qm35IoJHA3xgA0JCFi6R6pXl/HCF1D+R72tL8YwtP60CcLafKEwdcFlSOVXQM8Z
         3qDeY13sc6Blu+7J7RAOHiWO2PSNcMTe701dIp0DfstANq+To3SsnmK86EO3ZiwFeS
         dtt/5ub6miQYxnLJlUGh7t9E2oRKv07Sx1lAeARUlVTk2uUd3dUyOaycigSFojh5gD
         yRd1tfUkzccohADFY4ehfbbclyKsrhqedBA+G/1D04LraLsIOG8foWgHLO3ZHSLblP
         ROt8M6sAa0PPGdaEL+H85tby8pPtmEG4pnsacnKODljIm0zEjONfEDZq787aOREwE9
         ElarrFPe1pM9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/31] media: pulse8-cec: handle possible ping error
Date:   Sun, 13 Aug 2023 12:05:36 -0400
Message-Id: <20230813160605.1080385-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 92cbf865ea2e0f2997ff97815c6db182eb23df1b ]

Handle (and warn about) possible error waiting for MSGCODE_PING result.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/usb/pulse8/pulse8-cec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/usb/pulse8/pulse8-cec.c b/drivers/media/cec/usb/pulse8/pulse8-cec.c
index 04b13cdc38d2c..ba67587bd43ec 100644
--- a/drivers/media/cec/usb/pulse8/pulse8-cec.c
+++ b/drivers/media/cec/usb/pulse8/pulse8-cec.c
@@ -809,8 +809,11 @@ static void pulse8_ping_eeprom_work_handler(struct work_struct *work)
 
 	mutex_lock(&pulse8->lock);
 	cmd = MSGCODE_PING;
-	pulse8_send_and_wait(pulse8, &cmd, 1,
-			     MSGCODE_COMMAND_ACCEPTED, 0);
+	if (pulse8_send_and_wait(pulse8, &cmd, 1,
+				 MSGCODE_COMMAND_ACCEPTED, 0)) {
+		dev_warn(pulse8->dev, "failed to ping EEPROM\n");
+		goto unlock;
+	}
 
 	if (pulse8->vers < 2)
 		goto unlock;
-- 
2.40.1

