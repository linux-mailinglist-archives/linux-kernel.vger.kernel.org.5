Return-Path: <linux-kernel+bounces-126780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B825893CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FAA1C20F57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75721481DB;
	Mon,  1 Apr 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqdzuZ0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896045BF9;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984217; cv=none; b=dPKH/FdqjmVxvHC8QhrrM9pTOetdNnYKO1HtXi1VWWith022VC/4N1rV5HqwiMukGTHR/1s/22cQE3n7kO460WE3dYv6gVGpAJmXUkrWdVOiXSOsZVlk+4H1baDXmLm+5yFqjtOiDY+SGfaZK4tRXIoamz4qcsXQis3qn5XwLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984217; c=relaxed/simple;
	bh=sB4XW2Iy9WrEDv3ZxInXXORojt09vA9WlbAC80dGpys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juYhmVwnaTKYSzHbVlvhDl5nOhge6rCrjTxsTTRAOOq76hOKexfYN5P40pyFhpaaCmCF6lAQ4bK40LugCjzpBmtxTle4qLnUBQDTNs9OyeLVlmwb9DhuWmC8VkNzkeM31s6m6+zTgfJ9e1U6WG767fpXff/PEvqOorBX5GISCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqdzuZ0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFDCC43399;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984217;
	bh=sB4XW2Iy9WrEDv3ZxInXXORojt09vA9WlbAC80dGpys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XqdzuZ0TlU9SV1IQWTipwyCFeQFQXqkWz6PyJIVtrt9+OmKll9rWL1QY8CkKZ3BfH
	 /fOIjjOeszDCLUsXOth8Q6GvcoM2/1Zvm0i/rxTQ46fmCQcgvdPlAYPz1nPtVg8wu2
	 IMHK2V8E4CUc0JkqQkjq+kaSZtpz52S+b62GeG4YXxbJaU4MLfn+lj81TjKWxw65hb
	 m6du6HCFBiFbvE7QZ/66HFm03jp8VMDhcNBxGI9zz6yov+flZolcSbay89eVfvgHQ0
	 I4fhJvFE3vRgek+y5qBYd0eek7dNK6FBgsU9cL/8PUjBfSEr1sYjf3GZpVT2MJqchI
	 4BDSXiMrwkmkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB90CD1292;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 01 Apr 2024 18:32:21 +0300
Subject: [PATCH 3/6] iio: adc: ad7173: refactor channel configuration
 parsing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-ad4111-v1-3-34618a9cc502@analog.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711985550; l=2160;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=LP925hA7l/Zq+jxivGEGAOgI2hBOHLlP0ftz5riKxwA=;
 b=/RbMwmYnyhC5pKQaInX3g8tTV5ka0OyCWhWopLnpDFY3wgL+e2loPLkV1ldaDbSKtknDIKhsB
 /+X38d8OzhKC/vKCrDsGYSh0zjHicqefIm2+JfwdgrZGF5a+ELQ9yVs
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Move configurations regarding number of channels from
*_fw_parse_device_config to *_fw_parse_channel_config.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 8a95b1391826..699bc6970790 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -917,7 +917,23 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[2], chan_index = 0;
-	int ref_sel, ret;
+	int ref_sel, ret, num_channels;
+
+	num_channels = device_get_child_node_count(dev);
+
+	if (st->info->has_temp)
+		num_channels++;
+
+	if (num_channels == 0)
+		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
+
+	if (num_channels > st->info->num_channels)
+		return dev_err_probe(dev, -EINVAL,
+			"Too many channels specified. Maximum is %d, not including temperature channel if supported.\n",
+			st->info->num_channels);
+
+	indio_dev->num_channels = num_channels;
+	st->num_channels = num_channels;
 
 	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
 				st->num_channels, GFP_KERNEL);
@@ -1012,7 +1028,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	unsigned int num_channels;
 	int ret;
 
 	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
@@ -1071,16 +1086,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 
 	ad7173_sigma_delta_info.irq_line = ret;
 
-	num_channels = device_get_child_node_count(dev);
-
-	if (st->info->has_temp)
-		num_channels++;
-
-	if (num_channels == 0)
-		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
-	indio_dev->num_channels = num_channels;
-	st->num_channels = num_channels;
-
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
 

-- 
2.43.0



