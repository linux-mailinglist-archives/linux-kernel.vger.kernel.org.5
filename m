Return-Path: <linux-kernel+bounces-154165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450E98AD882
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D8628592D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58E18413F;
	Mon, 22 Apr 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a4CCWf2M"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A6184114
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826637; cv=none; b=gHdikw1yY37Hpg54LwUnzgrWiUE/uIoOwordg0XzQog/HR3wEEqH6Mzd9T3NyjK14JS2RnmTNXKNKegrPNYBLNmSB2axWNDbX0cguJoQJ5G386GsYOEZw4k3G5q7r+EVLZ/okDOQx4bicu/IgWWx/AYGIxAUi+NTTPJPO/IQQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826637; c=relaxed/simple;
	bh=oNDqfcadVCBv1NHKCDbX55nWD61GnGcAsAeavqpXrsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diHvKUY5Wki9lP2m0vZWhJvEgvr/rL9KrSTcpYR8Zim8cMgtLwTFPsT+fIhQiQZRBsC+6ZCff/OG8jNLu8+wtg1kNeqMDOZgiBU7hWKs4m7dflggiiqThSg7qLXPWuwAm9NYtAHFweXYuh6hvWRQ5HYvCHyreC8GSCQV/b4r90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a4CCWf2M; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso4699421b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713826635; x=1714431435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbe175V7J4mZKX1qbMhvDPfRMOR41WhVMQTZgQjYbwc=;
        b=a4CCWf2MIJqlTmDMNl44s6zsUSbItpdEzm5+1srvWmQzHAMX3H8bpuFXimLcnZrGy6
         Kvuz/+t+80DMPETzAPh4SskLKS82qry6YOD4126hGwySUMN+uYV3BQzuFNKt33iZoi66
         xkMbMQa7zWEFSmAQr3WSpR87uDPO09FmLEx9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826635; x=1714431435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbe175V7J4mZKX1qbMhvDPfRMOR41WhVMQTZgQjYbwc=;
        b=AydI69ZL5xEljRvEV4SNhIw1HSHbWsgsjd6LtuHFq7i6x4xbc/OHCE5PhzA2cwfRcT
         UVmtx85uE1axbaqm5aRzPsXfG9XWo0Dg5qgKEwyD17PrusefF71ajTIs2A3MNgrYJAoZ
         wGGtN6l8NeQGXobNzcAsxkNuadye8Qzupb4lidJq8WFHfYw+1d/Le1NkviafJfA1kYAm
         95a9myIklBdoy8X7gQANZIhla6uLwHL5D+HfkEhw0IQsXODo5+cgRe4YzI8h6zsdJYpn
         /fOzFqpI5iMHo9GlhA1ATQqafZ2e2WqcdO8RN7wkTz+XJ3BgJlc35F6GCs/AF6qlpJpq
         gevg==
X-Gm-Message-State: AOJu0YwX7roEs4+sF89/4Bh1zWvwKzvdd6AZbU/uNKPgZmBmVg+4W5l0
	y5g9xOzWYAgxDQYkRe7DPn5SA54j0OH8tPdnUX9Wtp3/SnQFE4FviIISbE2r4OwFzPwH1Nmw+t5
	ozFbEniFzzvzkFJq6wLuxPZX7gB20IWeO/ESc8p1BIjkxvEjWAeT84JoVcH1wBwPz7XNoImL3ym
	K6nsq2B3GfovUWkHrtnJXg2OroYZgV17RLxNa4f6geKK9fMHKIfh/eZ8c=
X-Google-Smtp-Source: AGHT+IEFR7KNfHlG9ODURmFuea8hUHKaNcbvVa/moCCwACPaA96hdooyXKpZmuNWh/BCyTnbNdW3EA==
X-Received: by 2002:a05:6a20:9484:b0:1aa:7097:49e2 with SMTP id hs4-20020a056a20948400b001aa709749e2mr13552908pzb.50.1713826635356;
        Mon, 22 Apr 2024 15:57:15 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm8093597pgc.88.2024.04.22.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:57:15 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Jeff Sipek <jsipek@vmware.com>
Subject: [PATCH v8 3/7] ptp/vmware: Use VMware hypercall API
Date: Mon, 22 Apr 2024 15:56:52 -0700
Message-Id: <20240422225656.10309-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
References: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Jeff Sipek <jsipek@vmware.com>
---
 drivers/ptp/ptp_vmw.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 279d191d2df9..e5bb521b9b82 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,17 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		[port] "i" (VMWARE_HYPERVISOR_PORT),
-		[mode] "m" (vmware_hypercall_mode),
-		"a"(VMWARE_MAGIC), "b"(0),
-		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
-		"memory");
+	u32 ret, nsec_hi, nsec_lo;
 
+	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
+				&nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
 	return ret;
-- 
2.39.0


