Return-Path: <linux-kernel+bounces-84241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A791486A419
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649C7286545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A75730C;
	Tue, 27 Feb 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBWiEFmc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EC5674B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078321; cv=none; b=Kz9pIlodstvTVEGCwg4+4/GRTIwQdiKL5xSpvgQaaknl6hpZL2zVrE7BLVG6TjMhlsq428HarAsMCJipSnHJL+xKWvQRXOCprVdpKuOoTwM7WMo2WM53PGjY+u21/Uh6LvHuhS8ngy2wX1PcewrCJrrK0vzp7qSKcu/4NQboy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078321; c=relaxed/simple;
	bh=2/lRzbav4ZEIZxCx4lcDj3Wd/X8auYnCnUQfBTX1XUM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RvXXnjRVKex+lajfAl2jA2FDKDoJ6WetSJr1ER7E00cXAcQt4dW0BWU6oQko4AFWSQ9nnK34vKKB11kJuGCPtjmi03T9H+nYlCr1D3ziOYmkb1wd81NRDexopDb51IJKR9pbAyeW1SCTOnBul0xXTNFw8F0GE1FAINIYdgWE7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBWiEFmc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso9338925276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709078318; x=1709683118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LdW7tPXFcFwIvF+jtRCAIo7Kke3BZ9m44DLtohg7Ec=;
        b=rBWiEFmcZqnDXPkn82+eQ5P9Zb2pGgmxxXOarVQMVv6GFdSfMNb8im2/RqG529TFWp
         sScu0GxpmpcqBUL14wytPzS/yywlC2lk/qlFJTUIcK3xb2YrOSkBV+68Np88wZeenloy
         eQYpIHe9e4Hx1C9dKZS76Yu41AqmTF0XJ9KIkBjFlYxKPQzlM03dRJm38DVo01Nr4lhB
         5z4Us1QwcUkp8fW3nSx6s1d6o7XK3PJKpeo1pbCHWIFXwDYz4w5oOGDSjmakMQu4SQbT
         1UCtCAODID72PnFNI07TY2LGdlJMNR4NVgRFZP9yNxlfDt/V4s7mP9gDpN0I75mKGVTR
         oKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078318; x=1709683118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LdW7tPXFcFwIvF+jtRCAIo7Kke3BZ9m44DLtohg7Ec=;
        b=ddfLL5QObDyjjQEMFCaJrwVu9HHq6SVhQfqADNLprHmtB3mxQEOjyt0Izu9vz4GRXh
         MWKKFMhCcAwqzD2PYqp726RfKjh4QlamYCIkg3aF+X+yz5UVBAvhaNIEIM0d+5mIu2so
         jl9FM5DY29tRDyE4g3ftGreNybTSf89bj+55a2HSN5uLBRn+1oPp+WP7gGr5mBjFW7xC
         Ona9n5S/kT0rcNiGkgkcaD2bjgZBpgSn1oca6LUVhgzmdrqQD1qkDxBqcBw85U12ZwoH
         ZO1ArrgwpqE9VdK564wChiLFe9ozG7m60oJSNl+9qHqSw+gg6x3GujGmdoj+TwyZX5e/
         8NVg==
X-Forwarded-Encrypted: i=1; AJvYcCV5bUtcADTytRm19CiWJLVPadUxLNQNQW7Uyxq4Y1vfVCvGMg6sauI0wNIznZsdLIsks5E4lz9T2k9iOjie4JnQrBFEgKVe0rLTLqIZ
X-Gm-Message-State: AOJu0YxZ0QGE1wXA4BMgJLL24zXK91E7byzhTjJpiv8RGcTiq6++MM7s
	8kJqWsv8ff7oI6PsxRB32aO3lLXR5YbOzr7Yj53zB0zBk3ZOmvBK6fRlJyjD205YpzXSMaOKvxj
	pJA==
X-Google-Smtp-Source: AGHT+IG0oglXzdl0/+UCvI8lhfH7WFBVyu8Ryq/6LJlQ/oklxmy8TdLcC0HnTPw/C46EKLLizN5gxuAWvGY=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a25:b341:0:b0:dcb:bc80:8333 with SMTP id
 k1-20020a25b341000000b00dcbbc808333mr294382ybg.13.1709078318262; Tue, 27 Feb
 2024 15:58:38 -0800 (PST)
Date: Tue, 27 Feb 2024 23:58:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227235832.744908-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices
From: Badhri Jagan Sridharan <badhri@google.com>
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, broonie@kernel.org, 
	Badhri Jagan Sridharan <badhri@google.com>, stable@kernel.org
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
Cc: stable@kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
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


