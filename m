Return-Path: <linux-kernel+bounces-127480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAA894C50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E00F2842E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889133D0CD;
	Tue,  2 Apr 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f3bX7Jpc"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE4374F6;
	Tue,  2 Apr 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041944; cv=none; b=UYpuCdZTJ4S6NcHGCeQ5zZp2IWId63JSBvG9F6PrvqVXxHxqJcXBT2PPRidNzvnfZDoCuojcOGTBqfw4Ce0dg/EAwWYD7vPTKcN9lDeQAU1QHf9Tjmd4xf34TI7L3k9x9gY1/7QECo13iqPsUDSP0P2Tl9PCEI1q917+MQekSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041944; c=relaxed/simple;
	bh=MDsLsFHtLslxvPtCs/nUPioPhXfjVy6AZnDa713pFfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/TKW9dhEa1SlamslkKEn2zmrHy2ejNtN8++67IUCsxH2wfz/fXsxfsPDsFZwfGMPFvgOFIyJHzkqxFGF/AFC6ynM5l0S+Y3qmayfJhOvvYn8DrDFSErGZx5XCGB5akIdtmC4stl5XtjfcdsRlW71MlqJ/Lhn1ruaTZp4KYeQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f3bX7Jpc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 10E9BFF80A;
	Tue,  2 Apr 2024 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjMah6RzWU9Pw9jrFvPJ1cd8OwCxOXg5IsWRlfB0YHk=;
	b=f3bX7Jpc6sXcyKJnYTY182aCDhlFJ78Bq9bDoCqL3Q4wpQw6nArUE4pWQr6S5iLlThLMtC
	40CGAijuVr7Dsjcfisy4N4kQFIvibJXT041zmdssqolQ0p06rxlHB6NRjnX0UvOY5B2SNf
	33D+47Val3gVaOcSmDuXBQ6tneJrOqRJyyIZT5tNeTbFL6EmiFfpJpB7IPvvWfMqz4P6Fl
	fan3UFGtnsh5CbWHpJWdfjz/Jc7njZoqV7Uy6IlY8bbfeML2r1eH3csi227NZqC5QXTYLp
	X9JT26fUsKT75D2Y7TT9D/82uqY4tAXwW5gbbufgxbxZjC7GuhN8m3fG323JdA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 02/13] ASoC: dt-bindings: davinci-mcbsp: Add optional clock
Date: Tue,  2 Apr 2024 09:12:02 +0200
Message-ID: <20240402071213.11671-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The McBSP uses an internal sample rate generator to provide bit clock
or frame clock. This sample rate generator can be programmed to be
driven by McBSP's internal clock source or by an external clock source
(located on CLKS pin). The external clock source is not described in
the bindings.

Add an optional clock item that allows to select an external clock as
sample rate generator's input.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
index 139b594dd192..0c2b1936c6a1 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
@@ -50,12 +50,16 @@ properties:
       - const: tx
 
   clocks:
+    minItems: 1
     items:
       - description: functional clock
+      - description: external input clock for sample rate generator.
 
   clock-names:
+    minItems: 1
     items:
       - const: fck
+      - const: clks
 
   power-domains:
     maxItems: 1
-- 
2.44.0


