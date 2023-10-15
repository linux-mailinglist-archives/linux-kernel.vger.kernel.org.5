Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC07C97FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjJOFPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOFPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:15:47 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6BD8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:15:42 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b7179ff4easo68773a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697346942; x=1697951742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TdaEzOTX6ywtIk5zck1LY8j1JHQ8Qsr1vK5cWeNfXMc=;
        b=N3HanSpNBGNxmLQH3LAh2FcJBxee86VOHrOWCjZUsuwukqPNNiJxuIUb4s1cz1obLJ
         FtivQJsGPyvkZollxt/yFS2FTJXjCNROE6/QIWrr1zyeJTIV0fWl73Gdm1uh00BytX1U
         A9MhddtKlLy37VOV76DyXmfEYbkvOTHPQqDqSmfHiS1ZrjeldDah3m9+UBKurXGD8ewW
         djrpNnVCDoIfeuvjV+hkFb+5EF80uZkT9ovQYjwBgxV9gupyTeGLE6EITfInb0YSpIKb
         7vSgXSP8pqkTtwBkQ2OzfzolTZ2OkrSMIR5tx7z46pRejXW/Ld6vB6jkNxUMkzN54DeV
         tDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697346942; x=1697951742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdaEzOTX6ywtIk5zck1LY8j1JHQ8Qsr1vK5cWeNfXMc=;
        b=UwXaEI8awzb0D7f0pPgV141InD51w5Xq8MUZayBvHUVUxJqNM8VEoaclbcsUnk8lxo
         g0ZeJUvizmsxfJ5aBTWLjXTabZf0ddlZbo+YUvJaZaK7d/4A1CvXLnVV/Vlk81t7DBiO
         tBCnCcy/plhZNjmSJeMI9oSyXMvzZZZ/B77cuAlDEEzMR8njWhXppLpkT8tPQjXC43ZS
         wqye2+98qq1rV4jnzAeOX5BkmDwgJsRUz1wIRAeFVW1ev2UTUGTY2riAFY6ppdOjlqEt
         EQCvrkLxbiuonUOqsAW1fXr8a9Uz7dkYin359cAXHGpNgZS///GWDCLdjAVJ056VLTJC
         jN5g==
X-Gm-Message-State: AOJu0Yy23zA95Vo7WfTPEU+Kc7vBAOaYdl15MZe1SQKi3F1pfhUvxjdB
        12nGj7GaH1VStvOTWkE0eZ7EUChy7zU=
X-Google-Smtp-Source: AGHT+IG0jy59Rsv7ESphioQunhxw4q/SrMwa5fIMSN14rVK7m4kY8tzaw4ZKdhJgi38niKUcBa/gHCArfMo=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a63:334e:0:b0:58a:a0c:a62 with SMTP id
 z75-20020a63334e000000b0058a0a0c0a62mr472465pgz.9.1697346942053; Sat, 14 Oct
 2023 22:15:42 -0700 (PDT)
Date:   Sun, 15 Oct 2023 05:15:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231015051538.2344565-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Add additional checks for contaminant
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When transitioning from SNK_DEBOUNCED to unattached, its worthwhile to
check for contaminant to mitigate wakeups.

```
[81334.219571] Start toggling
[81334.228220] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[81334.305147] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[81334.305162] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[81334.305187] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[81334.475515] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[81334.486480] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0, disconnected]
[81334.486495] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[81334.486515] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 ms [rev3 NONE_AMS]
[81334.506621] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 ms]
[81334.506640] Start toggling
[81334.516972] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[81334.592759] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[81334.592773] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[81334.592792] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[81334.762940] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[81334.773557] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0, disconnected]
[81334.773570] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[81334.773588] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 ms [rev3 NONE_AMS]
[81334.793672] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 ms]
[81334.793681] Start toggling
[81334.801840] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[81334.878655] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[81334.878672] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[81334.878696] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[81335.048968] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
[81335.060684] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0, disconnected]
[81335.060754] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
[81335.060775] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 ms [rev3 NONE_AMS]
[81335.080884] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 ms]
[81335.080900] Start toggling
```

Cc: stable@vger.kernel.org
Fixes: 00bdc7e4e0f56 ("usb: typec: tcpm: Add callbacks to mitigate wakeups due to contaminant")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6e843c511b85..3634f9092a84 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3903,7 +3903,9 @@ static void run_state_machine(struct tcpm_port *port)
 		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
 						port->state == SRC_UNATTACHED) ||
 					       (port->enter_state == SNK_ATTACH_WAIT &&
-						port->state == SNK_UNATTACHED));
+						port->state == SNK_UNATTACHED) ||
+					       (port->enter_state == SNK_DEBOUNCED &&
+					        port->state == SNK_UNATTACHED));
 
 	port->enter_state = port->state;
 	switch (port->state) {

base-commit: 1034cc423f1b4a7a9a56d310ca980fcd2753e11d
-- 
2.42.0.655.g421f12c284-goog

