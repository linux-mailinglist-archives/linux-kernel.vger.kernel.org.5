Return-Path: <linux-kernel+bounces-167243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951668BA655
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53D51C21C93
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202313C82C;
	Fri,  3 May 2024 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="10mQQFFM"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D413C3F4
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711633; cv=none; b=Gu9SBD7YFMJLM71z5nFX94WpzAhBwzvTTcFAcDZqzCGYohjJw/urgeVO2Es7ywXEPfMaL1QVXxn/JnmZBHSXmJIa+mldELzKW5o7cfvYHSlHmHcFheyZz1WckVcH+6VagnItTxeDUrIFg8azD5/jePir1UxvboiXK0J4PEuYPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711633; c=relaxed/simple;
	bh=fwxPC9e5acCJKXfvxD0QuLfngnuG8uQUjT/zUUS4iJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCDlIj7/vOrpI1Kx29V9Ouk2uM8uzeJ7pMXKe4GvkaKvqdNuVUOHlYxUhMfq9Etc6ERcOu1/ouImWugeA33gvQ+oQs4VBtAp7uy3vPgSHQ+aDDuvhKOv72DqjCzIsA1i1L6MU5S3ned8NYNnG/9cj5yf9liiWELPrhLwMzLs7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=10mQQFFM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-61bbb208ea5so693899a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711629; x=1715316429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLBLJWgoI5ONq0p19OcZNiSMS9NNG1Jn9M7ZhOPyPpg=;
        b=10mQQFFMyj93hRzub9RVw4aNnbISIkROmNpjpbbIY3RtakFodyjR2+p3C03tXle4GL
         W0yuDfe9JnjqC6dJSg6FENFVWHIHPC6Eu4O0wgbwBKfZ/7MTbw4Q1whbsxGQvvHDFJ4n
         ag9dZfo8QxHvO5Qcqylbz2XUn96yuHMum3m9oySQ/EwZXfnqlukI5ykN5VonxDzRycv+
         qKd8xSb+2Jt/uhUrwgEHE+j6PKSrgYzHmhkkiYYUlZ7RipAw6gl3GZRKk4MOzHzG+NGJ
         yxPkWSh3kCZKqQrzsENfWqysDWgVGbKYFyt76VShVaGDwFAzNkJGC3xdEzvEge/dAyEG
         HpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711629; x=1715316429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLBLJWgoI5ONq0p19OcZNiSMS9NNG1Jn9M7ZhOPyPpg=;
        b=hDSBaphP4Y7k0n4qHIjdfaL2PDV5CREi49cepgXz2cgZAlJPQYMpDynSvjAalP2O6V
         25wL6xtbdW/mq4bhCfS9SDEG+zwHMc1qQ31aAUC7BG+Y2s+t/LZ+K9zn3jtvWc6z8e4Q
         854oIY/QaubRpslSRLag8v1jEKdLp7FPWVlvbtieiTujxJnT4EmlHS+8bMKS7ATcspxB
         K4U5zWsF2rB+0sB55K56e6DpyaVW4HlMd18t+OHvvzpwqUxNOyJMMuejr3n4u38C7XV2
         dC0l5P1xvzbkWIomlAGi4fzxhemjEd+3vVNzh3tnGnssZfr64N5RoIKlZICZhLoqmc9x
         FrjA==
X-Forwarded-Encrypted: i=1; AJvYcCV694sHTf257ecSlYJodgQO9N0MQLh5o5KtG6YBt+uz72w6GQ7q/A7ed9RJDjrzVvlSiGXynqSKpeidZ1KIHSwtOC9D7pDWuqbyLyhG
X-Gm-Message-State: AOJu0YzHNphIr5jfrss8uyt1arsi6s7ZDIxeqS0pKi9mXuzEH2VOLSeW
	9KWK2gYmZ4h6PSsOHKNAl9Q7cvrnrxNQ1NJttziVePRqxIBbcqnCfyo3QE6hJmo=
X-Google-Smtp-Source: AGHT+IHxiJG3XKuZnalMhMY0zBrYlix3NEAr72SPYl6kui+CH+Se+262eWO3YNNn+MAYWHadXypMvQ==
X-Received: by 2002:a05:6a20:f393:b0:1a7:4b40:96db with SMTP id qr19-20020a056a20f39300b001a74b4096dbmr1617087pzb.10.1714711629443;
        Thu, 02 May 2024 21:47:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:47:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:47 -0700
Subject: [PATCH v5 12/17] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-12-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=1908;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=fwxPC9e5acCJKXfvxD0QuLfngnuG8uQUjT/zUUS4iJ0=;
 b=tsASdWZ+V/WOtznPM1nvcKllla4Vt62mCeqqf/9/oDU2uch8BE2mc33Z26RL6fLgWnEC8I0+Q
 8mBe6EQvsFnBS9sgIxF6SaL2+IQ9ituhuA3C9zxt/NwfJ3n0ZomxMIP
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

xtheadvector uses different encodings than standard vector for
vsetvli and vector loads/stores. Write the instruction formats to be
used in assembly code.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/vendor_extensions/thead.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
index 48421d1553ad..27a253a20ab8 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -13,4 +13,30 @@
 
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
+/* Extension specific helpers */
+
+/*
+ * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
+ * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
+ * vsetvli	t4, x0, e8, m8, d1
+ */
+#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
+#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
+
+/*
+ * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
+ * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
+ * the call resulting in a different encoding and then using a value for
+ * the "mop" field that is not part of vector-0.7.1
+ * So encode specific variants for vstate_save and _restore.
+ */
+#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
+#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
+#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
+#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
+#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
+#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
+#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
+#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
+
 #endif

-- 
2.44.0


