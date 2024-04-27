Return-Path: <linux-kernel+bounces-161117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356198B4750
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A76BB216E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FC9143C53;
	Sat, 27 Apr 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3YN2pcLa"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBA1411D5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714240216; cv=none; b=c+O/gyxSj1kq8sMV4WmMFhVtDd7Ilr/GUuNDROkogawi255yIkCzjwExp2F5uei+S31He0fgGb8Qo7Du3v7ktHixCTK10tOV3FD2Dm1h31iZnb1j2yFGL3raaKVEe7sn50C+Gyu07ZmzfXYdeEsD7cvNn3ziHpmihaNJMFUxta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714240216; c=relaxed/simple;
	bh=HPEmpGV8ikOGmRuJrVPlO+Cc678t+l647LTwRvWKw8Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pahH3wW1f23zJOr1qrVVd5WJZ4rHSLylTuWbZIoZ4TC4rIrYAqJfrl5h9O7UHG3lqd1SIqcKMBkZQum018SzhenRaRiQUHF2/P+io7D/mAgQ6p7pJs7sV6g7UtkTAxtEgEGw7eSe2H+P9I23IX2B0pDON7tWF1Izryy6X8imex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YN2pcLa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed03216b70so3170328b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714240215; x=1714845015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FvHMe73fi2IbWQfQ1tIXOVg2/1YesXICaNMQ7jwXAkM=;
        b=3YN2pcLax/LQUI9ikICdUoQ+zyBXMh5n0f6gxbp8MbXc18pecP4qC7mPE5WRiiFjvx
         4dNPA1/G2qDu3t2ZjrK8QsvMhWVt/f+pswvlyMLDzupbKHL0hzVziwj0nKVBQUNWerxK
         GB1oY/b8VCyscUwecRk1xTAinxNTNYuJv7KZxHo5ywSxvLLIKpC1HsEUQ4vW9pCXqJ2Z
         i9+eJAeWAxpQVg1OIgMe9pSzPMxqYafKCSTuhQNJgYPyoxZQ0GUzFTaNbWsvFhxsyRyB
         tCRygilT6n69yIMN6Y7D3NzQv99ktai4y0VoPc1Lp8fyy+V2SCEzHVUP28j5FDK3PZlX
         9DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714240215; x=1714845015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvHMe73fi2IbWQfQ1tIXOVg2/1YesXICaNMQ7jwXAkM=;
        b=CWwlgibUFcwVKbWDUt7/EbIefc7wZoy0lfuM2g8RWcPbyDrkQ9YdjPe4/UR4hN7LKJ
         UqThyw54W7R1Ng/ANiub4va0dgwv3Ujovw/1ZyrydSRk6tpX9bf/g9bhOBgubpW1Qmee
         6frHyZJ0YmrIh3yyYaWAspsrq3AeLxCwKWjC1RRWZDwlps3LIBVJ92a6yir0UwNrq/eb
         mupquPPxUdF8XfjiDSPWzVpq9xIvUML9XufZmXu3J9Hn2pNXc2vBmBVHhAJPw0CFoq+u
         /6attd+x35oAvLExiys2QHks86zxCXW6+vGBKqPVNyt7wwgs2SQXdryGg1T6Lefqd4IX
         SsSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6pAyCElFAHWy9YnE8TSL9keRYs3QhJG1DZ0WEZV6H+vDj0nWqu61AOmRnPvUR0gOyX9UWeLDZMQPknD6ShaeS9W8pSy72du9lvtU/
X-Gm-Message-State: AOJu0YzphaXjZ55Rn9IOajfWjYpbF6Kv95yl6PKgWzbykUXKukz6oBqa
	QfJTGcvEQUwqDTZfCbebwIwnFTP6GN79lBq0b1emVIw500c2RKO6Hc37XbR4syHA8ObJgpOHsp0
	Ljg==
X-Google-Smtp-Source: AGHT+IGEpg5uSIhdwXNozIFHlt39+Ph13USP/g2rCrjlvxbhTvA61K8s6M02/Abp83Y8ZnWPy5PeCj9ONqA=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a05:6a00:2e85:b0:6f3:f514:ec1c with SMTP id
 fd5-20020a056a002e8500b006f3f514ec1cmr101792pfb.1.1714240214608; Sat, 27 Apr
 2024 10:50:14 -0700 (PDT)
Date: Sat, 27 Apr 2024 17:50:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240427175010.3367154-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tcpm: Check for port partner validity before
 consuming it
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, broonie@kernel.org, 
	Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"

typec_register_partner() does not guarantee partner registration
to always succeed. In the event of failure, port->partner is set
to the error value or NULL. Given that port->partner validity is
not checked, this results in the following crash:

[17514.377076][  T275] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003c0
[17514.378270][  T275] pc : run_state_machine+0x1bc8/0x1c08
[17514.378286][  T275] lr : run_state_machine+0x1b90/0x1c08
.
[17514.378377][  T275] Call trace:
[17514.378381][  T275]  run_state_machine+0x1bc8/0x1c08
[17514.378388][  T275]  tcpm_state_machine_work+0x94/0xe4
[17514.378396][  T275]  kthread_worker_fn+0x118/0x328
[17514.378406][  T275]  kthread+0x1d0/0x23c
[17514.378412][  T275]  ret_from_fork+0x10/0x20

To prevent the crash, check for port->partner validity before
derefencing it in all the call sites.

Cc: stable@vger.kernel.org
Fixes: c97cd0b4b54e ("usb: typec: tcpm: set initial svdm version based on pd revision")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ab6ed6111ed0..8a4fa8d875c6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4,7 +4,6 @@
  *
  * USB Power Delivery protocol stack.
  */
-
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -1580,7 +1579,8 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 	port->partner_ident.cert_stat = p[VDO_INDEX_CSTAT];
 	port->partner_ident.product = product;
 
-	typec_partner_set_identity(port->partner);
+	if (!IS_ERR_OR_NULL(port->partner))
+		typec_partner_set_identity(port->partner);
 
 	tcpm_log(port, "Identity: %04x:%04x.%04x",
 		 PD_IDH_VID(vdo),
@@ -1742,6 +1742,9 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 	struct typec_altmode *altmode;
 	int i;
 
+	if (IS_ERR_OR_NULL(port->partner))
+		return;
+
 	for (i = 0; i < modep->altmodes; i++) {
 		altmode = typec_partner_register_altmode(port->partner,
 						&modep->altmode_desc[i]);
@@ -4244,7 +4247,8 @@ static void tcpm_typec_connect(struct tcpm_port *port)
 		port->partner = typec_register_partner(port->typec_port,
 						       &port->partner_desc);
 		port->connected = true;
-		typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
+		if (!IS_ERR_OR_NULL(port->partner))
+			typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
 	}
 }
 
@@ -4323,8 +4327,10 @@ static void tcpm_typec_disconnect(struct tcpm_port *port)
 	port->plug_prime = NULL;
 	port->cable = NULL;
 	if (port->connected) {
-		typec_partner_set_usb_power_delivery(port->partner, NULL);
-		typec_unregister_partner(port->partner);
+		if (!IS_ERR_OR_NULL(port->partner)) {
+			typec_partner_set_usb_power_delivery(port->partner, NULL);
+			typec_unregister_partner(port->partner);
+		}
 		port->partner = NULL;
 		port->connected = false;
 	}
@@ -4549,6 +4555,9 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
 
 static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
 {
+	if (IS_ERR_OR_NULL(port->partner))
+		return;
+
 	switch (port->negotiated_rev) {
 	case PD_REV30:
 		break;

base-commit: 3f12222a4bebeb13ce06ddecc1610ad32fa835dd
-- 
2.44.0.769.g3c40516874-goog


