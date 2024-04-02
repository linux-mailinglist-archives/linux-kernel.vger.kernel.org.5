Return-Path: <linux-kernel+bounces-127490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36C894C6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47D9B2347E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32839AC3;
	Tue,  2 Apr 2024 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i6CP8+jV"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265CE59177;
	Tue,  2 Apr 2024 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041958; cv=none; b=LdN4wOcW9YkAeBhuW27r2bRItuYq4p2sc4l5cC9zxBK9E7KXgmcFRUHtAHSu6cMOukFUHWbO00L0JFDQKjcOnRm8u9z9BBp+kLY4VMYLSMZ7jmpfdkHipBRknQ6ssPk8hZG+63yfXr7d86VYc9q0fR3wro1aP/o9XI5GetVTfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041958; c=relaxed/simple;
	bh=YgIbRUy6+1L5DOGVht8whZV1f4NbwbHZHWVmd2UytFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZQZWge31Ibz0HgkA1E44DTcsix1N7AI00ndcZSkh3z5p1J7UjOXyOl9e+HpxKOpzJKGjEYN4OFIHKusOEaHeiUkynmeZcNi/GayKYkMSaEOPaa+5lOc0/xbTxihEFH4XWR1QCylyXWYjW+va2oHssXoN2voIQ0CMRIAHipVI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i6CP8+jV; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id EADE9FF809;
	Tue,  2 Apr 2024 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hUXRPUn9Ew3xx8mNXSwygNKoR19Gfh8s6NOLyAtqSQ=;
	b=i6CP8+jVSldQ/HJGgUsQdDB4c3KK4OwrJlMLeSshrbCKBa+aV1SQ9ewq1GXO0GxOXbGWXg
	sMPMwvYVigLnAZNXrldko5xJzftmVB1uf7K3OLAIKQt+5IL1ufw+HhjPF7KkNb/ZAKDzxr
	Q3H5eshHRygaEpu1WkXSwKE3wKs93A3P9up6eJm/fsUI7BKE6BrgUfs+xvnP0sUtT5BYOK
	Fb0oncJe+BWsKWv70FbBIAeRtSpRS25w/uSDfD8bSpJXOs+2tIFC1KvFswXvpxZkE3SYcL
	rc8fYgqPQsTfTyiJsACP0Zs6XxC34G4rjRpG1CXISj9WA+Hl4DSDUaNLgzs/yQ==
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
Subject: [PATCH v2 12/13] ASoC: dt-bindings: davinci-mcbsp: Add the 'ti,T1-framing-{rx/tx}' flags
Date: Tue,  2 Apr 2024 09:12:12 +0200
Message-ID: <20240402071213.11671-13-bastien.curutchet@bootlin.com>
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

McBSP's data delay can be configured from 0 to 2 bit clock periods. 0 is
used for DSP_B format, 1 for DSP_A format. A data delay of 2 bit clock
periods can be used to interface to 'T1 framing' devices where data
stream is preceded by a 'framing bit'. This 2 bit clock data delay is
not described in the bindings.

Add two flags 'ti,T1-framing-[rx/tx]' to enable a data delay of 2
bit clock periods in reception or transmission.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 .../devicetree/bindings/sound/davinci-mcbsp.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
index 0c2b1936c6a1..4fa677023827 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
@@ -67,6 +67,20 @@ properties:
   "#sound-dai-cells":
     const: 0
 
+  ti,T1-framing-tx:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If the property is present, tx data delay is set to 2 bit clock periods.
+      McBSP will insert a blank period (high-impedance period) before the first
+      data bit. This can be used to interface to T1-framing devices.
+
+  ti,T1-framing-rx:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If the property is present, rx data delay is set to 2 bit clock periods.
+      McBSP will discard the bit preceding the data stream (called framing bit).
+      This can be used to interface to T1-framing devices.
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.44.0


