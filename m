Return-Path: <linux-kernel+bounces-37752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D33F83B4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA233288B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55880135A76;
	Wed, 24 Jan 2024 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LG0iE5+A"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF6136665;
	Wed, 24 Jan 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135600; cv=none; b=Ki1/MmKayclzMompiaAF9jmgW95+Tq7vFMpf70+iEGkmZ5RCwquIXnj1un6uOA6oGAfW43c1elIm+xlrnKNkxFoFXIr53z0p1eoAgHvfap59SFRVnhlf8Yb7jmD4HCON9rguETafUAR+gkoOtFzQ7BQRlGNttWsXemPZ0yVzmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135600; c=relaxed/simple;
	bh=s+C5yRBMXtAg248/XAUH77adEcGlMjvS8LegdnUr0Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cf8iKlqNli4ySUIKxMlN55277jEqoILI+yJugqpThQLrw+GkWGKCDoItkmz2wos7gZLsj3P3BurvUtipblFZKw9haG5FBjMkYDYpFIXxqxx3fB/BwPYqNxyJYnY5tJaNSrqDYcWQUZuwllNBDMciNGpwGgFt238fQqYifUyCuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LG0iE5+A; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135559; x=1706740359; i=wahrenst@gmx.net;
	bh=s+C5yRBMXtAg248/XAUH77adEcGlMjvS8LegdnUr0Qo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=LG0iE5+AiYZoaOylOS2JD3zjQXf+vZE6Zt9lc8uong2WuCHu2jI91EIPn8ejcx6J
	 siZ7UrRqOKxKLaMtgI43GcalkioUH+jiIFBJAyUPEDuJboXeXSjJqW6LIjWJAjXdS
	 i3WcnM6eDbbYDKRABJ1h4VM0Sno7TYz3N98NqxXzeqQXSTP3kCtl0nPAzuPpLENOk
	 ctd9CLqognvcbU+QNoGb71GKEwZtM2scZdGq/gx2b3ApiqC2vKGJCVVPKGiuMMB5W
	 WeKrvdUu3lM/C9tRG76rdOzyC1q0UKkEpF5aAg1szoEmrmXTPFMyDAYZNZxRrFPic
	 5UvOXDdoN8Su5v/Jcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1rQq7w0z4l-007Tz5; Wed, 24
 Jan 2024 23:32:39 +0100
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
Subject: [PATCH V3 05/14 next] qca_7k_common: Drop unused len from qcafrm_handle
Date: Wed, 24 Jan 2024 23:32:02 +0100
Message-Id: <20240124223211.4687-6-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:+SuZi/0u10m1P5jyBmdtkcS73RAKkaeuN2Z+lELxTKX6LDgfoJc
 Yar6ss22riQf+pdHWY3z6pxcBp+HKkw13W/w46wMQmJSZxs3dK49Dd3W66YZT+ou8kwJT+q
 +/EI++PnIXq/TLzVRH3MzvPpNNjcN0LI0JrYgH7aYC2GM9BFOADqIh6buMS0IfNdhCoXX4U
 vfOlWpDSDNQeDvDUPRerg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:we1Zf7Dv0uw=;Ppq1h2j7vnp19IwoHAkD3X91UZf
 7zA6MT5zAAVvMPnKM+phPRO2su3u4gcfpzvhmtv1itVxAhHXZEq/BIaYKXqmpvxpKzm2HakLU
 Nii5ezDQNBkiX8sAeYaloi2WnRXxUYjsqAhDhiZ0J1+ajVVC1iXY+H83eM/uYufGMqb0Eyf2b
 j6vL29wDgRWLfrPtVwwlXXa3aLnkLB3VwyHCxVGccOksh1t5ucS7ooPb0tj/udrU+T7jA9jMw
 JGfQDLFF4Tbt9/hX74/LPaB4otgKecI4nA7AStsdWXpZZytf9SKGifPqpROYoiHMZaLFVpc+C
 4Uyt0nRkBKXSd8u4rz4gItQfSXXfkF07fQmwWVPFMTv/EAnSd9kFbQkgrr0nXDQx8V6mOhKBq
 y5z4yIv/cq2ApY90tvi0b5LLrQvS4Fc8eiNGjSM0kERFAs39e2dQ6vGgUJr+x/P3lIRPRyQiy
 xpFUPymib2Px/lHfCtA13/dDdAO/kMzD4CHXxyO5Yu0A0u7tCwtbnco+7+dRzalycVkexvYGF
 Jr7WV+ItyWs0rfoY13rfSZHZ3Do9NUOx9AppuGehpfNRbpjw0GVUrL6uIXJyjNb5ppk4U5L33
 h5jIOvO01LYcgrANW3C3VtZPx212l0ApjpgNBQi6slByJiWcHDSvjozUPTudjvCDriYWNC2qa
 ZiEOg8sZ8hGQlfZp+tjtYbJNqbBj4X/ZDhPznHOXcU0xU+mowVo4R4eo3R0yXjCEz4EDlBnoH
 iQS+tWXDkYll5ExdcyBuFbJNGZ/lLSr02WNYoplJsudwZCyarsU4rrLVtuYZSDn2QQ/eNqOzI
 A8PoL36DpEUZNqDcWzrG1G46YwJyzeJGdp03I+1KtJml2uDJNRChh9dmxI1B6E30U2vR7AVqg
 W419qyS391osKO620JXZAhfT/6X9UMZ6pBR9IY4reHzBGuHqtJPwVVo7UMFMwjb0iPo0Hk2ZI
 eQm97Q==

This member is never used. So drop it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 71bdf5d9f8d7..088cca7f61db 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -107,9 +107,6 @@ struct qcafrm_handle {

 	/* Offset in buffer (borrowed for length too) */
 	u16 offset;
-
-	/* Frame length as kept by this module */
-	u16 len;
 };

 u16 qcafrm_create_header(u8 *buf, u16 len);
=2D-
2.34.1


