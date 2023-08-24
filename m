Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE4786CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbjHXKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbjHXKmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:42:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A80E19A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:42:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf078d5f33so52269875ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692873721; x=1693478521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydoYhmo/zUvr/Z1jqPRUS4uEIJI8i2ctDqfsePibZ0M=;
        b=j+dJGmOnwFeanBncZxVZvZXDdOANE32WW+vw/iNPUL0ILVzlBSEFppcBXzFD+4nHDw
         WDZkcvHZrG2lDUkUEqCtDbaDjj6P9RZXLwL+Q2iQl3XehAvnZ06VtCkoHYMZvb1UfJSm
         XQj5mgQokXWMgcLNvVRQ4s3flUWFlQ95iUaPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873721; x=1693478521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydoYhmo/zUvr/Z1jqPRUS4uEIJI8i2ctDqfsePibZ0M=;
        b=bm6vCRQ3l+8NjoMVW4CD3CfRE9a3MoiSY+evDdxq98NiN5CmU0mzp56I+5ezw12IZr
         /Wex/ezpWgQCqYhQKUKkKNDVghT6Q/FjUGcIjQS3WIUoPMlJ+2Nx4B4JnJcmDgw4OF0B
         cVetnNaY/xkL8R564gQTqTIl+f9YFklPnHryV3ZIYrGZN/ewgncGRecyJNmYkkNfoHlY
         i0pRUM6HIJiKeb/yWy089SyJ8IEc4+CYEVw4vdghoRMpdEZcpzWR6usXAHxpB7qVu9NJ
         LtO3/eUruArF8tGmr/YGJFhTMmtyELRNNgmvspfumeymSKxdeV81T7IKzUmYouHMhlFT
         Nc2w==
X-Gm-Message-State: AOJu0YzMwoLMuGMiJ2pSoko9XK7eaMeAm+Muc6nYVJC4YrMQowwJAJ2d
        D7O3EzXFB2QAiVQGBGpPkYXS4Q==
X-Google-Smtp-Source: AGHT+IElZ1QAwdCYRCRyL6bvp8lbkZPrWVHjamIivTYTyzrIfMNAh7MSIJqXviqpBH4X+ld/2/CnDg==
X-Received: by 2002:a17:903:2446:b0:1b1:9233:bbf5 with SMTP id l6-20020a170903244600b001b19233bbf5mr17338652pls.57.1692873721059;
        Thu, 24 Aug 2023 03:42:01 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ed6d:42e3:a23:8316])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b001b5247cac3dsm12524645plx.110.2023.08.24.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:42:00 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] spmi: hisi-spmi-controller: Use devm_spmi_controller_add()
Date:   Thu, 24 Aug 2023 18:40:11 +0800
Message-ID: <20230824104101.4083400-5-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824104101.4083400-1-fshao@chromium.org>
References: <20230824104101.4083400-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to the device-managed version of spmi_controller_add() and
delete the unnecessary driver remove callback.

Signed-off-by: Fei Shao <fshao@chromium.org>
---
Note that I skipped the conversions in spmi-mtk-pmif.c and
spmi-pmic-arb.c because the driver remove sequence would have been
changed, as using the devm version will postpone
spmi_controller_remove() to where after remove callback is executed.
So it turns out only hisi-spmi-controller.c is updated.

 drivers/spmi/hisi-spmi-controller.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index a5525902656a..674a350cc676 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -308,7 +308,7 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	ctrl->read_cmd = spmi_read_cmd;
 	ctrl->write_cmd = spmi_write_cmd;
 
-	ret = spmi_controller_add(ctrl);
+	ret = devm_spmi_controller_add(&pdev->dev, ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "spmi_controller_add failed with error %d!\n", ret);
 		return ret;
@@ -317,13 +317,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void spmi_del_controller(struct platform_device *pdev)
-{
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
-
-	spmi_controller_remove(ctrl);
-}
-
 static const struct of_device_id spmi_controller_match_table[] = {
 	{
 		.compatible = "hisilicon,kirin970-spmi-controller",
@@ -334,7 +327,6 @@ MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
 
 static struct platform_driver spmi_controller_driver = {
 	.probe		= spmi_controller_probe,
-	.remove_new	= spmi_del_controller,
 	.driver		= {
 		.name	= "hisi_spmi_controller",
 		.of_match_table = spmi_controller_match_table,
-- 
2.42.0.rc1.204.g551eb34607-goog

