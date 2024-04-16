Return-Path: <linux-kernel+bounces-146835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E928A6B95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1171286534
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3512C52E;
	Tue, 16 Apr 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="g92ogG9p"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBB12BF1D;
	Tue, 16 Apr 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272216; cv=none; b=bCTrg/4y7jSLA0zB1WZlXnYPBwQdTSKPh5y+tj9ttaG63fg915h5kMnCa/Js5VotOdAoWy54KQkozYTFvUSGpcXiE4nArVW2HRSTrKRDqU1HgZzbN6Lk485J4Al+XuSOcGCYIDa0yZKVn7tYkQ7fO14OP0XBJM4D9mwg6erl28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272216; c=relaxed/simple;
	bh=QjdcD+5gndgUXKknCUOuWGZOGbJGx9wFZpaqOHf8IXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8rAlYLWhRGpMVqrnFFvxOmChmresY83giMvbtkH6g4nK1iPWbrxCLbXQ9W3kEGzuVPz6WxCusXfk3gZSZcXGNFtWbAf7jWtJHJaaSA0gP+NjtVV6NJaTqkejPSrZpMelRK4AGYHnpgz1jjVU6yttsqqnOayQCS1t6q1gW/Qa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=g92ogG9p; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272197; x=1713876997; i=parker@finest.io;
	bh=nq1fU38+YbMXQbv6fuKYJYq/QSLMrZ0aemu44ZrNMOg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g92ogG9pzZZl7fwWUUMWponggIrLl/pZr8Hflo99cbYyc/vafU4/FpJoKP8yuiG4
	 Rc3RCv6Dqpp8xwfNKgMla4t8gG9EwvP9KuNLNg8dZ5M786SbP3bSEXrnh/w30wAf0
	 fA/bdAagzGvRRm1/19P0BO2nqB5er9pb2WA0kTCxmPo8WSBJlZ1aoWr1Y26IwbOzD
	 2CyJtgNWmaRWLP1OdsnZOn8I3HLQguuLIk+ShMHmnMsW571af+4TCKDYtD5uf++qt
	 BVdf+arrURUtQpGZf8lAuSpUz6h0JHaN7d9e4m3Jc9Hpc/atfg1E7wbwMJKfRlpRQ
	 AbC1wsIwrQxpC40tyQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MYQD9-1sIrpN48A5-00NDRM; Tue, 16 Apr
 2024 14:56:37 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 4/8] serial: exar: add optional board_init function
Date: Tue, 16 Apr 2024 08:55:31 -0400
Message-ID: <cd710c68b6bc84efda3a57a1e91a1191d51fccb5.1713270624.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713270624.git.pnewman@connecttech.com>
References: <cover.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zc5YffDDEQWqNS9VJLFw2eg2+NrUU+PDgt9ChqVDh9Q/UVyvivJ
 /Cu4JP0BO+P6L7MS30AgR7uFWSP3erOLw1P4NKAh44NxMTIpOjxuJyQz+sgY9aCr7vrYsBU
 wPI9TwXlJ9ZjOL3gwKR9vVNf+iuCkdFwDEJTKYwRpnPcNaDUBXytE+oYkyi0lXDnaO4Xynr
 9p0IwUBBmfNED8X5YYK5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f8mxUc9XiuU=;PvwLdBSnRj94fQLN7Ku3b6I60gk
 4ed2JOP0nQXpOoslOFKm4BzwcdQNqD0mC0pnwaQlrRuz9epsWVbAlKO32Kdqd7y/t5uTS9n0X
 Pkffuny3e8n3n7n7U4dfWbFbEKoNnhDS3gokFHgd2Gy3MnIuum2JWocnvNc5Eg7gWPwboYJcZ
 8beh7kTuljqS7UfCviwKxcMRaalh1UhBKKxTEKff0R7iNgvehCN0yoiFCvLc5DePEMta19zAy
 m47pBEkgOTIJLTzxfp/s/WM5Th5Y5YzaOBBQTSP/kGt8lAY0ewFYnqWuARplTIan0MOJfegev
 Z34Me6AehVyB+zFuVJNEJWetuvgQ/K9AbuRRrgOPMOPKwN8hIEhhZwX4G0ula/l3S46e7OvBC
 hu9oyXcUynmtLmq7NbuBqg5X6PyI8CuyH839m5bYnPc1GHSmP1UIe9IPmfebeEYgyC0XJ+fBy
 3nI7EtFMvk4C0f0yJVtDTRxAOEQ5D1qtaOovLTc66OhcEMDKxCeBXPu898reGQ8HjBLP2sKsN
 KiiI6b0HOCXmkF2kjaupN3W9FWjEHSJB+lxastOXnQzKOmiAk//rh2eMeFN1obNAHo6hslohD
 0Rzz8ZlpVen3dEErNNBaj7jw5hatSbfBzUkuULwkVfvlWxnm7JFkt39mW0/iLx14+VMddDlmg
 P6Xjx7Xt6Jk8xi+7241PVW/h/3IL97uHuSORV4K2uFepbB0b6kg8gymG/dxQ3RcmPfjtG9jfz
 ul0P5dhE7z4qVcCtXzT3x2lgohT/in2ssnCpSbMyeLJDKM+rhFSCOs=

From: Parker Newman <pnewman@connecttech.com>

- Add an optional "board_init()" function pointer to struct
exar8250_board which is called once during probe prior to setting up
the ports.

- Fix several "missing identifier name" warnings from checkpatch in
struct exar8250_platform and struct exar8250_board:

WARNING: function definition argument <arg> should also have an
identifier name

- Fix warning from checkpatch:
WARNING: please, no space before tabs
+ * 0^I^I2 ^IMode bit 0$

Changes in v3:
 - Renamed board_setup to board_init.
 - Changed pci_err to dev_err_probe
 - Added note above about checkpatch fixes

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 388dd60ad23a..cf7900bd2974 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -133,7 +133,7 @@
  *
  * MPIO		Port	Function
  * ----		----	--------
- * 0		2 	Mode bit 0
+ * 0		2	Mode bit 0
  * 1		2	Mode bit 1
  * 2		2	Terminate bus
  * 3		-	<reserved>
@@ -169,22 +169,24 @@ struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port=
);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };

 /**
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
  * @reg_shift: describes UART register mapping in PCI memory
- * @setup: quirk run at ->probe() stage
+ * @board_init: quirk run once at ->probe() stage before setting up ports
+ * @setup: quirk run at ->probe() stage for each port
  * @exit: quirk run at ->remove() stage
  */
 struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
-	int	(*setup)(struct exar8250 *, struct pci_dev *,
-			 struct uart_8250_port *, int);
+	int     (*board_init)(struct exar8250 *priv);
+	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
+			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
 };

@@ -772,6 +774,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct p=
ci_device_id *ent)
 	if (rc)
 		return rc;

+	if (board->board_init) {
+		rc =3D board->board_init(priv);
+		if (rc) {
+			dev_err_probe(&pcidev->dev, rc,
+					"failed to init serial board\n");
+			return rc;
+		}
+	}
+
 	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
 		rc =3D board->setup(priv, pcidev, &uart, i);
 		if (rc) {
=2D-
2.43.2


