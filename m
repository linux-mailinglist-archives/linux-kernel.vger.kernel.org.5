Return-Path: <linux-kernel+bounces-126779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F4893CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F771C20F95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8A482D1;
	Mon,  1 Apr 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBpSmubq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13246436;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984217; cv=none; b=rUBza+gBOgqHO4X3ePjcHZkffSY8tMBQdcVlE9O3mz4w3jlxotVYsKWZN1e5gWI1F+EWfUgHuU6SuDruL1zsOt6RdoCBHKgBJfI3pmv2JjSolImyvEaLS6zJg7nDuxRWBnAINoMdaMtIjRi3PBxm4nQZi0W2X8pCTL+1SofDPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984217; c=relaxed/simple;
	bh=/ob0HLnTQN/zuJtE6XAi67E0eFBxRhaKMzO3UK+Xn68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7B99uwYgIN15bnjFjZxH6GSJSi6j63Dq093P5UkGzKonW+Hz+m4moMIqgKoVxcelTeBu5WGY5x9SeWqvjO94kt+WL2Dx+eAt8jfVCfHj9tZ7xPjh6naed6RxDxhde/98Dr7DnA58/q94p7P/vQOqLEtO+ddvvuC0b5sDHo0YDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBpSmubq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35C67C43330;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984217;
	bh=/ob0HLnTQN/zuJtE6XAi67E0eFBxRhaKMzO3UK+Xn68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GBpSmubqeCt2mIryC7viP2XlJpTmE0EsU6bk/q4u4rc9dNv7t9QjERjeiCVYPhMvZ
	 CYbOMWN8hUsZFtiiSz3cZrlD7pE1JGdxhNh9q+S4Tw+Qpbz3fxlfZCVL8ttKOgZWmI
	 mi4EmiAUfcL8m4P25W8Q1vFjWqsdGTSiAiaEACwpO9UAciA8n1pt5R1EuFFlBBm2me
	 wfw8Jj/z2XqKBqSDWonu+SyPknzhitdrJeUKR9fvD6gqXuRuYBj/cu2Bo/gt3qobAo
	 x/AsrYJJvGVl3ELwVmZipEZvoUBYL818M+7KLEfZhCIUbjYVHTqdFMkUIadtua6Cyy
	 KEplihiqZwqJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C686CD1297;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 01 Apr 2024 18:32:22 +0300
Subject: [PATCH 4/6] iio: adc: ad7173: refactor ain and vref selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-ad4111-v1-4-34618a9cc502@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711985550; l=3122;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=ugvDBN0G/VRH37DYWBENrnCso3rjndLZ6QW6zEbTWUI=;
 b=TaueQ6MIGfSMUSVPoPKL8zso0+kp5S07/EPrJPg2u5mZVRd50ehgCUX28X1NL0isaqG4oYMZr
 7lQoB91EPoKBBAYzUtyB1zqoW6tRzMlv0AwIaVuxj+iJ9PcbLUM0uTu
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Move validation of analog inputs and reference voltage selection to
separate functions.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 59 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 699bc6970790..bf5a5b384fe2 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -910,6 +910,41 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
 					   &st->int_clk_hw);
 }
 
+static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
+					      unsigned int ain[2])
+{
+	struct device *dev = &st->sd.spi->dev;
+
+	if (ain[0] >= st->info->num_inputs ||
+	    ain[1] >= st->info->num_inputs)
+		return dev_err_probe(dev, -EINVAL,
+			"Input pin number out of range for pair (%d %d).\n",
+			ain[0], ain[1]);
+
+	return 0;
+}
+
+static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
+{
+	struct device *dev = &st->sd.spi->dev;
+	int ret;
+
+	if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF && !st->info->has_int_ref)
+		return dev_err_probe(dev, -EINVAL,
+			"Internal reference is not available on current model.\n");
+
+	if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
+		return dev_err_probe(dev, -EINVAL,
+			"External reference 2 is not available on current model.\n");
+
+	ret = ad7173_get_ref_voltage_milli(st, ref_sel);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Cannot use reference %u\n", ref_sel);
+
+	return 0;
+}
+
 static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_channel *chans_st_arr, *chan_st_priv;
@@ -970,11 +1005,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (ret)
 			return ret;
 
-		if (ain[0] >= st->info->num_inputs ||
-		    ain[1] >= st->info->num_inputs)
-			return dev_err_probe(dev, -EINVAL,
-				"Input pin number out of range for pair (%d %d).\n",
-				ain[0], ain[1]);
+		ret = ad7173_validate_voltage_ain_inputs(st, ain);
+		if (ret)
+			return ret;
 
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
@@ -985,19 +1018,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		else
 			ref_sel = ret;
 
-		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
-		    !st->info->has_int_ref)
-			return dev_err_probe(dev, -EINVAL,
-				"Internal reference is not available on current model.\n");
-
-		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
-			return dev_err_probe(dev, -EINVAL,
-				"External reference 2 is not available on current model.\n");
-
-		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Cannot use reference %u\n", ref_sel);
+		ret = ad7173_validate_reference(st, ref_sel);
+		if (ret)
+			return ret;
 
 		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
 			st->adc_mode |= AD7173_ADC_MODE_REF_EN;

-- 
2.43.0



