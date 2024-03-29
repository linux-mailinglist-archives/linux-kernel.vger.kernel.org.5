Return-Path: <linux-kernel+bounces-124304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07717891557
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B29A1C215B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBCE3BBE4;
	Fri, 29 Mar 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SrVxiFGa"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA139FD3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703005; cv=none; b=s1BytJYd26ywTaagtrw15Y3Rs/RaJvp1CcoGxg7KwsgYkgmiU4LqkNVy6eKNvFwovo8DpjFG2JM9yRq/rgZJURarigk0dOGi/m2s6jtcscbFbWOOZZeb43T5EpFzMbcBQkr6spCqLOpEB9FhLrWbOdj7zWpkQct18mYJ2VR///8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703005; c=relaxed/simple;
	bh=AQuJ033viRpyXGzTdTzEU/QH6Pra8YYbR6Z3AwJAiig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=uJGaRrIJgoH250Qe+lg/5XpWcLX7WuS/6fhYKbEILeXcjMfJDShya6dI8Ao5lmICCGQepYsKFJQp+EMZkoa54u4L7unQPP8h58Ig1kXdyNmgRVkpvKdPzQ1gx4mTfgpyPlR6+UrpIYUUc92ZzdgSr1+9f7giXT4m/ZrDm04bGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SrVxiFGa; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240329090315epoutp014bcbe2c3c875bbd1e9dbcef5c5e02a34~BMM4kgpJZ0787807878epoutp01J
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:03:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240329090315epoutp014bcbe2c3c875bbd1e9dbcef5c5e02a34~BMM4kgpJZ0787807878epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711702995;
	bh=vX1ZmIy4KsaTHCPGAztg5Vs9WgV9OgxLWHoj1r1oYXE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SrVxiFGa8akfytfIz1yX+Vho8vmNwqB50uFqAvfjKvw4ayqzZ9e8uxCca1NahfFz2
	 nPwseYyuXsx413l4nf0iJWvSm/0Vk9br4ofRpT35RaaYeZfQ9PZutPQ97Gw2AaPEZQ
	 Sq/LLbnXiQivn83o04dFgnAXpfITAB3bgbYRDuxI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240329090314epcas2p1f06d978f384f00afcbfe9ddb00f5cc31~BMM4QeIJb1882218822epcas2p11;
	Fri, 29 Mar 2024 09:03:14 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V5ZFG25fhz4x9Q7; Fri, 29 Mar
	2024 09:03:14 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.60.08666.1D386066; Fri, 29 Mar 2024 18:03:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8~BMM2hPQd40316503165epcas2p2i;
	Fri, 29 Mar 2024 09:03:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240329090313epsmtrp15c7e69f53459f0207025c0c8d795eab3~BMM2gPMyD3021330213epsmtrp1W;
	Fri, 29 Mar 2024 09:03:13 +0000 (GMT)
X-AuditID: b6c32a43-84dff700000021da-c7-660683d14aee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.C2.19234.0D386066; Fri, 29 Mar 2024 18:03:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240329090312epsmtip1629a5d6fd45db15e32ae9f22f7fede5d~BMM2SSe5u0799507995epsmtip1Z;
	Fri, 29 Mar 2024 09:03:12 +0000 (GMT)
From: Jaewon Kim <jaewon02.kim@samsung.com>
To: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jaewon
	Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] spi: s3c64xx: Use DMA mode from fifo size
Date: Fri, 29 Mar 2024 17:58:40 +0900
Message-ID: <20240329085840.65856-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTTPdiM1uawdtj4hYP5m1js7j/tYPR
	YurDJ2wWOxqOsFrsfb2V3WLT42usFpd3zWGzmHF+H5NF48eb7BbP+/YxOXB5bFrVyeZx59oe
	No/NS+o9+rasYvT4vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
	MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5x
	aV66Xl5qiZWhgYGRKVBhQnbGmZbl7AXXuSv2nF/C1sC4n7OLkZNDQsBEYv6Ju8xdjFwcQgI7
	GCWe/nzOBOF8YpRoezCdGc55MH0NE0zL1PubWCESOxklVsxfxgjhfGSU2NTSyAhSxSagLfF9
	/WKwKhGBK0BV31aDzWIWWM8ose7CF7BZwgJWEt8WL2AFsVkEVCU23/kOFucVsJU4sL6PDWKf
	vMTdM7OYIeKCEidnPmEBsZmB4s1bZ4MNlRC4xS4xd9l1qANdJJ5Of8EKYQtLvDq+hR3ClpJ4
	2d8GZedLtF05A2XXSGxccIkRwraXWHTmJ1CcA2iBpsT6XfogpoSAssSRW1Br+SQ6Dv9lhwjz
	SnS0CUE0qkncn3oO6mIZiUlHVjJBlHhIvF4dBhIWEoiV+P9mAvMERvlZSH6ZheSXWQhrFzAy
	r2IUSy0ozk1PTTYqMITHanJ+7iZGcMLUct7BeGX+P71DjEwcjIcYJTiYlUR4dx5lSRPiTUms
	rEotyo8vKs1JLT7EaAoM3YnMUqLJ+cCUnVcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6Yklq
	dmpqQWoRTB8TB6dUA5Pu3PWTRb72zncolf/b4Hj9bdqm1htdNo7ijxMdajXXsWc99pDUC1J9
	eFBdps9nyZq/VvL7X5qn1xv/nlbyJtG1YeH8xg9sqUoT5d9XnIrcLL1n5WZGt9Bw7yt5Cpbr
	dJxEsvoKOBmvn12TuKhri0XM/0qTSUtCL7byKglPDn2zLd39yLk9fhdNg1M8v7tKrndw+52l
	2svzo6R8Q9DigtXrXPK2sLWt493cmLm29MJingcLdYpMNN+K1USLhRkLt9/+413m/MMrcp38
	bImNn3e8Fw4/6ZLTWLtoa77u4nONEwxme39U7o5UZmN3MzH+WsT2u2StxhK7sJk/bsy3qzNf
	bvGIjWfi4lSRNbOOKLEUZyQaajEXFScCALUXSdEhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnO6FZrY0g51zrS0ezNvGZnH/awej
	xdSHT9gsdjQcYbXY+3oru8Wmx9dYLS7vmsNmMeP8PiaLxo832S2e9+1jcuDy2LSqk83jzrU9
	bB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8aZluXsBde5K/acX8LWwLifs4uRk0NC
	wERi6v1NrCC2kMB2RoknXxMg4jISy5/1sUHYwhL3W44A1XAB1bxnlHj3fi4jSIJNQFvi+/rF
	YAkRgRuMEquXP2IBcZgFNjNKtJ8/BzZWWMBK4tviBWA2i4CqxOY735lAbF4BW4kD62FWyEvc
	PTOLGSIuKHFy5hMWEJsZKN68dTbzBEa+WUhSs5CkFjAyrWIUTS0ozk3PTS4w1CtOzC0uzUvX
	S87P3cQIDl6toB2My9b/1TvEyMTBeIhRgoNZSYR351GWNCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQamvRGZl30bTj//qXKGRdXPsJPvhquSbT1bo4iO
	6+vP1U92X74u4FfY/IxBOD1M6YZm2bqHc4rYlfYf/f/z07ElVvbnfnZaSBoGKR3zu5U6gWGJ
	r2+ZmsihV8fVpmzKP+uw9O3vomlN235Kujd6msb1Bf5XSJxf+vZ+dlT4nmt13LnO+2JKz70R
	3v9o6TbWtco5yQrxvN3x36s3/N292GTajNeHv1xdXML7ZzP3oj8XD9ZtrmtaaBD+X5j5Yr26
	5PM/z56sKtKTvXJeOKfewM5C0FzkbY2vamxvgLnydY87kc832W4zeROtbl56+fyvfSo9rzL6
	NhvwXfkz4etV9cuJAlnnX6gvWPFbbpXp+g2nlViKMxINtZiLihMBwF8Dms0CAAA=
X-CMS-MailID: 20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8
References: <CGME20240329090313epcas2p2cf95d22e44b6b1c120021622da68aeb8@epcas2p2.samsung.com>

If the SPI data size is smaller than FIFO, it operates in PIO mode,
and if it is larger than FIFO size, it oerates in DMA mode.

If the SPI data size is equal to fifo, it operates in PIO mode and it is
separated to 2 transfers. To prevent it, it must operate in DMA mode
from the case where the data size and the fifo size are the same.

Fixes: 1ee806718d5e ("spi: s3c64xx: support interrupt based pio mode")
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9fcbe040cb2f..f726d8670428 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -430,7 +430,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
-		return xfer->len > sdd->fifo_depth;
+		return xfer->len >= sdd->fifo_depth;
 
 	return false;
 }
@@ -826,10 +826,9 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 			return status;
 	}
 
-	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
+	if (!is_polling(sdd) && xfer->len >= fifo_len &&
 	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		use_dma = 1;
-
 	} else if (xfer->len >= fifo_len) {
 		tx_buf = xfer->tx_buf;
 		rx_buf = xfer->rx_buf;
-- 
2.43.2


