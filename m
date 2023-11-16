Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788077EDCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjKPIcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjKPIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:32:52 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC8C1B3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:32:47 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5bdfc1bb3eeso1808012a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700123567; x=1700728367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31bn3B5X8I0gch6WfMuHeSex2F8MyGxZRscHzn524C8=;
        b=Xz4ssHLTUhOVFxm8GT+WxnZh2sFM3LwE91GD+RtCGakdgX7qGmpqvhbLAo0dlWnmnU
         HP6uV5kTqR0NwmbtGDm2ZhhPRi5rMyf++bGwn9hATh41ILDdlyQYZtOAMm6h1HWT1d8S
         IEnKoZfoL0ED10jgvlRYZ8q9G1XSC4+Ju89VpgGWGaJm8IcnZzFDKBJe2g+iB06S7LUy
         aWScEL7LOEZ/J85E+8CZQAt53wtsBhs9t9O4oGSd2J3csxjX1LIGm/x5PDmWJcG+8jtf
         5C7TeJyF+toucHvTQ0fw3Spm3mfBxJADAQWx3KGaGfyYXGOlVxkgtbJ1CYrHlqy2Z5DU
         WpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700123567; x=1700728367;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31bn3B5X8I0gch6WfMuHeSex2F8MyGxZRscHzn524C8=;
        b=tXFE4LWPHs67Dfm6ex3umuzE7077KiJ4NneeZD+8M6vV8pcKe5+3yqflXjusjdGujS
         uaGp32i9/3cDDI0abYkzh+r4iO5yA6LTzshpLYCwbBGc2WCXG30SIYQ09zjoYs8TtVaX
         0TdNTCJygQgVyqBgvnijX6iLBS0+0P6VmoKEulsPpZUGL/kNwoQLxz0/cMpOYxK9QSmG
         1vDwHmWc4T5ZwEb+r1CJsQVkvVUI/GSDyNM+uSQ6ydSqo5Nypa8QfH5/KbtGXtNTaTl2
         TzBoSV4dmn3qYelOx0swphKELLJrf8dluVFCGG2v3IFSact2JEGD32VL5kTReogTRQzn
         LFiA==
X-Gm-Message-State: AOJu0YwrPAclGLWowivHIJ2DSwCJFjTfeYHz8SxJmZCVq6TpKY7QKY0F
        /G5WL6i9GI2SM8UegFevODhyS895yzWyzp4=
X-Google-Smtp-Source: AGHT+IGF3a0V8XXgRSu/fRueRhaUTO2mo/G8zpcGV7+ayUWSjR7I8sWOE7UrZNwXXcnavubN3aWnRnTKC0SSOOg=
X-Received: from guanyulin-p620linsp01.ntc.corp.google.com ([2401:fa00:fc:202:86b7:16db:b4e1:f67a])
 (user=guanyulin job=sendgmr) by 2002:a17:90b:2d8c:b0:280:32d5:8904 with SMTP
 id sj12-20020a17090b2d8c00b0028032d58904mr287071pjb.1.1700123567158; Thu, 16
 Nov 2023 00:32:47 -0800 (PST)
Date:   Thu, 16 Nov 2023 16:32:16 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116083221.1201892-1-guanyulin@google.com>
Subject: [PATCH] usb: typec: tcpm: skip checking port->send_discover in PD3.0
From:   Guan-Yu Lin <guanyulin@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, kyletso@google.com, albertccwang@google.com,
        Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original Collison Avoidance mechanism, port->send_discover, avoids
the conflict when port partners start AMS almost the same time. However,
this mechanism is replaced by SINK_TX_OK and SINK_TX_NG. Skip the check
in PD3.0 to avoid the deadlock when source is requesting DR_SWAP where
sink is requesting DISCOVER_IDENTITY.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 058d5b853b57..ff3c171a3a75 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2847,7 +2847,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 					   PD_MSG_CTRL_NOT_SUPP,
 					   NONE_AMS);
 		} else {
-			if (port->send_discover) {
+			if (port->send_discover && port->negotiated_rev < PD_REV30) {
 				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
 				break;
 			}
@@ -2863,7 +2863,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 					   PD_MSG_CTRL_NOT_SUPP,
 					   NONE_AMS);
 		} else {
-			if (port->send_discover) {
+			if (port->send_discover && port->negotiated_rev < PD_REV30) {
 				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
 				break;
 			}
@@ -2872,7 +2872,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		}
 		break;
 	case PD_CTRL_VCONN_SWAP:
-		if (port->send_discover) {
+		if (port->send_discover && port->negotiated_rev < PD_REV30) {
 			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
 			break;
 		}
-- 
2.43.0.rc0.421.g78406f8d94-goog

