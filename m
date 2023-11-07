Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591167E3C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjKGMON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjKGMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:13:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95EE35B5;
        Tue,  7 Nov 2023 04:10:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2ADC433C9;
        Tue,  7 Nov 2023 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359043;
        bh=MtEg56Db1ITpZqsJ9sWS9PdSnPZ0PiHqxkymMm27JNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9bD5zFMyd+vGdmzOX57/wy8n+pmP925cgd7G8V8ueNN0gtMqrKfb09iDcHSgWMNV
         gOQzT2M9WmQFuS3Q8PPrMNGDQ4w4SgcizqH44wbMWKOlunz0dYYjefwQtEVwieBLjg
         x6dQV84ce4R92nelHcYvhiSNrNp6Hqov77QkrygaIYjmeh4rTueN7xAUxMmIDGaRSV
         UXWLR7MtXba1inE65KFr7PhVA58mJELQE4dytX03lvD8VuUYqKI1PKu+twxCbciyN2
         kw10CPuZqofF2vDCjPixPYJl9KcGhNeFiPIZYvFRPVPxo3h1d8A81fkiAbntcx0DC4
         tkQF7Ztzx5ISg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sasha Levin <sashal@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 28/30] platform/chrome: kunit: initialize lock for fake ec_dev
Date:   Tue,  7 Nov 2023 07:08:43 -0500
Message-ID: <20231107120922.3757126-28-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index 5b9748e0463bc..63e38671e95a6 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2668,6 +2668,7 @@ static int cros_ec_proto_test_init(struct kunit *test)
 	ec_dev->dev->release = cros_ec_proto_test_release;
 	ec_dev->cmd_xfer = cros_kunit_ec_xfer_mock;
 	ec_dev->pkt_xfer = cros_kunit_ec_xfer_mock;
+	mutex_init(&ec_dev->lock);
 
 	priv->msg = (struct cros_ec_command *)priv->_msg;
 
-- 
2.42.0

