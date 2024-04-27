Return-Path: <linux-kernel+bounces-161163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB398B47D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BF4282479
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4A14535E;
	Sat, 27 Apr 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pBN2VjMK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5443143860
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714249699; cv=none; b=P3LEePU7pB73dhsCW/m0rbXx0T4p0gEmETp5mqhLYqV4upBfF40E8Jy33KL/noxv8xRdDaBlhE+G7HjAiExDMZLEEAL8Z4Mz2UFAPIDn3Wn8eiYmIULaL73Wf9j3rFzHZTNZcUUmhvVTptKYtzu4GlX6Bjw4MGSplGncrsPE7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714249699; c=relaxed/simple;
	bh=V73WW+nskmomT0tPd+6B81O72ANIKsXdEIUpthWEsFA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N0m/s1/Ita1lvyimkjBxssWkPuTmM0brrEe8A+J0i6eBk07FqtxLBjvB3Yu2epAlZ1SFMZvPpa69t7KT/XzpZS5HEjPX4cs2t+42v/NE04bWmlicvjYS226wUPeWYShK4NtiUGs8UMXi2rQ16Kr2Nndt8+p1jl63qSyjVhcGXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBN2VjMK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2ef746c9so58021287b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714249697; x=1714854497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylRat3ryBNNKSjCjBNxN3X4rZSrP8oWTwLpqPsqaRjI=;
        b=pBN2VjMKTd+4R7g0kQvsBDpBqhJlRgiRR6PGSeqamb+uZjvyhdF4kjlpKvV9sbzoWx
         YriejgA4nb7jijkoQryFDTBOVjt6m85aPYT9GgqjGG8uPk1HdcdvhIdbrUEErHuccvL8
         HGn675nXPfIFIxfetPseQynCPUKLvEfXakPEWFaSHumATfTpS5Qx8FlNibh4NspU/DNj
         VR7tT+cqLi9anErqX2dR1uh0ZVGU5b4XGj3Yo8Og6KUt5KZ4A70Mn6e7rXOqzeEujDkW
         TWoA12N0BDb3nf8KFEWlx3wIscO+1oOxYyNl20UF2aHSGuKIrCQVZtA5rBMf5t9eBrdl
         oIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714249697; x=1714854497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylRat3ryBNNKSjCjBNxN3X4rZSrP8oWTwLpqPsqaRjI=;
        b=g3UVnWs8cJv/fT2eMQYQ7ztExCrAyZWrJZfgq0KOX2awwk+eMpAwkOdUNx0gIel2iW
         X7Ui0lcUxapqTE16mB0z9uaindyTtHSjnoNuVSjF+e2QGhQghH6uvEubK3gOSvfGR71P
         POf+xi/AS8GSx14KOR8BDpzuH/wLfe2Jrv9J7UmA7A/65Wcd5MqPKz6rTq01b0Lle2Po
         ByX3ZtRThKbS/zkqWkZYxw3xsPtu8T5pwcDb4HW9+NV1wyXY51jVIRJPdOIyvm6WfhbU
         /84jSAqnalmVSFfV8qTNPMXYX24XGqrU6jfwEGUeMcnezo4Sqv8xh+uDGrbNXsGO159t
         Y1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXo/rpybLdsGZFmirGlgkSPldDNUbPqumODX1ygbP2RuAeb6jktXbFgxfFyWMGxgyuXqFcCnu7FfxdFslGqJG5mFJYGONvJrxZprtMy
X-Gm-Message-State: AOJu0YwdzQXmh6VLdn7BNN9/DAwITxwnd24jTssbjAhmDIsO9yhgYyWI
	RXrMOE5tbnh4UCxftlenbYDLUP2mnU1duhRpwwQ5h2VmCPLNTDo1mpQkKq3pPNG0vsPpJkzWRnG
	inA==
X-Google-Smtp-Source: AGHT+IGkMq5vFM0k2Xat2pYrsrj2ZDMri+8sn0ndwQCamks5vPEx35gvjfLOXFnev4t0SDDU7WASi4/aZRQ=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a81:a1c8:0:b0:615:33de:61d5 with SMTP id
 y191-20020a81a1c8000000b0061533de61d5mr1547806ywg.1.1714249696905; Sat, 27
 Apr 2024 13:28:16 -0700 (PDT)
Date: Sat, 27 Apr 2024 20:28:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240427202812.3435268-1-badhri@google.com>
Subject: [PATCH v3] usb: typec: tcpm: Check for port partner validity before
 consuming it
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, broonie@kernel.org, 
	dmitry.baryshkov@linaro.org, Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"

typec_register_partner() does not guarantee partner registration
to always succeed. In the event of failure, port->partner is set
to the error value or NULL. Given that port->partner validity is
not checked, this results in the following crash:

Unable to handle kernel NULL pointer dereference at virtual address xx
 pc : run_state_machine+0x1bc8/0x1c08
 lr : run_state_machine+0x1b90/0x1c08
.
 Call trace:
   run_state_machine+0x1bc8/0x1c08
   tcpm_state_machine_work+0x94/0xe4
   kthread_worker_fn+0x118/0x328
   kthread+0x1d0/0x23c
   ret_from_fork+0x10/0x20

To prevent the crash, check for port->partner validity before
derefencing it in all the call sites.

Cc: stable@vger.kernel.org
Fixes: c97cd0b4b54e ("usb: typec: tcpm: set initial svdm version based on pd revision")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ab6ed6111ed0..e1c6dffe5f8b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1580,7 +1580,8 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 	port->partner_ident.cert_stat = p[VDO_INDEX_CSTAT];
 	port->partner_ident.product = product;
 
-	typec_partner_set_identity(port->partner);
+	if (port->partner)
+		typec_partner_set_identity(port->partner);
 
 	tcpm_log(port, "Identity: %04x:%04x.%04x",
 		 PD_IDH_VID(vdo),
@@ -1742,6 +1743,9 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 	struct typec_altmode *altmode;
 	int i;
 
+	if (!port->partner)
+		return;
+
 	for (i = 0; i < modep->altmodes; i++) {
 		altmode = typec_partner_register_altmode(port->partner,
 						&modep->altmode_desc[i]);
@@ -4231,7 +4235,10 @@ static int tcpm_init_vconn(struct tcpm_port *port)
 
 static void tcpm_typec_connect(struct tcpm_port *port)
 {
+	struct typec_partner *partner;
+
 	if (!port->connected) {
+		port->connected = true;
 		/* Make sure we don't report stale identity information */
 		memset(&port->partner_ident, 0, sizeof(port->partner_ident));
 		port->partner_desc.usb_pd = port->pd_capable;
@@ -4241,9 +4248,13 @@ static void tcpm_typec_connect(struct tcpm_port *port)
 			port->partner_desc.accessory = TYPEC_ACCESSORY_AUDIO;
 		else
 			port->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
-		port->partner = typec_register_partner(port->typec_port,
-						       &port->partner_desc);
-		port->connected = true;
+		partner = typec_register_partner(port->typec_port, &port->partner_desc);
+		if (IS_ERR(partner)) {
+			dev_err(port->dev, "Failed to register partner (%ld)\n", PTR_ERR(partner));
+			return;
+		}
+
+		port->partner = partner;
 		typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
 	}
 }
@@ -4323,9 +4334,11 @@ static void tcpm_typec_disconnect(struct tcpm_port *port)
 	port->plug_prime = NULL;
 	port->cable = NULL;
 	if (port->connected) {
-		typec_partner_set_usb_power_delivery(port->partner, NULL);
-		typec_unregister_partner(port->partner);
-		port->partner = NULL;
+		if (port->partner) {
+			typec_partner_set_usb_power_delivery(port->partner, NULL);
+			typec_unregister_partner(port->partner);
+			port->partner = NULL;
+		}
 		port->connected = false;
 	}
 }
@@ -4549,6 +4562,9 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
 
 static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
 {
+	if (!port->partner)
+		return;
+
 	switch (port->negotiated_rev) {
 	case PD_REV30:
 		break;

base-commit: 3f12222a4bebeb13ce06ddecc1610ad32fa835dd
-- 
2.44.0.769.g3c40516874-goog


