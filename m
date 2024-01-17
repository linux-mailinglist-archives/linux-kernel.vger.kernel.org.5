Return-Path: <linux-kernel+bounces-28928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8972D8304BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBA61C2440C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B091DFDF;
	Wed, 17 Jan 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwsqLbLw"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D571D697
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492068; cv=none; b=VESMJNMk945lEsdMD7gU6poSA6Jl2KH2zck8DUZdvbg+18cUuxY3vjhQGWZnKSqQTVsQYoM+tRbvS9MLgXUao+lJa7bQ86/GiC+AgAtqXTmmSXwUv1BrGf5f4WuNAH/ZRsWrY8k6qHrHYunf5Vob9M+xdfBcKAdoGkgMlGP0iXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492068; c=relaxed/simple;
	bh=Nui8zu8V3ndYddOaheaEne/imbsV07hHxFFahrvH2Sg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=NIwt3HVCTMtoeUAR7mruhiK114qTKoCNUjL7qgNXj5v7bmDrYLzj+Vhdh6vN6chZgpY+KybmM7BcAw4utx9vSqXwDtAK+/6CXeg9IZwTJK09kZQcZr2Up62uvzQCTyn/f6zwm+RTbyAFCLgtdayvSwMlLc4LM47o7ZshtHB2+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwsqLbLw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28bc9e1f43eso11160901a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705492065; x=1706096865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W4MUqY7qziRkIoVCBAjHtlR0P63yXdlU8r3ZOJ0yHa4=;
        b=EwsqLbLwrHC+6uec1zex3MPtORgYgWFtDZ6TP9jbVleJwmOBNJmyr49VRSFO3xKtje
         tGYknPHymYsxUZuWNYD7QahGByjQ8hFrsaaTDJa3YLPSshOgLuHfvBgWdqMHRse4FPVW
         mtm6xhudADl1OiO6tb1Xi1PSTh9mBlTQgWcxMHrCcERYI5QzBfS8G5YRc1yJcWAqP50Q
         J4iVDzbXCiI73XO8EP4KFFC8WZ/hYrG8uaViZVgTSYV9hvt3Yb/YvoBvNqtvS42MYLQp
         p0IOJ/qZpVVGdY4m8NoXLdWY5fm8P8R6ySNszP/bxDBtnjsjaOhM61w89c+A9ymhyN6a
         LrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705492065; x=1706096865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4MUqY7qziRkIoVCBAjHtlR0P63yXdlU8r3ZOJ0yHa4=;
        b=Mn/6kjpNdHwqIfmV+vHV72hnOTajzyA2WvCtUgCQxan+oKTRXag+ri6sqyvfUENlIG
         iAfrqIkMkMpNpI6R1wfnWGo3W0eI1rIu4qXRYB7GdiDjwQiV2A954Av2dCOdXpWqphhc
         0mxhSIoH36FEwg19TZun9dQgOiFnsmwZlwtSYc9ssjIa1NRxOz+eRp4UF1A7Uu+dgDBB
         AVyAAcBbgt12OYo8/gZp5RMzH8jUcTwIquWUxtBCckw9eoxXXm/h/HDJGVpQmgmLX44Y
         AMPGfTgqaOUOPWci3HdvvCtEWHqM7vMuFW0NCVf2LV37wpXiDIB6I0PjFomXxOVs6qoJ
         Hn+A==
X-Gm-Message-State: AOJu0Ywq/HzkZlrGe0KrLqXgAixu5uqw8EW31lRA8pJXDMVvOcHlko4r
	tZcbuZPZvIm3xTWQEtdw1R+6HL54kU9xNnEsZQ==
X-Google-Smtp-Source: AGHT+IGbV5MXvSWEBDVzyqZxJqAc/AaSt2OI+WAdKyDsredw51/qTJldbeyuukgdzoqCm1Fy3ggzJuQQK8c=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a17:90b:5292:b0:28b:d1dc:8836 with SMTP id
 si18-20020a17090b529200b0028bd1dc8836mr381586pjb.5.1705492065692; Wed, 17 Jan
 2024 03:47:45 -0800 (PST)
Date: Wed, 17 Jan 2024 11:47:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117114742.2587779-1-badhri@google.com>
Subject: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, 
	Badhri Jagan Sridharan <badhri@google.com>
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

Cc: stable@vger.kernel.org
Cc: Frank Wang <frank.wang@rock-chips.com>
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


