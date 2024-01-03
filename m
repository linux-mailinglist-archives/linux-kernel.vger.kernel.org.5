Return-Path: <linux-kernel+bounces-15372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60AE822AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB0D1C23281
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C41865E;
	Wed,  3 Jan 2024 10:06:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5B18632;
	Wed,  3 Jan 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 10E881408EB; Wed,  3 Jan 2024 11:06:50 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-usb@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC] Fix stuck UCSI controller on DELL
Date: Wed,  3 Jan 2024 11:06:35 +0100
Message-Id: <20240103100635.57099-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a DELL Latitude 5431 where typec only works somewhat.
After the first plug/unplug event the PPM seems to be stuck and
commands end with a timeout (GET_CONNECTOR_STATUS failed (-110)).

This patch fixes it for me but according to my reading it is in
violation of the UCSI spec. On the other hand searching through
the net it appears that many DELL models seem to have timeout problems
with UCSI.

Do we want some kind of quirk here? There does not seem to be a quirk
framework for this part of the code, yet. Or is it ok to just send the
additional ACK in all cases and hope that the PPM will do the right
thing?

     regards   Christian

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61b64558f96c..65098a454f63 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -53,7 +53,10 @@ static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
 	ctrl = UCSI_ACK_CC_CI;
 	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
 
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	if (ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl)))
+		pr_err("ACK FAILED\n");
+
+	return ucsi_acknowledge_command(ucsi);
 }
 
 static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
-- 
2.40.1


