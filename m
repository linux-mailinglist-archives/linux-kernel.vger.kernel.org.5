Return-Path: <linux-kernel+bounces-60650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB685080D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA041F229EC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363046421;
	Sun, 11 Feb 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="eoDPkcoI"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489544C73;
	Sun, 11 Feb 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638219; cv=none; b=FkWyYzkaTPfCjRJVOEoDlmKfOwewW+2op3TP9FJ3hW0jON4S9LUjgDMopYbwyGHmTdzuug0dBGtpZtHWzaXkXfcYO0MXe0LuvjOHnxsL98/xU6n4xdoyMuGRrxLh1h4NaO0ScvVCdNjPmom6ZD6nQL+oeiPZ383Qwq+rxWmi5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638219; c=relaxed/simple;
	bh=ssqUa2WO6ImmQTiORIBKgCT7bL6cC03SOZkFNoSNvTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igYeTOs+4+QMtuEOuxRd1YfVzlTIA005MwXaBEcq/tH967CnfKnk1BJV89IS2EoYWjQxfRsfRRs5ne/ymQ6GPBieMLdGPvp5/KdKogLfNJArCSTa5STPsmIjh+BQh0ss4j+nuVarcB6l0XO4+xl/tdGrbyQj/0dIYAk4wjRZP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=eoDPkcoI; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id B107A331877;
	Sun, 11 Feb 2024 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638209;
	bh=ssqUa2WO6ImmQTiORIBKgCT7bL6cC03SOZkFNoSNvTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoDPkcoIXPKp0jXFgIOfJzEI94mmPOsrG4vRtVN22gQRIAFewhHGcyaxOLYgIqpz8
	 BRZW4nUZvCzXqZvk1rqRU1jkd1md6+QmkwQy7t6/cspQ+fIRyksOaqNnqTwaky1ETU
	 MuCK5VNd86D2Fo7axyLQcfCoWxuJqKW/REG8oawY=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
Date: Sun, 11 Feb 2024 09:56:32 +0200
Message-ID: <20240211075645.28777-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211075645.28777-1-petre.rodan@subdimension.ro>
References: <20240211075645.28777-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-peripheral-props.yaml requirement needed by the
spi-max-frequency property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 change the commit message based on Krzysztof's request
v2 -> v3 no changes
 .../devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
index 65a24ed67b3c..89977b9f01cf 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -99,6 +99,9 @@ required:
   - honeywell,transfer-function
   - honeywell,pressure-triplet
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
 additionalProperties: false
 
 dependentSchemas:
-- 
2.43.0


