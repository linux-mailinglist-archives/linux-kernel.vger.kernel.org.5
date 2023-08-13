Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE4077A878
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHMQCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjHMQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA61710;
        Sun, 13 Aug 2023 09:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D3E60B3D;
        Sun, 13 Aug 2023 16:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0DCC433C8;
        Sun, 13 Aug 2023 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942422;
        bh=uIkzi3MpeaquzFsir9NCDcM8HNJILcdPwSbHMHvylpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiXtNeIJk1aLILorQn4U8QeoLlNe9ESaZDKBPk0Ya1rNpd4XwmjFrVFQNKoEmfepq
         xsSNDUIWsNAQfIWcBD5QUV24uY1h3fqwd8GU+5cCh2e6Mo18qEgbizohHDjHOqighi
         mSvqT7jTFfoJPqtHceyK8TTJYfSZPHHGM83D5O1Q6uThqW7KlZdAClLCqxqbWU1MZK
         MCX27Gg8LsXWWZLaqZZqAUDqj5P8YxsDXHSIOJa2IqYd+zS4XG+H0Lf/rS1UF37R8d
         plNT13GoJPO2zU13sN9Q4/BpKRooamU7nAXNa3m+qIcSFRAb8oEK6N52mLd/FYJjKp
         dFLezLwcP1vCg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/47] media: pulse8-cec: handle possible ping error
Date:   Sun, 13 Aug 2023 11:58:59 -0400
Message-Id: <20230813160006.1073695-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

