Return-Path: <linux-kernel+bounces-104344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4F87CC5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097CC1C22413
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563813A1B4;
	Fri, 15 Mar 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zqxffvng"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F173717C;
	Fri, 15 Mar 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502094; cv=none; b=RtNdWpoD78yoPrslbH0Buj5tnTAQgae/iUfFVFWngv+xkP+W6FauulncOUYxHURT/+xntBfn2nksfprTuCy2rB7nbHQ0GMKIQbYtMGT9MByrbSvA549TIB1J9yrea+VUvB0sSTwrzqOwMaKVdS6q0TKcncuuMrW1gSFBWP/BC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502094; c=relaxed/simple;
	bh=GJ6RQynym7IzkN8dzvjBnAbZl2m4Fk+buwOjBvEbpkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ6vHBV1UXc+j0FoD04Nn0Ema92X+oCcCeEHmqQs6/IAZpibObBYL3E9QQ/HjXtfu/Tv1gZsNi6jfnfoHOibZUxcXKsHfknFZU8RnVtVAkzcVyEvhZQk0ZWXytUfJU8vKxYiqmEEszCvx44bV0DEZqzk/dMsX+Q4ESJ8urOuGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zqxffvng; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 33F01E0004;
	Fri, 15 Mar 2024 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhTP6U7YQJjOZYBiRpOBKkfxCerw/wQuu637FFjp5+0=;
	b=ZqxffvngtPIBKD+Q365GPXDXcCEySntYVgEaGJfhHtFvP/SdOYvT1OBsnbdFulFs0LIlmM
	ZaSjafSuv2ZYiSsK+uGZU7yzeKef6E+XLkywp5FfEKjKm2LAA3qz/Q8tlzhCWKXeGJarOu
	V8VjZBEP0ELy8lGq/xq4rwpvfoXYeqvrq4HNTFahENT0S8B2HReBiu3AXl5/dbZdsyaRSL
	ylXW0eFB5VCaqAFREh/iCYyfrl2V+SNAH3mZH+QqAmiBPYBAU0NZJ6vuj3XA/GCNhn1n6A
	hUEdaqstr3TuIu1ayKQRJb/KrImGpzxZs1QDtoXJ4Xx+MAyt5j2bnwq1uSlmTw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 12/13] ASoC: dt-bindings: davinic-mcbsp: Add the 'ti,drive-dx' property
Date: Fri, 15 Mar 2024 12:27:44 +0100
Message-ID: <20240315112745.63230-13-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

McBSP is able to handle capture and playback stream.
The McBSP's DX pins that outputs serial data during playback streams can
be used to output a chosen pattern during capture streams. For instance,
this can be useful to drive an active-low signal during capture streams
(by choosing <0> as pattern)

Add a 'ti,drive-dx' property that can be used to repeatedly output a
chosen pattern on DX pin while capture stream is ON.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
index d8d4e7ea6e02..f4d1fc6bcd61 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
@@ -80,6 +80,13 @@ properties:
       Enable synchronisation error detections when an unexpected frame pulse is
       received. If not present, unexpected frame pulses are ignored.
 
+  ti,drive-dx:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      If the property is present, McBSP will repeatedly output the selected
+      value on DX pin during capture streams. For instance, if set to 0, this
+      can be used to drive an active-low signal.
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.43.2


