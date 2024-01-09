Return-Path: <linux-kernel+bounces-20607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08414828253
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB8B1C23B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1638DD6;
	Tue,  9 Jan 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J7sHR0az"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7A374ED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28d7870574bso1053625a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704789676; x=1705394476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/C+cZAZlDGQnbyhqyYcqig/5vzt/WyH0xZX56gmkE=;
        b=J7sHR0az6M0IXYCdVG/4uiYdDAiynV1u/UguMMYdYPWYEHBc+RYmVfigAJj3gArvRI
         6lI5NCvc4Q0ekM/CpM0QoTzAIXsys5/JGi6nLnzNzaxouExrBKyF7SWNy+EiFz35YS2r
         An36GZdqHxElNIzgMEeKQVkfwttm0BkwzkPn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704789676; x=1705394476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/C+cZAZlDGQnbyhqyYcqig/5vzt/WyH0xZX56gmkE=;
        b=iu3hVMNdgjEta9Ti6lbWrC9nn2IcOU0vxg19x18yvu9q+d/BNt4dIkjknj18Bpc6n8
         9T4VWpynCNyK2PgvDCOWg6zDI0wvljA+Z8Ofr1OoR5iCTLhNW0B3HHp9oMRJLsA4OzDJ
         Xg5vbear+N97yWyphSnhbjyGIwjrCsRVS0UDG3vxGwBgUipf7dcjPtEFXFVVUsbHTFAS
         xnE4QifPFwrJkPoIEnciljLEMeFqyrRRyP5clanbHvuTkKWo3PrFWsQBQilCKs1sfoe5
         MJMbFzSDiarV0QWI4FBEN6UzXDKGNHzUHvnF36HRntFEtCrvsq+MbqoPH0zH0hA70oqm
         JT1A==
X-Gm-Message-State: AOJu0YzSrpp5HAzM84xiDHttjb0m/PykYOAUkwWwi01UEijQMAJEWzBr
	8DsL6Yb01NChs8JYRqHGAY7VW0fbwh/Lgb8zA1lkRxYiWStzWt5Zg1YWErNcllkkVc1VJUBdNH6
	XhaqPB2/RmLxFehFOMH7bzr5B3RhPyb6sqp/7ZMz7iLUTEA+mGscH+cdAhKSuaR5SnziaJkd/9k
	5kcGQfprKlldLYNkEW3dBC+hE=
X-Google-Smtp-Source: AGHT+IEKSJPQQ5kZXHfegHUZEeEfLJv3dBHvaNcjAImiJtqEMm+GIdULd8bk6lMU/uJqJHQXXQBX1A==
X-Received: by 2002:a17:90a:d50d:b0:28d:1e1b:d73b with SMTP id t13-20020a17090ad50d00b0028d1e1bd73bmr1951835pju.19.1704789675730;
        Tue, 09 Jan 2024 00:41:15 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id sf15-20020a17090b51cf00b0028d435cc2cbsm4772293pjb.15.2024.01.09.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:41:15 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
X-Google-Original-From: Alexey Makhalov <amakhalov@vmware.com>
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
Subject: [PATCH v6 6/7] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Tue,  9 Jan 2024 00:40:51 -0800
Message-Id: <20240109084052.58661-7-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240109084052.58661-1-amakhalov@vmware.com>
References: <20240109084052.58661-1-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
---
 arch/x86/include/asm/vmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 2ac87068184a..84a31f579a30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -273,5 +273,6 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 }
 #undef VMW_BP_REG
 #undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
-- 
2.39.0


