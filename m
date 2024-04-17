Return-Path: <linux-kernel+bounces-149189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73A8A8CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34419B24A26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5B657CB;
	Wed, 17 Apr 2024 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="x4pdr4J/"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B85651AB;
	Wed, 17 Apr 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385932; cv=none; b=tSUZbBMfXmUbRtQ0C+mQl/NAJovbiWckSXbEd8U89hjeY/mg9WdVsKV/cgTg6sUHSaZElkTY1765G5nvzkgzV8dN7oFaeCzN/r4va+8qqrGbAARIMzPysMyEeM5DEW/QJOe/dkJkQkW3LaBJL3dJ/smsfrWbLE1S5pe705heO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385932; c=relaxed/simple;
	bh=jBrmZuc+hQi/FGE2D/xlvk+OLFJTmVNAlYBeQ3oBbaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb8fE+NWo1ufNqhh4zPe7A4k+KAWHjb4ryr1SWhkXU5uBBXI8MpeFq+D3+AbD870Cmxwtz1iYzrcDWelE0bJbyVuPQdL34Dsivg0CUTh4FYosGZjpCrqHUvFsTY2XvvfKkK5g+zcfaWIiRzZ5HjKvbZqL9B/fJ8xRsKd6dnE6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=x4pdr4J/; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385915; x=1713990715; i=parker@finest.io;
	bh=QfpFgyFbjiFW1vFGm/sOAY+19iKk2+WxFUh4AkWal5Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=x4pdr4J/Iz8PtObnFCGICuk8JK1u94fdd5NBODkpfyqPI/65IDb08GgZEDsGRxOJ
	 zIcwApNuBK17QCLa82UwwdojXirr0yFzF9vIvfwrpEH/fFTHAPsy00AfCSGRrPd0e
	 5tyRFtGyMPlDYFI8nT6+DecLJ9nc0GVvMaAk+wW8NbUEfHCV/VmXjIJR7S3mwBS+l
	 bi7BDeCu08TXMJuwr/fpslTZmSxtFxNit0C+hcP4PULhnshrNTck9zwYOYtdLL7as
	 atDULNyRwVySSI65+HdKsl7Wgc3g4NmzKT5tyEG9lTyWTlHo/fV2vVKas8o3lF7On
	 06kQiyExeyIGK0cgCQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M5fxm-1s4KoL24TK-007Bs6; Wed, 17 Apr
 2024 22:31:55 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 5/7] serial: exar: add CTI cards to exar_get_nr_ports
Date: Wed, 17 Apr 2024 16:31:27 -0400
Message-ID: <0c64bdf852f39aec966b38696695d951e485d7e6.1713382717.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713382717.git.pnewman@connecttech.com>
References: <cover.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8N3qJWX/0pGN6XI4YNvCTwhbuWBV3TEryz8g7tRdPZHrL4eKgGC
 rMCl2TK+t++xEEgY0ntP2dT2FQwl5jZSetEmhLqlp9AFyJa9/vys9WcY3lDNhPg8aG1mr3X
 12lON7CCSsVzV0x4Y4ObsTTmv1fLtmddS7X3TjKmPsnHz5jcoXFAj9nOY5dzLXfeBCDTyea
 sL0SFFOJbdpErOVOR+gaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DI5yBrAfF6U=;+j/LC8KMH+9uKL2BSQzqZtK6Na5
 as9KKNuuRhL+VhZeRV4RA4Pq5mXw1BwaNV0ZzFRgzQvNbe97y/7GobbMqiv0QzKiwp+0KfP93
 0KVtBx8uag81gDfVBFMLrjC8BZuvqtHY1o7Weoy7OclPrhznb3E6+XuPMAbR+NJAX7MiDkZfn
 hYohJmFJeT2FzvlM+qSlyhpCDdVUUX49HG5kNy3Re8fDRnr3fLAUsObXnz1mHRDRt4qyrZcGH
 1wIIkepI2bqeGtUfZG4IuaErV+B49ut7+/hWHXrEl9HA2KtVXsGSBXn0Z95mqqEmVJB8HKgpI
 cONdbwaYr3SNeBNniU4zBJ4otUhp+oYQkcq/0X72mBtXXJJiAk2FKfSLUHT1Wjw5Kqmdn4JpJ
 RM7WHpmrwC4489Wgohs5W407YOZyVDXPlOzZAfJU6fJ2C+EiVduq/Xa26Xpf4EL81/NndF7CG
 mojJn+IYsToQsHLDkZR6/B+iM16OybqMrRMy3Q8kXo5UwCm+DlEhk0/IvQ7WWDstjkkhRkV+B
 l4Cc/N2VJHDIIu5R/iZdDB72tlbHSKwiijoN0uFvgPeoJhgEzYqaySGIl199lFHp0QzNEdTM1
 9hBmT2czIAWyvBu+AZGruF+aDTwJ2ik/hrtJGcyvaU6XoyYZozTOrtpviZchmoPo/MQgVgZrO
 vvlwpMEEsZhkjlN99MmhGs7/3PPZ/8rUHi8YESfrRaIj76ZtcuyGyOVEkMw88TVEV0hg9tD9b
 FfU4z/ofL7zbRwoVs43tuW3wciwZ1LDCNqXTv7EWKZNWT1fl33YQ9s=

From: Parker Newman <pnewman@connecttech.com>

Add code for getting number of ports of CTI cards to
exar_get_nr_ports().

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
- moved to separate patch
- added spaces to single line comments

 drivers/tty/serial/8250/8250_exar.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index e68029a59122..197f45e306ff 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -711,12 +711,28 @@ static unsigned int exar_get_nr_ports(struct exar825=
0_board *board,
 {
 	unsigned int nr_ports =3D 0;

-	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
+	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO) {
 		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
-	else if (board->num_ports)
+	} else if (board->num_ports > 0) {
+		// Check if board struct overrides number of ports
 		nr_ports =3D board->num_ports;
-	else
+	} else if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
+		// Exar encodes # ports in last nibble of PCI Device ID ex. 0358
 		nr_ports =3D pcidev->device & 0x0f;
+	} else  if (pcidev->vendor =3D=3D PCI_VENDOR_ID_CONNECT_TECH) {
+		// Handle CTI FPGA cards
+		switch (pcidev->device) {
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+			nr_ports =3D 12;
+			break;
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+			nr_ports =3D 16;
+			break;
+		default:
+			break;
+		}
+	}

 	return nr_ports;
 }
=2D-
2.43.2


