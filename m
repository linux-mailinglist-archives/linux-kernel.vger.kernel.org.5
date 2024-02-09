Return-Path: <linux-kernel+bounces-59667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7884FA27
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576461F21677
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E0129A85;
	Fri,  9 Feb 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="WXGoVKBr"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312D1292D5;
	Fri,  9 Feb 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497344; cv=none; b=p9MVV6teCZWPjhdx3qSBN1wziZYQensEyVPOJMte1/j7QbT4TINUMVhb3/WnH0LsXx2OeKsESju8Gak+V0hDSQfiE1Dj4KHP/FD+R5a1FhRMAu6qFUgwycqi+ugI8f7muv/9+ZPzPDEbdqWkcTlUKyPDFmHXuZvyyCpnTvciE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497344; c=relaxed/simple;
	bh=HEaAf1XGgy9fl8nIJh5MfpAqgcXCyXG9JZBAOI6E+tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCFhNqkDeB9ZNRmWMT7oWywZ5nuuCR8F0styPLE4+nKQbx3pX996y2I1zjyd1qrGrAjDFLHryUpYssimj0JxYY7FJ6E2QJ6Qe4xFI1dAOX2K4ub9zswXUTsbjMK1DokwYPX4X5xI5hxzJW5tBvkBZcYuRkhylZ0/C9l3FsngY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=WXGoVKBr; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 80920283DEC;
	Fri,  9 Feb 2024 17:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707496962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+X8NQUi2jiCyiGcDvFXoE4L/61FfsMj7jWccnE5jeM=;
	b=WXGoVKBrEbISJonBA15RC99h9Az85ZlwXxxtaMeoqa+PjLqDQ9n71bv1mXfjuOV5FxlMOr
	ocyfbxbVjOuMJuPedkKGNP+IThtxGZ5LaxMJs4E5e9yiGBYV1NHLs0glGICpV38CGOUhU+
	17MFTVi3vZRMqtr6/Ly0S9ng3MOCILI=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 5D5214590CD;
	Fri,  9 Feb 2024 17:42:42 +0100 (CET)
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
	phone-devel@vger.kernel.org
Subject: [PATCH v5 4/5] dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
Date: Fri,  9 Feb 2024 17:34:21 +0100
Message-ID: <20240209164217.9008-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209164217.9008-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240209164217.9008-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

IST3032C is a touchscreen IC which seems mostly compatible with IST3038C
except that it reports a different chip ID value.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v5:
    - Add Rob's trailer.
    v4:
    - Reword commit description to mention how this IC differs from the
      already supported.

 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index b5372c4eae56..2af71cbcc97d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3032c
       - imagis,ist3038b
       - imagis,ist3038c
 
-- 
2.43.0


