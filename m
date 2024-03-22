Return-Path: <linux-kernel+bounces-111644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E5886EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BF21C22702
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA64CE13;
	Fri, 22 Mar 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxmfFUFc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A154BD3;
	Fri, 22 Mar 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118712; cv=none; b=V9/JKcx3EIkn60ohFWn393N/pcJr7J3wwURBysBzeGlkJ4HF0P7Ki6J4MQoKC0P57SgcQFUA4tgYpn7QI4pU+82/V9UD5hL8BAYig1cQPKVPvyIOGlNE5CDG5cDycXYRPPxrSa3rUHkH2O5/SsnxSu/L5CerbHuSxv79tYWZP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118712; c=relaxed/simple;
	bh=veb2SWtHL0Ox9QO3zZylkMTzcpBgXqQeJZKsGDwqEUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1ycfjqDeRnOpAABg+oQs0p3iwxDQvSAA2AxqnRp4znDBqXp5DAQckHe5r1Ve4nQDSzTsSI1qXQrfvUX+S4XWGgZrhB0/XQNvdl44OqBg74RyduVACkxvRkwhhvc40UiFMXkqedx+PsZJYjN06WwJFBkDYElViycr63L/8cRlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxmfFUFc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4147e3e4d3cso2484845e9.2;
        Fri, 22 Mar 2024 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118707; x=1711723507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWuEvV0rvpO/l7LvIGHT/JLAEhFTYoLZLqtwl5iRm64=;
        b=GxmfFUFckVSHvrdQKxawyNBJ3Am2rTfgeAXR+PLnVUERvsp973ZE6FtoJyOzw2N9ZQ
         tBCRhUf6d2ebKV/exxX365IiUdU6vrqVakHVFOcgrLQ3FoMSdXSWexBIFvkbvXyZgPck
         XHz1RQMuFWZaY2r/lzlvu55Lb17/Ehd5T4/Qa5L15zOQjFQQbNkDcaM0cOZENNUTy8Kr
         6PoVzJg0K3BuJaMACogkI+PVQBxqmJK8ahOTbrLQ11fY8qjAQJpM6aG7PTuckien+HHC
         zb3FQ2n3iVU8IOu8S0roubqqEYFcPRQeGr4vr+pcDMQUro17VxD097MbfSNyt2NwIwMe
         hxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118707; x=1711723507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWuEvV0rvpO/l7LvIGHT/JLAEhFTYoLZLqtwl5iRm64=;
        b=pFlVODu/GlxaZC/5ez+XR8UT3TYson36FW4wUBKoKyJN5Udad/vqmaVpT/XdDOOeNp
         ++lgicMhaK/gY6K27Qyc8CLAJvgx/RnYMTxMrkoiLFebHszBN5vhPlaphKtQlaDRthJX
         u6zeVVwY1b5wLtIHBgCP6k5SmzQcbFCB4lGJozzFhLkLsJtlFZVmEIjdXEgQmUEZSvDD
         E98QARyOwKuoLqZqgXsOJ1Iv+2CRpbefT3l1B/HaK7CrZReAuNimWeArIT1Xmc5JKyv9
         L3t8/hzWeoRMnqqjMW3Cj3rfym7p5Gk4CERw2kv1HRQ1cEMxFxxG5pyxZyn2fwvELQcF
         Hx0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXgJqJGXKKke03JpsvECXRSIqvMqTBIsMCSFtYSJZcl0BKpD5S+SoHOywU6ZztO4cJYQZD/aFPnWczJjjUWgQGgQt/thOO+D+ZOQ0WST4EGXUA/zyIwZ18m09Wm2qRj0WwiJDgzHQPOxbG8KgSbM9xuDNsHwSrjkMuBVTgSxM9rQUsHZL9KF4JNQAx
X-Gm-Message-State: AOJu0Yy+7YLsGun8nSnOdPpo5vuK3t+TpZW8wOvFKPI51OLIXHNnbaxT
	5Ega546BE9dRZsHOgRYtNzY94qTyTAY/SMdUIYQ0+qJ3MUBbppLA
X-Google-Smtp-Source: AGHT+IGjPztaqKpu596k3blnST+nfDPu+lVA/PnAdQ4mezi8JzRKgF2wtriu9oc4aDkqJvhuMV83+Q==
X-Received: by 2002:a05:600c:6a85:b0:414:6638:4507 with SMTP id jl5-20020a05600c6a8500b0041466384507mr1723116wmb.16.1711118707528;
        Fri, 22 Mar 2024 07:45:07 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041466e03e55sm3911117wmo.0.2024.03.22.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:06 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 5/5] serial: sh-sci: Add support for RZ/V2H(P) SoC
Date: Fri, 22 Mar 2024 14:43:55 +0000
Message-Id: <20240322144355.878930-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add serial support for RZ/V2H(P) SoC with earlycon.

The SCIF interface in the Renesas RZ/V2H(P) is similar to that available
in the RZ/G2L (R9A07G044) SoC, with the following differences:

- RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
  and two for Rx and Tx buffer full, all of which are edge-triggered.
- RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
  synchronous and asynchronous modes.
- There are differences in the configuration of certain registers such
  as SCSMR, SCFCR, and SCSPTR between the two SoCs.

To handle these differences on RZ/V2H(P) SoC SCIx_RZV2H_SCIF_REGTYPE
is added.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Geert,

To keep the changes minimal I've added a new regtype instead of
port type.

Cheers, Prabhakar

v3 - > v4
- Added SCIx_RZV2H_SCIF_REGTYPE to handle the differences on the
  RZ/V2H(P) SoC

v2 - > v3
- new patch
---
 drivers/tty/serial/sh-sci.c | 55 +++++++++++++++++++++++++++++++++----
 include/linux/serial_sci.h  |  1 +
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a85e7b9a2e49..297787dc5c1c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -317,6 +317,37 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
+	/*
+	 * The "SCIF" that is in RZ/V2H(P) SoC is similar to one found on RZ/G2L SoC
+	 * with below differences,
+	 * - Break out of interrupts are different: ERI, BRI, RXI, TXI, TEI, DRI,
+	 *   TEI-DRI, RXI-EDGE and TXI-EDGE.
+	 * - SCSMR register does not have CM bit (BIT(7)) ie it does not support synchronous mode.
+	 * - SCFCR register does not have SCFCR_MCE bit.
+	 * - SCSPTR register has only bits SCSPTR_SPB2DT and SCSPTR_SPB2IO.
+	 */
+	[SCIx_RZV2H_SCIF_REGTYPE] = {
+		.regs = {
+			[SCSMR]		= { 0x00, 16 },
+			[SCBRR]		= { 0x02,  8 },
+			[SCSCR]		= { 0x04, 16 },
+			[SCxTDR]	= { 0x06,  8 },
+			[SCxSR]		= { 0x08, 16 },
+			[SCxRDR]	= { 0x0a,  8 },
+			[SCFCR]		= { 0x0c, 16 },
+			[SCFDR]		= { 0x0e, 16 },
+			[SCSPTR]	= { 0x10, 16 },
+			[SCLSR]		= { 0x12, 16 },
+			[SEMR]		= { 0x14, 8 },
+		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
+	},
+
 	/*
 	 * Common SH-3 SCIF definitions.
 	 */
@@ -758,7 +789,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		}
 		serial_port_out(port, SCPDR, data);
 		serial_port_out(port, SCPCR, ctrl);
-	} else if (sci_getreg(port, SCSPTR)->size) {
+	} else if (sci_getreg(port, SCSPTR)->size && s->cfg->regtype != SCIx_RZV2H_SCIF_REGTYPE) {
 		u16 status = serial_port_in(port, SCSPTR);
 
 		/* RTS# is always output; and active low, unless autorts */
@@ -2120,8 +2151,9 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	if (!(mctrl & TIOCM_RTS)) {
 		/* Disable Auto RTS */
-		serial_port_out(port, SCFCR,
-				serial_port_in(port, SCFCR) & ~SCFCR_MCE);
+		if (s->cfg->regtype != SCIx_RZV2H_SCIF_REGTYPE)
+			serial_port_out(port, SCFCR,
+					serial_port_in(port, SCFCR) & ~SCFCR_MCE);
 
 		/* Clear RTS */
 		sci_set_rts(port, 0);
@@ -2133,8 +2165,9 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		}
 
 		/* Enable Auto RTS */
-		serial_port_out(port, SCFCR,
-				serial_port_in(port, SCFCR) | SCFCR_MCE);
+		if (s->cfg->regtype != SCIx_RZV2H_SCIF_REGTYPE)
+			serial_port_out(port, SCFCR,
+					serial_port_in(port, SCFCR) | SCFCR_MCE);
 	} else {
 		/* Set RTS */
 		sci_set_rts(port, 1);
@@ -3224,6 +3257,10 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 		.compatible = "renesas,scif-r9a07g044",
 		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
 	},
+	{
+		.compatible = "renesas,scif-r9a09g057",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZV2H_SCIF_REGTYPE),
+	},
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
@@ -3534,6 +3571,13 @@ static int __init rzscifa_early_console_setup(struct earlycon_device *device,
 	return early_console_setup(device, PORT_SCIF);
 }
 
+static int __init rzv2hscif_early_console_setup(struct earlycon_device *device,
+						const char *opt)
+{
+	port_cfg.regtype = SCIx_RZV2H_SCIF_REGTYPE;
+	return early_console_setup(device, PORT_SCIF);
+}
+
 static int __init scifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
@@ -3554,6 +3598,7 @@ OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a09g057", rzv2hscif_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 1c89611e0e06..0f2f50b8d28e 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -37,6 +37,7 @@ enum {
 	SCIx_SH7705_SCIF_REGTYPE,
 	SCIx_HSCIF_REGTYPE,
 	SCIx_RZ_SCIFA_REGTYPE,
+	SCIx_RZV2H_SCIF_REGTYPE,
 
 	SCIx_NR_REGTYPES,
 };
-- 
2.34.1


