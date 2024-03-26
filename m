Return-Path: <linux-kernel+bounces-118901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B43988C0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F18B1C3C83F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CCF5C911;
	Tue, 26 Mar 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qxUANOsR"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFE548F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452969; cv=none; b=JfgKi8dcRHto2UwEVRFykNjdhVTh6QjSoeeIR2QQiPRkdCm/zwfGneyxHXcRVr81EICq2O77IOA7ankWhBhC9tuOpu5yS2gC0CejJQyIJ0Q9NU6NToeI27YtsWb6DyyvJmkdLGsdZbP/0DRzRHh4ccDlQI0ImwqiG9Rnz4D95NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452969; c=relaxed/simple;
	bh=/9sjfhLIfFGy77UGOvipu72hd+OCrZ/YXwyTWB7a/e8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=BTg3cdansTrNSGvyVeqK2tJFZdZNhPdRN7o986qxM39rIeNYXaFvP1wzKdJUS/7pSFI5Z2CfXFQ+6Dq5DzFlo4JzidFTe7rZP+HbGNDaDrew7iFez7xp6bKxbunCX+6R13CGKerebCFv+WUBMklvAVAdC2rM/brT2swkwNRmUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qxUANOsR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240326113603epoutp0246ddb989801b8095fc24872bff454c51~ATWb_Z58f0288402884epoutp02E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:36:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240326113603epoutp0246ddb989801b8095fc24872bff454c51~ATWb_Z58f0288402884epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711452963;
	bh=3Z1Bn3oqb+Uo6Pqdv34+uEDikoxRgsxCbeOO/g/bLpI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=qxUANOsRkdJARt33vn/dplgg4X50Iz/ZJQyZDDPi8LwPK2c7uRjkNrVco83zlxw9m
	 t6ssRm0+3LQ7z2I7WM1vwSNKTRo2hecxbVyF2gmZmuRNi1g9PWSc9tZMrXCgwd6m1b
	 17nGLC2/Ea7wsYQn0iDRCrP6METS67St9LK9pShw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240326113602epcas5p3e9735ef1a0d2b1d3dd112c70c7dfac72~ATWbgawYF2752627526epcas5p3r;
	Tue, 26 Mar 2024 11:36:02 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4V3nmw6CsLz4x9Py; Tue, 26 Mar
	2024 11:36:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.B6.09665.023B2066; Tue, 26 Mar 2024 20:36:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240326113600epcas5p273b4e2b62aa732a55bade196b3f45afe~ATWZVkryq2506225062epcas5p2j;
	Tue, 26 Mar 2024 11:36:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240326113600epsmtrp216cf20999d06b863f2fb703b60349db6~ATWZRHkMj0269802698epsmtrp2Y;
	Tue, 26 Mar 2024 11:36:00 +0000 (GMT)
X-AuditID: b6c32a4b-5cdff700000025c1-0b-6602b320c210
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.5B.08924.023B2066; Tue, 26 Mar 2024 20:36:00 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240326113558epsmtip11297fc7f004d14d87616aff8b8e509fb~ATWXVzdOO2176721767epsmtip1R;
	Tue, 26 Mar 2024 11:35:58 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>,
	<peter.griffin@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andre.draszik@linaro.org>,
	<willmcvicker@google.com>, <kernel-team@android.com>
In-Reply-To: <20240326103620.298298-5-tudor.ambarus@linaro.org>
Subject: RE: [PATCH v2 4/4] arm64: dts: exynos: gs101: define all PERIC USI
 nodes
Date: Tue, 26 Mar 2024 17:05:56 +0530
Message-ID: <001a01da7f71$c68073f0$53815bd0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD6o8IeErxKDZrGFPr+Y/HHTXn7CgHEJvlEAe9KlRWy7AASoA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmhq7CZqY0gymT9S22vNrMYrFm7zkm
	i/lHzrFa7NguYtH34iGzxabH11gtLu+aw2Yx4/w+JosNM/6xWLTuPcJu8elWnMWqT/8ZHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfPYvKTe4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4Hjn
	eFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKADlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGa/e/GIqaOeqWP+6j6mB8ThHFyMnh4SA
	icS6C+1sXYxcHEICuxklrh89zALhfGKU+PhmJZTzjVGi+8pxdpiWP93roRJ7GSXm/zzMDOG8
	YJRYuXw7K0gVm4CuxI7FbWCDRQQWMUo8P7uQDSTBLPCUUeLgSwsQm1PAXmLtJ5CFnBzCAsES
	h/tbwGwWAVWJxg/9TCA2r4ClxJ7uR1C2oMTJmU9YIObIS2x/O4cZ4iQFiZ9Pl4EtFhFwkvi3
	/BYjRI24xMujR9hBjpAQOMAh8XsmxHUSAi4Sn5Y0Q/0jLPHq+BYoW0ri87u9QIdyANkeEov+
	SEGEMyTeLl/PCGHbSxy4MocFpIRZQFNi/S59iFV8Er2/nzBBdPJKdLQJQVSrSjS/u8oCYUtL
	TOzuhjrAQ2LTi/msExgVZyF5bBaSx2YheWAWwrIFjCyrGCVTC4pz01OLTQuM81LL4RGenJ+7
	iRGcfrW8dzA+evBB7xAjEwfjIUYJDmYlEd6WLwxpQrwpiZVVqUX58UWlOanFhxhNgaE9kVlK
	NDkfmAHySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgCre745JZ
	embZ4SMzV4lFSJaFNqct/sL4UpjrgMmjNZ5/6qyi4w46S5R9K95spf71xpSrQQY1S+fsCWcs
	S4tZrNcVXX/r3PWNn54tORt9qFZp3/Fcm2laW/7/fvFUZoV0k8xO9l0JgoU1RQIHux5Gim48
	1l2tVGn7olpllo+AysEX4aVbJrCvvfdOoHPpuz2P0qpn/Gnf6sy4sfziykcfzv+9x9syc1PR
	hFjjnwJubAIfO1jOZ8f5yDcyVl27zu+63KfPZvLrs2HMVTmCha/8jTfecxJIsBKqr/TafsSv
	oWj7RJUJqrbq/9Zqlj5cuf2hz62dXBGr/kj4/A6ZfdTxrtzk4g9af6+/N/0a/640S4mlOCPR
	UIu5qDgRAKJsNo5IBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnK7CZqY0g2MruSy2vNrMYrFm7zkm
	i/lHzrFa7NguYtH34iGzxabH11gtLu+aw2Yx4/w+JosNM/6xWLTuPcJu8elWnMWqT/8ZHXg8
	tu3exuqxYFOpx6ZVnWwed67tYfPYvKTe4/MmuQC2KC6blNSczLLUIn27BK6MV29+MRW0c1Ws
	f93H1MB4nKOLkZNDQsBE4k/3epYuRi4OIYHdjBKbvpxhgkhIS1zfOIEdwhaWWPnvOTtE0TNG
	iY1rf4MVsQnoSuxY3MYGYosILGOUmPpZFaSIWeA1o8Sn5Vegxh5mlHi6aB9YB6eAvcTaT4dZ
	QGxhgUCJ/ctamEFsFgFVicYP/WA1vAKWEnu6H0HZghInZz4BqucAmqon0baRESTMLCAvsf3t
	HGaI6xQkfj5dxgpxhJPEv+W3oGrEJV4ePcI+gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPT
	c4sNCwzzUsv1ihNzi0vz0vWS83M3MYJjUEtzB+P2VR/0DjEycTAeYpTgYFYS4W35wpAmxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgUno63Hm4Jvz/5+9
	ceqoxaPOl0L/lpSombz74n75Ynupp421WLnr2Rnvmebu4UyTXDLjsNDiw03/y6L822atbD86
	sWn2ldbAWJ1p2e/Zi09NmmO6Uvmn3PStj2pOTLdt7T24OOnl5dqXQdvz82T6ONUfbtj8ipVR
	PnDTne2Xp63siOE7tC/09QTJW8ItT6SfLmBrnXjgm4XFi6K4LvUgA/UHiyfek1iWeUP2oM3W
	50lKfznK6wWnnLjAa/JbYr3Vk163bRmXuLxYb37Y8WybZpPzu3v71p6/tePY03P31qsHd9Ys
	nuXSMH3lfOE9Cx1ZZY9tjjk58+Ovt0Ghjte2au7ZUqDHlznNycaqXu7ci3AtJiWW4oxEQy3m
	ouJEAEOTuj4wAwAA
X-CMS-MailID: 20240326113600epcas5p273b4e2b62aa732a55bade196b3f45afe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326103634epcas5p2a6a3621a6258aed8e13958339dd6caba
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
	<CGME20240326103634epcas5p2a6a3621a6258aed8e13958339dd6caba@epcas5p2.samsung.com>
	<20240326103620.298298-5-tudor.ambarus@linaro.org>

Hi Tudor,

> -----Original Message-----
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
> Sent: Tuesday, March 26, 2024 4:06 PM
> To: peter.griffin@linaro.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org
> Cc: alim.akhtar@samsung.com; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; andre.draszik@linaro.org;
> willmcvicker@google.com; kernel-team@android.com; Tudor Ambarus
> <tudor.ambarus@linaro.org>
> Subject: [PATCH v2 4/4] arm64: dts: exynos: gs101: define all PERIC USI
nodes
> 
> Universal Serial Interface (USI) supports three types of serial interface
such
> as UART, SPI and I2C. Each protocol works independently.
> USI can be configured to work as one of these protocols. Define all the
USI
> nodes from the PERIC blocks (USI0-14), in all their possible
configurations.
> These blocks have the TX/RX FIFO depth of 64 bytes.
> 
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 769
> +++++++++++++++++++
>  1 file changed, 769 insertions(+)
> 


