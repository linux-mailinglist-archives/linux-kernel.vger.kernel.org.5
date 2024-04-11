Return-Path: <linux-kernel+bounces-141571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA98A202B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE751F21EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBC1CF87;
	Thu, 11 Apr 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="TtlHFyvR"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5E17C7F;
	Thu, 11 Apr 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867165; cv=none; b=JPiOuWSQOz2u095d6xULQxCsdT/bKDzFncMm51DhfzrysZKnxikx3JZg6rsqJrs1EFIRGrUunDuKvyG1tMC6u7Mx2P+Cv88PmklNh3ryCv60jNLaPtN23+hO+/IpWEjUKcAjBTJJRzKCmz3GPzTC7V1Ah0VykY5dnLqSBYofFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867165; c=relaxed/simple;
	bh=+2XwDQ6lAn4Bx7+V6jX/KojsTWOswymbTXhB7XkGjWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHQ1l7H73QFN6e9zJgf9GMbj2iTCpZ6Y1EEOH3TIh93RGgn9Kv/+cWy70kOkmM7mg2fQQoSoR8WF4qmmNaD/oHh+8T3fOJq1cWmXnPo7ufff5EJEP2qPv59j81m4cx0YIona9FoJFu3gCB9A/309hNjICZrM0eArcozTaXYrRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=TtlHFyvR; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712867158; x=1713471958; i=parker@finest.io;
	bh=uAlKCcZd53Dk25E1mU4G5eUWhLwVSNKWLZARPx1Vd/k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=TtlHFyvRI6Kr9lAjljKBLlf7S2jloEqhkZQZzEI5SpolyfIMupBf4tzDmaVQ5E8m
	 QHjuh1T/rLHQqkLJfOY5nMnnKSCnd1OSU7howzSWncicMBDxxJBzuRjkb42UD9AJR
	 u0tBwfNOsyEUY1G+ZCDF25/hSiYaE1kHoG10MtTACMTWznOGm8JDDuYZgW64oxjl2
	 C6Wo/VRHl8j2xCz2BzbWc5aLMXYciYgsgjQnsD52Ay/GPITW/+h6ccVS0KiQg2n4I
	 oRtGMLiLjmJ9tSqu3pGx+hhsT+9euELnv1eyuqKGVLsU4YDxU0yDQ/ci1JxssGZ9t
	 i6fpttzP/ymK4S6Ydg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LaEeW-1scdYJ3bTi-00cNNe; Thu, 11 Apr
 2024 22:25:57 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 3/7] serial: exar: add support for config/set single MPIO
Date: Thu, 11 Apr 2024 16:25:41 -0400
Message-ID: <3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712863999.git.pnewman@connecttech.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yXBxXgdcJalhXxtH8gjTeGnupsP1RKxLCVurqpPIXIFf7CIdcfr
 JHmai1w/JQ4yp+ktShW+hu+yi6m/RhETynrnoNxAv61gBEgDoX7e5GPicA9QG0KyY5lJIjr
 cI5II2tdeo3Cj3E/x3xoQ01Yq7g+fNHKbcK02Ux7eJgIch9J/N5pA9zufh0HseGV6O50Aej
 i7TBIbMJ1PYrOKvpIKMuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DpKvsfJhqzk=;cG+QJzw+y/TjMJhI+R3NDMhHo38
 Y05pfv2h7JRdf5o0S2/lBKtExZrYB8u5RDuePCwDFg2i98IlKFyzcHMos1wLWK416LdxSvMOH
 YNoPmi3W1MOg1nxzUy4lhe/yprLb00yiXknghTKU9AS45NBLJSrMjym75pH54+uqOn4fxGakr
 nUo1dhy3YY53VpnC1FNLz8VNE+ShsFGPX9qGnWcBUCZ8xMf+ZACNF8lOx9GZA8HhGLfNCNgq4
 xRFnOcRXcfCm5TbTJ50qd6oLRKHkbmIiqmX+qLMI11ijmqMHaywA7pAY2HkcRQcUQsU4VQG+v
 LU2OEAS93k3jNqppG6aop3s2jCIwYjc83MleaYUrLHPo3ZHXcwGimy4yV9CZjxt7+zO3M/NSq
 SmPRHMUT09mvLAoT6I6kMb5mclFREinMoX/tarxaMYMeGdAecQ3Aj2aqsYPbEyOvngb88EmDr
 QELkO6c/7jwVtC71vgfL4TB17TDG2cxEsnJIjA5z9dtzyWo7Wr9BVnJLqicltZODgiHnaCi37
 UyAsQ4GA1yV4GS+dQ63Q5alql9klj6Wj7V8Q/TmH2lp9+5WQv/+udfTwpoS8HI2VoNALz7mU+
 /kO6DyO1dSVkbzdn8sjO41NmR4JY4/0P3vUNAPYfQ2Csj267Av55uLXCwMFyxM/jaSvTLGUjC
 uu5aP/YT5mwTJ3GBcw6CbEcD1DID0BcQ6X3cbduonI5F4XP2+YrBUfmU9LTb7ajrItJCEK1dw
 w7kA8PKRKcUUg263CEMkKJ+7SCnXCSHmfXWBZGEVBSXoy+LbD/JiLc=

From: Parker Newman <pnewman@connecttech.com>

Adds support for configuring and setting a single MPIO

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 88 +++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 49d690344e65..9915a99cb7c6 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -305,6 +305,94 @@ static int exar_ee_read(struct exar8250 *priv, uint8_=
t ee_addr)
 	return data;
 }

+/**
+ * exar_mpio_config() - Configure an EXar MPIO as input or output
+ * @priv: Device's private structure
+ * @mpio_num: MPIO number/offset to configure
+ * @output: Configure as output if true, inout if false
+ *
+ * Configure a single MPIO as an input or output and disable trisate.
+ * If configuring as output it is reccomended to set value with
+ * exar_mpio_set prior to calling this function to ensure default state.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int exar_mpio_config(struct exar8250 *priv,
+			unsigned int mpio_num, bool output)
+{
+	uint8_t sel_reg; //MPIO Select register (input/output)
+	uint8_t tri_reg; //MPIO Tristate register
+	uint8_t value;
+	unsigned int bit;
+
+	if (mpio_num < 8) {
+		sel_reg =3D UART_EXAR_MPIOSEL_7_0;
+		tri_reg =3D UART_EXAR_MPIO3T_7_0;
+		bit =3D mpio_num;
+	} else if (mpio_num >=3D 8 && mpio_num < 16) {
+		sel_reg =3D UART_EXAR_MPIOSEL_15_8;
+		tri_reg =3D UART_EXAR_MPIO3T_15_8;
+		bit =3D mpio_num - 8;
+	} else {
+		return -EINVAL;
+	}
+
+	//Disable MPIO pin tri-state
+	value =3D exar_read_reg(priv, tri_reg);
+	value &=3D ~(BIT(bit));
+	exar_write_reg(priv, tri_reg, value);
+
+	value =3D exar_read_reg(priv, sel_reg);
+	//Set MPIO as input (1) or output (0)
+	if (output)
+		value &=3D ~(BIT(bit));
+	else
+		value |=3D BIT(bit);
+
+	exar_write_reg(priv, sel_reg, value);
+
+	return 0;
+}
+/**
+ * exar_mpio_set() - Set an Exar MPIO output high or low
+ * @priv: Device's private structure
+ * @mpio_num: MPIO number/offset to set
+ * @high: Set MPIO high if true, low if false
+ *
+ * Set a single MPIO high or low. exar_mpio_config must also be called
+ * to configure the pin as an output.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int exar_mpio_set(struct exar8250 *priv,
+		unsigned int mpio_num, bool high)
+{
+	uint8_t reg;
+	uint8_t value;
+	unsigned int bit;
+
+	if (mpio_num < 8) {
+		reg =3D UART_EXAR_MPIOSEL_7_0;
+		bit =3D mpio_num;
+	} else if (mpio_num >=3D 8 && mpio_num < 16) {
+		reg =3D UART_EXAR_MPIOSEL_15_8;
+		bit =3D mpio_num - 8;
+	} else {
+		return -EINVAL;
+	}
+
+	value =3D exar_read_reg(priv, reg);
+
+	if (high)
+		value |=3D BIT(bit);
+	else
+		value &=3D ~(BIT(bit));
+
+	exar_write_reg(priv, reg, value);
+
+	return 0;
+}
+
 static void exar_pm(struct uart_port *port, unsigned int state, unsigned =
int old)
 {
 	/*
=2D-
2.43.2


