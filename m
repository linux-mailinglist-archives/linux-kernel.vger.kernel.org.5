Return-Path: <linux-kernel+bounces-146832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105F8A6B90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F5F1F225E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB23312C47F;
	Tue, 16 Apr 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="F7SqsJJ4"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B212BE8D;
	Tue, 16 Apr 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272215; cv=none; b=YJYPTu8dNYOX0UwR6rUmxFnA+FLuDpg/5Siwxveayg+s5lQRKtwd2dbw5YWNFm1TNTCjYuOTnhaWVNVzdR+5qWPOgm1gjerSxZMMWiur3DcoKWDfmtSq5exrg3xZJEnHXvHqiQGZOQ5ll0DA5QPVaDWoAMY9kDySY2NShkxz69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272215; c=relaxed/simple;
	bh=ZIhUJYvk/wOqSM1Ia5ds5H6P5YLEAb5YuO7xaYAFlVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVEfwmYzidSKE8ZlRRWp4o1UTKavYUEUz/cwEieHbiHLK87GlaeM2tOicYfQSF2s4ohRrvIGM1JLDYZB4fxjVQuofjI+J6pFRbtnz1DPSvvQE2W6m/U/96rsqTp0m954lKqC8iOmiOAosTcI+Ciyk4CP0VmTA+PqpxhMdR7AOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=F7SqsJJ4; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713272196; x=1713876996; i=parker@finest.io;
	bh=/pMNEblpoORPGqBosh2QqloC4JBppA9VbN2iUpBE/p8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F7SqsJJ44Ke/3ripWDqYM6t6r0/HLxveQjdJBTp90pbWNw6f7xcKT4x/ef7HUAaG
	 q+OE6VfaWed4SFPu/kdTvogcwSsLkv5QA3YeqsnoHxTGvzFG2kb6zBuVie/ByLogh
	 UwCC1dRUE6MlqHChi9WZMmbL0LKX+paNnk8WAihNpiBttfumbPBjLqfQYyNLCegma
	 5M1I/exxJz1GfxIDz4uDBSDfzKzd6OHztJasRCs02XifdQPwLVTUpAZcK8mv6EHnn
	 jNKv0xlGwF2ev8a4l8jakCv3dGLl4jutKvmMr9QYOpzFhaX7wPqbyvorvL2CvRYay
	 OQWOSb3AVoTgtEbhlA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lan9S-1scchQ0Eh6-00cy8L; Tue, 16 Apr
 2024 14:56:36 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 1/8] serial: exar: adding missing CTI and Exar PCI ids
Date: Tue, 16 Apr 2024 08:55:28 -0400
Message-ID: <7c3d8e795a864dd9b0a00353b722060dc27c4e09.1713270624.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:/xHh/AkH89Z8uGkzl5PbTvHd7qBh0BgC800ou4B0KmtKs6cDYjz
 HbOFWxvfzTXW9n7JjOTkKQXMzE/QhwqP6fmXRvSBRFsTD0tTNRtbfKzDIVK3nhpURdGeDD4
 JfH1FYENDaGag5mrE4JwuNjnLIwjI2qyawEyh3cT21j1dk1xZWcuAgUdNLrP2loO/XXkaXJ
 ti71253uQEFfSAkbmGCeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q/udNzQOnbI=;shTdRZPHhz1v4L9TEhcRavEEyX3
 HhiWhZav0LU1ooDIfslUgonWfaxmqsrSHFBT5ya4t7mlS/GrQbDy95FyVOj8ciS4BZtnW1HQI
 TLc+ndgCMLDarGf66tVa0rQUYf2+Q9dNsGp1o3rE/nIQIUu5jV8P3xx1OQyorfSEf3dwP7CDn
 kj5bpygksnKyqf1Yq/eU0m9hwG44chATqzPV11xln+KFZyaZFtLw3QQdZu2sygjKy7YaHF8Yj
 IlUoXwPwVTjGFjGUGVYRyNqIRiv533CCjwi4a35dbxQD6dmBTiNsKqHdcDQjvh5TK4nE8Zn1g
 eiZp/ytmzQFfuTTuvFMj9OPUf/Dqz/s/971Ho4ybjmz60WwnIukxgyzYGZj3uFGlH9DMFMaLj
 ZtrqrQFFN9CASjdoGiS8W4ev59qK8vsiWQISrFdFtJas0P5qxg0Et2JHiqW4wcbrU1mxkHHWk
 nH1rSLSTcD+AHU0Tedw+9x5Lhq+5AsDuxtwQlZFmyBzLH+P3a7woGHCQexHwE8Exur1tUEraz
 +CRQ7pqRO4+0xYKv9d9NO8z9M9LszxyRtfRCb4q5WVmD/8RrSDACmKk64T7ocuIOZ2pIbNKdw
 yJAaosb70AqjYB46Fs7vS9ed/LG5Gly1+enPdnTbAiwhwRr7p7PGeYW0Cxa3/3PkzouM9BPg7
 MloAoeaY8l96PRZw5cnOkSQWHiddgIejbVnSV2tLvnGWXqfpYhNSOktE4/zU0vL9wAx2396wZ
 LVX9eVdddMwhwXwtAmb02wWZ8UvlzqD55jrfBUefLJiJJCSCDctEyE=

From: Parker Newman <pnewman@connecttech.com>

- Added Connect Tech and Exar IDs not already in pci_ids.h

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 0440df7de1ed..4d1e07343d0b 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -46,8 +46,50 @@
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022

+#define PCI_VENDOR_ID_CONNECT_TECH				0x12c4
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO        0x0340
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A      0x0341
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B      0x0342
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS           0x0350
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A         0x0351
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B         0x0352
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS           0x0353
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A        0x0354
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B        0x0355
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO      0x0360
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A    0x0361
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B    0x0362
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP             0x0370
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232         0x0371
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485         0x0372
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP           0x0373
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP           0x0374
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP           0x0375
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS      0x0376
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT   0x0380
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT  0x0381
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO        0x0382
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO    0x0392
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP        0x03A0
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232    0x03A1
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485    0x03A2
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS 0x03A3
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XEG001               0x0602
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_BASE           0x1000
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_2              0x1002
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_4              0x1004
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_8              0x1008
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_12             0x100C
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_16             0x1010
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X          0x110c
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X          0x110d
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16                 0x1110
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
+#define PCI_DEVICE_ID_EXAR_XR17V252		0x0252
+#define PCI_DEVICE_ID_EXAR_XR17V254		0x0254
+#define PCI_DEVICE_ID_EXAR_XR17V258		0x0258

 #define PCI_SUBDEVICE_ID_USR_2980		0x0128
 #define PCI_SUBDEVICE_ID_USR_2981		0x0129
=2D-
2.43.2


