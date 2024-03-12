Return-Path: <linux-kernel+bounces-100727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E520879C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9035A1C2201C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184E14373E;
	Tue, 12 Mar 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3H5ZUf6R"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED514290B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272881; cv=none; b=kiJtaIfaN5i8VAZ1t3QLoEVXg37S2PvlBxQPb0uReRhU06cw0ZLfhwBRAFC+hHLt2GhNdRn0/CeWfxAfzGm+kzvycAziU7kmgV49Gr14HZJi56/B7r7BkYVLL4Scc3hYWlamn43jHr84toV0kV2PDbn1x8+l8cat7Y400uEWu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272881; c=relaxed/simple;
	bh=BFOeXqJe9VyECGMuWiCNLoTZwBpuu0T2u1Mq+P/cqDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RdmffKgz/i4cKypxg1LnSK9sXHFNCLHI6wSwr3g9r4uY3fWJP3LZdOB6NnIjfVPSjle7/L96TxOv8bKr+M4E08ZFbeq+DrHP51h1HGkyy2J3hIjilMoCfPJL5Sghp+7q78p0fuvP+Fz/KRqnyDhboiFYCn5+pNTzlPa4ItTQm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3H5ZUf6R; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a22d940ff4so462291eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710272879; x=1710877679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4XSa/PSXORT4uTdUR+bw2OZtjIlaWQWlwg5OyZv4ig=;
        b=3H5ZUf6RU1lQQGj/bvMwxqw2skT0BM2V1JAvhbJWo3pFIADpfHK69fFU3QwTjE//IH
         RuTZZp/foAv6eTPyrIiWUJ4lrOAEBPHqNQzGdlMiwykUNBmlhKZ3KA3dJK/ZmcWdJ2W6
         YcOFyt638PyoLlYPXWybdKbK0kwz5Hp5jJy8G8n9/kTwxNArZwGAZDDq4EJ+zmqt4jKj
         odx7M6PcT/c/a2NOhu1ZFYYAIzhYQEyeCv0g34GmkI35rjkERxxsZqEH5yWPAV2rASRr
         bEqAhKy2PGOux2RCXvKQQnpDHqiaeIygOlcOV4Ht2bayTsdH1c2JhrsQ/pRL/yYE4Gmz
         3rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710272879; x=1710877679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4XSa/PSXORT4uTdUR+bw2OZtjIlaWQWlwg5OyZv4ig=;
        b=arZk0ztWD4YBJ+Go+hhIkOeM49GLega5Qid9lUNIwvGD9XgzE6lNQ4xmYwLSxYVcCD
         vMC7pK6DZ05uLTXnRBV2vNmcH85cnuxsahkaDj/8SNJHjXrLObvUP6fSovH2vA78Ur23
         gHJDhYAclQGN9uu2bt2WI0V6ya6ls3JAWFB6D2n34jZhJDDUO+kd4sukhUgrN3Qc0rYP
         JqW4g9zaRTgVl2psEDr6ZzhoVMmG9S15dfVu0pGiTdRjuzgxhf/UhliSdik1mDp/dtId
         kX+jWF024zA5jqU05n7+X6Kmx+QyWhXoQK0CZbKhozGF1OSsjCPM+qIhmeOdAiS3P0L/
         5PDg==
X-Forwarded-Encrypted: i=1; AJvYcCWXL63JmtHexceV/Ut5zYirb/iZMkVSZkzyWjQRO1oyYFe5FViK61qfEMD+qxDAnWslUppeEULPH8mFxJfy1pmufxTxxAZ+7vdWz0iw
X-Gm-Message-State: AOJu0Yy8msJTRYRGOl5pCAC63KTRqGkCVLBf1UcfFMAB8T073U2q+ljG
	vr0YVAgd0RTlhMALyVcdcuH8id0g3ERl+54R5PwMjlH6HiwUNP5jsuagkNv55EA=
X-Google-Smtp-Source: AGHT+IE+Yl3rd4VRKQ0Xgn0vLA0/IXGphbXEbzUjbknciDm6FUQ1nMtO8B6Nv0KNcv+QR9Td6lCSWw==
X-Received: by 2002:a05:6359:5f9f:b0:17b:88c2:5c13 with SMTP id lh31-20020a0563595f9f00b0017b88c25c13mr12958442rwc.7.1710272878964;
        Tue, 12 Mar 2024 12:47:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z69-20020a633348000000b005dc884e9f5bsm6433495pgz.38.2024.03.12.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:47:58 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 12 Mar 2024 12:47:54 -0700
Subject: [PATCH v12 4/4] cpumask: Add assign cpu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-fencei-v12-4-0f340f004ce7@rivosinc.com>
References: <20240312-fencei-v12-0-0f340f004ce7@rivosinc.com>
In-Reply-To: <20240312-fencei-v12-0-0f340f004ce7@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710272871; l=1746;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BFOeXqJe9VyECGMuWiCNLoTZwBpuu0T2u1Mq+P/cqDo=;
 b=dUaXZnD9VQ8vsLYsKXOkCevPuNYqjQqs4wBvroTCyGKXR0MwtTqi+kVmNS6cpmRfvj+9eBpTV
 UJ9TU9gIUSeDYCpY+ggkBt8sv4yB1OqY2YjqtfD0d/3rv858ooSwNYg
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Standardize an assign_cpu function for cpumasks.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/mm/cacheflush.c |  2 +-
 include/linux/cpumask.h    | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 329b95529580..2e16ed19e957 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -234,7 +234,7 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 			stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
 
 			cpumask_setall(mask);
-			assign_bit(cpumask_check(smp_processor_id()), cpumask_bits(mask), stale_cpu);
+			cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
 			break;
 		default:
 			return -EINVAL;
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..1b85e09c4ba5 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -492,6 +492,22 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 	__clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
+/**
+ * cpumask_assign_cpu - assign a cpu in a cpumask
+ * @cpu: cpu number (< nr_cpu_ids)
+ * @dstp: the cpumask pointer
+ * @bool: the value to assign
+ */
+static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
+{
+	assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
+}
+
+static __always_inline void __cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
+{
+	__assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
+}
+
 /**
  * cpumask_test_cpu - test for a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)

-- 
2.43.2


