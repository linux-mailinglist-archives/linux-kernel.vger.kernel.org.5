Return-Path: <linux-kernel+bounces-108166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D528880706
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CE21F22DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8954F885;
	Tue, 19 Mar 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h4ElhIxx"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BF4C626
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885560; cv=none; b=PKVKHeosv1qik4WNoyJFov6ycyMUUP/9olkJMf05jQbLeKeUfKzj9QaotpHx5+ZL+CNywYt1OJ4y18mSXIXJCd2wk6/+NeZvD5maka30qrYr2EF/HJnI6MslrF/baWqdoTbfG41YJ07Ct4AhFYq1Wl7bE4FqaWdYZ0K2Tv+lIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885560; c=relaxed/simple;
	bh=FmlnN/GKOAOCg5UbOr9A5w45WtgIdMY5JUe3z3aaSTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRqEVmOKJER195G+OvdvQbBYSQSMbu+EJM2Qyq9cDn9K/pmVieKBaoIWCfpGJbEFjEtkvoRh5LBlAzwaL3vCm2wEhl5Xv6YSy3uIFDjiEF9rKLwVW/dHktjejIlXKQ5Xh7Rw52zzjgm+RWlVvP27DXnZKUfGAKIJfeEpM0Xt6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=h4ElhIxx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so5628188b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885558; x=1711490358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf8TbChjgkUHpdp7I/ykwc/bJc9eIQRGH4wGpVTxw4U=;
        b=h4ElhIxxgcBFKJpDrNLqiOlMU8/BnoaTPFp5Q8tDZXfePRxS2oo66AK2KCRHk3uso4
         Eqh9MSwDoGtjERIVfVDeBuy7ZsT+RsTn56n7y0P3WAvI61GSI1MOuNxVRz2KE6hTe5HM
         c8GWRQCiOU2A5ppIXlRkVEu4c9yiQLbolZ9VWdKVoIU4bCIn+KbCeU6X3hZCDxG7ff7S
         xMcF8sKdaiT1F+0ug/rRyRKaNY7hm6ml1OaxAdjRSqdPN6bMDkXgBaejzA9ShK42XnLn
         iEFTxRNu/s1NDWOOEvIuGm7Cahfeb/QR9MVM7ceRejGHSBb7aqMiqWVQoeg6AOHYVuF/
         5GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885558; x=1711490358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf8TbChjgkUHpdp7I/ykwc/bJc9eIQRGH4wGpVTxw4U=;
        b=IEXOHrzHjClS1PA+flg9c2vkX9JEGslCp4QfX4Tl0wwBQJ5kAQD8pQVMdVdv6euCoU
         wGn13JCH73TB+/UjXLdzxktoEazsinYfMyCEj0XAulJvK2MyoqVjeHxa0YJnqmwlMUMF
         FPG0eoq2JJY1sPg4IzTFYRRCKA7bL3pBWLw5s2M4+lcvJ+ZNYWRz88gu3fitAhqpPIkA
         w0FzgEiP/VCCR1FfjKSTNbLEQzbAVfMu26FLc90Q7RHuZuk+l79Dr2TOvTGtnV4aqWSY
         nALzA1Ds/pZHsOmfdt83mmYAwvd18iOnf19IZsSnermrO/bdOsoxfuGqhvUdkUXVtNOG
         GCRg==
X-Forwarded-Encrypted: i=1; AJvYcCUNecv5Eq1h5B1KwKN4pyleVoh+UvqH2J8bs237Bb/MPNWL3ow0/MfFqRPSzfpI90PTPxGO3gifR9lAbkOGgObi0YQLCHoZcVzgEv5Y
X-Gm-Message-State: AOJu0YyhvWSQjtl6UA6nN+3FCS1r7FBskkZ5nvKIdiRjgH0T8KqwN7lq
	e6qiWLC/MwBg9poO3nUh8R7GXMcVuIqlHSh9++T7QNlkS2DTKq1fOOV98u1tr2Y=
X-Google-Smtp-Source: AGHT+IHxqp3vSJIj8u1FQnLhGGhgkkZd9sPyRN/6PCbIT9hhDxZABaPjD8SNbLUKLifMerMmPS4+xQ==
X-Received: by 2002:a05:6a00:cd5:b0:6e6:9ac4:d501 with SMTP id b21-20020a056a000cd500b006e69ac4d501mr443835pfv.25.1710885558184;
        Tue, 19 Mar 2024 14:59:18 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:17 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: [RFC PATCH 1/9] dt-bindings: riscv: Add pointer masking ISA extensions
Date: Tue, 19 Mar 2024 14:58:27 -0700
Message-ID: <20240319215915.832127-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240319215915.832127-1-samuel.holland@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Document the behavior as of the current draft
of the specification, which is version 0.8.4.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..bb7d5d84f31f 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,18 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smmpm
+          description: |
+            The standard Smmpm extension for M-mode pointer masking as defined
+            at commit a1e68469c60 ("Minor correction to pointer masking spec.")
+            of riscv-j-extension.
+
+        - const: smnpm
+          description: |
+            The standard Smnpm extension for next-mode pointer masking as defined
+            at commit a1e68469c60 ("Minor correction to pointer masking spec.")
+            of riscv-j-extension.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
@@ -147,6 +159,12 @@ properties:
             and mode-based filtering as ratified at commit 01d1df0 ("Add ability
             to manually trigger workflow. (#2)") of riscv-count-overflow.
 
+        - const: ssnpm
+          description: |
+            The standard Ssnpm extension for next-mode pointer masking as defined
+            at commit a1e68469c60 ("Minor correction to pointer masking spec.")
+            of riscv-j-extension.
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as
-- 
2.43.1


