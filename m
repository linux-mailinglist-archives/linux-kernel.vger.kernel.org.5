Return-Path: <linux-kernel+bounces-79789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35DA8626BB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCDCB20F80
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A294D107;
	Sat, 24 Feb 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="IEP426xT"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D514CE04;
	Sat, 24 Feb 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798834; cv=none; b=C7HClWI68Q3JcL/XUcialeue4YpSNBWPjgAY6xWHcGshDW3w3pBguPe9SCAYyJah5aGDf1JzAcGQE+Tv0ZdPalhfF1lMsvoaHEuIYsaDCfktLoZI1wEu0Y+h1LplV+bTXVP+PrrS1SnecstMXeNjTgbsI+x/MRDmtEd0h7dSCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798834; c=relaxed/simple;
	bh=HLdtFuwBDRNLRQYjgEwBZfjetsumFZP9EINs5eu8Ui0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qxlRoVwAQO1HoEPqf/rH3aJKbNOxAmj7EAljzJyMQJa+hURysmf8qNvEauIrfeQqN4DRp0ntlUGSS/9JgDU9urwUPwwAr0KtMm9BJScMeOGOJLePt+EVERfaTp1W5/EmXlDz1JxHZmOWJI3lWWuacyPRxE6tNv5VNjA25v+yvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=IEP426xT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708798805; x=1709403605; i=erick.archer@gmx.com;
	bh=HLdtFuwBDRNLRQYjgEwBZfjetsumFZP9EINs5eu8Ui0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=IEP426xTmej+7wKw+cfrPlRcwHyTD2bo6IKM9j8f4FRW9IH91ACv+ZZ1oR3ljs8/
	 jzGmx3XrzB5p21J2sX+RFH2XbY99Ji8EnAMnX+wVs7fNLy25JjsA09DAIoYOx2ge0
	 z67MXv0gRBZhaq2tJjVTIeA3YNcACLUjmpnuKNAQpGAvQ0IYwBm+fW/Dt395Th5M2
	 0vl+c565fUx5qBgLxOpU3glRVvsS7UrIVxOSqfufnbf1fwBqcJhgMz1dltAmbKJbr
	 k4NAwiyp5iAXL/cFjXQzEXIcbeWD/8QO9NKBkqOTooOHrwh0FoI+6XPTtC5LfkmcE
	 4OKqJ3OJdITMBpYLNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mzyuc-1qjUQ638qs-00wzVL; Sat, 24 Feb 2024 19:20:05 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: Prefer struct_size over open coded arithmetic
Date: Sat, 24 Feb 2024 19:19:32 +0100
Message-Id: <20240224181932.2720-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zqwqz6nr2f2W88YDtxj5s173lC+WL8Q3S4fkpDNb1BxCayF7w1B
 hiCsPIspmSeo9iD2LNzgyOJJHCXzOZK9RUcL/lcMGu3szbUEieZxyCk7aITHWPn7rAqhg5T
 XMbRQYVfUl73uwaX3hZiEp9ssE/TFiYTLsCvjHa9X7FnAK3/MR5hXC2FrIpTIL7SH9uIvZX
 x6DXFyrAcH//mveWSeAMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H68dJOmZMmY=;ChL+qRCgvBIQRtWHzfugkT2SI+x
 +Oi5d92008y1yW13c9DyKvLTBUnq8BrfHQxxe4JNI3mdQv3/A6xOPpkdibF5VA3UzCusMrVKp
 zyCD9mgiwg9b6J5nntqh2zG0U3qvfWGehEFhfpKb6KR106FlFfFh/QOtolxgv44VOD5amdtFU
 DxoEEqDnC9rhmLI+BblRg+ndf/8KF8NCvlmuSpRYlGiB/4towQTW4cBmMzf1iCmMOenzkClIo
 +xcZEnxGcaN/kcYqYu7sQXHjBiPqVYXFGlst2TbuX4tN16RIoufpiuEb6O6OvgMAYEj8IfqtA
 SIVdkuLcsw/MMIsO6LRS6SPprEGJ/XBzWmjnhBrYrJ9sfhrvlvuUUWik3Ez/hvNdb1IUKrda8
 FdPQ3Ll0jS3MgCiehwqX+7URUqirCX27rHv2447iD4gV7WIeie6PUo2H8aqNs5ccV0XErA700
 I0NFCSCKj3E8MKQSmKv/ahbtjjFLcn3nwMi+vDPW4Cwrxdk3chqIv37pWsqeHl9sffEm2diZ3
 3zI26HBTz/i8jWm/V2us69meMXliDX7s6yDSU3vPOR2xtxxAlR3GM0Nvt0x8XU08ezOEmBuN4
 sYVAySeTgDD+DpHh8vjTff84tfABOXYogOLfFsPBSOnh6jmV3owJCScKfndCeatsurWkRloW4
 kuvWTlMi6LxB1wJGnFlD4GstSHVaiYFYbGyChZ46yV6N+CYFs/Q8AXnnOCkdAoO5Vkfrb7/+E
 wrBaV2fyfF2Z+r+zf3k3kY34l8bp+RcU6wrxQOOttNoJ/upP38pvBe3BNXNQyVGWlD19YO7N/
 qsK5qexm6Y6XWfZcqex7o4fysVoq7JLhrF63tUdBRLxcY=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "port_prox" variable is a pointer to "struct port_proxy" and
this structure ends in a flexible array:

struct port_proxy {
	[...]
	struct t7xx_port ports[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + size * count" in the
devm_kzalloc() function.

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]

Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/net/wwan/t7xx/t7xx_port_proxy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7=
xx/t7xx_port_proxy.c
index 8f5e01705af2..7d6388bf1d7c 100644
=2D-- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -543,8 +543,10 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 	struct device *dev =3D &md->t7xx_dev->pdev->dev;
 	struct port_proxy *port_prox;

-	port_prox =3D devm_kzalloc(dev, sizeof(*port_prox) +
-				 sizeof(struct t7xx_port) * T7XX_MAX_POSSIBLE_PORTS_NUM,
+	port_prox =3D devm_kzalloc(dev,
+				 struct_size(port_prox,
+					     ports,
+					     T7XX_MAX_POSSIBLE_PORTS_NUM),
 				 GFP_KERNEL);
 	if (!port_prox)
 		return -ENOMEM;
=2D-
2.25.1


