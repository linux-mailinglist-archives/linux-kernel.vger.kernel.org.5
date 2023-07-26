Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D5476289A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGZCJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGZCJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:09:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184F2125
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:09:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66a4c89bbb1so5558577b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690337394; x=1690942194;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m/nV3g6W736EPXRjXQLJgCrEvEP4ZKlAHmzn9beuWG8=;
        b=KOLtmsS8P0ISZmL9jvfLjbYpz6z6ythWieakQSytridy4l9RIZTuXjSPJpt8CHXZKN
         l4WF323TNy8bK8QXEC5mFPCJ0BoeNcjmnBCTbPA6EeorPzBQ0nvim+BDLdNzymy6LBbv
         zERjEydmWyz3FmRGS0EqwwjOOmiQ5VGrvLMAvhctwQfs7R9eamLMn7lG9mfd9srlCSt5
         D8i9twjaJ72g0Q88YH0HweOB/GLlWL6k9o4MPW+Dr9B/UNHkb/0SCxwPkE1mqv7ocFLP
         iCSUuGaqLwE5TtrbwudOD+4dvc9gruNE7Yr/CjPVYAlT+D/4uEUaEVSMkCxEzq9GSf7V
         0mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337394; x=1690942194;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/nV3g6W736EPXRjXQLJgCrEvEP4ZKlAHmzn9beuWG8=;
        b=Vku51fd/CzIlTLpdCHRzQLKhp4K/hPGrkHvr7P/d8VleXbza8S/hNZL02ng7/+msGO
         yzGuWydqQPQFtfjqW0bQgcoXfowTrY/I9IdipTKk6mGLxAWo+nwMBXAwvuV8hS7KlEob
         s9VbjEDJnMOa9EPt19jSziC9bNyw53wF5Fg46Ip0A328cE7e0crp9+nTOQDoOTWEcPhq
         194TX6IS/IFCZXV3ADQAxLHZJKaee61O5GIY2l6yWVVO5UztvIXcjwS6da7K3t8hRyZq
         z9F93fQXa8Y1aEpUH2YxNjZhDD2rxiJdMZGw6H4tU7LMbVQ/mfySFKG4dPLOwqlzSH4d
         OhSg==
X-Gm-Message-State: ABy/qLbQ2/3f4X40G87W+X+E1wNO38nd8O2ftzosMolRjCYXno431Enw
        FOtUavxQULR40Hc8QoFDpw86UZEuVsns9YI=
X-Google-Smtp-Source: APBJJlEYaQMIalvi3YO/cmF8SvDsq27tctdkZurvNZhkWwYzZa3gzT4XKHO+LrzLsg8TEuEI6wAE20CmjRgnU7E=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6a00:1803:b0:682:5748:2e88 with SMTP
 id y3-20020a056a00180300b0068257482e88mr7393pfa.0.1690337393881; Tue, 25 Jul
 2023 19:09:53 -0700 (PDT)
Date:   Wed, 26 Jul 2023 02:09:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726020946.1409565-1-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: bus: verify partner exists in typec_altmode_attention
From:   RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux@roeck-us.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
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

Some usb hubs will negotiate DisplayPort Alt mode with the device
but will then negotiate a data role swap after entering the alt
mode. The data role swap causes the device to unregister all alt
modes, however the usb hub will still send Attention messages
even after failing to reregister the Alt Mode. type_altmode_attention
currently does not verify whether or not a device's altmode partner
exists, which results in a NULL pointer error when dereferencing
the typec_altmode and typec_altmode_ops belonging to the altmode
partner.

This patch verifies the presence of a device's altmode partner
before sending the Attention message to the Alt Mode driver. It
also changes the return type from void to int so errors can be
logged at the tcpm level.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/bus.c           | 12 ++++++++++--
 drivers/usb/typec/tcpm/tcpm.c     |  5 ++++-
 include/linux/usb/typec_altmode.h |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index fe5b9a2e61f5..2f1823e16b3b 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
  *
  * Notifies the partner of @adev about Attention command.
  */
-void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
+int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
 {
-	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
+	struct altmode *partner = to_altmode(adev)->partner;
+	struct typec_altmode *pdev = &partner->adev;
+
+	if (!partner || !pdev)
+		return -ENODEV;
 
 	if (pdev->ops && pdev->ops->attention)
 		pdev->ops->attention(pdev, vdo);
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_altmode_attention);
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 829d75ebab42..be37a662e54d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1791,6 +1791,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	u32 p[PD_MAX_PAYLOAD];
 	u32 response[8] = { };
 	int i, rlen = 0;
+	int ret;
 
 	for (i = 0; i < cnt; i++)
 		p[i] = le32_to_cpu(payload[i]);
@@ -1877,7 +1878,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			ret = typec_altmode_attention(adev, p[1]);
+			if (ret)
+				tcpm_log(port, "altmode_attention failed ret:%d", ret);
 			break;
 		}
 	}
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 350d49012659..28aeef8f9e7b 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -67,7 +67,7 @@ struct typec_altmode_ops {
 
 int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
 int typec_altmode_exit(struct typec_altmode *altmode);
-void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
+int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
 int typec_altmode_vdm(struct typec_altmode *altmode,
 		      const u32 header, const u32 *vdo, int count);
 int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.487.g6d72f3e995-goog

