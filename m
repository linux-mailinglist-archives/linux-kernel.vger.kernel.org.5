Return-Path: <linux-kernel+bounces-77565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E1860792
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABFB1F24932
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE71C13;
	Fri, 23 Feb 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="By1EFvaH"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939B372
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647780; cv=none; b=gfj6e9AFjwEgxM1t8+pu+7pivaM6c3PgOZRtVrT2/00SI5h8YezEH9ie1kWycOnG3/RUathWTDq5xPLTBOXu6s7oYPGjghibe/EymOVEegw33ytomomcpBKSVhegv0EhIImah/ENojCs5tB8dzeZeI4Ys+wuPBMZTWejudHhyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647780; c=relaxed/simple;
	bh=/QbcREJdj8/HhgjcLw0luxn0IZH6b4nOIm623A+PQGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jsi3ZrIuxVms60aHnwVLHx7GRDj5wI9ShCM+F1T2Y+f5bqttDjoz4xH7CSeiLBj8oO7OWs/XNAvFdP8jXTOmUyQkLsIXhjKz5l187iNcQB6KRpMDxEgH4nK+POjvy6gxgyDzlsZFtvC7DFJBxyxxnSnDFuDfRG9g0kD7hfdNR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=By1EFvaH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dc889cb8edso297283a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708647778; x=1709252578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aRCvuwH8rAugmkg3ZUi08lKYBtiQ+yXb5dektYqZbOw=;
        b=By1EFvaHtBuXTRQvk1cKmFqSw8r0GB2crDQjLFmeZHkyJcfJds9ppBPPliYUZJxV3X
         /v15h2H5EdnPxvWn7B8eopksAZmkIu77DAthZAOW4HMgbem2naNB+KU3Sm2EcrU+ufpV
         R9dKWuJtU6hbrq/Ibcz6NAAmmSDYnD2Tc0QZ8gEY2lCo/ZY+pyzTUvYWSxOy0VGgoWpz
         aexm0EpUgFVTVEi1Bf0YOL56wCBj0ph+/LTuQ3g0VJW+awNGIMoYwbWCc3+JchL9FXaq
         3edbxubt8YUV2EpBk6NuIrpi/MC723rjshYoo5uav5A1/YwMu3HTjTHyhTiKD+ERhP7h
         adig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708647778; x=1709252578;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRCvuwH8rAugmkg3ZUi08lKYBtiQ+yXb5dektYqZbOw=;
        b=BnpeNgGMpSB6uyz0S/xZMFbZGdXkXEwyl358NRToQE/UgUDaIlTE9hhO69OzaJYtnm
         0aIBf9wpHqTVFwvY3KDouL28jg4ZmS0pDqfFeAU83AdQA2XO0xys8RwiZSJSwOj5jxct
         CHUZMWuYFNzZwD71/E2G0EK318SFcB1seYeGoq0MebPaYUisyXQsz3FKOX98XYMLYA7a
         /pqc2hOZCKDDVIRTyl/QSYpA8c3ickNS/0uPivNvcnE9H6enJiK5i+zYLRc597/tu09f
         A4RcmKXfk/oITjZbQtrakHnDcPuoVcIDO6mWqpgSuC70HworaxRZ1hPQmuwxVjoQ7687
         BCHw==
X-Forwarded-Encrypted: i=1; AJvYcCU+IxB7iJ9soSozgtoF3stfiPEKnuxWvXikf812bsRr9AXAEq9BZoNX7h8Iy/v6WORzE6Kbh2xtqPRPUZyOvzKSsp3Eq2+L3bR5QtzP
X-Gm-Message-State: AOJu0YztBP2i799zLX55sN5Jo7Dsm642cpji+M4wV1RWlSjGAdTgeD2h
	WbYtAyNa4hgK4Ckr4ELb9PkJCDfgR7zWikL9Nz9d9oZYSUchsFTERwjbmDz/sKBn0BEfOzSOSWt
	hy+5RMEM9aHv2HQ==
X-Google-Smtp-Source: AGHT+IGsazkBX2H0gNoyZav7hYZhinGJef7Vus84CALdlie8S7EhSkwwvOgy8BCs7QbrXU9n/Lu0usiu9lZdYNg=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a65:6d8b:0:b0:5da:44f5:8dfc with SMTP id
 bc11-20020a656d8b000000b005da44f58dfcmr860pgb.11.1708647777906; Thu, 22 Feb
 2024 16:22:57 -0800 (PST)
Date: Fri, 23 Feb 2024 00:22:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340; i=rdbabiera@google.com;
 h=from:subject; bh=/QbcREJdj8/HhgjcLw0luxn0IZH6b4nOIm623A+PQGk=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnXn3ruvRtqcNPbSjelKOlwveaHbS1Lyw7vnHeqbd23j
 +zac20+dZSyMIhxMMiKKbLo+ucZ3LiSumUOZ40xzBxWJpAhDFycAjARtkqGf/ayRbut5woc8P4i
 4djyMqr7ewDb1NNNnB+uPbz15MQJcSWGv7L2B4t//E6MVNu+tPZXZ5R35oGcf77+T1V4752wSdV 35wEA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223002233.3936275-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: fix SOP' sequences in tcpm_pd_svdm
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Smatch checker flags svdm_version being uninitialized for Discover
Identity Messages within tcpm_pd_svdm for the CMDT_INIT case. Cable plugs
cannot initialize SVDM commands, however a port partner that isn't allowed
to communicate over SOP' could, which would result in the CMDT_INIT block
running for a received SOP' message.

First, initialize svdm_version for the TCPC_TX_SOP_PRIME case. If the
svdm_version returns as an error, we expect the received svdm to be the
result of Discover Identity that updates the value accordingly.

Next, drop all SOP' messages of type CMDT_INIT within tcpm_pd_svdm.

Finally, remove redundant call that assigns modep and pdev. Smatch will
raise an uninitialized symbol error over modep_prime and pdev_prime, but
both the assignment and use of these variables are guarded behind
a check for rx_sop_type == TCPC_TX_SOP_PRIME.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a432603b-b801-4001-b309-247dded707d3@moroto.mountain/
Fixes: fb7ff25ae433 ("usb: typec: tcpm: add discover identity support for SOP'")
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d975fc525eac..55c438c62203 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1878,11 +1878,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 	tcpm_log(port, "Rx VDM cmd 0x%x type %d cmd %d len %d",
 		 p[0], cmd_type, cmd, cnt);
 
-	modep = &port->mode_data;
-
-	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
-				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
-
 	switch (rx_sop_type) {
 	case TCPC_TX_SOP_PRIME:
 		modep_prime = &port->mode_data_prime;
@@ -1890,11 +1885,13 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 						 ALTMODE_DISCOVERY_MAX,
 						 PD_VDO_VID(p[0]),
 						 PD_VDO_OPOS(p[0]));
-		if (!IS_ERR_OR_NULL(port->cable)) {
-			svdm_version = typec_get_cable_svdm_version(typec);
-			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
-				typec_cable_set_svdm_version(port->cable, svdm_version);
-		}
+		svdm_version = typec_get_cable_svdm_version(typec);
+		/*
+		 * Update SVDM version if cable was discovered before port partner.
+		 */
+		if (!IS_ERR_OR_NULL(port->cable) &&
+		    PD_VDO_SVDM_VER(p[0]) < svdm_version)
+			typec_cable_set_svdm_version(port->cable, svdm_version);
 		break;
 	case TCPC_TX_SOP:
 		modep = &port->mode_data;
@@ -1920,6 +1917,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 
 	switch (cmd_type) {
 	case CMDT_INIT:
+		/*
+		 * Only the port or port partner is allowed to initialize SVDM
+		 * commands over SOP'. In case the port partner initializes a
+		 * sequence when it is not allowed to send SOP' messages, drop
+		 * the message should the TCPM port try to process it.
+		 */
+		if (rx_sop_type == TCPC_TX_SOP_PRIME)
+			return 0;
+
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)

base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
-- 
2.44.0.rc0.258.g7320e95886-goog


