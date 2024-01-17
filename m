Return-Path: <linux-kernel+bounces-28918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E483049F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF6A2889D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8A1DFC7;
	Wed, 17 Jan 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Qmm87pM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8A1DDFA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491493; cv=none; b=j/Jq65310BZ5KjSVYREUqJT6ejGHgdDRc2t4wjiCM/C4TeOvthX+S06ppAIR5BshXB/5rNV5DySrNHcxkL0PlfIjssAavAuGWkDqX+eMjhURMB1n1KWRUafNh8DIWQJ6Rws0FR3GlkDDMu2UrjwYNXndfdOCLNkJF3klF657xRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491493; c=relaxed/simple;
	bh=PYJp2nLrI9r8h/8LkHvioy23opDePS5vBpBicUrJSGE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=jzzW20u148DJ6QSAUExw+MqPGPFvKeXn9GDPB6N6GrFfXP3QCii78EJ49EvONtVRdrlXXIxF1jMLBFXQqFy+8Kh6cpRmfyJ1bWJTsupGrU7GEr6ztQKclKACkkDj1O/UZP8wqmZkdTZZL/zh7iCUOMgdillvh44Y1/Ad/09PH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Qmm87pM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28bb7083fb5so6606682a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705491491; x=1706096291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z4JdV8kFxtKhHRthXQH9G50zNT6LFN+iPkzR+QshzVU=;
        b=0Qmm87pM+2Fq0BThWjmXPRFKqRdP7mnFF2BkdyVWnVaniynGQaBF9yifZozRwVdeMx
         dMvIN98c+NT2zwQMhXfy2+ID7fGBBcpBMOKSkWkp+RPcgun7KVAIqg4cotBJYI6XSXdX
         8+yv51zCjLkc6hJM9mlLpu26/1ECocaguUL1F4z5QgSUNGkRwbgEycI3iNixk3is1QxT
         pONVGLkEfmOJe9xRLJJltWwloiS86/PB4mK+dgAKskXqkk9CM6ZBbSYkF+C7RU7xOAIx
         GL45xM/2Bc7MRfK1ssEMqdL23ExpcV+NfngHnBGH5RWzOG5C+fqmmHenR4sKqvOAMoXF
         EbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705491491; x=1706096291;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4JdV8kFxtKhHRthXQH9G50zNT6LFN+iPkzR+QshzVU=;
        b=FAbbRBNcgdf5lL+p66Lpq5LpNhayNcf2GmwPAgyNtOxbGomPNx+1wO/WvNY08KPJU5
         +uOygYFMByRowdWCwChjVVX5Xic5cM/McFClF7vuFkLz7aWP+is0ynhxo06OSryLmsfG
         LjRHrhcom27jXS5JTSp8NIkyc7lKKK8tqDqjLPDhOJsfoorhNurQp2SGcQe4uVjJdfJd
         oi3PQy8k/H818/1gOWVzykz69wlLsqmvJNdXQ0hFCc3/bTUdYtfzNhgdlrJ+xSryPm8g
         pgMPr8ENaqCkFV0cHySSeIehxBge9SJls6cWG4b/79MPjVP9P/EploDcWKb0IEjRrN1l
         RPxw==
X-Gm-Message-State: AOJu0Yzt3Gj4VdSwfS7mUkAoXf3UyOdEOXo78na3uGyu3IITtLY1UX92
	WpoNNTiQGBkm9260kov9eyyd8gy0REGozsL/eg==
X-Google-Smtp-Source: AGHT+IGjP8x81OyM46jxmx1E+RfQKTwqso7GoQ2AyYom1wVdI96zSCsX5JK88Swop5uVIpBi/sk/PCQ/VeI=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a17:90b:1fc7:b0:28d:bc0f:58f3 with SMTP id
 st7-20020a17090b1fc700b0028dbc0f58f3mr612274pjb.3.1705491491475; Wed, 17 Jan
 2024 03:38:11 -0800 (PST)
Date: Wed, 17 Jan 2024 11:38:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117113806.2584341-1-badhri@google.com>
Subject: [PATCH v1] Revert "usb: typec: tcpm: fix cc role at port reset"
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.

Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
the CC pins, setting CC pins to default state during PORT_RESET
breaks error recovery.

4.5.2.2.2.1 ErrorRecovery State Requirements
The port shall not drive VBUS or VCONN, and shall present a
high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.

Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
CC pins are set to default state after tErrorRecovery in
PORT_RESET_WAIT_OFF.

4.5.2.2.2.2 Exiting From ErrorRecovery State
A Sink shall transition to Unattached.SNK after tErrorRecovery.
A Source shall transition to Unattached.SRC after tErrorRecovery.

Cc: stable@kernel.org
Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5945e3a2b0f7..9d410718eaf4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
-			    TYPEC_CC_RD : tcpm_rp_cc(port));
+		tcpm_set_cc(port, TYPEC_CC_OPEN);
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;

base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00
-- 
2.43.0.429.g432eaa2c6b-goog


