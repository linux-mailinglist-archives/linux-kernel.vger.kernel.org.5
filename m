Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF7F75DDD2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGVRbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:31:02 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Jul 2023 10:30:59 PDT
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F163C1BFC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 10:30:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690047059; x=1690054259; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=KTX5c2W9IC0se4k6UfvNshruBo0qc1MufVYnBdWH05Q=;
 b=UUCKktTCdBnjLMqq3Ib5x0e8cBKIVY2lcXRIF/OynlEawQFFjsvFuzl/3yKGN7vaBNyj1Ya/JdRxTXSOmmb87Vd2WMAvQc/zgrJaETlzHIqo3gEHvdhEDWyllIwHdPBwsZtL3Tt2ldxa46J6y3fSxQ4r3ftr79sKZ1gNVZqaHbD36knJgfpEpoJN2HrnbWOwkpIAfxnbQXnxrczal+VFgjIEVeZbjuwd3s+rdurK5xrA+ss+3ZbjOrmfPpQJFHvU67MfTql49VG0NeQQIEHBoI5my3oTtv4Y1Fs9Cl+gUmRb1LZVYPTuyFErQQqb2IX+J3yTzULcZD2bph+6wvuryA==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 34081948f2f3 with SMTP id
 64bc11259b55128dd86df00a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 Jul 2023 17:25:57 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: hp-wmi-sensors: Get WMI instance count from WMI driver core
Date:   Sat, 22 Jul 2023 10:25:13 -0700
Message-Id: <20230722172513.9324-2-james@equiv.tech>
In-Reply-To: <20230722172513.9324-1-james@equiv.tech>
References: <20230722172513.9324-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2a2b13ae50cf ("platform/x86: wmi: Allow retrieving the number of WMI
object instances") means we no longer need to find this ourselves.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/hp-wmi-sensors.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index ebe2fb513480..3a99cc5f44b2 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -435,25 +435,11 @@ static union acpi_object *hp_wmi_get_wobj(const char *guid, u8 instance)
 /* hp_wmi_wobj_instance_count - find count of WMI object instances */
 static u8 hp_wmi_wobj_instance_count(const char *guid)
 {
-	u8 hi = HP_WMI_MAX_INSTANCES;
-	union acpi_object *wobj;
-	u8 lo = 0;
-	u8 mid;
-
-	while (lo < hi) {
-		mid = (lo + hi) / 2;
-
-		wobj = hp_wmi_get_wobj(guid, mid);
-		if (!wobj) {
-			hi = mid;
-			continue;
-		}
+	int count;
 
-		lo = mid + 1;
-		kfree(wobj);
-	}
+	count = wmi_instance_count(guid);
 
-	return lo;
+	return clamp(count, 0, (int)HP_WMI_MAX_INSTANCES);
 }
 
 static int check_wobj(const union acpi_object *wobj,
-- 
2.39.2

