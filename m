Return-Path: <linux-kernel+bounces-5997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760C68192B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CF61C21A87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599240BE4;
	Tue, 19 Dec 2023 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YZjYFDxW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18773F8E1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ce28ac3cso17109105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703023091; x=1703627891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=YZjYFDxWeilt0yKL6t3cVFUaTOgVfeTwOZu49ddDpWCWAK22kGFfIP0G1VzN/aBp0b
         U8rSMwJ00onrbCBxdkSdpyInr0B8LIf4QMdgGkricHS/CHamwAuoumYORr7zv3NihDos
         squyFoSYQwD0NZeNs2fwRQJR1raM46dNIaO/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023091; x=1703627891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=wahWELDhBBe1WSbWHVLyhZtdOh1nLFcy5Vg07uYNDJ35nidwKHDk9k0pZOivDwkFX0
         o8ryAEACHOGnnKGBD3MuH/xlnTaIHH1ep0qtCUXxteSlluLMcGpCg6xzPTMTH8GK8zNu
         Zd6lOaKTqYFo9S/yXM24NAYikUcRF+5t/ctjG/GuvVnOSuY7xedDswIWY+s0wPcxLyi0
         DMNCS/4oaBKWa4op9+J98deBAWLMFCtaJXjVJRUst/KU1kfa2iBVlKMmwjkbFV2v5/yt
         5bibqnLq6bbpg09tCDd7CRlXpNua/W/doaQ8z7ld4SnBE0ZuXKmMBubvfD/vbBjig6hL
         qNVg==
X-Gm-Message-State: AOJu0YxkZnqwErWtCtiwGN1jGd3COL1ERth4NV6KTODvew1IH8ewyF+k
	V9+xT8EtI9OTjiU03q1JbFIbLIaKho7zzk/Z9YWChysiufhuy9AtuFBNa36p0HmYf2l7MkyBbGs
	1MM+QPjcCKCpJ8E6IpkISytRUXALlpMDNcrE/15nVT8l28YlZWNRVDD+LYEGg8y5AsCI3xE5+pe
	Dl/v4TDW2K1OJ/IBi41O8=
X-Google-Smtp-Source: AGHT+IHGD0xZLG33r4K3W27zHJ54xxNx9BXxPN80CB3EUkCBFgov+arX/Surcqdx9o4S55QyyiUwAQ==
X-Received: by 2002:a17:902:7809:b0:1d3:e171:7d0c with SMTP id p9-20020a170902780900b001d3e1717d0cmr816076pll.83.1703023090468;
        Tue, 19 Dec 2023 13:58:10 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902e8c100b001d3aa7604c5sm5356476plg.0.2023.12.19.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:58:10 -0800 (PST)
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
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v3 3/6] ptp/vmware: Use vmware_hypercall API
Date: Tue, 19 Dec 2023 13:57:48 -0800
Message-Id: <20231219215751.9445-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Jeff Sipek <jsipek@vmware.com>
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 27c5547aa8a9..e5bb521b9b82 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,15 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
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


