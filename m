Return-Path: <linux-kernel+bounces-160707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C78B4165
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF7C1C214B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79A3CF58;
	Fri, 26 Apr 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Gew71aKb"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A83BBCE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167450; cv=none; b=EfrhbGN3EYF7c6Y3lBJCSFD/22hV+lwS5+hfGUipJD7AduADHhtyW9B9qo4+CNwLsCsw/nc2QhS1Byw8Q+xGwagZu/bL66MlZlpd3rIcWcerIaW56Fev+D9o/yxBECAxwWFQRZ7InrGFQ+OQo1xe891jVy14CtqNV/moUDXKlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167450; c=relaxed/simple;
	bh=VVos6nAzmHOy7EOA1ppaqJ4Dx+U57WxCTD6XuCvS0Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6Ob/BDD8P3+bImdwdQ9QLMdGU+BDtZxc4nbDr7O2RlZLwUHMCnQrSgE9pVG/LTkQ2LjmcEkg6sos875mlJB/ULyBOlsPY8yPSgN5Ew/4GEdoShS6kvAMCZEyuHzjiY/58xlZI54kE3OjPe4gNX2tUc9TF0oEP99EOiE1RENu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Gew71aKb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so2558824b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714167448; x=1714772248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3SjbYRlfVLcKXzSMNjYRrKo8hPdxAu3bA3GNGrI0mQ=;
        b=Gew71aKbtnX7tkzWcsPrYnexoF5+m8Mk5r7y9Az3JIz/PgKmxXoue3Lvc7VIUZLTQj
         w0pzexSy6Lt66pPmBD4XEx9f09a5jsWJeh9GBzSNYldiZc178JzeX6PqD2zgEX7zMmy2
         meecQvguPPnNrVWJTgNnOJLvjOa7fOP9ZipR4pqsQUOzCG+9qWEn4kzkcEYOMEFwVH8y
         DaDjSQeu0ikvg+s9CQJMsq1+ccApDjvITOqokBOSRQ6Yc3wa41Ty65qPxY/0xP9papZJ
         sDEpFEMC/YWIY5Fa5m9A0sKxeOWY0UpneYdCxc1cDLgIGbI4+H3BqpMeqbkc9UOvsV0R
         hRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167448; x=1714772248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3SjbYRlfVLcKXzSMNjYRrKo8hPdxAu3bA3GNGrI0mQ=;
        b=LhEk/2IxOyCxMqWaJShLFxT7wMFtRfSfbYbxgeyJoGugNXVbHcXuKD4ELvTC0nBvLZ
         BFc6qg711/47jsz4YbsdaCh21pPnUeOC5pM944ZCCI/pi9zJ/q+SGfZ/qUya4Ea/Wfgf
         m/IEszqQTChPBbuuV60fo08VlxfjXrw70ojLpM74Lyxjm/AX5QR0wBrjgq1MoD93x6I8
         LjDg9qg9dKYy2/mTyNZVTjHQY/tUeynW0ik3WsJ72sQZdYidWfkFGTjkV+BccC3z+Sli
         4iJIWX7uVAStnAwi9Mr94ndnNf99aM5/QPFgkVCmsagrsnnXfyI7Zcld80Xwaw9tzONx
         JORA==
X-Forwarded-Encrypted: i=1; AJvYcCWJxG2hO6sngM9H/uVxqPGBaxrjywNS/DjadLqfyTuveSc0AlgChYaS/LJQvpq+zNV410iay0yY69U59qawlhzH92EUbxpbRSKftYP1
X-Gm-Message-State: AOJu0YyJUwb8HNwGveHUFCavgADWXrKmtN+eWGNgUGlsuVxHs9WFuq5F
	HnXH2VIkQm0aTv5uCB35d5oYrFLDf2RSuSgDf7a4WrTV6soW5xg2sdXLGbyJMLw=
X-Google-Smtp-Source: AGHT+IHm5zjW+ioSlduj4IUVa22zr9qzjWQiXQZ2Y/v/laULdkXJTWt9qYlN0WXsPxl/15hsWAapOw==
X-Received: by 2002:a05:6a20:b112:b0:1ad:6e6:b494 with SMTP id ed18-20020a056a20b11200b001ad06e6b494mr3747995pzb.54.1714167448210;
        Fri, 26 Apr 2024 14:37:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902760400b001e2936705b4sm15935701pll.243.2024.04.26.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:37:26 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:37:09 -0700
Subject: [PATCH v4 14/16] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-14-5cf53b5bc492@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-5cf53b5bc492@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714167425; l=1205;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VVos6nAzmHOy7EOA1ppaqJ4Dx+U57WxCTD6XuCvS0Gs=;
 b=e/cAGXYDWmxX50AQyo8xsB3J/G31Eq8eUDUhpDifz2FCc5Ho3O6JsuFEwtpQxetc2K8CMG6gP
 M9udTAsKA4wAkZkxbNvpvvFbbz4MRw/af9XgaK3F9Xx1+v4uG+N2dmN
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..b2bb305140aa 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


