Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF5781C8F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHTGAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjHTGAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:00:30 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05FAD952
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 21:45:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26f51613d05so46562a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 21:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692506700; x=1693111500;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0FxH3RmVNebbCiuph+Bo6boQ8Nz4tprYlS7+OEsOmqw=;
        b=5jmbfSXOvAMBjY7XcewJDVevQopgO54KQmbQ2iQKCPwWla6sUAswnrQug61V8hji0P
         FaRA54BkkIuCNeFsp8E4UIG5T7V4sFSfFeatIfwF6jAXyA9xgu2mNc6TuPy513kAB3Rz
         RiT7tiN4pfEvGwwI8oiuOlidELgMrLeYxDbWEaI7W5tajNVXMefLkGp05jOY8nS1ru9H
         /pGsi97IyOxc244X4uetUs36QpUq+1OB6S4HvDZXotaICbhy4suLuW6xt5bXIl6MgD9v
         DvC03mjIj0uwMuIRzFNUmiBWXBVYTlO6b+XCGLeqq8G0ERC4BwKeoxk3CCel2uiyUEGe
         wvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692506700; x=1693111500;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FxH3RmVNebbCiuph+Bo6boQ8Nz4tprYlS7+OEsOmqw=;
        b=A1n0aa6jnHd+0m0WZdzo4jJpdAz/jrTUpbEGzWZmDfuPJ9K54Eei5IhZTIkC74GiSF
         HozR4qXBPdoqlxTZLHhINkmvkzf/swckuhyaHaqqE+sbbGw7DoeMMRFlKxuZOnQ/y07Y
         N7FjOgbDTMUbC5ls23NKd8MvkmpS5h5lcfIEAypt08rIwZ5C83pAuaTwgGeBdRkRhjaW
         PyG7meW7ko5jzGkzRW35hNwxIGnhzsLqf5CXbxxo+o6cQZmpc4pitfoTbYaQytDXhbDq
         4Mbm1sUorhpDsP3TK+FD7Sq0OvpDyzyBcvTp5SP8A3+u7YWImdYyFd3ZOQcjlXtlcmkT
         gU7Q==
X-Gm-Message-State: AOJu0Yw7gKwiQLGvrHPM8qJr1WDSp6H3J6JuQeumz6ZWufb+ObYZFb/o
        voH4Bs7U9OVVr1WBC4peIAvQDrrZpmk=
X-Google-Smtp-Source: AGHT+IEqOT3wwRMG5WwcbGjs5DHF28XuWoiMfoFuFwXlv5eZTJ+qF6GxclqG4t6qc2t8wDLRKskoRu3kjBA=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a17:90a:f00b:b0:268:4dee:eba0 with SMTP id
 bt11-20020a17090af00b00b002684deeeba0mr669301pjb.8.1692506699855; Sat, 19 Aug
 2023 21:44:59 -0700 (PDT)
Date:   Sun, 20 Aug 2023 04:44:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230820044449.1005889-1-badhri@google.com>
Subject: [PATCH v1] tcpm: Avoid soft reset when partner does not support get_status
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When partner does not support get_status message, tcpm right now
responds with soft reset message. This causes PD renegotiation to
happen and resets PPS link. Avoid soft resetting the link when
partner does not support get_status message to mitigate PPS resets.

[  208.926752] Setting voltage/current limit 9500 mV 2450 mA
[  208.930407] set_auto_vbus_discharge_threshold mode:3 pps_active:y vbus:9500 ret:0
[  208.930418] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
[  208.930455] AMS POWER_NEGOTIATION finished

// ALERT message from the Source
[  213.948442] PD RX, header: 0x19a6 [1]
[  213.948451] state change SNK_READY -> GET_STATUS_SEND [rev3 GETTING_SOURCE_SINK_STATUS]
[  213.948457] PD TX, header: 0x492
[  213.950402] PD TX complete, status: 0
[  213.950427] pending state change GET_STATUS_SEND -> GET_STATUS_SEND_TIMEOUT @ 60 ms [rev3 GETTING_SOURCE_SINK_STATUS]

// NOT_SUPPORTED from the Source
[  213.959954] PD RX, header: 0xbb0 [1]

// sink sends SOFT_RESET
[  213.959958] state change GET_STATUS_SEND -> SNK_SOFT_RESET [rev3 GETTING_SOURCE_SINK_STATUS]
[  213.959962] AMS GETTING_SOURCE_SINK_STATUS finished
[  213.959964] AMS SOFT_RESET_AMS start
[  213.959966] state change SNK_SOFT_RESET -> AMS_START [rev3 SOFT_RESET_AMS]
[  213.959969] state change AMS_START -> SOFT_RESET_SEND [rev3 SOFT_RESET_AMS]

Cc: stable@vger.kernel.org
Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5639b9a1e0bf..280ce1bd7b53 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2753,6 +2753,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			port->sink_cap_done = true;
 			tcpm_set_state(port, ready_state(port), 0);
 			break;
+		/*
+		 * Some port partners do not support GET_STATUS, avoid soft reset the link to
+		 * prevent redundant power re-negotiation
+		 */
+		case GET_STATUS_SEND:
+			tcpm_set_state(port, ready_state(port), 0);
+			break;
 		case SRC_READY:
 		case SNK_READY:
 			if (port->vdm_state > VDM_STATE_READY) {

base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
-- 
2.42.0.rc1.204.g551eb34607-goog

