Return-Path: <linux-kernel+bounces-78590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19183861589
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0401C23F65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCAA82D77;
	Fri, 23 Feb 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8JqInj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA008289E;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701787; cv=none; b=AkSWTj+KvtUW0xStKq6N4dNs1gBHEoeRu/YgAhUp0tW2ck/RNzmWg3FyEoUgZ/AuNYmywO2sxH1itloyFuH6cyomK6hTDmSac4wjbF4GR/IJKRuIenq7p8bGeEmB8fZcAgKa1bQCfJaMe3Lgm9UsJcucyJQyZ5ELnW0SYxk8QzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701787; c=relaxed/simple;
	bh=PoDeEFZKMM5sUBAoDnRImQrfjwOwvKT2JU4hjPgvF6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXbRhXS2ZyJw7PKmFGTYBpauq4u1ShhDD2NU8yGMkKMZmEJYevHqUBNhPp3ENqkEObfUQNay3cN5BupYDX4wmZ2CddjWdj929EjNwaHvIZ805KUQkZnh3Qv/ygaiz7cl8M570YQGfTYg6NoMDvc+BEfeAc09k1QJe1Ho8AeHOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8JqInj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A66CC43394;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=PoDeEFZKMM5sUBAoDnRImQrfjwOwvKT2JU4hjPgvF6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8JqInj4eWTc/Dq15O3aGReyVmV6LLV31cevUgbT6ufHuz2WGfmFb0RwlpTwLnxeC
	 KMcT7DP4e4qaenE9WqOLZZT34xy7nz0TMi82sbfd7cJciUKOmtFBSODPSgDcYa7ZQj
	 Y63dYc+Z00T3qRVNxbSJdIaybiPwa+7tG6nWpBYLcFP+SzgBLYiQh3V/nwdb47sOuL
	 BGypnfRLmtkH+4uK7864yeo1Bn8XSs+OMJuy4J5zNmxl2aLdpApQYBACsMbHtgi+cr
	 wk51VOMMf1liYZqQZNUIC0sh1q9q57r2y5TUhYubCSkRwYL0/td4orj+YZbc9x4bI6
	 V2I8QFtpmoHqw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOI-000000005FX-435q;
	Fri, 23 Feb 2024 16:23:10 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/12] dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
Date: Fri, 23 Feb 2024 16:21:14 +0100
Message-ID: <20240223152124.20042-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether the 'msi-map-mask' property is needed or not depends on how the
MSI interrupts are mapped and it should therefore not be described as
required.

Note that the current schema fails to detect omissions of the mask
property if the internal MSI controller properties are also present.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5eda4e72f681..b28517047db2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -146,7 +146,6 @@ anyOf:
       - "#interrupt-cells"
   - required:
       - msi-map
-      - msi-map-mask
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
-- 
2.43.0


