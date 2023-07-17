Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7360757083
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjGQXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGQXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:32:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328F1737
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:31:18 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c79a5565aso2367902a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689636580; x=1692228580;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ird/WLydYaL1CZ8k5wr+kVwYTmymx69M3RobX2GjRRk=;
        b=hkifHyWTg3IccG5d/p0hfc+tMQUiLWzqHqVw7JWr85jdGXtWpvj7aATj6c/OzxTY1y
         2Iyf8y7BOcM914r8tnAJUC9c2l7r+2no2RdWV2OPYYuGdWu+x5rljiz+xVO5PmITzOD8
         cthk8Z+66glwpEg5AXsfVjothdOienhxYmYCGqXvmqT4IueqOqRoVLH82IFR3r107A72
         PB7RZy5OBdPhEmJ24npqCLJLviFGiiekbk+JkPVzf7/4rArUUMpdZp1VsqHgdu+mDl3n
         G9XhdZBklOtDwY9v1KcXF+BxKNLMupUDKYTBryTbmAOiF1LBeOOiM1l2iP3awq/NswtW
         iTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689636580; x=1692228580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ird/WLydYaL1CZ8k5wr+kVwYTmymx69M3RobX2GjRRk=;
        b=KK1vdkpk8m/GkXiMNvNivvMiqoRO4wfdpJGsE24VPMTQjD49MOgSDLDyS73TKYAhbn
         htexINZhbvaLyG6tZYmoiZNISiBAh+f6h2tbZVckRhbmP0+4gcDFyp70Sy6BegyB+GSZ
         CmaxWEdRYr5qLaLdXwI1D90sWsMKdbTlJjy01/gauVpVH1moXFSM7OWDrSpXCZ8sq6WV
         lF/ROyvhvf1zEmsvbEAQ+7snoTeFIqT3N6IpipZFcimvIH9ZY6RC1AsPx2cShghEP+dv
         IpvDKZBCu94lGSzXoUR5ArsW/k07Gdxigz0h5hD0FU0j0W0OFcfdyMf75WRPg8xLHApQ
         NwLQ==
X-Gm-Message-State: ABy/qLZKG1ZCp75IAGDDjmEI+qZXXnnupHp7Y0q2e165DBVX7I5Xo8MY
        ARB81IMzYxBjVm2cQjGP/1wF0P2jiUj5eY4=
X-Google-Smtp-Source: APBJJlFf2yFppmL7A2x5VBahkETSDvkzC8Bm3eSvb1eaR96HjbZm8g/RzRfWAVGfvhdgg9m7kq7fcTczsJw+3k4=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a63:9316:0:b0:55a:e71b:45b9 with SMTP id
 b22-20020a639316000000b0055ae71b45b9mr104144pge.2.1689636579886; Mon, 17 Jul
 2023 16:29:39 -0700 (PDT)
Date:   Mon, 17 Jul 2023 23:29:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
Subject: [PATCH] drivers/cros_ec: Emergency sync filesystem on EC panic
From:   Rob Barnes <robbarnes@google.com>
To:     pmalani@chromium.org, chrome-platform@lists.linux.dev
Cc:     robbarnes@google.com, briannorris@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
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

Perform an emergency filesystem sync when an EC panic is reported. An
emergency sync actually performs two syncs internally in case some
inodes or pages are temporarily locked.

hw_protection_shutdown is replaced for a few reasons. It is unnecessary
because the EC will force reset either way. hw_protection_shutdown does
not reliably sync filesystem before shutting down. emergency_sync is not
synchronous so hw_protection_shutdown may interrupt emergency_sync.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---

 drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 500a61b093e47..9652fc073c2a4 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -327,8 +327,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
-		/* Begin orderly shutdown. Force shutdown after 1 second. */
-		hw_protection_shutdown("CrOS EC Panic", 1000);
+		/* Force sync the filesystem before EC resets */
+		emergency_sync();
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

