Return-Path: <linux-kernel+bounces-60891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8059850AAA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FEB281A70
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479A5F467;
	Sun, 11 Feb 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej3YfNCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB745D488;
	Sun, 11 Feb 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673414; cv=none; b=SIj5UzeUr7bkHNpmAaDTQGzA+tUdislDUjslGTlUo8y/nrNS40tFFLI7F+oXviWthNLGhpOFY1VlH9wy0af9YiTU5TroNGWv4F/44nyuuz+SUBZh1ynjN3YSIHe1Fb9tWC/bNcZM8y6+1fIKDDcZuFNWm/Af4uwT9wEbQHNOo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673414; c=relaxed/simple;
	bh=7bhniuqSD2L2Qes7Q2zW21qyQGYtas6Yezol52kECBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9VNiNKu6zG+XmalyDu5ryBwx/ex6WzdAeKC9q0U6I/G6h20IiKTF2Z+Vj5NxOueX2RsFG8yImOeUfv6hU3QpWvxNHUDSM5ZviGfw/KIBEgnml2rIM/ueCn7U1srejEtEXk6ROxPgST9lZIrQ8ZXI+EoZQbIZ+RyvkVwBHcJds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej3YfNCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA7FC433C7;
	Sun, 11 Feb 2024 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673414;
	bh=7bhniuqSD2L2Qes7Q2zW21qyQGYtas6Yezol52kECBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ej3YfNCTsrNyhgyrJSjWQfqpVOb/sXA8AliwEeRJTObFTGZIAdWK9nKPRZQmXOJa3
	 DcxZAKQY9ko4IgGCn2UFYDhXFGFvtobi05jy1z6QkrNV9bnQxphA/ZGJIraBQiq2wH
	 1AwHxdFnY21L3kJe2z5KTRf/zRlUfqLt8kdOqV6W5E+WuQCTfmBfxgIJrZ1jKRK63f
	 c+mrIOjOYxrUM54NqkSBgLil+IbqaVKKXlggGGLzYx9UVP8iEW0mfz5euTGRk9Ld/l
	 moxJVf1KPZ2k4GQCsuxgTt56fvfiJahSpwsu3BSvQn+FNMCMLbKGQqi+W0Y4NO+78u
	 Cst08PfMKSOHQ==
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
Subject: [PATCH 6/8] iio: adc: ad7124: Use for_each_available_child_of_node_scoped()
Date: Sun, 11 Feb 2024 17:42:34 +0000
Message-ID: <20240211174237.182947-7-jic23@kernel.org>
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

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b9b206fcd748..67ccdad752c5 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -813,7 +813,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	struct ad7124_state *st = iio_priv(indio_dev);
 	struct ad7124_channel_config *cfg;
 	struct ad7124_channel *channels;
-	struct device_node *child;
 	struct iio_chan_spec *chan;
 	unsigned int ain[2], channel = 0, tmp;
 	int ret;
@@ -838,24 +837,21 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	indio_dev->num_channels = st->num_channels;
 	st->channels = channels;
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		cfg = &st->channels[channel].cfg;
 
 		ret = of_property_read_u32(child, "reg", &channel);
 		if (ret)
-			goto err;
+			return ret;
 
-		if (channel >= indio_dev->num_channels) {
-			dev_err(indio_dev->dev.parent,
-				"Channel index >= number of channels\n");
-			ret = -EINVAL;
-			goto err;
-		}
+		if (channel >= indio_dev->num_channels)
+			return dev_err_probe(indio_dev->dev.parent, -EINVAL,
+					     "Channel index >= number of channels\n");
 
 		ret = of_property_read_u32_array(child, "diff-channels",
 						 ain, 2);
 		if (ret)
-			goto err;
+			return ret;
 
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
@@ -880,10 +876,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	}
 
 	return 0;
-err:
-	of_node_put(child);
-
-	return ret;
 }
 
 static int ad7124_setup(struct ad7124_state *st)
-- 
2.43.1


