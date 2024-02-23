Return-Path: <linux-kernel+bounces-77652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087B860885
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D1D285DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EFBE62;
	Fri, 23 Feb 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="hDfWFMaD"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BAB64C;
	Fri, 23 Feb 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653151; cv=none; b=rcMnpH1EBFkNh21SZYTJ4/VQ3CicHVNorPD1aRLA+KRTPduQOhxUvUeEEvpooCmT6ahOnYMxy7qiVpRCw1VbhYeL2G1oZx4SaHYpRoUhv293xYmQcaIWX8tmELcSa+Qd4crzpGBvLlyXGYfZmQhVHHIYXIQ0/EcOGCFWseYqQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653151; c=relaxed/simple;
	bh=6sk56gVI0A8n0qFpYuh7aNKcgFgXVN6+8f765I+Eq54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9L1K/0MqyOgndb4vlO0w3FZLpoardoZvJJowbc4bbhMtrXSpXlAlKNdhi42AQRo4Cnh5cMy8HclIHO83UMMkXLGTZOA/UoQ/ZRfBA6KlCv4j3a2+Cz544PfobrGvd7evOmQ04PeyOn9rSrgYHOb+wiiLF8V9Qb6hRBu8dvAifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=hDfWFMaD; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708653141; bh=6sk56gVI0A8n0qFpYuh7aNKcgFgXVN6+8f765I+Eq54=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hDfWFMaDLa++M0quMYHdkRxCRJlCxKh5BaSwKUm23H97hHGG/ReKWrWqL5Hu/5pGI
	 ACb4sJ8tnsO6c67fGmF9CmfIFWF4Xzry6EwwV49c1ZMDa4SyN+lXRBsaAwhY4/ToIi
	 Kw8TMVIJMRibVj7kE+P6l18pRTbNfGp7BHFAVc1k=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/5] dt-bindings: sound: Add jack-type property to sun8i-a33-codec
Date: Fri, 23 Feb 2024 02:52:11 +0100
Message-ID: <20240223015219.3618111-2-megi@xff.cz>
In-Reply-To: <20240223015219.3618111-1-megi@xff.cz>
References: <20240223015219.3618111-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

The codec driver needs to know what jack connector is connected to
on the board. Add proprty to describe the type of connector.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 .../bindings/sound/allwinner,sun8i-a33-codec.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 63eadc4200ac..399fc00ad3f4 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -44,6 +44,15 @@ properties:
       - const: bus
       - const: mod
 
+  jack-type:
+    enum:
+      - headset
+      - headphone
+    description:
+      Type of jack connector connected to the codec. This can be either
+      a 3-pin headphone connector or 4-pin headset connector. If not
+      specified, jack detection is disabled.
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.43.0


