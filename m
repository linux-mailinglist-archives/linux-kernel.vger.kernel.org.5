Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE02276F55E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjHCWCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjHCWCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:02:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6E3C16;
        Thu,  3 Aug 2023 15:02:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68783004143so1069284b3a.2;
        Thu, 03 Aug 2023 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100146; x=1691704946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdIQ5YsNyrlOWXwSuXx23oN8qxRbhtWI4ShbAosGVe0=;
        b=sY6tJHcmXKaCE9qCeuSrRxn8tuTREX4eVuSfZvU32Ry0/icJ9OtVDmxhagKAVuyBMG
         SUlXoizmhVMryD/E8eq5VmhsMaFhtRWTcx8Z3VDUZPEoYMQTd6SkR9z7vso9XLWHYkTS
         6G9Ivds6degZQNmEcVjcTyJml6OXTI9ZiM35raRv4xX8Ealp/ILJbHMBVkGxiok4i1jv
         79yixE/qNmhB6NESnN2Zw9tQ5znpOqPcsYkko7KoB2AK/a1bDGMh1E4oYnQh8/heHyfO
         TjaF/icZeS7mS7tCSdKfcxd9dlGz731i4zqGEICpOLuMrrnAaVLJnUCIL9OuxNCX08Xt
         fC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100146; x=1691704946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdIQ5YsNyrlOWXwSuXx23oN8qxRbhtWI4ShbAosGVe0=;
        b=MqApzZOS6yhBQrX/ndS0QrZiA8QicXBbrVKjDsRdkavgLPUFXcaKkHOFtxbKow7ROj
         G/X2imbOXIKwI6mWp8og1IZhdvOKjIlu4JBaSfaFK2/AP9rjnuqbMJZgRqL/Gba5BtgP
         5TXARwh9aZiw3FpVO7KrW+QlE1HJ8Say8VOuyUUYFiKlBj1ZsJVaCwaKh5OjE8U8MeBH
         Q3kTdxTHdMk5pucdURgGHIRscJspj1wsLHdvtFK1S5M1nD2P/lfzZxwsl02bDSvDA4Y5
         nBDiKl5HUuiuuq+HavuQGHsAfiRjOwR3/sbwH9ZiZ3WkOyiUGJvUVQE87+7oUBU4bhBr
         hGJg==
X-Gm-Message-State: ABy/qLZ/ABKMcMP9oPCTLXzISVUMAzkHdeKFsiwW4+FNWH7FQGPFyVEC
        wGDYouTpwrrk7qVbbo/EwEA=
X-Google-Smtp-Source: APBJJlFOc6AAnszSskkuTa0g94925qyVeNjNM4id7xkJhDjPBOi6n4upfghDHL/yd0tHm29nnK72Rw==
X-Received: by 2002:a05:6a21:4984:b0:12d:3069:69e1 with SMTP id ax4-20020a056a21498400b0012d306969e1mr16263038pzc.60.1691100145981;
        Thu, 03 Aug 2023 15:02:25 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b00666b012baedsm295147pfh.158.2023.08.03.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:02:25 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/9] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
Date:   Thu,  3 Aug 2023 15:01:52 -0700
Message-ID: <20230803220202.78036-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803220202.78036-1-robdclark@gmail.com>
References: <20230803220202.78036-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Similar to the previous patch, move the allocation out from under
dev_pm_qos_mtx, by speculatively doing the allocation and handle
any race after acquiring dev_pm_qos_mtx by freeing the redundant
allocation.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index f3e0c6b65635..4537d93ddb45 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -922,17 +922,19 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
  */
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
+	struct dev_pm_qos_request *req = NULL;
 	int ret;
 
 	ret = dev_pm_qos_constraints_ensure_allocated(dev);
 	if (ret)
 		return ret;
 
+	if (!dev->power.qos->latency_tolerance_req)
+		req = kzalloc(sizeof(*req), GFP_KERNEL);
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (!dev->power.qos->latency_tolerance_req) {
-		struct dev_pm_qos_request *req;
-
 		if (val < 0) {
 			if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
 				ret = 0;
@@ -940,7 +942,6 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 				ret = -EINVAL;
 			goto out;
 		}
-		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req) {
 			ret = -ENOMEM;
 			goto out;
@@ -952,6 +953,13 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 		}
 		dev->power.qos->latency_tolerance_req = req;
 	} else {
+		/*
+		 * If we raced with another thread to allocate the request,
+		 * simply free the redundant allocation and move on.
+		 */
+		if (req)
+			kfree(req);
+
 		if (val < 0) {
 			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
 			ret = 0;
-- 
2.41.0

