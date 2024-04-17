Return-Path: <linux-kernel+bounces-149182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E18A8CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765252857B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF54645B;
	Wed, 17 Apr 2024 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="n2YGThtR"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5242A81;
	Wed, 17 Apr 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385921; cv=none; b=DMTyWEVNQF8/f5f452BQPP3pon2ky/cpLnOLnavbGcNfIYmRpzuW0ncHYGhpbZIutLDBybeDkjn3g8UkRwswQEb2C3KXYM1yexECixjTbRuSooZ2j7xHnkQ5yJ7KXZOSjCF5JZwaglaIxmsh4EJ/N0YK5jrQyo8uH4RB8FKFBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385921; c=relaxed/simple;
	bh=vaOwlWfWNCYXW1bY0aCtIE5T8+KB0DoUNLHtA1QtREM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaA5P4xeeZVkM6koQTYeqIBZdjHVesQmleCTS7/j/gqboWxn0SVFr+AjuB4dwePA6jrbWxgMgiAnx5MVEeHK9FZtqYkMW4KxflI+1sYTRS5NcoZ+4IFfuCnJ4g9Qrybbw/kjCr/c5Djb0YAsk4YLIjWyKhioaI0ZJdsQ5gjj/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=n2YGThtR; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713385915; x=1713990715; i=parker@finest.io;
	bh=OgdkLE55rcfI4iKjjOB90ezNiSvnD5C9xJWlY5tEYG8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n2YGThtRzvolVvlSHqhtDIbr4ndivkR6tQ49p0Aw6jCGLr7SgjDJ8SvdnsW/DKDB
	 w3zhGvfVcZxESmLifGdMps2sF7NQzgFU4Gfj6MAL5U0GfjnPG1Qa2sUJnkAXSoTm8
	 OAhbug+Tb8dbr2ZI3e69lIdQYh09jZKFCXSXMTIuzeq/rBR85Nox1hAt0EtnkOpqY
	 UGoapV1l/1oSJ6no0ofElxDhxyWADngSVm0ctXsIA1jibU+yovtpc6sRFSlWtflyg
	 hGF6UKsSMvkT9VdCDbRKSW6EwI8NtbfCfXlMmyqbN4o6o96vkjg1IyZfYYnyD/vfo
	 qjUxrYaZOGn6n5zO4A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M3U6Q-1rxkAy3htS-000cIY; Wed, 17 Apr
 2024 22:31:55 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 3/7] serial: exar: add optional board_init function
Date: Wed, 17 Apr 2024 16:31:25 -0400
Message-ID: <0e72a3154114c733283ff273bc1e31456ee101f4.1713382717.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:iIMK9UjhQLlMwa/AOnMoIDct01FXLpiy27KVmAkNRK+LmCzAnPC
 t+KobOXZIttezz417DQSrVYFS/VmMwxdd7w5OsCgzi8b5C8z+UyVRKJzWLSivOZUmvebN1N
 rY3AynBj8LnKs0iyCSD57ngXnMko1zle9AVgt/86ddGmBsaMerXrQ8eisH8HAm0rg3cvA0C
 WKlp/zjHGcYL1+vcYYy1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oMV7c3eF+9c=;jyZpVD84WwK6gUFMo7JqnwP6lzG
 QPlRNKOqX1Aflozb8oWDsYsLxTMrkbKf4VX/IG2x2r6MhnZCxX4jF7H1GgiO6q74kIpMzdBGo
 NnlmsRsZUCFftXlfwkIEE22SL6HQY2KX0odTEyLwy+IzdwgbGNXdK2XQHes1l9s6VBIWr7Bd3
 fBmWGy9N/yKiruBVTZxpuDPmVKL4T8XReZDCNOD7vMiu+TLsz7g/0s/EFDgkTUchPbHxTsBsQ
 WxvsvZvujNr+q56zlSAoP9uLbX2MJ8OO2wH7J765dNGq5OOz404G7EmV20O/cMae5o4pLLKnM
 0FjouOS0/R9qDENNQyKDYmfarnOHHQ3TzvFXEV7eGkRNFi36qlEXlq4Fi+Q+PJ2fv3nfOBh7y
 MBuCfFU/k4Xu7mnzrBkaBKkMYvHiCNmhCMI7zCiwdw583U0GqU2YLavhKaz+ob69lnwTTw1hF
 ONjOO4/0bHWnIK/998P0QeJSruB2vK0I8+YmSigN4QNqe6mWgTa2SoJzcni0htJfp6ViS71zm
 mUE8Vdq1kQYQaKte7DJVzQeHPpWFF3Ak9QdInZhFR4Io2CLmqSGn7Vc6fR/a25adHHyRVVDip
 iqLaG8qVXDoTmyufw4m9sdT4fMW+iDHtvWW+2a72sw7Gn8VW9qBkIN+JO+qbQq0P3nVisnBHG
 sw5CBpj2VvDbRGKumxXyBD7jMqm1pCp1GPlTe9BeXsLE2Zwu1/DmNwEGgPMzU7gjB/8XBYsli
 9uBRTB20hTqCfq81uOTvatdRiEsBtR4lGzGKUgv92C9zho6+SZpI7M=

From: Parker Newman <pnewman@connecttech.com>

Add an optional "board_init()" function pointer to struct exar8250_board
which is called once during probe prior to setting up the ports. It will
be used in subsequent patches of this series.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
 - Renamed board_setup to board_init.
 - Changed pci_err to dev_err_probe
 - Added note above about checkpatch fixes

Changes in v4:
 - Removed checkpatch fixes, they will be in their own patch at the end
 - Added pcidev to board_init() args to avoid needing to add to priv

 drivers/tty/serial/8250/8250_exar.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 72385c7d2eda..f14f73d250bb 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -177,12 +177,14 @@ struct exar8250_platform {
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
+	int     (*board_init)(struct exar8250 *priv, struct pci_dev *pcidev);
 	int	(*setup)(struct exar8250 *, struct pci_dev *,
 			 struct uart_8250_port *, int);
 	void	(*exit)(struct pci_dev *pcidev);
@@ -773,6 +775,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct p=
ci_device_id *ent)
 	if (rc)
 		return rc;

+	if (board->board_init) {
+		rc =3D board->board_init(priv, pcidev);
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


