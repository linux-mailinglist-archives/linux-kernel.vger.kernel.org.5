Return-Path: <linux-kernel+bounces-41936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685D83F9C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89581F21C43
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1D4E1DD;
	Sun, 28 Jan 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tTcF6HLp"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33D41C85;
	Sun, 28 Jan 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472699; cv=none; b=CchqvnBiwD5LF3wGcypPUR8huEdtYO4wy66ez0XmCNbtjtobLAzn9uGMqSWcWbUaBj5tF4laweanEE6dgTnCyfE6pIVV2VaP78G2B0oLf7IsmzDgVMhvDy99VDuHUoB91gdvo7m+F+vgtBzzaMh2AGOArCAoklkyM+gkW7VSk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472699; c=relaxed/simple;
	bh=qrDaTsk7HTfc8TrmJHba7pRVGRstI4yMYwXgF2rjUlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krW1Aj94fMgfI6rOMWLIdFh+akoZOleLbwE5CuT6kHwEYI1jllTvinAfwcRnE3fR0AxxQ/G9xXMQzdOtn0yHERSRmRWLQ25ZkSRgYPVJWmsp8ge7ejScR9OZH9hf2MsRq8Num6xRcEH4gh8tpzbfdkjY+FeXb0wMR9uwoA0Uxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tTcF6HLp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472681; x=1707077481; i=wahrenst@gmx.net;
	bh=qrDaTsk7HTfc8TrmJHba7pRVGRstI4yMYwXgF2rjUlY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=tTcF6HLprL22VAD0O+Ir7RABGx40LNO5i7fDqumLJFRm3GwodUul70mmVT02+8T8
	 I0PFEOrBeXcwh6K150d45gcSPZM8sq9wTD3j++nCmeh62PUS8YjBYszFoVbwnwu5n
	 gyHNK/BGj/fYqaHdD3NnjJR6sS5b0guuB7nAO2iCRQWeogz3b5pkXBSzNDAC78QzH
	 SAlFloTVfs0OoOPJ1Ap8ZWE8evP0hfkN0KeaWNfeJ5bHFCV+wNC4Tzbe+IaicOdMn
	 rRPzJQTkdp81lUS+iX3zjJqpvyb81Dz1cUL5pASqIUOnh8rlwNhiTNN0IuiZx+egi
	 F5fmIU0oQK6xl6WpJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1rckJu0dFb-00REBN; Sun, 28
 Jan 2024 21:11:21 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V4 05/15 net-next] qca_7k_common: Drop unnecessary function description
Date: Sun, 28 Jan 2024 21:10:49 +0100
Message-Id: <20240128201059.6259-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Qu2GViOiUfHEkQicjzPEyIBrIAa1MFYCLZ5ZvBNpPxXfLIdsG6
 Di4QCjyU7rsdzl7sXQVNqn0EZ8EU77Tctz+dbYzAMhZsuEtES+TBJxhCUctdl5axdFJ1cuE
 mXRKDn+0/b2HiMrqYKjYQSaLmAiNK5CMxg7nVZlgbZIbhZWtWieZfrUo3yO8Nr8XSzUL75k
 kU33VH9SpVGZD2Jg6c65g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kAoRPM2GeSk=;7JUgHRIaySRwE7vGkfoM01Y1e9c
 KLYMwhjzBqttNp81J116rMohewK2pEuFZTUIXvSPDtHVvbH79oTIwZ5YINJcIy4VtGMC+3/dt
 5h/punMBQvGgFhHux4pRFOA5rUiQRaF2IPcppB6GpKtxHWCxBnZYqKTrdv2GpAXRo0ViVJVIx
 1LV4MXMplqlDTn6ojUGeC2LIZWTIVrb4Q/6Xg19hFK6Xx8LG0TWxBYTbbatPHWnlKa34r+3xu
 8c3WKTzN+A3V+XJyutnpHMapUz7k+JOxyp4v+XTBoFudI40h0clHaKq5UPzpe+YSiZp6ugYT8
 LQ5/8VLg8f53ptVcTrorTiC+Nl0UeVoXlZycazjJDmD51+sSHB44qq1EqCDolxtxr7XR6IzUs
 k3zpLIZXD719r81F7J6qcJUtcrfyEEeAuVM2daIHH8UpV29X5qZ5G1E6SQfo25QMTRUM4XU5T
 BQrevwBtRlBb2VyiFdVHVOanQJ/ELq15AcTjSt53AReg9iLKDkA5wkwBIgR7Gprp34myB5Uxf
 QtpxJIhqPBKj6IJQBkF238uVlv6SA+sjrYgKEVC8GHCrrB32yJCgNFvbfKsMJuiJQIuJ9j5co
 e1ltAIredbWyE/i/EbLXU3GfN3fXgh9+Wcw/rxUYsonXyMnE3heaDhHZ2Z0B438lbG3bQjfra
 uIFz/RctPu5m6M/ysEQdX79SOfVXaqllNs0KzbPSr4b9L/Qw3nRyvQ7iLz5f9xnz8liweLeNn
 i8e3NFbB2cIEZXlUNtfVC3FYKSiKhDTlAjoIBVdQmh2G3jlZbWqHo0GgDiEhFm5Uy/78Nn1Gz
 gobbgHlH3em83Kj4cemsdINZTfEhgPJns6XXogbAwaqwnZurwhisnoXw6F/FkdxBiJnXVKUO2
 mQ+Hf82rYt2kgEkNLZTyeJOf6kSe93mSoU1McEJvLua2wOx8N4JzqlPtGMXcjMgetWgA1rMtO
 Sqvs6bJDi/oRI+Vz3FoH5OSsE54=

qcafrm_fsm_decode has the almost the same function description in
qca_7k_common.c. So drop the comment here.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 928554f11e35..71bdf5d9f8d7 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -128,17 +128,6 @@ static inline void qcafrm_fsm_init_uart(struct qcafrm=
_handle *handle)
 	handle->state =3D handle->init;
 }

-/*   Gather received bytes and try to extract a full Ethernet frame
- *   by following a simple state machine.
- *
- * Return:   QCAFRM_GATHER       No Ethernet frame fully received yet.
- *           QCAFRM_NOHEAD       Header expected but not found.
- *           QCAFRM_INVLEN       QCA7K frame length is invalid
- *           QCAFRM_NOTAIL       Footer expected but not found.
- *           > 0                 Number of byte in the fully received
- *                               Ethernet frame
- */
-
 s32 qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len,=
 u8 recv_byte);

 #endif /* _QCA_FRAMING_H */
=2D-
2.34.1


