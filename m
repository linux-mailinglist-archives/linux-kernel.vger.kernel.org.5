Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33378784913
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjHVSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHVSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:02:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F5CD7;
        Tue, 22 Aug 2023 11:02:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-269304c135aso3288749a91.3;
        Tue, 22 Aug 2023 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727358; x=1693332158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XShSbqbLSjOdDhersXOLs7lzCQuSfnKt14AX57BEfg=;
        b=pUZ+14WTjGDCf1BQn529IVVAU3hq39BWMLQDcxyh3ZnNRBdW80UywIS+1pmIIApzlC
         qwS842G1JCCQnTm2GE6oMZBJelvEJUhgD2Vt6d+kHraK7Dnkl31KoMaN4WQv2KPpm59X
         7MZU2Ldos4yc3gUepBLpO9lBcwusarlG6zxLEYeX6CEbONCv3dq6NYXvPJNGCVz2TlEF
         8IDQFIcKMxuxoF8DTAbGfanLO9KXBeSmSHFjrWlyJLnWnxFR5OMc7gC1wmwHSesOW1y9
         4VgfyDskCki8nCRAB6ulGOZbQL7awkJoyYTayPWZF9yyiFx8tdwu5nGGw1vPvf66bNRo
         FFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727358; x=1693332158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XShSbqbLSjOdDhersXOLs7lzCQuSfnKt14AX57BEfg=;
        b=coOmU9ytivoc1NcpdkDzsolaYIgqSOm0fvm8Txhro3Y0/zVFVyqF2jekMuFKcBoXsk
         wVWuPoq+LvfvrvZZwNHmxdBE0uiTrg2UGEyDlFkSxHRwUAFNntOMWJ2KY7ksOPKwVpF/
         nRvIEqMWqw04wfeZW4bKf5LRf2TDKXge9s0acOsTjd33hKtXxxfQboilcsBHzRvGLBEE
         KIfiLtakaWo3RukEpDfcSd84ZSfedxLJ0uGP+fhX2Zqm6o+HLEgG0P2mTXt+COmGiJZ9
         YhsdvKaePK9OZugetOE/TIVA6aHKBY8th3j7ncM/ECiPhcWBIJCAEcZbvpCtzOM5xevt
         6CGQ==
X-Gm-Message-State: AOJu0YzOO0qy3s4fF2AwscHei1mTF4bBUEUje3dgNtpC8Y0Cwt5gB+4I
        gTwbOSHVV+9JbyHIWRDV9dc=
X-Google-Smtp-Source: AGHT+IGU2q4GqtMlWZay5JuzPmetg/Z4r0XDExQ7OUUvf4EpBFUGF1s2dS8kYHGsXJw0CZke5NhQ/g==
X-Received: by 2002:a17:90b:2304:b0:269:46d7:f1db with SMTP id mt4-20020a17090b230400b0026946d7f1dbmr9862231pjb.32.1692727358080;
        Tue, 22 Aug 2023 11:02:38 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id cm1-20020a17090afa0100b0026940eb686bsm9910775pjb.20.2023.08.22.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:37 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/11] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
Date:   Tue, 22 Aug 2023 11:01:51 -0700
Message-ID: <20230822180208.95556-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822180208.95556-1-robdclark@gmail.com>
References: <20230822180208.95556-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/base/power/qos.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7e95760d16dc..09834f3354d7 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -930,8 +930,12 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
 	struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
+	struct dev_pm_qos_request *req = NULL;
 	int ret = 0;
 
+	if (!qos->latency_tolerance_req)
+		req = kzalloc(sizeof(*req), GFP_KERNEL);
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	dev_pm_qos_constraints_set(dev, qos);
@@ -945,8 +949,6 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 		goto out;
 
 	if (!dev->power.qos->latency_tolerance_req) {
-		struct dev_pm_qos_request *req;
-
 		if (val < 0) {
 			if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
 				ret = 0;
@@ -954,17 +956,15 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 				ret = -EINVAL;
 			goto out;
 		}
-		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req) {
 			ret = -ENOMEM;
 			goto out;
 		}
 		ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_LATENCY_TOLERANCE, val);
-		if (ret < 0) {
-			kfree(req);
+		if (ret < 0)
 			goto out;
-		}
 		dev->power.qos->latency_tolerance_req = req;
+		req = NULL;
 	} else {
 		if (val < 0) {
 			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
@@ -976,6 +976,7 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 
  out:
 	mutex_unlock(&dev_pm_qos_mtx);
+	kfree(req);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_update_user_latency_tolerance);
-- 
2.41.0

