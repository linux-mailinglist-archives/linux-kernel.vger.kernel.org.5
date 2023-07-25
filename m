Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D25760FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGYJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjGYJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:48:44 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EF1A3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:48:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690278521; x=1690285721; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=a7euifVUehZsKlaZIpC9d5sGc1HeYiQSbpWf0EJ7QP8=;
 b=aMwyHjc1Ie3XzN3jSnYF0T6fY+zfs44bBdIaPzPeija+U4Ejh8SuJD9bgUd4Orwl45uUqrhiwTCXAerA/Kqe3rKEc6Z8XghNoEPbAPc3SBPf8T6kSAoTIDcZDShYvrQ0bV8MUCw2Xo/xxhioZSuaEtrcYBKGwBPrWtxX8ylAyAPqyy0G9L9eV7u/+LLNn4FvezaY7Y30ze/rGeRu3YBzTgfCGHDY/OMEtzEyPo2WyaXaefBAHMHDyI8cAeU+oNe7LhSFKDAIYixlHkbqszOsFhrgqAAaopRed09nfdW5MdFUGHx97yWTASh8A4WyITgsuOqr7PsbZx+VToUlYipfIA==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 292765024a19 with SMTP id
 64bf9a7995a6293efb65da65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Jul 2023 09:48:41 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (hp-wmi-sensors) Initialize pevents in hp_wmi_sensors_init()
Date:   Tue, 25 Jul 2023 02:48:17 -0700
Message-Id: <20230725094817.588640-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning is given by the Smatch static checker:

  drivers/hwmon/hp-wmi-sensors.c:1937 hp_wmi_sensors_init()
  error: uninitialized symbol 'pevents'.

If there are no instances of the HPBIOS_PlatformEvents WMI object
available, init_platform_events() never initializes this pointer,
which may then be passed to hp_wmi_debugfs_init() uninitialized.

The impact should be limited because hp_wmi_debugfs_init() uses this
pointer only if the count of HPBIOS_PlatformEvents instances is _not_
zero, while conversely, it will be uninitialized only if the count of
such instances _is_ zero. However, passing it uninitialized still
constitutes a bug.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-hwmon/f72c129b-8c57-406a-bf41-bd889b65ea0f@moroto.mountain/
Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/hp-wmi-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index 3a99cc5f44b2..17ae62f88bbf 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1913,7 +1913,7 @@ static bool add_event_handler(struct hp_wmi_sensors *state)
 static int hp_wmi_sensors_init(struct hp_wmi_sensors *state)
 {
 	struct hp_wmi_info *connected[HP_WMI_MAX_INSTANCES];
-	struct hp_wmi_platform_events *pevents;
+	struct hp_wmi_platform_events *pevents = NULL;
 	struct device *dev = &state->wdev->dev;
 	struct hp_wmi_info *info;
 	struct device *hwdev;

base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
-- 
2.39.2

