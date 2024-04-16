Return-Path: <linux-kernel+bounces-147418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE328A73BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED1D1C21923
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162613D265;
	Tue, 16 Apr 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aEEo+vGd"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0283140360
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293112; cv=none; b=JOCixOpbmcYcycT8PHqJp3dGMZf6Q4H+iGZ5CwmVzv0i2/CPiGQcuWasbl8WIwiuRTySwMHQhinC45u8uP32U/fWsE/Hkfq82xCRKE+ZC1XcXo3Uwaw/LuwuGFuzFVBfNOHih1MMAT1LACn6fX+AkgtXaWDUGjTJPMmoyOt28wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293112; c=relaxed/simple;
	bh=kGDqdfAz5O6jd2BlwqWEgDKuhCYmFyrLfaexp9eWGuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLcgez4GS+q1FZiDMXxt5ftbK8b1ntUsWMTfql7QIzDSyhQDTFhHCRP3ZF3x4hCAWyYBbRHaMweQnydDFmLTlBdwm1HHeXUUBdvo9NA+BMuNxKAl49bDTdu3rAbH8SIzkFY2n9oIXedoQPf7+yuhPoGhqUnAWvImawqMwfcIhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aEEo+vGd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3875810a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293108; x=1713897908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=aEEo+vGdgR6NcF+0+HebnJ0ZatfUYfidhByY9xCAgjwhItfkpuBAclxYm3JLOyN5sW
         xZRlOShsclLGZdHP1tPhi9MZeHL1oc+NstVyPNIzizUG+Q1PReJTo3Ueai0QOJXx35Ds
         BiF3DUxOaBMFdYbsgUYsoSer7TiGa18lWeF8o/Ss0JwFwBZE5fiKgLWcUliby+37nIiX
         +KnQFRCrDYaKABzZK7ET3AgQ+V6ZCtOhBhqf/Teh52IK7w7ByVB3UVcLsbQaumC0hsrY
         8vHx2Ru04oYzf3BZKJP0oFS8rAaLJEA569+fFiTe9FFcqDY0hM7+SLJfuRJLpeaxQYCX
         AB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293108; x=1713897908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=IlFYsechRjt8fF75Rv6W3zmTTpiuphymIM5GNmtAPZNIYFFLd+MMEQKsotIY/oHv+P
         9Vv2h2GEewnsDvvmm5adkKU67I5Fx/QxaZ/ML+vXWB8lO+EWWQOx3PmXOJDoskNew1k7
         j3F21RSy9kHA8AIpI8TZ97xUlaW+I491eB0ly1ODRk42z15EjbA1kfA0M2C7etcJk/vB
         XDLAJYyB19LylADialDcA9/DG+nUAMMpQsIPRNmYaQ2k/ab4Q6T710H0V8Weeygj1TWc
         y7Xw6pB/7eUtexOW69w/MXJVw5K/tAbalnp99iQJ05p2Yby8vUOndUMfbcvjkjhNH/nY
         Ng6Q==
X-Gm-Message-State: AOJu0Yz9fqW+TQy/yq3/ldrXUk+RruyHkk0R9fUk4q7QB2Ud5gPLmdDu
	zgMEn4GruLmVCfX1ilak6/dSYatImMnGBIfKGlSLJG9hvzi3OY+mUJWpyuCY6ifmi1ymVlVwPO4
	A
X-Google-Smtp-Source: AGHT+IHgRG4T/+azse3yQ3uEFH4UwWDhG7EwA6pm2R37KVOzESHt+dYSJ3kmp52wvG9g6bY/TLOb7g==
X-Received: by 2002:a17:90a:fa08:b0:2a4:7df8:bd71 with SMTP id cm8-20020a17090afa0800b002a47df8bd71mr12249412pjb.13.1713293108318;
        Tue, 16 Apr 2024 11:45:08 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:45:07 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 19/24] KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
Date: Tue, 16 Apr 2024 11:44:16 -0700
Message-Id: <20240416184421.3693802-20-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Sscofpmf extension for Guest/VM so let us
add this extension to get-reg-list test.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b882b7b9b785..222198dd6d04 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -43,6 +43,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
@@ -408,6 +409,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(V),
 		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
+		KVM_ISA_EXT_ARR(SSCOFPMF),
 		KVM_ISA_EXT_ARR(SSTC),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
@@ -931,6 +933,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
+KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
@@ -986,6 +989,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_d,
 	&config_h,
 	&config_smstateen,
+	&config_sscofpmf,
 	&config_sstc,
 	&config_svinval,
 	&config_svnapot,
-- 
2.34.1


