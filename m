Return-Path: <linux-kernel+bounces-37756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92A83B4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF1F281488
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20A13D4F5;
	Wed, 24 Jan 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ZOzwnXMl"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35170137C24;
	Wed, 24 Jan 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135601; cv=none; b=RSV2L2ziVFM1FpIlkve/HXpyUOUqwM9LALTotp0HL5EKnUtZpbYLTASdeVLoTtvHtia1+G43p9xHFFIR8thyGWSw0C8LtDzLUO22TfRIeCNKLyNAzIKtAtXgkEtq9yYLOOq9erimeJdWm+lbB6aR6XLZZcafNohA2VMGPIB/d2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135601; c=relaxed/simple;
	bh=RDndYU/UJoApIcvHSwbCFnZCrA4471ZL4jmcwAK2gCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3GTSNUzCEOEtihRtvK+w0coH0NoUMp8YmiQztRcWuOQkXwFAkVOxwSCghrf/Mie6vG0jcdCLHme6DNnGXGc54UqZlTqAkQuKpGSmq1sPjtgZdZktz2IdxtTYuL0mULA8yODOfjyiO/TPHmKvzgEHxZb/yLrWDt3SnyP+6flI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ZOzwnXMl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135562; x=1706740362; i=wahrenst@gmx.net;
	bh=RDndYU/UJoApIcvHSwbCFnZCrA4471ZL4jmcwAK2gCw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ZOzwnXMlq1fqAu2xfqP8JbsO3NvTEF2lf5GjznbjySjJF6h01bo7gVAt4tmqAksc
	 Petd5KqgqNMTNLZ7mYbYjoZhKf7QgE4+NR7GQpBbYGZVVgD7J2p8HUJ8rQ+l+9gbM
	 rqx7walvFUIRjQy/CNnNR/pLtcU3rq/XI8klOZmjV0voG1hEz8KQh0zQKnhgFL1rh
	 U2eM8hKp5Iu6e6CRub9Fehr7oB6Y9PFG5GuDFsC9YCf8AhgWO7HQoNgy2yGWuuLCM
	 zsUKaLcWD6rg6LbN0RTzcrMzoXa/YsZb8i6+d3BSnaNe8N7JaMQS+JD1nEac961PE
	 RWHFFm31xuWSsKMUOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1qni1X0e0D-00li65; Wed, 24
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
Subject: [PATCH V3 11/14 next] qca_7k: Replace BSD boilerplate with SPDX
Date: Wed, 24 Jan 2024 23:32:08 +0100
Message-Id: <20240124223211.4687-12-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:1KGzPM3vAPeQ78Lo4tnVvpL5N+I4Iimqb4T9or5sZULdIZDt2ra
 N6pEqS4NtG/z2e1Du/B+6VK3432vSa9+Q0j5vqsJbgb5Y38k3otP1dS/taHmnrmfMAHJDBa
 O/pii8v6qu6sYHMjtGhOyhqwyz6xD6OkFRfUz3HqVmbEAjGAYh706rAcRNlhVMD8Cf2YRlQ
 dUroEa8JcTtKCw9vxubdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QsGj+4zh6gs=;tIuKtwgL1D3h+0mIIA9N2egloP4
 vdDSRzZ7Dv3U5zeyQH04n8HCR8BD9zeuHLO4F8oI+8nlmRxqYjJ/e3N6vhskMaCalb0aXgBBn
 z/NJbP5ddgJCVBs4TBEjKO8VxcxXV21sehBLjpkM1vzS0dwfypokMkWvpp8dq+4Ke+ui3vZZ4
 O71WBNK7uxK7jPGezdDoOptOFqtLzdDWYmrFsg/sqwJoexINAcNOrHO1ZKH8Ei+nkF4w9OCyD
 E5YnY5HTGVtDF8CMPsMgUwtyldEVjkgZN2OwP3y8NFfA7mKNsZaD+Zp6/IF9Fmhr8DkfmLL/E
 J6G7qmyK1Wzde/9ar5jB5ZrnoNvcMiMyc23Iwbg5IhnVIYR6Mrjmkv5ixCd8OS9my56RstyiC
 VFdI0vRTEGcZK6r/yQO5McNlY64d8+rq4YWTzkTcvYFpfUkhg4uoE6idYvIM55+FWg8nRGLc4
 LtSb5ModmBXxn+M5ZLbhQ6/EzKNSpJIEI0/MmrXgVXWMqHlHxE8LIfN4hnPDt+U5Tb6bvWcke
 YaIaMkDQ/Bh6N9XjJlmDWK+7ZKzVdtQVWn+CcNvkzGnwm3kE9cFtFp4ke2PRkB2b2ys+PCWMA
 jKVcREbS6tXoxTpeBbWBTxsWVEfY218woVidIT9mHNTNLqby5aU4r3/0LTB8gHdWVxCmeOSIk
 oJ8jtWjRxtcdzbbnoHxj1SW55em0PEgy6mxzRVkYKEx91D6o6le5peVd4R8lACSBbMtKp2vwA
 Vm0uNSE7kPvSje6Arwt/xdMwpwEgVAeaoioiOtIIR5dZRr9Te2KkF/bUmseiFl1p0+tIk5ewK
 JaXa6QKsIO1i6V4EyETgLp7sxz+FPXT95I0mqJbVpyqTeUFbidiUb16arw4+kvUDrKPLwaDXj
 z0EXrEiw+lUY/WePwawJsYxTjwHHT7gqEIPDoezHEGcuNkAue66Grtai8LXJAUwdiyXkPU1i/
 rzYcVxxmboOGKKreZGGQ6tECVew=

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
index d3109eb24b4d..7c63baeb3844 100644
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


