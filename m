Return-Path: <linux-kernel+bounces-47342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A25844D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D32BB36049
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080C47F59;
	Wed, 31 Jan 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKopBDI5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADA47A55
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742553; cv=none; b=qVl3yj82Y8lS1d0SrXP/aPTanDcqVZ2D+pgjOKnCq/yx9L8akHGXArfr9Z7yHCsf2iKE2djD0cIuLwtlEQswThF0fAHelCiccrlguifQZr3+qFus+qeffWLVTaKa1lWlr2zrh5i1YrU2/ArllUD/ktOj/DY0DaUyMsJp6wMElQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742553; c=relaxed/simple;
	bh=AITC0g6KpE00MHHi4gqzkoS6GaRfFWD8G+vwLdrjOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqtKTAOwaFdWEh3Eh/rR4C6NRgKbCe0U9dICRNzVGbT6SbM/ZKQzabnzdBOhRQk7DxUp8rz9hlOTz6A08lNsRGbN8bKWL6WwPiSAs4w5z1RVJzw8e4rzaXqnjuqVLX/vArK5w31q8VdvRbdKTh/XgECId14lh5rQOtdIOqTnM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKopBDI5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706742550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tcUd6aqQBTGujreDUlh09+Wd/lkDDTLdTqmcFaCI+4=;
	b=CKopBDI5X/zXFBzQsOiazKhh1+vPFMTEDXmkL/FzaplWVVDTL66FVjCQvwtyKbS500tZtt
	fZSZcVHDnfICupYD5r/Mj0RXDh70MXpHdjk2i0/7SB6UBZz0YanPVIBUVxkcm27v7b5UfL
	3NVapYn6xs4rNx/Xsx7wCtmMf893ruY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-oPTCD6TwMMK2Lt-cLSZfbQ-1; Wed, 31 Jan 2024 18:09:09 -0500
X-MC-Unique: oPTCD6TwMMK2Lt-cLSZfbQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b04ad091eso100064f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706742547; x=1707347347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tcUd6aqQBTGujreDUlh09+Wd/lkDDTLdTqmcFaCI+4=;
        b=tKVzBcB0/qMCY5E4AAM7k6dQ/NAIf55OAMyoZSuTthBqPFvp4WETfjLL4HWnvrvfYW
         7DLZuY0wimHb3Ys5bGBKGlFdlKHqTGKh2eolljJBKnYeLfNV9xwaX19sXhsjiZLCUodQ
         NQpXvsc2veCncOIsyDGcwHaVreuSOHhmDjBejfPfKhGNcOq2mCyoT9N+3Az0kIqVCBY9
         YkdXRYr7YEsiKD+iA/KY6E8txLeE3a+TyFkxW1tlMp0vLUqjO/0QsGkVYiz78j8USQ8+
         +3pOOt7VgPIPZV+fYGmricBne3KIPjDkfsOOKAyO12a7hfIqGsDXeBaTKjMED/V6Tx7r
         PNkw==
X-Gm-Message-State: AOJu0YznS8SSvYnHR2i8Qc/cRUddkDhOGUbaNps90PEwKssxA3rIGalT
	fU1OFmOCbw3+oo+lgQR87ehlnlO1ZpQsfEFfXMJKSa773ZG+aGgA3awmW4K/P+RYDyxsL3DCvPQ
	fhHxzp73lskN7E3wBez3ecBM7QmGZv55GcvS9xPwTkwpVbGUmV2OG2YtBMtdwwwRn/TzdG8FoNv
	tv3eVXbJASqRRzquVdSfon9zsih2OyfXkk+In5Qc39QEgJCIAp
X-Received: by 2002:adf:e2c5:0:b0:33a:fe3b:b2ae with SMTP id d5-20020adfe2c5000000b0033afe3bb2aemr1897580wrj.66.1706742547340;
        Wed, 31 Jan 2024 15:09:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAzHcFMYzZ1Fjt1TKLWmURRBot7v+72esHPyNaiZPiNsBBgagAdfrkSX8NfQy6730BbzqiyA==
X-Received: by 2002:adf:e2c5:0:b0:33a:fe3b:b2ae with SMTP id d5-20020adfe2c5000000b0033afe3bb2aemr1897565wrj.66.1706742547097;
        Wed, 31 Jan 2024 15:09:07 -0800 (PST)
Received: from [10.10.0.32] ([213.214.41.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b0033afe816977sm3900965wru.66.2024.01.31.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 15:09:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Zixi Chen <zixchen@redhat.com>,
	Adam Dunlap <acdunlap@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] x86/cpu: allow reducing x86_phys_bits during early_identify_cpu()
Date: Thu,  1 Feb 2024 00:09:01 +0100
Message-ID: <20240131230902.1867092-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131230902.1867092-1-pbonzini@redhat.com>
References: <20240131230902.1867092-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct
value straight away, instead of a two-phase approach"), the initialization
of c->x86_phys_bits was moved after this_cpu->c_early_init(c).  This is
incorrect because early_init_amd() expected to be able to reduce the
value according to the contents of CPUID leaf 0x8000001f.

Fortunately, the bug was negated by init_amd()'s call to early_init_amd(),
which does reduce x86_phys_bits in the end.  However, this is very
late in the boot process and, most notably, the wrong value is used for
x86_phys_bits when setting up MTRRs.

To fix this, call get_cpu_address_sizes() as soon as X86_FEATURE_CPUID is
set/cleared, and c->extended_cpuid_level is retrieved.

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
Cc: Adam Dunlap <acdunlap@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcde70c6..fbc4e60d027c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1589,6 +1589,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
+		get_cpu_address_sizes(c);
 		cpu_parse_early_param();
 
 		if (this_cpu->c_early_init)
@@ -1601,10 +1602,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 			this_cpu->c_bsp_init(c);
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
+		get_cpu_address_sizes(c);
 	}
 
-	get_cpu_address_sizes(c);
-
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
 	cpu_set_bug_bits(c);
-- 
2.43.0


