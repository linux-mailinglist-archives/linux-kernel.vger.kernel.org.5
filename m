Return-Path: <linux-kernel+bounces-120308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32D88D590
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2552C217D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC051BF35;
	Wed, 27 Mar 2024 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nwXZug69"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CDD17565
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515050; cv=none; b=mRpoa/do7sKCb5cgvitWt/RuTpU7xvubwqyW7zz9IQ4yd50T4L02GoL6g7NJXEQv0/zm67LjPojrYG4e/E1IA3qAYv3+9N6GCjB1pHjo4IT33k0m9/eZWM6uHQUJu/ZJUXwY+q2attUCS0QFD8cqfTE/FmuuYS14Ql+Ly+6ghZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515050; c=relaxed/simple;
	bh=ya97YfXpoRK/xYSjnVMkP8sXm9+Mh9TCgaVbVD32L2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxmp1W/fJrYjummRNqhLBMiZ6AmMwLtdtBrbyhZCm5NNA+LJaeaN2SsNk+WU38JWDNgHwJTOfkQ72zansm4XAk5Q1ij6L44bIDbOTGXSeKkM5JghDVkgKMvyOKK/gkMi+q+YsQo/Ki2NP7reihJeKQzEYSDPPNsMM9/7LAlDStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nwXZug69; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e67b5d6dd8so3499275a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515048; x=1712119848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r90DmKfTzo12+b9oHF/xBbsXVRSBOTytxxA308aMe8=;
        b=nwXZug69+IWYGlBdBnH+/S0tnz8xTjrFivzLBhkfZu916ZIO7k8frGmvIrXU6F2BEB
         TP7b3LdkOt7LhwjHG88NAsgbK7Eg4byv2iaCrOM2j1gXbiXT5d/hjq0oeG3+n8ySCUcw
         PRaMjJSsIolgo1DuhZI/p0RG+VCfaEe75TVpuBTJkDEDdQ5vl8sN60j3rDaCEtCq1sph
         IHM7ajqVmrmigUnMAkt88+9F/xhu1vul6dUp5Rjl5Pqgdt0Z3rtyZArpNT25fqDX6gI7
         pVP2hDuBBSvnOobpHnjkORXkP7mSMiiqXLV7e9JMw46t0B4ou0VarDBYl53xrACdz2X5
         Dy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515048; x=1712119848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r90DmKfTzo12+b9oHF/xBbsXVRSBOTytxxA308aMe8=;
        b=g7gai5jqF5m4sEJiabBU8umyFK2lWIOAVudSkl+5OYq2kuo/8AuQIPBsQNFxwUrOXg
         rZQ9IX33CdPw0/zzPnM3uB1OEm75cfNWzCujxeB36uRSwyDBIPXzuJN6Om7I9BOyrEiT
         /db/YzvNRjJ1F+4UlRZCN4yMO7nFRRmrcnWoV8ED0oMou9g00EwGJYnUmd97qsOK4TAf
         O/ultPR+4hKeBAbKyyrc64plDkV/0Lc7MkcY9nO7BPdQLGpvVzYEbmu/ebo6xtMg36Xh
         zPdFJFd95LPy1OOv2gbKZSVtuQcyYBhQV2aku7YYNQhIfqJ0Vag+N6Ymwhq7hqiuWGYZ
         9o1w==
X-Gm-Message-State: AOJu0YyCS/D762bV8UEOsSi/metpt5jPv4msbVWf0mt911In6SNBfdW7
	27L73H041F8LHMxt8fRIl4T6Q5i6/1WbEjmLMagjhGnlA9R7y2wnxLlf/zEOSEs=
X-Google-Smtp-Source: AGHT+IE/gtW/a2EQvN+qhLpDTcQ1EZrF+9VNRUlZn60iPj1iarim6P+gGyjDapgmLmO07m/XYQ3rgg==
X-Received: by 2002:a05:6830:1e72:b0:6e6:7db1:b444 with SMTP id m18-20020a0568301e7200b006e67db1b444mr154078otr.36.1711515048291;
        Tue, 26 Mar 2024 21:50:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:47 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 05/13] riscv: Only send remote fences when some other CPU is online
Date: Tue, 26 Mar 2024 21:49:46 -0700
Message-ID: <20240327045035.368512-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If no other CPU is online, a local cache or TLB flush is sufficient.
These checks can be constant-folded when SMP is disabled.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v4)

Changes in v4:
 - New patch for v4

 arch/riscv/mm/cacheflush.c | 4 +++-
 arch/riscv/mm/tlbflush.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index d76fc73e594b..f5be1fec8191 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -21,7 +21,9 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (riscv_use_sbi_for_rfence())
+	if (num_online_cpus() < 2)
+		return;
+	else if (riscv_use_sbi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index da821315d43e..0901aa47b58f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -79,7 +79,9 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (riscv_use_sbi_for_rfence())
+	if (num_online_cpus() < 2)
+		local_flush_tlb_all();
+	else if (riscv_use_sbi_for_rfence())
 		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
 	else
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
-- 
2.43.1


