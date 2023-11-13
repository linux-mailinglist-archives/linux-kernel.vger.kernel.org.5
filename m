Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51647EA5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjKMWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:09:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35710C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:09:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so33978887b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699913395; x=1700518195; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NKOgnOqcuEzsewKSEI/OcNGfQuQjOeXQPq9KFL5FVes=;
        b=yQuPf4BnqYZ0VnJ4OJGEIB56QDYTlB/Sp8pzU6I4jUEgRS3y+cWZoatw0F1duXXEGe
         6lAmYXmuPw78GFwLp1Fwa2ItO6Xv/wM6Pdbq2QlLfy5kUWwDtmjXh75PeZqXTSI9RZli
         m0chh6jp2z4ZD1x2Wt3x8UemyPD+4QwSnNAnCnWPy3sWjGg8UBjKLz2Y3IB6e/JrQ3jY
         Ge5q/qEBQ6cB3ghghFn+fgMupleoHYIc59e89BqC2IqUiVMcEQeOml4kZvT7f2GhJYLq
         HqwI54/rRm2vK37CLKmDzC4e1HPX5AbciqtmmYciUy2h35doW1vpH2m8mvUKx0s8FWwu
         6P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699913395; x=1700518195;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKOgnOqcuEzsewKSEI/OcNGfQuQjOeXQPq9KFL5FVes=;
        b=ibpGMTTQTOICZYwdpukFvCq7a7JOk/J4ZdjlgBIZBClBaKyry5zMTAzI+fqiGzVVlt
         v3c4UNb58DEKCsKnbC02E64mlGDBflLf/r9EFYyeDQ41q0lvmIamM5U0627pEkf+9fRT
         0VxmNvsXkjXM7c9leh0lf7K5VyKfWMP2EzD7fhsE3QyT9Dlz4ExwZp5BaiRoH8ObBla3
         3+1WDkCePWuuzJ6mu0Dp58jKKjkihqvWkW/KyN3t2aWzLRiVHOqbK/DC3Hf8pjkkZYed
         DRxl6Gpid05r77jmeJR144l1J5WcRqBPQOilki2flnBs9wIzhjYT9lDH6tkLIzen1Es/
         sbsg==
X-Gm-Message-State: AOJu0Yz0DdO0Np64vLq2/ExFijNUnGnHcis9MHUdFk0yz7OzUqAXJujq
        9QIjve35WvafQibbFBcyWOuC2iPZ1BFgukA=
X-Google-Smtp-Source: AGHT+IFMJCDnXWqObB7S9SAE33m3yAt8D+sX1ctX9YHxuvz+9QuCAzt80uaWQWcNjKRSFXcP0oNjNU3eq9YuNn8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16cf:68dd:5d77:2a0c])
 (user=saravanak job=sendgmr) by 2002:a05:690c:31a:b0:5a8:207a:143a with SMTP
 id bg26-20020a05690c031a00b005a8207a143amr38683ywb.0.1699913395771; Mon, 13
 Nov 2023 14:09:55 -0800 (PST)
Date:   Mon, 13 Nov 2023 14:09:47 -0800
Message-Id: <20231113220948.80089-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v1] driver core: Enable fw_devlink=rpm by default
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_devlink=on has stabilized and is working correctly. Let's start using
device links created by fw_devlink to also enforce runtime PM ordering.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..9dee7d6282ae 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1641,7 +1641,7 @@ static void device_links_purge(struct device *dev)
 #define FW_DEVLINK_FLAGS_RPM		(FW_DEVLINK_FLAGS_ON | \
 					 DL_FLAG_PM_RUNTIME)
 
-static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
+static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_RPM;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
-- 
2.42.0.869.gea05f2083d-goog

