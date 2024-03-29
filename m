Return-Path: <linux-kernel+bounces-124334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF128915D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E881F22147
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940F524DE;
	Fri, 29 Mar 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FDKiLbhW"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738751012
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704469; cv=none; b=BBjcf/ZYfp5VucHnwukvOf+zibRsAhUbgZOSAM6HFzl6pBSpDEJBFUFzeifC7OwCPUlv2dT8bINz8JkHJNA2MGtOYb4ADHGAX3FcJ51nyiUeOpXp9Y0/WLi08M1R6nMCN+ctd8X3cB/lY1Y8Q+ob3kssLGDmqq6NiRGrmS3A1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704469; c=relaxed/simple;
	bh=fkcsbGMX7J/mGQ3kvbZ+/zIV5Yfm+uf2j5rr/bXjhvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBMdLxu9Pd5B8R6CCZOUG3QB/pBo1uqAsGvt6h+EbjElU1N/u1KDt0nw8flbcOIj4otyYDP+Y1B/rwLalgmdhZRPvfXUHnGGI0d7Jnv6C5TV1Q25NSLuRN7xokNE3TweKSdfWnwG8ebhAfDbm+iSg2plvKApe0pZm0NjZ6vxIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FDKiLbhW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a21af18037so40211a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704467; x=1712309267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0W2e62vRjypPXRsKNjsPCEnDXDpWajUvlAFErcdHOc=;
        b=FDKiLbhW62r5AuDSXRUZj5O5V3KeL56RpH3jWggpLKpbu7GKnA7nl+0w1rNFqWqCrL
         bCNU+xqLaMoPdGIm2fXL9sQJOcQSGSb1rDXaSg4xusFdoHHhGShDjOvxqbt3tveJy3AX
         SlQDBcxdKfr7wO7SmIXrDTOusRs5IT++cTkN6QRFi4nS+968tg36N+p2RA10SHrKeJuy
         FYxkGlnzCi7Kq5S1W4EuUVGpZmfpYHnldAftYCFD/rmgTmJCyLdJPNF6Y2Hn4ypjNpnz
         SPhzruXMbp/eSgUgWD3TTj84ZlzS+4vrKUHnDAm46+xl7zEtd6+4kg7wfA6qLP43GDcB
         0Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704467; x=1712309267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0W2e62vRjypPXRsKNjsPCEnDXDpWajUvlAFErcdHOc=;
        b=Ptex+km5WwIPtuXrm2Cj6wMbCNZEcyC/7e5klBVQeYZ6DALiP9F9fC9rr4LNyMdSjE
         3P8Hw7mj5THpuWKPNxjBR0fymxAIj1o6ZcGYUG/UhM4nIEL8cEEJNTE4wSIye2/Xph49
         fxenf+am9aAiElM/9lbZSCpwgSfLJx525fHeU+NVaIT4/GwujuXw/6O4r2ycmkLpfLTJ
         7dBGHh6QH8gDF3dAiTLUnVjiCeHuXaM4J59oQFkec/0Q0hpdFdnH5npOw8+BBCdkNbgU
         AM9FMYCoT2ImECHEILHhMpIcj7631wtzTa7HKeiJNfKH0b+F3qDAAzjhnR6juJSZMACD
         IiPw==
X-Forwarded-Encrypted: i=1; AJvYcCWuVSNPvsq9BXDIizXVZxI5S8/TWWzuxb6C4zVI93dY6Fk0ei1UHjAMLHuZQCeSlLGGWqsEhnKFmCGvZzHqFgLa3tcMK667ieOvh6H4
X-Gm-Message-State: AOJu0YyCJaQjYnvOclZoDHoa5RZZ/9YgXMEHLOSaMAeeTrDKw0T2M1bC
	p0nkBf/Zs/I/UzkSkMHFsxpcH3POeEvW9ce0Qw+64+OS3iwciw448Ni5upxbR68=
X-Google-Smtp-Source: AGHT+IEuJwWsZcF37cdSyR4oAfPxO9tw5zd/KR1va4FW9dJBQvIHdmB9ul/Vbw6Ly8QQV6MyjM+RcQ==
X-Received: by 2002:a17:90b:46c6:b0:2a2:176f:fba9 with SMTP id jx6-20020a17090b46c600b002a2176ffba9mr596520pjb.43.1711704467546;
        Fri, 29 Mar 2024 02:27:47 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:47 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:18 +0800
Subject: [PATCH RFC 02/11] dt-bindings: riscv: Add Sdtrig optional CSRs
 existence on DT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-2-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.13.0

The mcontext/hcontext/scontext CSRs are optional in the Sdtrig extension,
to prevent RW operations to the missing CSRs, which will cause
illegal instructions.

As a solution, we have proposed the dt format for these CSRs.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..c713a48c5025 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -137,6 +137,24 @@ properties:
       DMIPS/MHz, relative to highest capacity-dmips-mhz
       in the system.
 
+  debug:
+    type: object
+    properties:
+      compatible:
+        const: riscv,debug-v1.0.0
+      trigger-module:
+        type: object
+        description: |
+          An indication set of optional CSR existence from
+          riscv-debug-spec Sdtrig extension
+        properties:
+          mcontext-present:
+            type: boolean
+          hcontext-present:
+            type: boolean
+          scontext-present:
+            type: boolean
+
 anyOf:
   - required:
       - riscv,isa

-- 
2.43.2


