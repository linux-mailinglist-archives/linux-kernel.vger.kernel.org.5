Return-Path: <linux-kernel+bounces-84027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547386A18E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A7F1F281C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329821509AB;
	Tue, 27 Feb 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lYcSDEAv"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534914EFDB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068972; cv=none; b=O0B5mGbiMZnx97JQWhpH7lYQk/Or6ogSk9/gHAKgKTu5DGL3nK0BbsyroZGUwZAC1zqpKd5J5qo571Fd8qvMvxnSF7Daod0wJF1VXQd/41ZwLYtWGUDvoz5Lv7uI9kP3K40auY2jsbAh0uJ5BOWnPvfzMbJ7iUzbzDhpK+9kgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068972; c=relaxed/simple;
	bh=eK9yw7rjJCnXz/CRcOc0uADvvqCIKYQRpfuCDUPnZlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxyw42peQelpySeonm2+ywojbDphf6LMdG4YGQmqOC7k2RxNfy5ReveG0H1Q9kM7U2cJ/kf/agTyLtkuN1oLaeQrNMIfx1OSVhv8bFNYKRZmqhX92+PwcePpEyQqyTYaM+AKBZo8DefUiXRYAUP7NpJFC1qUI6cSLn2Zbd0bHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=lYcSDEAv; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D11672C05BB;
	Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709068966;
	bh=LOw+APALrT5aUqA/0fMq33F3F8DtOvqcqkhH81G9wOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYcSDEAviff6X00qS3mF3yGsjFgw2eo+sDdRxFGO79Ddn70FcnWazriYVZJ6l16p3
	 53IPb0v65KS9ObQBR5QhbKKl4wkPRy7cMH/DlFxR39krhG06lxuNKl7FoOXIcz4i2m
	 70wSgJlYIG+D/I9RBmdjdMvn9WLL8wVy16vrN12qEXt5W+EGG7EAc8Vu12Z3OWE9PG
	 7ELjT/Cnm//csJstogNXktFod2rBtpMOu5ddjbiy1tmzzL0IxnvvY/pMbTntEvsMWn
	 UH0APOj8wR+iDzYie4+VeMLi2MkiMClOBjhrSynXWEdrN2D4w/3+SOIg7XDCI0ae83
	 vrXvMybCVSxCQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65de52a60002>; Wed, 28 Feb 2024 10:22:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 66AB013EE85;
	Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 628CE280B00; Wed, 28 Feb 2024 10:22:46 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	ojeda@kernel.org,
	tzimmermann@suse.de,
	javierm@redhat.com,
	robin@protonic.nl,
	lee@kernel.org,
	pavel@ucw.cz
Cc: devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic 7 segment LED
Date: Wed, 28 Feb 2024 10:22:42 +1300
Message-ID: <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65de52a6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gEfo2CItAAAA:8 a=wDxYY4ZP0rUsokw9mtgA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add bindings for a generic 7 segment LED display using GPIOs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Use compatible =3D "generic-gpio-7seg" to keep checkpatch.pl happy

 .../auxdisplay/generic-gpio-7seg.yaml         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic-=
gpio-7seg.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7s=
eg.yaml b/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.=
yaml
new file mode 100644
index 000000000000..46d53ebdf413
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/generic,gpio-7seg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO based LED segment display
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    const: generic-gpio-7seg
+
+  segment-gpios:
+    description:
+      An array of GPIOs one per segment.
+    minItems: 7
+
+required:
+  - segment-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/gpio/gpio.h>
+
+    led-7seg {
+        compatible =3D "generic-gpio-7seg";
+        segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
+                         &gpio 1 GPIO_ACTIVE_LOW
+                         &gpio 2 GPIO_ACTIVE_LOW
+                         &gpio 3 GPIO_ACTIVE_LOW
+                         &gpio 4 GPIO_ACTIVE_LOW
+                         &gpio 5 GPIO_ACTIVE_LOW
+                         &gpio 6 GPIO_ACTIVE_LOW>;
+    };
--=20
2.43.2


