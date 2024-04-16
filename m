Return-Path: <linux-kernel+bounces-146839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA28A6B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47DD1C21847
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038212EBE8;
	Tue, 16 Apr 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="EWYhDEmy"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301E12C7FA;
	Tue, 16 Apr 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272219; cv=none; b=b9zB4TPO/HVpNXgIKI9rUU7IYSewF/Co/I7zX0QxnS8p7U1UoWXf83IqDDYogin73ghfIhGo0la9hWOHHTkfpcnIayghaZA+TdrcIFdliNby8VCBm5OOoWFRGDGHoj9cKrryOJE3dwTvx7luOYp+ZWXGkQk2P+molsYLqMmxJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272219; c=relaxed/simple;
	bh=BeHbDLxRX4WOrHYa4ThT+3HJ8zBUg6fW2R74rAnsV38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVR5wdFdSMic4xKez7LMslkdYgJ1APH1bqZwS81blo7L/tdMeo8mMzRThgkaCE+R51O2QpmpGqEsCAazmCAn3AaXvvDJUy375dmjNwLnlHNb1EoASM48qvGoYrv2xldbAaszDc9FeZw2gw+mAMDj80XivsqrJ+NGH90FOGYmxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=EWYhDEmy; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272198; x=1713876998; i=parker@finest.io;
	bh=kAv0oBFkgwwU3Vt2YCqpLc+ik9GcQOdElLHJtyXfBOo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EWYhDEmySObpxDKJlYLm19HJhmWDuGRRG7zLtQ+qS8WdDpBpzpSiAxEk2FogTDKq
	 JDTZD05z/D04Hnt/UvQ4/KvKZgkJfSTQKbPUfdDnznn1cf5qcotxk87hRZ6+oa0mK
	 zF1hxawKorfmyFSRu/N0HomgvXvOcT62xSeMSTOkb/+kY+y0KmlUiy1GD5edooMJI
	 0ba2PcJSk26I35eMprZ+kDNUXAeE5ZcM3YrnsuQqLfuuSruhYrK0Y59AYvLSTaGCo
	 EiKy8p/uZQk5E11ukcjaPSI7ZUsRUthZNMBycLfsA/bYKw9JOS6nmmP2pCGynUwmh
	 RgaFX/mrfD6yEeRWSw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M5uwh-1shFHT0wnJ-017VYa; Tue, 16 Apr
 2024 14:56:38 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 8/8] serial: exar: fix: fix crash during shutdown if setup fails
Date: Tue, 16 Apr 2024 08:55:35 -0400
Message-ID: <1a21fffe403d7181e0404db1ed92140c306f97b7.1713270624.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:Aix2Gfbz3WAlz2Z+lR82+NyyweP0ySGfxPJud5y3h/eaUD+TfCK
 tNX9oGSruoLdOu9OVjQ9Uo+0rMlWuAnj6QsQuf3NDwyJeJenh9G0YNuqjDrvxGC9To3Prd5
 jnZUmHyyBgT1l7zjRXaSm1ujrg3CmsH+J0VneP9UY/0irnodH4Aa//OhmPjPqbOQZeA8qvd
 qvFGMX5q3L8Sz2gc/pDIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R9jOjENT1WY=;ejdCrwwafJxLraDIM3YWdGe5Gf8
 TGgftdLfb0YEcoJYUk0MjEIP5PuK3s748EFwOTKaLY+Pq67vKwXlBwwF6Qr2vRrcq7L3SIdyI
 ysVumb/Co+kA88d4EnuG+4x/6O0tWghnHZXILOYGY+grItIiuXDDBue+YGPsojqQe/vQFCu5j
 AnM5ofSPS1mRszGgXFvhgtEyU56eKQwL/kQPAumflvQARki2PgJ4EtskR9xbqSQuv0Lv64oH1
 4BHQXvS8+9kES+adbpXhgmg8qJx0KNTUNBRlc2QE3qzfSZqa67dmyl9sG1+75pkPjusK5YWqO
 dbNGBATZ2m8olWBCF3w/91oDCqfQZ5sASj4VQ+iFfbEMhI9UE5bX+ve05LagaY3wxSKdQD57K
 85LMfFDKXgdBsYuNP3iCqh0/eKX7k8Ut8ntFm/p+/9WiPYFFbN41dn+hjOFfmhhCK+KAaBpLC
 EnvcA5GERyQum/2sHmHkh2gkjT+K4S7xvi9KNWBmRztfGF4+MFs929LvBWT/MZ1c29emR83Ao
 RZSvao8gY2jnbrYQvmBdmHxzFDr0qHlmjqS9mOZTXXjDpb1+S+bUJdhSFTpIzFsWz0Ak0iQdR
 Csqskd5/909oaQ3kbEe042qJU62/boQ1w7xDTaMMdUARd0u1l2ktaUbvJtXIjCHJLGpYZC/4Q
 OV4ZW0lBaNndXjHuKj0L55EB0NoyqPeg+rN9YX4gufMj9w9ko44hKulEjeQX/xzkmNgQVOt0V
 eiF47/CMa5tfT5XvMX9PeNVTtTPxP1P+frurlBoSXwIT7gPCDQTyvg=

From: Parker Newman <pnewman@connecttech.com>

If a port fails to register with serial8250_register_8250_port() the
kernel can crash when shutting down or module removal.

This is because "priv->line[i]" will be set to a negative error code
and in the exar_pci_remove() function serial8250_unregister_port() is
called without checking if the "priv->line[i]" value is valid.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 501b9f3e9c89..f5a395ed69d1 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1671,7 +1671,8 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	unsigned int i;

 	for (i =3D 0; i < priv->nr; i++)
-		serial8250_unregister_port(priv->line[i]);
+		if (priv->line[i] >=3D 0)
+			serial8250_unregister_port(priv->line[i]);

 	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
=2D-
2.43.2


