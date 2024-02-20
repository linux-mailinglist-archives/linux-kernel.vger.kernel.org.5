Return-Path: <linux-kernel+bounces-73812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE285CBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867371F23094
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933E154C01;
	Tue, 20 Feb 2024 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQLaX7vl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5813667B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471077; cv=none; b=Z1tbDA/ev1FR5hxtDh/VNMZeOst5o4gOVTXJk/gxz5iBQHm3dY1oR46ktQGThDwMBZUF+5gNC3/RlzTlBt4o54LuDjsRWue4g5DstWRXx7WbIZAo4oeXze8k/Y4gfQ/cb8hqmC+PSMu3vWGENNblTgPD3Y9nVKy9gjITwUmG3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471077; c=relaxed/simple;
	bh=yqsbw6iQdZTVB2cYQu2elIu0K2UeUBgcZazLloZTOHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7IROXxa45S5Gfl+mMb38vWEC6nXdyMuyelRdkKOYmJclpi1iSr1mG59TteiTgbnLbvmua+8a9RU60iqH40D7Gt+aO1HokebPOeT5Zdj34E6Tk1hc85pC5Qg6BgPkyWlSFhh5QVRyxV/2BuP3Z+KR8LF6hS3eTIcmf2W5YqcKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQLaX7vl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso3045810b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471076; x=1709075876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBH3LTjaBMSoYxUwPuTSep1EAb5H3OicE1Nmx6szstY=;
        b=mQLaX7vlg2cyb+ishtPrBoSFpqrI2WwABZ8omrC5LJya8fwbfPtMou4MGa9s++ksHn
         PoCuDEE1ffL5DKxDDzGq/4eaTqznhldh8CckBrs0Xx8vnO6/LM74SSqO+piqULGD3PRW
         o+DiP+0lENwhzYq08Qqru3svzF9vZJcP2BU8D47Ww0c1VO5UnXPu1OXP2Tz1FC4VRgUX
         jQHQxVJ8JuZWpsCo92xE8vjWvHRh9LiUyteK/tR5I63CK3GobVgxiEJ+sCtCHb6SEFEw
         b9/F6GZKqiTUHAsOGTcugi/pLbAn1mWvp/qdEJ11l26lOtEtKpPfPIqydOX7HBAX0fG+
         rwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471076; x=1709075876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBH3LTjaBMSoYxUwPuTSep1EAb5H3OicE1Nmx6szstY=;
        b=CLglZ9eeYuI/Jx/GsDalFcGMNdCUu1Vea+FQVPC7myfS4jDijn5UI8gZEM5QwKTjmG
         zrsYxVj8RVYXFli6sgnae9kS+kLVTYo9/4mR9IfylroKykBu9gYiIGYR4B+VInWZtwF7
         gZuknv+Ash4ua/J+cOxjsy2gVA723WZ00mYRlqWGZZ4Qjwy5UDO21q8uSVnWzWTNR/H2
         w5Vs/E1HBf9iOqjpd3eqe5tg0dpNtIgrH8gl77WhrZ5Za2uBF7XjzOrER7gjvcxOo1S4
         8hS9fVHYLdFTX5aO/o25I0m4ILuDbdlpXBYagOXyI1A67dFGIHYEFogz/ZnsikxiwlGH
         Sp0g==
X-Gm-Message-State: AOJu0Yzx/z0o7F4FgkfbXi516MQfv8EBjYseUja9EX//G7F/YS0WNfLI
	btMIVdGXFHYVj7OL7nYpXh+9zCb4/HVkI/Rg47NmQn2tuWxwF627
X-Google-Smtp-Source: AGHT+IFeVa9iBxvsSpbEiIeYAtJicngo1Z4fESwQ2XBwkVGNXaE9jzVuGxav+9PKFoCevZ1IULDQ/Q==
X-Received: by 2002:a62:c312:0:b0:6e1:338d:e01c with SMTP id v18-20020a62c312000000b006e1338de01cmr13801818pfg.1.1708471075876;
        Tue, 20 Feb 2024 15:17:55 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id x16-20020aa784d0000000b006e13a5ab1e5sm5317803pfn.73.2024.02.20.15.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:17:55 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/3] mm/memory: Change vmf_anon_prepare() to be non-static
Date: Tue, 20 Feb 2024 15:14:22 -0800
Message-ID: <20240220231424.126600-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231424.126600-1-vishal.moola@gmail.com>
References: <20240220231424.126600-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to handle hugetlb faults under the VMA lock, hugetlb can use
vmf_anon_prepare() to ensure we can safely prepare an anon_vma. Change
it to be a non-static function so it can be used within hugetlb as well.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/hugetlb.h | 1 +
 mm/memory.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..9b45edb6e303 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -272,6 +272,7 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
 int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
 void hugetlb_vma_lock_release(struct kref *kref);
+vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
diff --git a/mm/memory.c b/mm/memory.c
index 89bcae0b224d..c93b058adfb2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3081,7 +3081,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 	return VM_FAULT_RETRY;
 }
 
-static vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-- 
2.43.0


