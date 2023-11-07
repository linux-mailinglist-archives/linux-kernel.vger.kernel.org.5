Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA67E3C78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjKGMQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjKGMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:15:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E844B5;
        Tue,  7 Nov 2023 04:11:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC3CC43397;
        Tue,  7 Nov 2023 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359107;
        bh=Gs8lRYHG/QEOT40sG68E/a1IAjmfaXVTdhAS+MD2BBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfw8FOgxTt1M/QZh0zIgsO/i08gGko3/+IZN49TubCtBfRhDTfF5Mojl0i+byULCa
         rhoOuyQ38rNuFoKTcDJmluxVLgpXyCbxIf2Zh7JPtwSn+73ZSAAnY/O/dw3T6RzVIv
         r3eOA2J1XxUC6PknAtS6163gKOPh+E/IWSrrZDkBBuezAearFXD1xKXhfTAq7OlGb3
         SEiR8qSfRb0iiUjLMHxOx2lZr2rzAWwqzdB0hJfIKUIdUiHSpxDuKVhwPMKfhKJSwy
         gVZJ058qcDYdsxsPlUPG1fcYhGRZSOMhxX2tf34dQt/vmCfgYaT6zZ67vZfTgXeLq0
         t8YHC6n88faWw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sasha Levin <sashal@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 17/18] platform/chrome: kunit: initialize lock for fake ec_dev
Date:   Tue,  7 Nov 2023 07:10:47 -0500
Message-ID: <20231107121104.3757943-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121104.3757943-1-sashal@kernel.org>
References: <20231107121104.3757943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit e410b4ade83d06a046f6e32b5085997502ba0559 ]

cros_ec_cmd_xfer() uses ec_dev->lock.  Initialize it.

Otherwise, dmesg shows the following:
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> ...
> Call Trace:
>  ? __mutex_lock
>  ? __warn
>  ? __mutex_lock
>  ...
>  ? cros_ec_cmd_xfer

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20231003080504.4011337-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index c6a83df91ae1e..b46a8bc2196fe 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2667,6 +2667,7 @@ static int cros_ec_proto_test_init(struct kunit *test)
 	ec_dev->dev->release = cros_ec_proto_test_release;
 	ec_dev->cmd_xfer = cros_kunit_ec_xfer_mock;
 	ec_dev->pkt_xfer = cros_kunit_ec_xfer_mock;
+	mutex_init(&ec_dev->lock);
 
 	priv->msg = (struct cros_ec_command *)priv->_msg;
 
-- 
2.42.0

