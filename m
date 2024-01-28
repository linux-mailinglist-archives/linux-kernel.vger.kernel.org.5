Return-Path: <linux-kernel+bounces-41944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B297A83F9D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8E281F2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3054F85;
	Sun, 28 Jan 2024 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gosZk95J"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADB4EB5A;
	Sun, 28 Jan 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472703; cv=none; b=nx5scTIpNghVcTkYNlbpnouPJp1HFAcpcho+LWUfhs0E8u6fNlzJRi+ww7QgNbhJWMp6Lc7N95Vi+q/TriZyBSvk2bSFDGo460p62kx8iZMDdButSJjpxkYrsYbAwJ7XGpl0OOLbc8htWxENuu1jtwjm6AsbaJwyVtx/YoOloFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472703; c=relaxed/simple;
	bh=23alTXm9k3lUbkrmIhUVX5VMI48Qopj/KB7hkWZaKlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dgsfQ8O/qVDbZpVy8rcEO2CgWghQRtXJh+BZsBAUeFxI+ZcWaKvoppINWDGrVe6GbfNY5BAJz3h6Dgyg5cnG0J6ZPzZdE5nIg7YgjWXKrCinVZLmonpf17oRgTVt49fFOB/nCTaGELctYM5sWktZa6unCqN64aXBEaUmADHzY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=gosZk95J; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472684; x=1707077484; i=wahrenst@gmx.net;
	bh=23alTXm9k3lUbkrmIhUVX5VMI48Qopj/KB7hkWZaKlc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=gosZk95JFvmUVPWauOOS4Npvv4ELr7lDNIr0T0YG3t9oSfIhC5NbvWV54xHbeHkm
	 9wxlkOf6g96n+pe6tR0zszm3GpOp5rGuMQcb5sHn3LcAJM/Kvzmd+I81KELBbZ1Wx
	 APRO3QhYvkvBxwd8RPxzG4GjfV9psohzZOkoRSlVOanTDspoNUJMLM5/t1goz273K
	 JWig2Fp1gythLNCNMzI684InIevwZggktGAp1ZP7Gg0HqcgMsSj8+qA0O1t0WRUHP
	 KTOHucpmiDg3HIguWaSslVLVZwqEZCTJWp83Nczaozuh79n6YYKaD37WWiXAbVtuG
	 qN8d8h7QdVwdLUk6QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1rDLfP1ZU7-00v6Pl; Sun, 28
 Jan 2024 21:11:24 +0100
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
Subject: [PATCH V4 12/15 net-next] qca_7k: Replace BSD boilerplate with SPDX
Date: Sun, 28 Jan 2024 21:10:56 +0100
Message-Id: <20240128201059.6259-13-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:sv3C3CwzpQQO+yKvCE+VSbpj3mQKK33sLQnOkw1dQQwvbLUAbUr
 6Feq5wsqmWh5vyrw0NjpKlQpkNe3cKHqys35UuZz7g6WyjDk6B+DJDEEUCtx59+QZFiKQrS
 iGMNchysZEHw98tXqXZJLVFAvxlSXYGL/SukxZG+F9oWdTa5oZy3opWt85n5bNsQPZR8iBV
 QM5cMb/AnLBXWj8ZVgy5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B97AHIhxMB4=;q4B1ppViQhUZZpfOdX6hMzVLB7B
 8jtXX1rzRyfzUwQhWb6HyzVhbIIXqPIvc9dj+SbKq3GqvFsyFWHsR4EcGoUPFeoF6eXl6X9b2
 Uvhnezv6bsp02M2Pjhpb0+7zHSgIWIOfN3wS/yUnOCtSiC4r+Q83sgHUjESNJ+HAqpBsCCaTH
 Bz8LrOIGmr6wjf1VhTp0mI4uLAB29NfvRuN7ss+rwHz1DRQzNa1bF8y6PL2PE4gSVXEFiPvbg
 We8C7dtvd3QHjBysRuABp4Us3/E+FYpM4eQ0W2cj7hbKf9vhBe3A7iksEO8eOrW+HL8wCOYdZ
 PvgUgUe6X8M2Il8ervAFIA9sJ+74uhvoC+pAbfoh33IexZeUvKDPlk7WNwjgBh6uLUN/QqK9I
 y4BM85K0cgFipWCsDmw2/FctyBoYw7woKATQiDVjfZH7fFjyCpziXoRwKopn47hdB+7i88KAu
 gksukh+zvc8r6OMCGqEsMXdBDBad06/mD5twi07mwFe/DS8a7ymx2NyFSBrRNmvVzOKsE6wSN
 lkqVRV6zil2mLHVQDYCEGyacktBuIMzJaZ0OgzKQHXBUfpcmCb1FhijoXaZqpYmWD8S7QN9EF
 rwDiY/S7O++eu2fCYPANxcTRVbOP8MYurbBLhNHFCuVBhlme6in3GKUlGbwPLPuyGefIVuoxe
 8/IL0wTh3YzS1hAYJ1ayOVizH9MDRRASLKDy0C2L2rbAaFeEW+u6RvYc39O8aNHl/vcr2Xc4u
 ApF7mdjEPfW9tBw15lu3RJ60hqgjHdwYiDBYZKMiimXdmC3GP6APGsXDjONP/YoZieDF9bqPm
 qoDuRAl74SNVdNKzLmipw++ULhJEk+HOURkbGlZnQ09lwJmRAsQAJZN1kTNG25wZlx18/oh9b
 z5Qra7EloRaVE4YMvQteI3yX6pFbgquLB9eWk1EaBs48BikRTMQzDNz2GVRCn0T1awNZKazqI
 tS02LA==

From: Stefan Wahren <stefan.wahren@i2se.com>

According to MODULE_LICENSE the driver is under a dual license.
So replace the BSD license text with the proper SPDX tag.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +----------------
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +---------------
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_spi.c       | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_uart.c      | 15 +--------------
 9 files changed, 9 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k.c b/drivers/net/ethernet=
/qualcomm/qca_7k.c
index 4292c89bd35c..6263e4cf47fa 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- *
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */

 /*   This module implements the Qualcomm Atheros SPI protocol for
diff --git a/drivers/net/ethernet/qualcomm/qca_7k.h b/drivers/net/ethernet=
/qualcomm/qca_7k.h
index 356de8ec5d48..828ee9c27578 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k.h
@@ -1,21 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */

 /*   Qualcomm Atheros SPI register definition.
diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/e=
thernet/qualcomm/qca_7k_common.c
index 6b511f05df61..be2f754efd21 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Atheros ethernet framing. Every Ethernet frame is surrounded
diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 088cca7f61db..44ed66fdb407 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Atheros Ethernet framing. Every Ethernet frame is surrounded by an a=
theros
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 857883d0b5ed..ff3b89e9028e 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This file contains debugging routines for use in the QCA7K driver.
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.h b/drivers/net/ether=
net/qualcomm/qca_debug.h
index 46a785844421..0d98cef3abc4 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.h
+++ b/drivers/net/ethernet/qualcomm/qca_debug.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This file contains debugging routines for use in the QCA7K driver.
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index ca8c0596a992..ed6d20be19bb 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This module implements the Qualcomm Atheros SPI protocol for
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index f735ad77402f..d59cb2352cee 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Qualcomm Atheros SPI register definition.
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethern=
et/qualcomm/qca_uart.c
index 223321897b96..d0db9d0adad7 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2017, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This module implements the Qualcomm Atheros UART protocol for
=2D-
2.34.1


