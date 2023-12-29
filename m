Return-Path: <linux-kernel+bounces-13208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FE820127
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE251F235D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE112E43;
	Fri, 29 Dec 2023 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="xs/aaxtT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE712E46;
	Fri, 29 Dec 2023 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from newone.congress.ccc.de (unknown [151.217.64.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id BEE601630CF;
	Fri, 29 Dec 2023 20:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1703877043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q0JdO7g/7YiJgRmDEIU1W+ag1x30v1qSlkuc7yHM1QY=;
	b=xs/aaxtTA1BdwJ9DgsJ4JxoQGwVX3OJYMgjVE9CaomvVGN4/OZEiQ9y6WNoSghib28eyFJ
	1ZVgqXpxdrkv1pm9eeaROCvM9tHxCpHZbL18XUZOainHloZ4qwP9BJRK2GeMp3/+xsxTF4
	ySEfKdJfzQriecRbbCOJOZ9LL/yQb88=
From: David Heidelberg <david@ixit.cz>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: opp: switch inner and outer min/maxItems rules for opp-hz
Date: Fri, 29 Dec 2023 20:10:29 +0100
Message-ID: <20231229191038.247258-1-david@ixit.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes issue as:
```
arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
```

Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index e2f8f7af3cf4..86d3aa0eb435 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -55,10 +55,9 @@ patternProperties:
           to relate the values to their clocks or the order in which the clocks
           need to be configured and that is left for the implementation
           specific binding.
-        minItems: 1
-        maxItems: 32
         items:
-          maxItems: 1
+          minItems: 1
+          maxItems: 32
 
       opp-microvolt:
         description: |
-- 
2.43.0


