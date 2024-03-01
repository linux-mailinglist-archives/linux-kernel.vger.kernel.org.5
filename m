Return-Path: <linux-kernel+bounces-88772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DAA86E660
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1840028FBB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B318C05;
	Fri,  1 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="ltqO98cH"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFACEAED;
	Fri,  1 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311667; cv=none; b=saA98Yk7ZpxvEhu/fmgMfOwefws1G5P8TK6WkN4Q0Zfj+8iurFHQxok0/RDPSIP4sOUN9ycK3eKKJXkIomdWHl9L7zI26E9pq/kyVF2y6PqyCNWGWm6gamwMQ5Jd9QNoComV5v+ZKaMtPyUKfl+LprNoGT1oqwgOwcv3SLhyJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311667; c=relaxed/simple;
	bh=ESdxNUTZV8huBaCXfnANhXBOuC/wSr95nB+gwaKgrIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6nQ+dKIeMWPRmzAmJwTB/vtVDl8Pes/VNcRv+pqH59Y7L2nrydtqfhm1ijFEYhTeZhiOAlfc8MYAtU4w9UpU2t9B8U4i6RX22nKf/iEOz4ZaZt6hWRyHVWuINdRTw6gJ9JLaBjl+MegV3ODCAvGSJcNeyg+3pG7QWoX4uZCIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=ltqO98cH; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 35513284255;
	Fri,  1 Mar 2024 17:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709311655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwToY8aGzzgZXoPxLc+siTU0nymhjCfDtUmF5U3SxWA=;
	b=ltqO98cHBqtHCz3GqvW410/jJhgE1CouQVt/I37gGFBdwfPYKRVqcOs9CGrJUxxJ+qbzMK
	YLbvef8mDj412KVYC2m28OtUzQQTf9MAG7pqAvSf9J91777LmTL+uIRtw6WSJ2eJEw1/yP
	QyLC1SMPMpHeK4G94qA9wPMrsP0EQV0=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 116974587C6;
	Fri,  1 Mar 2024 17:47:35 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	karelb@gimli.ms.mff.cuni.cz
Subject: [RESEND PATCH v5 2/5] dt-bindings: input/touchscreen: Add compatible for IST3038B
Date: Fri,  1 Mar 2024 17:41:01 +0100
Message-ID: <20240301164659.13240-3-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC
differing from IST3038C in its register interface. Add the
compatible for it to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
[balejk@matfyz.cz: elaborate chip differences in the commit message]
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v4:
    * Mention how the chip is different in terms of the programming model in
      the commit message.
    * Add Conor's trailer.

 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index 0d6b033fd5fb..b5372c4eae56 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3038b
       - imagis,ist3038c
 
   reg:
-- 
2.44.0


