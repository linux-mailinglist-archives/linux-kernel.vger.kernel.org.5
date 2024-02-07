Return-Path: <linux-kernel+bounces-56888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A784D0DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325C1281F65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6185943;
	Wed,  7 Feb 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="nH+j8fhu"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283B7D3E6;
	Wed,  7 Feb 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328960; cv=none; b=GMmzg5f4MDZ8X1eMXiHPTqh0LZd4xZdhBwbMqN8qym0XSocETBEILIG5DrwRhKWmXjXoNNA2UGei92hxjqH43TKLXyQgwn41mK/QrQCnmC2RXC+pYs+RQk7C/5GkXaUy1jIpf8lUEAI7TJWkJffoxu7eH2fYRb3P5gjQvzVQ3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328960; c=relaxed/simple;
	bh=lwoe7HY3Oph3ImZWZIlxENJkS/bc6DUnYsSbIpdD/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyvyS9qBIA3NgQqDl4VmARwiU8+LzPSh6DgLxtWwi9Hh/2bWK8yO43VcSATVEcQoEEvTilaMe18hOaJjWaUrxI/bB3SWdN27FRT0t4i1res378nNu9ZbJ24GBIThnZ1bEBnsZDKIVbv1pJqQHWSVZPGDT7C0ai718b5YJtHa1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=nH+j8fhu; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9E1AD9C48BD;
	Wed,  7 Feb 2024 13:02:33 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id dsiiqCpFK7Tb; Wed,  7 Feb 2024 13:02:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0A5169C48F1;
	Wed,  7 Feb 2024 13:02:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0A5169C48F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707328953; bh=nHQnXDVxcSW7s6S1tBnJ+p00mzPnPdlE/JmMr8nROKA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=nH+j8fhuuJW7+GZqUYncdyIEP2uuGaWZLUsk1mYNkZPGBsYHfCxY3YDXkTuhhhrDv
	 0dfrPNKKNJySt+6xw17RXWSc/OX/wi+Qn0VGDTh3qcn/UPpsNSnzXBCmo/Y20izj4k
	 NXnsHRfUe4y19zVlaGH+B9gBQ/FuTdI6rQzMlzIQ4Q+2QM0P9WmObAacNCzpmnu+r+
	 JwghLqC4MsTq9sEhynuzcZughxbForzaYCuzPNPUacBySRsw3bTHXIMMUcjm6561u+
	 JR9Nov1YKMwo0B6zu8CF8Hevx27KuTm0t3N0LThh3IJAU0F+ftcRma8nLRjeSDrAoU
	 J/ssiE+WCZctw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id r22U_qOEgoEB; Wed,  7 Feb 2024 13:02:32 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D9B809C48BD;
	Wed,  7 Feb 2024 13:02:32 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	kishore Manne <nava.kishore.manne@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/5] dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
Date: Wed,  7 Feb 2024 13:01:27 -0500
Message-ID: <20240207180142.79625-5-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document the SelectMAP interface of Xilinx 7 series FPGA.

Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.y=
aml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
new file mode 100644
index 0000000000000..c54bb2ecc30e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SelectMAP FPGA interface
+
+maintainers:
+  - Charles Perry <charles.perry@savoirfairelinux.com>
+
+description: |
+  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
+  parallel port named the SelectMAP interface in the documentation. Only
+  the x8 mode is supported where data is loaded at one byte per rising e=
dge of
+  the clock, with the MSB of each byte presented to the D0 pin.
+
+  Datasheets:
+    https://www.xilinx.com/support/documentation/user_guides/ug470_7Seri=
es_Config.pdf
+
+allOf:
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,fpga-xc7s-selectmap
+      - xlnx,fpga-xc7a-selectmap
+      - xlnx,fpga-xc7k-selectmap
+      - xlnx,fpga-xc7v-selectmap
+
+  reg:
+    description:
+      At least 1 byte of memory mapped IO
+    maxItems: 1
+
+  prog-gpios:
+    description:
+      config pin (referred to as PROGRAM_B in the manual)
+    maxItems: 1
+
+  done-gpios:
+    description:
+      config status pin (referred to as DONE in the manual)
+    maxItems: 1
+
+  init-gpios:
+    description:
+      initialization status and configuration error pin
+      (referred to as INIT_B in the manual)
+    maxItems: 1
+
+  csi-gpios:
+    description:
+      chip select pin (referred to as CSI_B in the manual)
+      Optional gpio for if the bus controller does not provide a chip se=
lect.
+    maxItems: 1
+
+  rdwr-gpios:
+    description:
+      read/write select pin (referred to as RDWR_B in the manual)
+      Optional gpio for if the bus controller does not provide this pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - prog-gpios
+  - done-gpios
+  - init-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    fpga-mgr@8000000 {
+      compatible =3D "xlnx,fpga-selectmap";
+      reg =3D <0x8000000 0x4>;
+      prog-gpios =3D <&gpio5 5 GPIO_ACTIVE_LOW>;
+      init-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
+      done-gpios =3D <&gpio2 30 GPIO_ACTIVE_HIGH>;
+      csi-gpios =3D <&gpio3 19 GPIO_ACTIVE_LOW>;
+      rdwr-gpios =3D <&gpio3 10 GPIO_ACTIVE_LOW>;
+    };
+...
--=20
2.43.0


