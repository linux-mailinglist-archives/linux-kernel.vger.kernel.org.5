Return-Path: <linux-kernel+bounces-159368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DB8B2DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20E81C20E45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF2156F41;
	Thu, 25 Apr 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N3uIFkfQ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001F156962
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088905; cv=none; b=gwxzjWY0EAuDV3HsArkfIhwl2nsIj/JrTpavhBZE5VOSLHNe5a431LNlj+ZlxOFfF0N6zLzS2a84Cgxj/WxpySQ0ZZyk2IV5bWVA9tI9JmkLsPf4Ub9lvnZwPiFO5bOeC1Fy6bPRCD+7gis/fFqNYmM4ISW+U2BLboGoG266TR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088905; c=relaxed/simple;
	bh=lcrnHRD9ixghBZdzmzfMAtQdZt4DQgGAZC7L6LSo2/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKNbGJUEMJhwfcMTKwIAISrxfrCMsBKB6CbBOjwZldhFaJFKkOFGQHF6mivB62PY9VcaGJOEPFwPWnuri0cKt9igIixXRH6OJ5a0p+FhDmJo9aHOjZTS71P87G5W/vn1kT1bkq7EkON8Ra4nNeW0PdFzNZGqHHxOFV7Sr65oYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N3uIFkfQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b1cd446fso12750605ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714088902; x=1714693702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqvGcDnU4Q7GXsG0msQsBmmm+QdgUC8OStzEmaKGVBg=;
        b=N3uIFkfQ2XkXKfMCjWPo1XZSrU7OB6shyHckelPf9VXqedt+GT1ceNdaZk1yMfVtbG
         ceR8y81wxFSd/AksN22INaK9/cw4+B7Z0GfUfYBuQgyVvBKgx74kasSUcfAWGqc6jLWt
         FKaI7eQ0X8YNcEr90euTu3Kps4OYEs51DFtG4yuAjpcp6dC1fh7XngeD9yszkS9+SLcC
         BNKzv2ks9Mhi4Dokl0L4/NwQXREecrEbLalmpcUcQ8kF4oh8HL03aQ/Q+La1horkJxvL
         Trla6mJGmj3goP9DF+N/SCWq/yD3QCOOYbm4Huq2Hv3haeunoFH0Gr0/EHBmvgFS6E1I
         XdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088902; x=1714693702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqvGcDnU4Q7GXsG0msQsBmmm+QdgUC8OStzEmaKGVBg=;
        b=Z58KRUOsFiHYXl5GrEqLhkDljHaIBGD5aFYCM+Tn9HctutpGIBaXbNmy/lDgqYzipH
         1aKRTzLUJTBHyM/jwT6BV+yu8mbvFCyYx8kvZz1PJqSBxYTc1UyaIlHK/kQte6yRH7GP
         gD22+uvZ9wHnmpvmR8xFDGe5w9lgxlCMbe8YjE5CTa4+G98d4LC/8eII8cbdu7BRgbmf
         pfaS5oIt3Uvip7AtX8Sb3MYKXWqzDxl8LoPBfuEEo4bnep0aALsjAyVWHMCmU3Wm+44j
         8u1wM8L0vkw93bsbPhhpYchVa/supdx76cddS8XzII5YUC7RGdp5LaE9wDE74yMB5KHg
         Lz+w==
X-Gm-Message-State: AOJu0Yw0NMxYzS0GDC7diM59VUlHq9f6aUNfPVFo2qFPafnkqTKYzuXg
	9Q5TOIgyGgGCUAxsqJqUEnzUudeA+Y2hA4YXyb6gtsj2HwTadF2MY+W9jlDgc0F8kz/ITR67dNC
	5
X-Google-Smtp-Source: AGHT+IFvadHJo6CHVYlerS5YjMlarvs6SjBXIDYE60SuTW+TYKkQrVr89MpU3rNa3hW0vdQ+MjDUOQ==
X-Received: by 2002:a17:903:2b0f:b0:1eb:ed2:fe89 with SMTP id mc15-20020a1709032b0f00b001eb0ed2fe89mr12781plb.10.1714088901920;
        Thu, 25 Apr 2024 16:48:21 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b001e0b5eeee41sm14349281pla.38.2024.04.25.16.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 16:48:21 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 kvm-riscv/for-next 1/2] drivers/perf: riscv: Remove the warning from stop function
Date: Thu, 25 Apr 2024 20:16:36 -0700
Message-Id: <20240426031637.4135544-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426031637.4135544-1-atishp@rivosinc.com>
References: <20240426031637.4135544-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The warning message was initially added just to indicate that counter
stop function is being called while the event is already stopped.

However, we update the state to stopped case now in an overflow handler
after stopping the counter. If there is another child overflow handler
is registered (e.g kvm) it may call stop again which will trigger the
warning.

Fixes: 22f5dac41004 ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 36d348753d05..78c490e0505a 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -191,8 +191,6 @@ void riscv_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
 
-	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
-
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		if (rvpmu->ctr_stop) {
 			rvpmu->ctr_stop(event, 0);
-- 
2.34.1


