Return-Path: <linux-kernel+bounces-58023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B484E05E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5783B2554F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7471B35;
	Thu,  8 Feb 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSAE/PTm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422076E2C9;
	Thu,  8 Feb 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393931; cv=none; b=VWl1lt5P0c+UJNZXKiPVVkOJtQf19c1hRMfUb/rU7t3VewHP+o+ywPLr2x3QZM3NzqtW1MCbwYu9GYSKdgSUDbbNCs4zXpqxcF/1aPONXkdt7K5WZZnjJBWO2TOgKID6iUra/c8QsSB95/4mSgwa54OZPBBETB4NS8KvhhpPYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393931; c=relaxed/simple;
	bh=baWoNkCdLWv2mD3EuXld947fsGpLleSuOLYvC6wOyMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XThUlX1ECo9qnsFj+1bu3bHvsntqRtk9ycReGjNf/y97iCw7HEzj+BL/vU2B3fEv1al+Ramxk7W/yqSlAkY5EUvLgBpdyneijwlRl0YIx8VGwpo0j/9XKuYEz9PEQ97Y9JLA2rwfxW+P4xAu7dNYIO3yaa99yCIFVB6HFQtVvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSAE/PTm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337d05b8942so1290007f8f.3;
        Thu, 08 Feb 2024 04:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707393928; x=1707998728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iBviACd6G9SLbDDYc9R0rps72fTMAV79UQpJ8ANwvg=;
        b=dSAE/PTmM51eSQ5jh/UAUc3ANITMtdvEu4oCx/mANru+dJqafMrIb+Qt0WmBsLtcPQ
         fNcigLTmYex8y8xnrVgsPJyqlbj+Unmx8N9xZ093izWKh8R4NHG3upcMzOtrc6oFI1Uy
         hXxgssuVpFkT94VTcStN1KlPyT25b6ceG5kPQanCCkWFEYqZ/xsAUhAIGCcTKe3m8WUU
         AhbHY1mXAAJ6PTEvci8f7ahZ0ZHQilfi6kzaLNv8a0wbnPmP6XOnL0fK2EoisfLyvbVb
         xkZhoYNb7T4AXHg37BOGhG9Y1b7zRL5bykVF57M/xmCY8iB4q4EivD3nV+WGGNNU8l2r
         C53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707393928; x=1707998728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iBviACd6G9SLbDDYc9R0rps72fTMAV79UQpJ8ANwvg=;
        b=V6LyrooegnYN1CcrN69x4Mfizwpa4ZQ0mYuINy89dtEFWb4Ujwl1RKuH+NeoKX3VUD
         WZq+M1OBSJ/Ty9uQln35/gLoh3vtZIbMzoTd279Ue1TWbrvcWU+52eAxoJlSgR6sK0NG
         Ama2EI14Yp5U4aRwvBCx08vtwZfEt42czMLuog2wzKQ/eJIoa1XehJUwKUnVYRW+aCMW
         DkA0gQ7o0DHSNoIQ+gxSnLif6hc+k5nABRDJZerkTdqKok/6aAE57wHAYaQYfxkgckBn
         KMgVGNWunT6QHSthSJOHdzRhyFk9oq2pO9lok9EdE9Gd0yjQzr0fYLlJ7mlwiYqPArUf
         8gFA==
X-Forwarded-Encrypted: i=1; AJvYcCXDf00IKGNmDhROpY6B6qWqkcdBrBJjbsJeysDqI+lnPxQDFCAyiQg3kfLwqkMqpQaIykMjII36ewBIVRDdQZCcu+Dv/cmvtmIDYKuvrMs0pA6Lo3t3SKWf82EyhuI+eOby7gkBiXuu7prVHR+RQxw=
X-Gm-Message-State: AOJu0YzsDozTx2Mb5wGY8IKBwD5UdrMFiAC2LWiTAh8JIJV2kKOBHn2B
	fq1HhojyLpmclMH5RuzL5HmC3XcYQaUOYKnkx7ErCjX9aIgxdc7X
X-Google-Smtp-Source: AGHT+IEi+qvp/DHtyCS43h2PFBYo8G5Vw+KDnLsQ3zD/trYg4VKZVl98/7LCEms7s5eWzlqM79WUZw==
X-Received: by 2002:adf:e949:0:b0:33b:433d:e1d7 with SMTP id m9-20020adfe949000000b0033b433de1d7mr5245815wrn.1.1707393928029;
        Thu, 08 Feb 2024 04:05:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjYkMhXcheZeg9IcbEhfMDR2gp8XbY8AaCsQQIAei3K6adBOAUjqsihg9i5/n9MVfO+DvKzrPJHI1i0r6hwV29yz1z5MloJXEwkG0eEQVYwlOKLmitZP6GEDHM6UAts7vcn7LX2SqlYdLRQNWmIp19Dd4S3GfpYEr1efZQvJZc+RU3U/eElJM4EmhtdTn2EHRganYZtkl03XrPlzImUYRruUJxZOM2ReefvltZDsN5As16VrwDc2rbPpHj3/kWCn1XniuqU+iLKILFTfnY81+t2bMcy+Bgy5gOEYiy8q1r3BdQMed+VuvZadyb0/qUY9R9blj4oO7Xm4vsqnQL6jDd+cNSSJJil8FNwoSglVUqUFuHtHFYJH4MESMuMsUS4cEpOFeS88mI0uE8L0uC5epdic1ZNPYkMoDGHN+hv3bmC51V1n/7xzkkkD96axStx/TaSj9Mtg==
Received: from prasmi.home ([2a00:23c8:2500:a01:9a90:9247:99aa:fe24])
        by smtp.gmail.com with ESMTPSA id f5-20020a056000128500b0033b3cf1ff09sm3439197wrx.29.2024.02.08.04.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:05:27 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: soc: renesas: Preserve the order of SoCs based on their part numbers
Date: Thu,  8 Feb 2024 12:04:55 +0000
Message-Id: <20240208120455.48009-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This commit ensures the preservation of the order of SoCs according to
their part numbers.

Fixes: 9c57c4a9a45c0 ("dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 1a228dd4822c..c1ce4da2dc32 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -488,12 +488,6 @@ properties:
               - renesas,r9a07g054l2 # Dual Cortex-A55 RZ/V2L
           - const: renesas,r9a07g054
 
-      - description: RZ/V2M (R9A09G011)
-        items:
-          - enum:
-              - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
-          - const: renesas,r9a09g011
-
       - description: RZ/G3S (R9A08G045)
         items:
           - enum:
@@ -513,6 +507,12 @@ properties:
           - const: renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ/V2M (R9A09G011)
+        items:
+          - enum:
+              - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
+          - const: renesas,r9a09g011
+
 additionalProperties: true
 
 ...
-- 
2.34.1


