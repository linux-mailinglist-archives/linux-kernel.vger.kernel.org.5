Return-Path: <linux-kernel+bounces-130744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B7897C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD4428A708
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A915D5CF;
	Wed,  3 Apr 2024 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PvX7RDcR"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7415B979
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187766; cv=none; b=SzoLlDt2xryWHqjQhKebFzatRvI1hf1QeEcHIuqnQSixrOqtLlSxZxIbGEVkJ8bbBssnottwpAuIpsfCJtyLmiXaFQQUOjAgLgwZ+A9uDS2bfmrCHBYn0So8kBHe7IF5Jiuspqu4rkgUA9JcFw5IQwpHNm/OlMPRr7iVezA6YxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187766; c=relaxed/simple;
	bh=pPsjKQNhRwejOqj/6voWrsT8oKJgv/GHoJDFx3yhJmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMLRUvfMDW735Cl2ir/jO+pZ0ZpEEiMBL4DuyFJmTzAnWkOe4eOihwX5q5+PtiY5szS7Fuz+GJDbtLE21qenyn64WYPmEYROYMXHJ9avgK0znzd5X3vaekpjqN0yL7ATa5Y/PiEkhu2Idkr/guMtEsWSRY69sJsJqhT0isb1HRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PvX7RDcR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecea46e1bfso131729b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187765; x=1712792565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqdiAdr1yNbBMpdTZAViS/5DaSW59POCvFmbCyQTXxo=;
        b=PvX7RDcRfPn6QhV2Mkv7ZmcszL/0FEPUlj7p/BAamixdpFgX8C2MXHYy9nIz2IWVIE
         tydE3kxFKOUhYp7mPnX2W6A3AYOPvDoDFAKviAj3j2hnBDSonmk+8xUGjo/UVVxArOEz
         oYD3DvfP23n5PPpLtaxA7SiUHZ9WbOJLqxjQfX16VWnAUlpJITfFy3xvxhZo/EKb9cLl
         6VjhLDf6DPsEpWMdng+IwlpDcm5SBV7hw6EISbUqo6y9cvfNQIbeQ86Dqwa9igw/N2T5
         XQnf4RfcN/Akl6w/kQu6GXBQCc8BQBXEnlkcyg8ZXxDltyXVJDpZoAhHan15YyxP8jO9
         /Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187765; x=1712792565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqdiAdr1yNbBMpdTZAViS/5DaSW59POCvFmbCyQTXxo=;
        b=fLq3djkHFZb17voDgoqOVWS/x5tkkvRvevmWbfhNMee176yltGBOEndmLPxYnPlmGz
         AsojUGCKRF9RgHWrS93070YAwRiZXR/U2qHMkVXxtWtul2nxgLuGjN/H1VmhdkN4O6bw
         rm4nzGShQQUAQ33xU3GZ/vzRlAVu8p9ugYpJIutjiA3w9bNugLD8v0nQ/EfmOH+cukGm
         1rSOWD6lJL8059V6K5tLMhdK9ToQdjSHMAl/v6GexHgimEIhqpkvz5YyJr7XK6nHv7Ud
         4dYVEOQhVZ6NksPAz0YY4v3PZTQun0L1ASMUfYace1EDwChfh1hWH3JartOe1uwuaDyI
         0JCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7fzJOgubnHW4UwBr+zmtgDx72KnvksxRfS0oIEjd1Iv6C7HKjhnCh0qpGzbXXM+pWPzzSqOnHx15Iql/u86uDq0e//UdJet5MEWyp
X-Gm-Message-State: AOJu0Yy/PPNlP/KvDJ9V2J7JHGJa49nevBSRqs72pEUEYL1On0HR9GR8
	CHYm1Gd2InkeaOQt4JC56H3aj1ujoUGILx4uSbcq09eYjVLljsAnVYqo/paqJUk=
X-Google-Smtp-Source: AGHT+IFo9UTPYbI7WojHDrQA4c7uxF6nWpUROcJy8v8Ru9VCeqKQcLt71oVNVn3YtJu+elhu+4bSwA==
X-Received: by 2002:a05:6a20:3212:b0:1a7:4df:d052 with SMTP id hl18-20020a056a20321200b001a704dfd052mr985278pzc.61.1712187764833;
        Wed, 03 Apr 2024 16:42:44 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:44 -0700 (PDT)
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
Subject: [PATCH v3 25/29] riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
Date: Wed,  3 Apr 2024 16:35:13 -0700
Message-ID: <20240403234054.2020347-26-debug@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9f2a8e3ff204..4ffc6de1eed7 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -59,6 +59,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 36)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 37)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..ddc7a9612a90 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -111,6 +111,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZTSO);
 		EXT_KEY(ZACAS);
 		EXT_KEY(ZICOND);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.2


