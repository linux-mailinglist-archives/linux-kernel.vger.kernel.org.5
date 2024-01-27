Return-Path: <linux-kernel+bounces-41261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EE83EE2E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D81F228A7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B12C6A3;
	Sat, 27 Jan 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Cd65x+KJ"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5929425;
	Sat, 27 Jan 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371462; cv=none; b=ZwLnY7THY1l1GvBWpslECJSvFjlNsoHS9uJvMjb13oIthHy/Ub99oBxsHf9+Bo28aiWuWXH5bULarctY85QX5qKPYNEfV8yTSmc4gsSXPp7d+lyoZKTJSXRNrdOrCVRUMLynK5lSBLPK9EIlUQgBOuvNyeYlVTzrux2Nr/XPcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371462; c=relaxed/simple;
	bh=rThLPG0oKPIY+R5SCgniLS4AOa/AbEm1BbmpT++4eoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2Mpx2pmv7XP/4VQk4ycED3rwx789qyCZyhAdx1gnyB5n26Z88e00N5eoRqr4D4qD22Hq3ixMnZE820Bp+Ke16wRIuJBngn4LozuKsIHzr91O01GjWFN+RyHYAS3e1l+NfQScZfEyymtJSV8Wsal95X8gRpg42hi9XxBVVAa4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Cd65x+KJ; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.80.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 365B4293A94;
	Sat, 27 Jan 2024 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706371452;
	bh=rThLPG0oKPIY+R5SCgniLS4AOa/AbEm1BbmpT++4eoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cd65x+KJigdUgolM9yGgHvd18F5uWnJQkw1b/oQB/HUPhr4Culgab6NpdCTq/nK95
	 86UzlvQBZPQhPyzAmsBMSsV+zCQLMS1pz+TA1cnuk7Ami9p7SmDIG/exn1HIUcP8Dc
	 ov2uVz+GGyq9TQJr0UfJGoM68TqmEQTzNXOrcVxI=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
Date: Sat, 27 Jan 2024 18:03:55 +0200
Message-ID: <20240127160405.19696-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127160405.19696-1-petre.rodan@subdimension.ro>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-peripheral-props.yaml requirement needed by the
spi-max-frequency property.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v1 change the commit message based on Krzysztof's request
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


