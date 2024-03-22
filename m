Return-Path: <linux-kernel+bounces-111640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D2886EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF94D1C224D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640B51C59;
	Fri, 22 Mar 2024 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APVllpdS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456EF4DA14;
	Fri, 22 Mar 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118707; cv=none; b=Bc9+e1zoVd6rV4J7VNR0JhEuPtcUUAxp00O7hjUzhTm9hb//ISRs1jNivH6hFMqWSVvlOvOg++ioNFvmTz8F+bsdAax8J53oTNnJsxFtfCrw9pJTctPcsn14oJa9xxXsSAP04WbIbBxJYzbCjy59mvRbNLo0LQ3mDnoGHNTHCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118707; c=relaxed/simple;
	bh=z0Q1447+VXQ1c95jXZFQ+x38c2pAXex+0RvwMrg0i0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nK3A5lGjhRY5fztww9ikV+XG0aE+xSfIO9L/l3yLKaV86R0mJtLdVsRXahBFKAYKhdfe0sOcCyGel1Hpf3OxNofTBZCjFj0Uy/tpJm1fZI66ok1egKn4oNPK9wEPSeXZms3TwiFE6E5TQW5XYTZhEjH+kMwkkOTJkSzE2TnAy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APVllpdS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso35447681fa.3;
        Fri, 22 Mar 2024 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118703; x=1711723503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TciX4HiN46XXmyc3hzy4hKoPSxTKgXcyydo7DRa6ZT4=;
        b=APVllpdS+Xp+OF/dr45CJJhoaxWv/iy73NN2Ojc1jMbW2N4AY71KNPh6NQUb4Uh7rs
         95I8XlXGWQ1a3RKGvNsJMQturnalKYPWxTykUJajpG1bOsJONJWpnnhPWg8TLSrUuDQP
         sXX3m9G8Bpnpdm/JoK/95AhDnAm+IqCz2KFz+dGci6EdvSQz7moIoHaaCE7nP5RdelxQ
         8qKtvPHwe3N/FyMN+2QGiXa+xA1wsxRDvnJ+nNIPx8hi0HngmR6OLxj+UfrGw8pnhomZ
         sX9OctlUFVtxdEp0k4h6IzvgBDKkGpDkJNg19LK8hiwNIEHWot+Gyyzlx6RPa60eGqZw
         +zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118703; x=1711723503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TciX4HiN46XXmyc3hzy4hKoPSxTKgXcyydo7DRa6ZT4=;
        b=jfxdU9YJhwXwRIK5R2ZBQVzzvJJTWLC9Vf5TYz1gIug9gz1RF4un4FenjmugnP/EUO
         rZFu/VNGGIgIOxL/nV3Na77UdDdc7xG8gT5hpb6QNqo4yB+F14r+8qPdH8am5jwxNu0c
         xarS7/RcYa38H6kD+q9SDl6dBSqjjHJnzeZNn7PQNO1DJIKumNHsWtJktXlQ6kCwjQPZ
         X0WellmR1oeFZLY/lSXFWzoxyQyMlMRowWQ8Y4gADX2d4zdYn+jJIO2xmLflfoA136Jp
         JQkvEYHtumYbHunwFOB1T2+ejZk7cdrSzt1bl29T17R/nmHDejjs3IQkKySpDXBQ4Lfn
         ltSg==
X-Forwarded-Encrypted: i=1; AJvYcCW26NTqM1fWXBUjWIKWua352LcPPLHP4B0CRGMl9rau/CqupmhuguSgPOufPp6GMJOPxx3D4lhn2TgUeZcnBo7ZLggLHpVprbDRzLOL9LI+R8q8hAQ+AnaVZs8jga1LgkvH72Fb68Pobbz/oCbXiBTtEMYRKDYLKsufq+SdkpTvKmuGHdJBegypt5T/
X-Gm-Message-State: AOJu0Yyrb1rW8guUkGH3pS/T3WpDCsaYCi62QPvN1SdxeICCmrr9aQAc
	rRXl6DZV7C1y1Balzc2kKHQ7b0bo+AP7k3RYzB3JhZFxSmIOwI1g
X-Google-Smtp-Source: AGHT+IFlVfO/3rSmnSFfsEbaTWG/rvRuZ6WdzzXtqSIhfCKde9Deb9cwHUkTZlWfUdAhPQOcipdW4A==
X-Received: by 2002:a2e:95d3:0:b0:2d4:49d0:d20b with SMTP id y19-20020a2e95d3000000b002d449d0d20bmr1873600ljh.5.1711118702855;
        Fri, 22 Mar 2024 07:45:02 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041466e03e55sm3911117wmo.0.2024.03.22.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:01 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Fri, 22 Mar 2024 14:43:51 +0000
Message-Id: <20240322144355.878930-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In preparation for adding more validation checks move the ref for
'serial.yaml' to the end and also move reset check in 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3->v4
- no change

v2->v3
- no change
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c..af72c3420453 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface with FIFO (SCIF)
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -160,18 +157,21 @@ required:
   - clock-names
   - power-domains
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rcar-gen2-scif
-          - renesas,rcar-gen3-scif
-          - renesas,rcar-gen4-scif
-          - renesas,scif-r9a07g044
-then:
-  required:
-    - resets
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+              - renesas,scif-r9a07g044
+    then:
+      required:
+        - resets
 
 unevaluatedProperties: false
 
-- 
2.34.1


