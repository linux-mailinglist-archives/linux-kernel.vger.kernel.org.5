Return-Path: <linux-kernel+bounces-53039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8E849FCC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C9CB216F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3940BF2;
	Mon,  5 Feb 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+a9wNmJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5993D3FE46;
	Mon,  5 Feb 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151748; cv=none; b=C6emLdxVhwfg+2CEMIFS4p5ArSZfuPJuDXv6w0fFEB82AARS7/+ZkUSYILQH0yGoINQ3ztj5LHQyrofIBaiOsWfRfNCC1SOxEQXx2GlScw0m2xSYpP0Jp0LHH+M6NnqFQRovNSK5kpFBV5wJ1qRHFR33VuSYmFkpGrMVJWstX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151748; c=relaxed/simple;
	bh=ilTj5VWnzbXDnAmzljy5yyfGbnvyZnNPzs2eb6s2nj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWmHF3QqTdmg7qpFLB4TRfzi/tMOchqtxsIBb2N3NVg6Usdvr9A6lZ3VGdlGV1HMPEck0ffCVFzlL4fJR3yVIMj0QYVtqEygnTO4mJle8cHorca/rzf1LsRcIbSyfKY4IJ9dlk7/sYEmdso+RL+b4G1JYC9/D/2ggaB37EPOA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+a9wNmJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51025cafb51so6954032e87.2;
        Mon, 05 Feb 2024 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151744; x=1707756544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hloNsWsZXa6Vf2TLiftzXJ4XARi6FJ1Kn6mZNuM3PA=;
        b=K+a9wNmJDEBDKvFcLkgsGKk94M39xZJKRmwSqplO9LoAyRDqF6tEUXDyiMeN82z4JG
         FuI6Ed0SsJuCBd9N73s3gu69NARRH0wqs7HjwrnWktpoJeqLp4XoKD7GkAeoKk5YMhXu
         8SL4aGqz35mCxhbb9z7X8aTx28TRSaC7ba+cbefigrJ6/O0EmsNglGmZ6G5nr9wrkfht
         +hqp1pS9o1B7Qfp1dhpDHaKYOhfjPM0oatC18WOOc1AZI9hd9iW+rVErbbH6GxDeQHVT
         Pk5qEGeJosI0ghmLL96BQ91pRuo3OPjQ+4oiiJzUe0DT6U1xQ9hoevhk53JuZnMOXwnh
         lmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151744; x=1707756544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hloNsWsZXa6Vf2TLiftzXJ4XARi6FJ1Kn6mZNuM3PA=;
        b=A9yMpKUrqjslZN/xxm4HEcd6ccQ7QhKnNt6GYZKe7MeYRXlb+H1dSDv3j2JAO3Wme3
         F3aQeag5tPPcYpMa3aM35/vkIsgfd1pzL+lrn7kCxpGIyhKsWtrk90eQzZNpEa9dukrL
         vsXLD65s38FiVYpAvQuYc1yOspgor5W/t4p3EHOlK9JGeC1IJ3aEzPeN9lAjSSTx0y3W
         rpZatpZRcWh6xmXhtqEfv1TYiKUbVSc56sTH9e9MnsfF+c3zAE6413xWf0r1SeWMboUO
         v50sfx215/1FkYj7gVltbBEWwKdXVyAfkZsrVkhlcjXkRAjhXq5Tsi/kiCRx07b2gktj
         RMIw==
X-Gm-Message-State: AOJu0Yyva1qcCENb9IXRd1nqfs/wRhe0DLmfrxsqVrN2JGhbxUCu8l5L
	NxEAiIypT/WqDH1b41XJxA8P2gmgpX8MLft0i4nfJqReycCz+yaY
X-Google-Smtp-Source: AGHT+IGKL4S/NbUdFlbh/K8uszUH1kWAVsBWWqkO40Q/829DjsnfSp4xNi0RfcgWVWVjLwHZQWKglA==
X-Received: by 2002:a19:6717:0:b0:511:475b:7079 with SMTP id b23-20020a196717000000b00511475b7079mr114167lfc.43.1707151743947;
        Mon, 05 Feb 2024 08:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW7fo8RmTk93QVMmXH9b9xNfXo/Y6u0mwzN0bO8Wc+3ASzGhhEg9iWBADgb611Wbtb1fEztVq0HxdJq4wqf6kNWF6NOqEwoq1w/befzV/Z+3M6/smTRqyvkxBKKVD05cMjRW86p0egExti2ehZalMblBRh4FiksZ5KfDC1vqD3dxaOgN7287VcJX18S6GXo6nZNK8Y/U0mHqqYl2HrlYjj4/cTWu2D23kfuBQ8fUAEBPJcWiKt9EgDLgsHDZCNx1wvFKPtesPP9P7IV7L9f1hgFiqdppvKfNOW87wfoLGB8twsQlPMYc/RvXowtDRVgwbVmAORMVkaWczHDpDB3Qn1qreZfYXwryZ+A/i1tDV2AWeeM5H6ac5EklYDNgSAGiwHo+qTKxVRpHzU3EDofw4oL9W3dhbKrUsq524mept9tefMddLCsf9fRa58dg3u6F+YylhlUaCHmDjgB33yPKDM/gXIs9+crIxVlqa4WjfKhQcghAo6Torpu7xpPTgDSkWq3eHTsIWKCYXEvXr7SQ5lojYWtXn0L5lTT5H2XmLaGVxiImVDQBE75laMPA7ardePe8UP5ELRMiaOD7zRUe+/3yDi9hDhz6c2zsM9fDQOoUdYlRlHsCkYCOf9wyDFn3gDi65Ccrh0QJCIoQN4YpavZ+enBd6uuIOkLBPghBGww8AUcointXA==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:03 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 01/10] dt-bindings: net: document ethernet PHY package nodes
Date: Mon,  5 Feb 2024 17:48:33 +0100
Message-ID: <20240205164851.1351-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document ethernet PHY package nodes used to describe PHY shipped in
bundle of 2-5 PHY. The special node describe a container of PHY that
share common properties. This is a generic schema and PHY package
should create specialized version with the required additional shared
properties.

Example are PHY packages that have some regs only in one PHY of the
package and will affect every other PHY in the package, for example
related to PHY interface mode calibration or global PHY mode selection.

The PHY package node MUST declare the base address used by the PHY driver
for global configuration by calculating the offsets of the global PHY
based on the base address of the PHY package.

Each reg of the PHYs defined in the PHY package node is absolute and
describe the real address of the Ethernet PHY on the bus.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/ethernet-phy-package.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
new file mode 100644
index 000000000000..e567101e6f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ethernet PHY Package Common Properties
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  PHY packages are multi-port Ethernet PHY of the same family
+  and each Ethernet PHY is affected by the global configuration
+  of the PHY package.
+
+  Each reg of the PHYs defined in the PHY package node is
+  absolute and describe the real address of the Ethernet PHY on
+  the MDIO bus.
+
+properties:
+  $nodename:
+    pattern: "^ethernet-phy-package@[a-f0-9]+$"
+
+  reg:
+    minimum: 0
+    maximum: 31
+    description:
+      The base ID number for the PHY package.
+      Commonly the ID of the first PHY in the PHY package.
+
+      Some PHY in the PHY package might be not defined but
+      still occupy ID on the device (just not attached to
+      anything) hence the PHY package reg might correspond
+      to a not attached PHY (offset 0).
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  ^ethernet-phy@[a-f0-9]+$:
+    $ref: ethernet-phy.yaml#
+
+required:
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: true
-- 
2.43.0


