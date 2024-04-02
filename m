Return-Path: <linux-kernel+bounces-128589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9AE895CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAC228349A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694FE15B971;
	Tue,  2 Apr 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5qss+en"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398E15DBBB;
	Tue,  2 Apr 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086566; cv=none; b=thu3LJi4WXwdiwq2ftcGwDBF898Z5G+sYfC/uDXc1rj2vZLvDjFAWLc4IdRnPJnVGWVpMvOIHFIHvja+E5ThjlYGiv0G9VMIvBsX3dPb1xCUMROcKsOzJGawITQZudOR7HkXFHG5rvwvtniVj//dCcK96umAIYSGHjFCesZMEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086566; c=relaxed/simple;
	bh=0tIuJNvFsc0/yZejA65A2Zkxy0hhzxdsvdn7WTX3Si8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfxJPg1XnQr/VTcH64RYJwx/3VUQYk8qDh0etrE7joIXDY9gGWakRqZ0wefYQIx+fGY3tInE4rhqR4bkjxTvHUkdPrXyZiSVCNPC6b60/2ztCjr4uFY5sr16TE3IXF0MOwgHX2nJb6ugzw28rSF91ybkUbAJiWfqCiiTc3YB9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5qss+en; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e28be94d32so2136655ad.0;
        Tue, 02 Apr 2024 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086564; x=1712691364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYbnaHnAGjSi67+NJWyZTmxz12NICwI8+9rmQ1o+iIg=;
        b=W5qss+enAKcRqKS2qgX9pOIdrXOo6dcpvxHUfmBw3n09054VTXcp+iv/oMjoMtzcU0
         sbwSXnLH0+/d92xnVrm0YiRuXx2RqfuPLeHOeUwDMQWtKzQkimn18FSh7eFOXEwe+mVw
         gdDwubCvB2baV1WLtT04edkgsXBQ8HoTkfDUb2d091eRbPhMYwx+0s777g7SQGDzl1lW
         So44aL7QSuP+reqwi1k5oW4mCw4lfeLnUSZVu/+svRVz6fFVw0VEZbFd7HogAr/4cexm
         zo3RZhKkdWkDrW8UusKtITGtzACgIat/Akl/GPM2Mwj1Q2tPt43vjLnq/iq3rtccJ5hT
         DAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086564; x=1712691364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYbnaHnAGjSi67+NJWyZTmxz12NICwI8+9rmQ1o+iIg=;
        b=UKsr7AUGDwHkKv4I8llyvJl8HJ/PEykubAonJ1+c0NzDPfsX59zFamIdLWeHY24hqk
         UEPbzrfBT9cmROWEPmMUhCQxDBz/6I4uf+MS1CokxtCpxVa3Kx1M3AANUi5fdmNXAdE6
         OHA7DHiTX7CX/zRlVnW0EBLTtv3yLAVfEXS/EXVGw1WhTDo80R6y0w52WamVq9hc7j/P
         9vM9csn9U72C0b/t8Iy1wvjY664xXH69N6+RcP9kSM6mOrOPC9UXMAiz2EI6KsHZBAAs
         kv7JnoW15uhtrpyc5oqn0xeTkNex+JyMWKjm6P963xmY2oJ9h6nZ08QdtZGtqyJ2MtiE
         6yag==
X-Forwarded-Encrypted: i=1; AJvYcCUkgXlQOZMJTCawk2znRZptnbkjBJBLIQ9n5S/w42Oze4x2n5lWimXS6D3Q7C0carAWO4eOBzLdDUqwcxe+nTzG+/137e2IY5K1VYeKFv79rhqD0Dcs5kOKxYg2taERHiLzbR4fg9mU/g==
X-Gm-Message-State: AOJu0Ywj+21sdvkxQUWXXijuQ5v6SnxbQOR4Vb/VvVqSps8ejN0Ptyw1
	oXTWRx/XwwW48TVrpdu47F8p5+3JVgxosAhkzMKnxcvFStM6LVgg
X-Google-Smtp-Source: AGHT+IEPSU/1XY9EHbykDe2oxo8f0Qt9LIq0jfhSQ7ADCMVKwNg/qNGXLeCEnjDk1wHyy/bAdLzrNw==
X-Received: by 2002:a17:902:ce85:b0:1e2:8bce:b338 with SMTP id f5-20020a170902ce8500b001e28bceb338mr807799plg.5.1712086564628;
        Tue, 02 Apr 2024 12:36:04 -0700 (PDT)
Received: from frhdebian.. ([2804:14d:8084:b86e:ac17:f518:b547:13a8])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd59b54f9fsm7775841plt.136.2024.04.02.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:36:04 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] dt-bindings: arm: fsl: Add Colibri iMX8DX
Date: Tue,  2 Apr 2024 16:35:11 -0300
Message-Id: <20240402193512.240417-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402193512.240417-1-hiagofranco@gmail.com>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Add support for Toradex Colibri iMX8DX SoM. As the i.MX8QXP variant is
already supported, update the description with i.MX8DX and add
'fsl,imx8dx' item as well.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6fdfa10af43c..f872c6ae151e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1226,7 +1226,7 @@ properties:
               - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
           - const: fsl,imx8dxl
 
-      - description: i.MX8QXP Boards with Toradex Colibri iMX8X Modules
+      - description: i.MX8QXP/i.MX8DX Boards with Toradex Colibri iMX8X Modules
         items:
           - enum:
               - toradex,colibri-imx8x-aster   # Colibri iMX8X Module on Aster Board
@@ -1234,7 +1234,9 @@ properties:
               - toradex,colibri-imx8x-iris    # Colibri iMX8X Module on Iris Board
               - toradex,colibri-imx8x-iris-v2 # Colibri iMX8X Module on Iris Board V2
           - const: toradex,colibri-imx8x
-          - const: fsl,imx8qxp
+          - enum:
+              - fsl,imx8qxp
+              - fsl,imx8dx
 
       - description:
           TQMa8Xx is a series of SOM featuring NXP i.MX8X system-on-chip
-- 
2.39.2


