Return-Path: <linux-kernel+bounces-50823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A2847E5D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C015F1C21AEF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072456AB9;
	Sat,  3 Feb 2024 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z7eg7EEI"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4C7464
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926873; cv=none; b=SKW/N6aYH3IthFSwYs3ZOxSwV14p2rheu23ZYmJHTfT0b6QaPkN8UDXyfRCN2T1ux72CZkHzgFy/M6/OhlHRBFoaNEAP6Hmd40jbs01xpjlt0ZOs0NJpv2AXCa0kGZ1PPFAFehIEbj91oSxfDAFBJ2McKXgNW6hXY/OgaRAVsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926873; c=relaxed/simple;
	bh=MFOE+nUaSwDTYdIw9JQlFvPuda2tfFqnXYWlhZRBQXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Dn++tn/ojL1EnfzVLL33/+a3UHSCMCQ8sjQC5hvf+scLmrBoB4hzKJY/e8lvY2eR6F0hU0ZXTXr/d40jb/AJY9LWk3Lo0lHtC6ezl4TmN1oJF4Tau2BipJiI5Rv0PzXEIAkGHsmgMJilLyRMUZrykrVW9+I3IAR0VF8cVOoVNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z7eg7EEI; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240203022109epoutp044f805447934370874686a783ba038274~wOPGvz6jP2307123071epoutp04N
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:21:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240203022109epoutp044f805447934370874686a783ba038274~wOPGvz6jP2307123071epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706926869;
	bh=rTfeTZ1ggn+RSJzom8PUIzN6CDAju1vOdXUC/7MJkyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7eg7EEIlK/mhLhTPJolRKNed07EJdR+lp40BnruGQIGEB9pw3t7q2D2hEsst3avh
	 NhySbkh1qKjU9thDKpyT8OmcGWnr0ISBfRok6XXTHSHxXNaxVp9lm58wRwWUq2CQw6
	 NLBV4S1rDlxJDyG2jKHBOwB2RVmN8xjeV+sidu/Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240203022108epcas5p231f876cc1c931ed688c54c4274e2434f~wOPFaRoUJ1637916379epcas5p2E;
	Sat,  3 Feb 2024 02:21:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TRbwf6LwKz4x9Pq; Sat,  3 Feb
	2024 02:21:06 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.37.08567.213ADB56; Sat,  3 Feb 2024 11:21:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0~wKMgv5ky52407524075epcas5p2x;
	Fri,  2 Feb 2024 21:24:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240202212459epsmtrp21812ca3f066d52542904ed328fd6ca46~wKMgvGfhC0549205492epsmtrp2a;
	Fri,  2 Feb 2024 21:24:59 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-0a-65bda3128b3b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.6F.08817.AAD5DB56; Sat,  3 Feb 2024 06:24:58 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240202212457epsmtip1d30d18afeb2388fde8b116ce91299907~wKMe7cwip2723127231epsmtip1g;
	Fri,  2 Feb 2024 21:24:56 +0000 (GMT)
From: Tamseel Shams <m.shams@samsung.com>
To: alim.akhtar@samsung.com, linux-fsd@tesla.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH 2/2] arm64: dts: fsd: Add fifosize for UART in Device Tree
Date: Sat,  3 Feb 2024 02:54:48 +0530
Message-Id: <20240202212448.74840-2-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202212448.74840-1-m.shams@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTS1do8d5Ug+lzdS0ezNvGZrFm7zkm
	i/lHzrFaNC9ez2bxbq6MRd+Lh8wWmx5fY7V4+Crc4vKuOWwWM87vY7I4s7iX3eJu62J2i9a9
	R9gdeD02repk87hzbQ+bx/65a9g9Ni+p9+jbsorR41/TXHaPz5vkAtijsm0yUhNTUosUUvOS
	81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5VUihLzCkFCgUkFhcr6dvZ
	FOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnF92kK2gl72iafMt
	lgbGO6xdjJwcEgImEvs6m4FsLg4hgd2MEruaDzFCOJ8YJTqfbmCCcL4xSjRfPsoM07Lq8jeo
	lr2MEpev7oVqaWWS+P9jIpDDwcEmoClx/Dw3SFxEYBOjxLSpb5lBHGaBM4wSFzrWM4MUCQt4
	SZxp4gaZyiKgKjF180w2EJtXwEKibUEv1DZ5idUbDoDZnAKWEqdnHWUHmSMh8JddYsmrT0wQ
	RS4SzxtOQn0kLPHq+BZ2CFtK4vO7vWwQdrrE3Ie9UPUFEst2fYeqsZc4cGUOC8g9zEBHr9+l
	DxGWlZh6ah1YObMAn0Tv7ydQrbwSO+bB2IoS/3f3Q40Rl3i3YgrUCR4Sd9dthAZdD6PEtf63
	TBMY5WYhrFjAyLiKUTK1oDg3PTXZtMAwL7UcHm3J+bmbGMEJUstlB+ON+f/0DjEycTAeYpTg
	YFYS4Z0gvDdViDclsbIqtSg/vqg0J7X4EKMpMAAnMkuJJucDU3ReSbyhiaWBiZmZmYmlsZmh
	kjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1Mp4oObGdKunfDb7WqrdTjJ89vlTWtjO/3XZPv
	pnrg9cnHns/Fbtw9fKvmj/xVvl8v7GdYHD5ztd+6Z3fFTJG1Zas+n5nec2rba6tTP2U8Zf4+
	OuZ1O6DScVvUxfxzDVe5HVdyPdcSDbpWVzZJSWhvgf0LKb7WpbHJhXODa6fezlaOqrgYYxG9
	WOe+zO3Vv6YsFbn9heni9g/TVb8c0Ji4NcKjYbeXxu33bUkLKtVnKB69MVdGhXmC1otZsl1H
	jnLJMjk6W3+sMZD54cJ7+ZX2It8nXXEBWRy3Xr4/HXu+3XWK9c+7sRPsH3zyvzjxRu0/U7sr
	xjodXY9Ko05smOijuvEn07v3+uVfVO5JcPzYv1+JpTgj0VCLuag4EQBEWKTsGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO6q2L2pBsu3m1s8mLeNzWLN3nNM
	FvOPnGO1aF68ns3i3VwZi74XD5ktNj2+xmrx8FW4xeVdc9gsZpzfx2RxZnEvu8Xd1sXsFq17
	j7A78HpsWtXJ5nHn2h42j/1z17B7bF5S79G3ZRWjx7+muewenzfJBbBHcdmkpOZklqUW6dsl
	cGWcX3aQraCXvaJp8y2WBsY7rF2MnBwSAiYSqy5/A7K5OIQEdjNKbH3TC5UQl5j2az8jhC0s
	sfLfc3aIomYmiaWvFgA5HBxsApoSx89zg8RFBHYxStw/1gY2iVngEqPE648/WUGKhAW8JM40
	cYMMYhFQlZi6eSYbiM0rYCHRtqCXGWKBvMTqDQfAbE4BS4nTs46yg9hCQDXPLz9gncDIt4CR
	YRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAAa2ntYNyz6oPeIUYmDsZDjBIczEoi
	vBOE96YK8aYkVlalFuXHF5XmpBYfYpTmYFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwHSe
	4Z+O5XGm1q/eK59eYDpg9uZv+34nuY8MUou3aZU9tpxy5cCm2vvPL0VlZZ2M5FQ5x3LjUINU
	G9OfpJ8PherSduR2Wl51Ytp8y2Gvyv9Kv8K711jOGQhd/GCj+v+Ri+SC7KWdKV+Nks4IWudK
	rfZNYWUQPL39s3SdV0OUZ346f0lyvVuNukrFfSeV9Az97iqfH3+5r7+Z4WRpobXmw7c7NsZz
	trV/OSZg5jn3ql2QSFFkzZYm2wOmOkKNQa1XhLqY6sV1W37xr9m8sl+tTVX35fIgP8HabCa+
	WQ05vwTFTxfYG2e6lkzomd5u+srr6s81GlufK+2JF3z/7GacV7zH7GsS7zMP73AoDZ2lxFKc
	kWioxVxUnAgAvM6sY88CAAA=
X-CMS-MailID: 20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0
References: <20240202212448.74840-1-m.shams@samsung.com>
	<CGME20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

UART in FSD SoC has fifosize of 64 bytes.
Set fifosize as 64 bytes for UART from Device Tree.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index aaffb50b8b60..047a83cee603 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -601,6 +601,7 @@
 			clocks = <&clock_peric PERIC_PCLK_UART0>,
 				 <&clock_peric PERIC_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
+			samsung,uart-fifosize = <64>;
 			status = "disabled";
 		};
 
@@ -613,6 +614,7 @@
 			clocks = <&clock_peric PERIC_PCLK_UART1>,
 				 <&clock_peric PERIC_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
+			samsung,uart-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.17.1


