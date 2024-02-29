Return-Path: <linux-kernel+bounces-86066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A786BF29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFB62857AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF9374EB;
	Thu, 29 Feb 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Od541j0o"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C1938382
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175498; cv=none; b=i/aIwqP9wGikot15d/WEDmNJNetklS283LtvrMSAnTkUwAn5toiO3uWTWnSsFLG4cGsrpIZ8I0QalrQsUEaNxm9qk8KbZgZ7UIdd3wm5kfFU6dUD34WtnD2drOOB3bmexNSn3ju0BsSoHRaZZ5JHz5qLbgAzGzgHjosOHUsg0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175498; c=relaxed/simple;
	bh=vBxpG3Dz9ZyzQmLOVkEwkMADJ6mdtbcyVLq+Z9tdtMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfrj1RQWu0fi7Kb9hkHr9gpIxatN6zPUkEk0cKrYav09l44h0ypd9KB73yfSJ/8nYNDZRLRhPSEVB/q0/UpD5hu2O8lXuPMR1h2IfPfLhTxr0CDjsa1dfnoSMCyTftGcPWvK0ZXlt3uoChnPxlqMR70ce59cCswNbPlBuq9bD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Od541j0o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so372528b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709175496; x=1709780296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqzBf0lbp1ARHQDBEkHQmEKBBGeWS/SzkM01JYF1z0o=;
        b=Od541j0o8r+l+813ZW6A63LYTtnUz48u1QrOxZ8ejUtOwR0zg0WrWI/dyD3Z9WuPcr
         GCPqD5el18IKluc49eM9k2Vs8TAFpxK+7qTE/pYOviYsCCqQkbalD6oQi1oZw/Q83RF8
         DoKinC/gJLAs9Mi9xpHEENjFW9V28EBNW54WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709175496; x=1709780296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqzBf0lbp1ARHQDBEkHQmEKBBGeWS/SzkM01JYF1z0o=;
        b=fd1o19bxw3yMrrjuqPocE2Q81ydSCyFaWy9W0uTRoHbiiXZ4MWGDk3b8hB7YI2ODym
         EMccULSgz2Afy+5Oy+yhnRQb8YEHU6Bk78nk2KF+I2rLN7WBrQjmxu69vk98yKvZHO9X
         61mhLYSv+JytHjJ7TU8U754iQ8GXLL415WP3WBBrZawcaGEyS866juSrf2U/yrxrAM+n
         kdCfYT44Hg4ys/f7YhRHlurpCa3jXiLzEB/xkPonWCbHPQxI9kMUuSzMxmpGUgkkCCho
         uEkeMKlU61HTNg/tcLL/hRevyBunfQ8XUWKtwRJdXDppZTdaA96ruLMKSUUkU2ZF/2nJ
         STGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz/yOv1dzTsCUnNSI40/r42ags2b8z81Q9++kxJCg69MYzqs3Z3lC8Osbp/agrX06w6xYQMCjK/pgPyktpALheEgS8ZYfVsiACwbg3
X-Gm-Message-State: AOJu0Yz8OMXGTGaFxrAUBE+UQsvyAQWiqtFKfcVssIB3Y3DYzEW6uNSo
	zr4wZuC6Jiv6srdJT803TKIMUL5rMiLx00CPqIdSKzF69352GXiQTzKk66/gcg==
X-Google-Smtp-Source: AGHT+IEaA3Yk5H5sm7OqlYuWJldrbQt1FyGNtf9CVSLw7qF8ebCkHsyFpFiViHyqoeQ9pbU7fRjgjg==
X-Received: by 2002:a05:6a20:c887:b0:1a0:f713:8317 with SMTP id hb7-20020a056a20c88700b001a0f7138317mr1259104pzb.61.1709175496202;
        Wed, 28 Feb 2024 18:58:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f51:e79e:9056:77ea])
        by smtp.gmail.com with UTF8SMTPSA id a1-20020a17090aa50100b002997f192d4esm2055537pjq.1.2024.02.28.18.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 18:58:15 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v11 2/8] KVM: Relax BUG_ON argument validation
Date: Thu, 29 Feb 2024 11:57:53 +0900
Message-ID: <20240229025759.1187910-3-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240229025759.1187910-1-stevensd@google.com>
References: <20240229025759.1187910-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

hva_to_pfn() includes a check that KVM isn't trying to do an async page
fault in a situation where it can't sleep. Downgrade this check from a
BUG_ON() to a WARN_ON_ONCE(), since DoS'ing the guest (at worst) is
better than bringing down the host.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c5e4bf7c48f9..6f37d56fb2fc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2979,7 +2979,7 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
 	int npages, r;
 
 	/* we can do it either atomically or asynchronously, not both */
-	BUG_ON(atomic && async);
+	WARN_ON_ONCE(atomic && async);
 
 	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
 		return pfn;
-- 
2.44.0.rc1.240.g4c46232300-goog


