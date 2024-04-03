Return-Path: <linux-kernel+bounces-130723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6D897C2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4CF1F21FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF333156C64;
	Wed,  3 Apr 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mTG+xJHH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87826157A69
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187703; cv=none; b=XbpM0opU2EJBaBOV866UFqqrBt010mtMFaWIA+XetAGXItN+paJoLnlhy7F/XSGRPSWn06f5SLQ8kNJmRc9Hi54ABDAvWfoD+bQi7bmsEj1EHW18rfQ+SmLV3h01/yqka0tBkbpxmBxwNfMF/tsQ2kQ6c9Pgjc1qd3ixJzHX05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187703; c=relaxed/simple;
	bh=J89q9o6s6HqxbEZ6ljGjC0aJm6z4lMiWud5hMQgiuBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZslVpM1f6KNFqPFXTi0fL5fM/fEeolitIZIv75PIiv3GW5ie96x5xVjsF8cNRS6LddzfNOOfPj2YSu2qJCXtjQ2F4+9sLZUvNeK/fSgV8H4tlRVxyV5uB7HM26AEgBkO1HGpkKAfcrvMmPCxgIbUYzBna+Rxb12zpJU/WyNLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mTG+xJHH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0d8403257so3257395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187701; x=1712792501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orqHimAqeIVvjnhm+Lh8YT/bDSQ5kt/uWL0O/MbcU4M=;
        b=mTG+xJHHkSNXluhuTNXNcLAt5ecDKHwA0gaXd7JrpPDne5+qSTWIVILo1n0KKQTz68
         Q03GKkaE55tLxNhpQtdk2ILD4s931BjN5AewwTG2sqF5y3UYbHzpo2I2Qs9AzCGWG0f3
         SJO4aj58OQTcYbny+4vw1CAKrUFKPCRQ738CKXXqdxa+9e8wapDULkVfxLZXjKRcWlzd
         GPx3TZy6+/0jtuUvedaKNVic8C7AJdU9XS56hU+/xgTIVvu8kiKqZmCkdWnYuCaP5g/7
         RY8R5F0X4xjnJrlsEX9hIHyZW3z3Fq+EeXG2x8Bs3usTqY9ym7jRQvILMrjhdiCzMcSX
         WSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187701; x=1712792501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orqHimAqeIVvjnhm+Lh8YT/bDSQ5kt/uWL0O/MbcU4M=;
        b=hgwxvtDIodwQUZJ96icVlVlmqlkLvq9SmNSdgBa+JSudUG5sAR2CbKMKTuhN9LYbmB
         ulYZ/sy6bBKtowgXd5X6FRHrNjfsTzuSjsG0IrK9Qr2Z6K75ik3suqx0IDlI5L0r29iM
         cpN63MequTItx3j/GrHAoXC6H6fL9pjQgJfE6Dz+UxNCz3SbOlGEHV6wvIh6i8zNj0al
         /FiYV8IXVOoiKq0GSbdG1S/PYaYwGUetNXRPQSNjyT+P/2EXLLFozdzQK3bBeHG+2cZC
         sSopTt/aWa+91m8CiQ+1jdFnViFcDDHHEL7VyGncbt940OilKuIqJBKvw8oJrCHr89sL
         3JMw==
X-Forwarded-Encrypted: i=1; AJvYcCXYfi4GtEG/Y3y0qcMjgL9YR7fysaQ1PoRIvI3C/jiDamGzTWW1PMZgfbqAsVWSIGx4RucDCfNGU10UCI6qBbcgkLYcFsBV5E1CaOBI
X-Gm-Message-State: AOJu0Ywd9gZdZTBMZySKwU1OOPwaU4l3bfTSNE7x49MtHcCgWqrOY48E
	RKbJ1fdQD8HkJNqvBgOfk6tjIzYTqGlwiEdiWhUUs2g7EFVtaoxOyuwbt4m8LUw=
X-Google-Smtp-Source: AGHT+IHS90cA+AgUmlXmCnhm/ecMbFJNWD0dZq3yi8zpTRzaElJ0z3lk+4PPNraXYIXlpU0z512YdA==
X-Received: by 2002:a17:902:d4d1:b0:1e2:8bce:b338 with SMTP id o17-20020a170902d4d100b001e28bceb338mr994151plg.5.1712187700925;
        Wed, 03 Apr 2024 16:41:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 04/29] riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
Date: Wed,  3 Apr 2024 16:34:52 -0700
Message-ID: <20240403234054.2020347-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 .../devicetree/bindings/riscv/extensions.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..45b87ad6cc1c 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -317,6 +317,16 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description:
+            The standard Zicfilp extension for enforcing forward edge control-flow
+            integrity in commit 3a20dc9 of riscv-cfi and is in public review.
+
+        - const: zicfiss
+          description:
+            The standard Zicfiss extension for enforcing backward edge control-flow
+            integrity in commit 3a20dc9 of riscv-cfi and is in publc review.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
-- 
2.43.2


