Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8E76288F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGZCI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGZCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:08:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97BB2126
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:08:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bba5563cd6so13916485ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690337334; x=1690942134;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvzO5xTQNyURF4nL/piskJHmeTo2rL1d+zB5x7OHimk=;
        b=P3IIEFPbQNJ6ydPAceQ0K37zoFX3b3J2u6B8NX8ZC0LYS9+4qVnufJnJyKV1j69+b0
         qn00VhJ/cCwEIzq5BPya/R6SuNkeKjW08SKgzDtl3ioaP2hZmq4Vov3Z8E3uB4mVmY0w
         JbWy8VyAazE9+WN02GeoJjHeOoPa/oR/xEUq17gPUyXhP7z71yvtqB+mbjCK2Oo98JBs
         eAwzGbMWH02REmapWlwdU8nHEUUSOaSrWkJMC6oBVPDHiBvlBuyFInat74L6zpRdym+4
         UrJxKrR56Em1fhpdgM7dcYKWeeXxydVjyqk8R3MbFUs3DW6/xbh/D7lhGfMKNqdFPR7D
         j77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337334; x=1690942134;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvzO5xTQNyURF4nL/piskJHmeTo2rL1d+zB5x7OHimk=;
        b=Tn83WAmigf2BRbojiG/NNoX+b+dKUonu6sFZpDQ7qPns+3ghCFLoSXyiUKa5JHsC/I
         0geRb0MwStxCwhMu2cdGz08ffa9Oilz426F+Z3257HbZxpvRrx4zpEYrrAF0FVYl4gEw
         JPdp/AluK+IvnDS0TrzzO7tYIghBNbLAHacsht2suwFTWyI9END1Y+2vRLsDNZ4Mlfy5
         SuF+ASdilQvjPBpPw2Zse5xL7U7BrT12E4iZg+/rEhCsz0TbTlWqsrLt9dQh+yPmrVOP
         PCaNRXom7kb+tHHwzmfKLK5k6Y1ssfjEB9zPTxvZmG1u9713C5sKSYocs3OCpLHmBNaQ
         L94g==
X-Gm-Message-State: ABy/qLbkPSk2pRxkn+wcFeKzLDvy/skk+lkQZKx9rtqyzT4mlxagCE+0
        dBlPRc3ZoUuSX9WfBpa5qO/+MiyuAIFwOLg=
X-Google-Smtp-Source: APBJJlFcGWdyVXRjmhYk8oHznaQ2BZoyJHq53LoLgm0V6/jCQj6VeXM0/pLHHRwvwG+p9kRwiKJeJb2Vn9hTC44=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:902:f145:b0:1ae:6895:cb96 with SMTP
 id d5-20020a170902f14500b001ae6895cb96mr3661plb.5.1690337334001; Tue, 25 Jul
 2023 19:08:54 -0700 (PDT)
Date:   Wed, 26 Jul 2023 02:08:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726020810.1408299-1-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: set initial svdm version based on pd revision
From:   RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, kyletso@google.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sending Discover Identity messages to a Port Partner that uses Power
Delivery v2 and SVDM v1, we currently send PD v2 messages with SVDM v2.0,
expecting the port partner to respond with its highest supported SVDM
version as stated in Section 6.4.4.2.3 in the Power Delivery v3
specification. However, sending SVDM v2 to some Power Delivery v2 port
partners results in a NAK whereas sending SVDM v1 does not.

NAK messages can be handled by the initiator (PD v3 section 6.4.4.2.5.1),
and one solution could be to resend Discover Identity on a lower SVDM
version if possible. But, Section 6.4.4.3 of PD v2 states that "A NAK
response Should be taken as an indication not to retry that particular
Command."

Instead, we can set the SVDM version to the maximum one supported by the
negotiated PD revision. When operating in PD v2, this obeys Section
6.4.4.2.3, which states the SVDM field "Shall be set to zero to indicate
Version 1.0." In PD v3, the SVDM field "Shall be set to 01b to indicate
Version 2.0."

Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 829d75ebab42..5b0a428fcf5d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3928,6 +3928,31 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
 	}
 }
 
+static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
+{
+	switch (port->negotiated_rev) {
+	case PD_REV30:
+		break;
+	/*
+	 * 6.4.4.2.3 Structured VDM Version
+	 * 2.0 states "At this time, there is only one version (1.0) defined.
+	 * This field Shall be set to zero to indicate Version 1.0."
+	 * 3.0 states "This field Shall be set to 01b to indicate Version 2.0."
+	 * To ensure that we follow the Power Delivery revision we are currently
+	 * operating on, downgrade the SVDM version to the highest one supported
+	 * by the Power Delivery revision.
+	 */
+	case PD_REV20:
+		typec_partner_set_svdm_version(port->partner,
+					       SVDM_VER_1_0);
+		break;
+	default:
+		typec_partner_set_svdm_version(port->partner,
+					       SVDM_VER_1_0);
+		break;
+	}
+}
+
 static void run_state_machine(struct tcpm_port *port)
 {
 	int ret;
@@ -4165,9 +4190,10 @@ static void run_state_machine(struct tcpm_port *port)
 		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
 		 * port->explicit_contract to decide whether to send the command.
 		 */
-		if (port->explicit_contract)
+		if (port->explicit_contract) {
+			tcpm_set_initial_svdm_version(port);
 			mod_send_discover_delayed_work(port, 0);
-		else
+		} else
 			port->send_discover = false;
 
 		/*
@@ -4455,9 +4481,10 @@ static void run_state_machine(struct tcpm_port *port)
 		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
 		 * port->explicit_contract.
 		 */
-		if (port->explicit_contract)
+		if (port->explicit_contract) {
+			tcpm_set_initial_svdm_version(port);
 			mod_send_discover_delayed_work(port, 0);
-		else
+		} else
 			port->send_discover = false;
 
 		power_supply_changed(port->psy);

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.487.g6d72f3e995-goog

