Return-Path: <linux-kernel+bounces-60892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45AD850AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D6E1F22840
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF905D495;
	Sun, 11 Feb 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0aMipmi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AD45F484;
	Sun, 11 Feb 2024 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673418; cv=none; b=dXeS5u/Lb738PKQRNwWBa3Gdo0+V0ywfLf65XikKWcSFGpvMukgNIaUtJdRnibFLx/d632QKX8Nq9l3z0lcs4RGmAg+ml6C1ssLT7ZrPK+L36JjqqhvYw23xdVsXF7Nb0bMzKxfOyWKhjzZ31NO6Ft7kh7dWmsEk3jh0zKfA/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673418; c=relaxed/simple;
	bh=+y95bK88fWChXwFe8dJiZk61N/FAhsRBrO4KSZJeTWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZxDug7nyiKIvoYUqPROAyd7GVB8LMI76PgAcP9HkLu9nP+IKDt1ZburtclPMtU4ITIMxi8Ht1VLsNjbmg97y+cUQ1kmiV6KpPH7/tnJZvQAKemk09qAigdn4lMLl+oQY05kPmmS+eUXoYXTw96HwnHdX6+bmeVsE9OI8B9DvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0aMipmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDEDC43399;
	Sun, 11 Feb 2024 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673418;
	bh=+y95bK88fWChXwFe8dJiZk61N/FAhsRBrO4KSZJeTWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0aMipmisV6duMkJCRpkqpdiPLxLixTLkM5cdohBgSPZ/vPLi8d6FZf3X6qPvMpAA
	 fouKTUqKFfVdvPxi+r9AIQuHW1o3LgPtJvxK6/fbMqMe4SrEmy+IFrL5mYKSCUvAMs
	 jm9iT2GreDxVejZblrC07OV+QihDMEFH3qz56ukAkFcgCyz29e/yKtVnXlx4nmsMEJ
	 3/uwd5hTaV5JCI/pt92fIzGjJeIv4otRNES5Gevdr5g2lyKfdmn2iHOjZmKpAhIZSw
	 qIwsBzz6I4G7c2uOowuCkhv3fDNYK2nTWVkewZPEhu/GmnAoPfkTj0DJFLFhNNNQF+
	 lQU34WT1KbA+w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: adc: ad7292: Use for_each_available_child_of_node_scoped()
Date: Sun, 11 Feb 2024 17:42:35 +0000
Message-ID: <20240211174237.182947-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211174237.182947-1-jic23@kernel.org>
References: <20240211174237.182947-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoids the need for manual cleanup of_node_put() in early exits from
the loop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7292.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index cccacec5db6d..a9354bd1ce54 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -260,7 +260,6 @@ static int ad7292_probe(struct spi_device *spi)
 {
 	struct ad7292_state *st;
 	struct iio_dev *indio_dev;
-	struct device_node *child;
 	bool diff_channels = false;
 	int ret;
 
@@ -305,12 +304,10 @@ static int ad7292_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7292_info;
 
-	for_each_available_child_of_node(spi->dev.of_node, child) {
+	for_each_available_child_of_node_scoped(spi->dev.of_node, child) {
 		diff_channels = of_property_read_bool(child, "diff-channels");
-		if (diff_channels) {
-			of_node_put(child);
+		if (diff_channels)
 			break;
-		}
 	}
 
 	if (diff_channels) {
-- 
2.43.1


