Return-Path: <linux-kernel+bounces-37745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C683B4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D080B283CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D11136662;
	Wed, 24 Jan 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="IrZFIK6c"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEE7C08E;
	Wed, 24 Jan 2024 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135597; cv=none; b=Rbbv4PI+OD5SHW1xRIcjrIuea/G/kAbugQ6K3NCOmqV/HcYkVcm2LexOAQomNJU9OSvC5prXHey2K/hnJMBHb5syn4hvTUXAgpEAXyVE1LFSmZSZL8ANv7Q0MBD/19NLQN+F/EPEU6gCW5e9l9rNtEbxBLAtNYMKMH4l6EjmMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135597; c=relaxed/simple;
	bh=tkLKTn8DhkyrcCxWX8yT7dnXK3EVIGJJiLfX8uXj23M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwaKMVGgIYJqKJkyr6EzT0MV0ZfDQkAnpsbSfmNukdAwL/LSqCLzgxtibNu8wcswLaRh8IQ4b67wvOSJaEl07lbCWEgOetrCvh9CYKvgK9DgNdLovQKyYwqhj3/+vuZM+UpgjYPKEcsLw41UsfP8htMZfTOiGZyD/OMYQfLUgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=IrZFIK6c; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135562; x=1706740362; i=wahrenst@gmx.net;
	bh=tkLKTn8DhkyrcCxWX8yT7dnXK3EVIGJJiLfX8uXj23M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=IrZFIK6cLJSYUSlJRhn4JJls7izj3y65r29pBWImkw038qmeonmwRIXx45LoSktO
	 fOxgG5wCGRNHwR2KwAeFZ9A9depFBpmD4Yy7/JHCSk85DlJYSt4ObA+1Vru9lYPiD
	 RttKCU8mzSvbSAjN9z8E+6iJxH/4ujBR2VvuinnQwXiIXEhg6Eub4RijFytk2qN5E
	 +eTkpasUdHy4WAHfb2Ds8lhoZR9gwkoS7t9XXYynbC9uEXLPseSqM8nCN4P+OjClS
	 355H66aeERcj3mEFWkEnG9UVXCDfbEldLzdhhQ8AoDzn9LDdGAgBoC5RzIIrUh69l
	 irUTBpMGLFmewWIvTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1rme822j2e-00JuCa; Wed, 24
 Jan 2024 23:32:42 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V3 12/14 next] qca_7k: Replace old mail address
Date: Wed, 24 Jan 2024 23:32:09 +0100
Message-Id: <20240124223211.4687-13-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124223211.4687-1-wahrenst@gmx.net>
References: <20240124223211.4687-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q3a0x4qQk5+uqt/dkBIkcBItlhLqcHvgSjgq3jq9a/cLwV2w2pa
 VNoMrGlqqCcgPzvNc3BpOaqTqVmf/42k7oY73heOOxeG+T1gEOnon9RiZss6d2ZRZ3MugWv
 8PQ1j69qHhr4S8A/qV34gdFwAN3ofLP5+IsH61op3JbWkw+ALUuEiPWRIlE95tGH3wYl3WT
 +U7w8vlHYL4rZlocBrUeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LAFXGoU9gpE=;V/M62mMDW3UBbW8g/Ves+20EiTZ
 SQxZqTrmxwXRDo9u41vuZ1EM9pWS9B6uZYyaUVje7ji27lHIrzLLMH3XJiQV9laDcRyFteQ4h
 fPQcqV0GgBTIhKT5nkXGMBQm3hxZTcQUcHtpm4OojGrNXqRrlSizuiJ6hVatmQQgPK1k8awFf
 OpVuuAhMthUyrK0F9wwyEsSF2MHNTq9yWLBqwz+atQg2uBVGbncMAES/LvY6yJtLXE49luyrE
 UtIe7lkC2quU3N7JpgKJX5e+GZfi1hBPTMYuHHsSdaTR1OM+wgblND6w3f+n5lWv6dv7uZ555
 6LVU1jmtcia/SDZ/0dU6J6dIaE2wWrUQXqPmV3OtCVf1jyD4dnvImi0nq1MRGOS/4wWiODt7U
 aywniOPj2AmVA+vDZEpYmjG3Cotf4ifo0afffZvRrNJWIJLJrihcRvn1YiBEJWPQRxNEUKHkv
 Q7gSzujbjEa5gnLDCVFNqd9c8nVWkIeL+DFvfOisMjQW5WE25xPN2NisEhuM+hEhL3OdGgP2v
 OSzE59W1uTCyIKrkCLlVfZtx8Mm7EvWrPGM5nvGpBlS+7tI3hIg47LJTWBg/SgvjPmtZgqvxR
 nN7a5J1kAKv+Qq0NfTVgwym6f9xUj+j4Dl4gEm8aTJZbkaO1hBcR6P0ntltGCptUtSJkWjG/H
 ovT2mOrA2zNVKqKanSKXEnM+BymDKpIzoakpUzZ1ShrrbfU3TOeVkWLIOfwhT8mjzb0eC7lRJ
 AmEX2RYkOgDQeHrkq2kuRFoJ8UWIkar4qNFW/ljg3BR2CBxliJURUjRvw+DLXm8uPxqz6dZii
 QhMv4z36EdVhVdS5NAHCu9245tUY1RSBWZTwMHcdTu8BqySLZsRKhaq+9yBDgFa9C2PrfUrVI
 f4dLxCnwUqwltUKks0k225O4FN8V2coY0InXWBsf0KkaQSOaYSKWAI1jd/24Ykl6sEul892Ul
 BWpNJSxFo8UDgA848eTjAn89Id4=

From: Stefan Wahren <stefan.wahren@i2se.com>

The company I2SE has been acquired a long time ago. Switch to
my private mail address before the I2SE account is deactivated.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 2 +-
 drivers/net/ethernet/qualcomm/qca_spi.c       | 2 +-
 drivers/net/ethernet/qualcomm/qca_uart.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/e=
thernet/qualcomm/qca_7k_common.c
index be2f754efd21..5302da587620 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -149,5 +149,5 @@ EXPORT_SYMBOL_GPL(qcafrm_fsm_decode);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 common");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 7c63baeb3844..29be0fe0b235 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1042,6 +1042,6 @@ module_spi_driver(qca_spi_driver);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 SPI Driver");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(QCASPI_DRV_VERSION);
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethern=
et/qualcomm/qca_uart.c
index d0db9d0adad7..321fd8d00730 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -397,6 +397,6 @@ module_serdev_device_driver(qca_uart_driver);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 UART Driver");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(QCAUART_DRV_VERSION);
=2D-
2.34.1


