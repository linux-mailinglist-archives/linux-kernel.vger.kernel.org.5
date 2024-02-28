Return-Path: <linux-kernel+bounces-84255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097786A439
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DCC1C2527D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C873364;
	Wed, 28 Feb 2024 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECLElM3H"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA6185E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078717; cv=none; b=ntiG1DZzYTEQUeAKzCu4GVy0gHx8s6dWse0EGykn1BbuSw9IbTSB+mBbNFyUZ5ZGO4te9A8k0/gl8dzRnjulusrtfYQ44DmhgWc07U00NjIqZrp86FOOc7uwYiW0EvXrT57atd0ji5+J37rdc1s5Ht9RMO2WtBSXOc1+io6QjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078717; c=relaxed/simple;
	bh=MNl2a9+9wniw0DL7pfu1Gvnvl1U5VZVdbJpueNcd744=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BZo2UzuUhOI+iTfBfBi4noEFkb3oC6BfTqwhGp9phRu4jRlDhApOt/1fY4/aGOyLUSZ2zbGxwZOvxZY62NujM5BjmSO1bxr4Ttm8aKDQWhdJmJeWKu/PHKw+vzPNO25B6++EHqrvnBvKGBbOBJdovU1KXqPqaVXxBSjLQFCe8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECLElM3H; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609239ad1bcso25000707b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709078715; x=1709683515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QynGLk1qlXS/b5BsO1d0j20dFGFaWGNAGl6bHTYfKo=;
        b=ECLElM3HQkvcm62xB5Xva3Vuz5+IoziuYtMtZzylSjPHH//vXeyiZ+Ks2wdGHWvlwX
         VK4hGLThu212pF9+EESz9NeZnh/uPAIRtu5jEzoJOazrkdwXkOJgqnhZaE0twESWbmNr
         BlmKfRMa/Wa3j6RXePNl4OGwueRZ6yM9prV7P+HxaqfODUNyx5I2a8DSq22Mi45531IO
         xpgFnOkKwuImqPUy5LO2mK/HB1/pGMAssdxYXsHdDYmk1HYb3MPbIFF93ofCeTf1BIqT
         OvGJdX4ENLK/e/2UYFcVXwEpIGthKWmuJ3BldxrB/AvcYUBZ5N8iL7nEE6wkmzf/Sa3J
         ISAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078715; x=1709683515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QynGLk1qlXS/b5BsO1d0j20dFGFaWGNAGl6bHTYfKo=;
        b=IH6IckcLwJB58HVD1EzofgHbEcf6Uwy55806amazj9HXL0Ud+DjlQa1HY3r30JLfR8
         diY39cJywgs3ZNGULF6KUO0BaZfAdeuFjuzdsJLB2a7Lykfk5Vb28dhSUoG8zFAf0R0Y
         BmRYaGxqIlWPCF1kR2fMNH0mdoTa0A2IdrV07LePLzmtf/KWBGbg4g2AOXOCVnLbRksR
         I6jcOgfx0JIb391HXSGpTTRL6AIMZL6C9yyMmUElqddZ+D3mNQRH8M3g6Ctfnie2W34B
         bQs4sFrOqK0ILxUjP6BN8wWKU6p1QUDEuJ2OuuydLVbo4KeJrZxzYzBilBSUwi5gtoEl
         up0w==
X-Forwarded-Encrypted: i=1; AJvYcCWRuM0MPFdBjBPyQc16SxN6lzS5oKb8GfOY2box+69RTd2Tb0pfOwuthP7yqiARYjInmBwvG0xGHql1Ii7QGdpb42qPRHWOHrTypp0L
X-Gm-Message-State: AOJu0YzjZMvDqYwEFa0DWi5zY/TTwaH/HY3qAFOQwPAQMCu0XlwwzzhW
	bE0uUEstdiKZ21DObpivjdr7RFmo7YrVkOKXW3n055KgZSa/DlY5BOYsi7j/Mz0BjpkoYVQOmp9
	6jg==
X-Google-Smtp-Source: AGHT+IEcTqr5Mo3qPu3T4l2gV/YiU1cSUvm6btQ2z1PV6ifgWkRvqJZxe/4/UzBvKLHXBCdu2ZjX8X+6Vck=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a0d:cb86:0:b0:609:2693:bb33 with SMTP id
 n128-20020a0dcb86000000b006092693bb33mr704963ywd.8.1709078714754; Tue, 27 Feb
 2024 16:05:14 -0800 (PST)
Date: Wed, 28 Feb 2024 00:05:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228000512.746252-1-badhri@google.com>
Subject: [PATCH v2] usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, broonie@kernel.org, 
	Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"

While commit 69f89168b310 ("usb: typec: tpcm: Fix issues with power being
removed during reset") fixes the boot issues for bus powered devices such
as LibreTech Renegade Elite/Firefly, it trades off the CC pins NOT being
Hi-Zed during errory recovery (i.e PORT_RESET) for devices which are NOT
bus powered(a.k.a self powered). This change Hi-Zs the CC pins only for
self powered devices, thus preventing brown out for bus powered devices

Adhering to spec is gaining more importance due to the Common charger
initiative enforced by the European Union.

Quoting from the spec:
    4.5.2.2.2.1 ErrorRecovery State Requirements
    The port shall not drive VBUS or VCONN, and shall present a
    high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.

Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
CC pins are set to default state after tErrorRecovery in
PORT_RESET_WAIT_OFF.

    4.5.2.2.2.2 Exiting From ErrorRecovery State
    A Sink shall transition to Unattached.SNK after tErrorRecovery.
    A Source shall transition to Unattached.SRC after tErrorRecovery.

Fixes: 69f89168b310 ("usb: typec: tpcm: Fix issues with power being removed during reset")
Cc: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since V1:
* Fix CC for linux stable
---
 drivers/usb/typec/tcpm/tcpm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c9a78f55ca48..bbe1381232eb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5593,8 +5593,11 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
-			    TYPEC_CC_RD : tcpm_rp_cc(port));
+		if (port->self_powered)
+			tcpm_set_cc(port, TYPEC_CC_OPEN);
+		else
+			tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
+				    TYPEC_CC_RD : tcpm_rp_cc(port));
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;

base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
-- 
2.44.0.rc1.240.g4c46232300-goog


