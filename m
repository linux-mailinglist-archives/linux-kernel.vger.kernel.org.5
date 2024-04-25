Return-Path: <linux-kernel+bounces-158359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319348B1EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E96283EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55E9128820;
	Thu, 25 Apr 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNtEPkRP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570F128804
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039504; cv=none; b=qv/1LUvvxxTgEzJ9NE9Hc9Flr4dubf7XXxCV0nWz5nyylVnox5V7vDxMF2nyRKqgA83etMro2dDPbwCKQH9OVgfI0SI7Waes6cFmV8XrDJZKyrGnDHnx8x6IAG/M0H0wN5Uf3Eji3wRxIaLHf0EPVCYfFklG2wM536+H7ZGTqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039504; c=relaxed/simple;
	bh=WwCFGkuEUhfYpOXGOtlQ0bc+aePAZJhfQPq/y/fFe+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3c25SdbyC+ueYNZcgPLB6zqSWNFVfBy8RwqR8LOZA5o8iJG7yx+TVG8DFoVooIKf4HhmJnmjGPHFL5hki90TPRKHfJ49KPLI4g7b+J3H4ZTfCZUCwr6Hm9CdQyvFi19K8XO3CmthXDTyC9U115L6IR7xjBBYSQj6mdCrZSFXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNtEPkRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqT75ILAb+wFvlIguVkiSmYBoQIWQKOiZ3Xjg0k4Etc=;
	b=JNtEPkRPNEw5irNYq+Ch112LoJd7dwmCiaNf5ptsF+FpQUR8MEzrhmbrmOm2zK1R5ukFye
	BCIcyzwdOmfuqAWvd46Mbxb7IqW+yoyRxx6TzUMqTElRIi6f8ls1L+SuMC6NV8kNIqCBPY
	HIqWDd3Rxnsou/DeKUwqfSXRnHh0pv8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-yxb7iLx5MuG_zMVM2rlU4g-1; Thu, 25 Apr 2024 06:05:00 -0400
X-MC-Unique: yxb7iLx5MuG_zMVM2rlU4g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a537ab9d7eso940995a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039498; x=1714644298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqT75ILAb+wFvlIguVkiSmYBoQIWQKOiZ3Xjg0k4Etc=;
        b=RFcKm8v7dTqg+8SXfOX8XcKzIvhN4UV3+alo3+scRrG06B1seJdposaa5GpY+VC9ZN
         GZwUnXQSSaErv7MCZMQgwICDHrgIRI2G2nIW7qjh49ehZfQ9XcW1kBdhAHsEjka6sxV/
         F/hZmSofl6wU3vn4X+QalGO8lzmUhuwVU8+0iT9ORzyqm7C+8q0FM2Cw6YFpVEN3yYlJ
         OS/cjwRxqATNveO/jKByKaIxuMcewK6tFLXO9cWucVxQRj/wH1IX3M0qrzimSmZwYtrM
         nGcVYPhsRjQowHZZuGIXC4Fd5tRX2Vm6FsgDEtnFF2Enew3v/lODATVtcP+7dwLkEuv6
         WLkg==
X-Forwarded-Encrypted: i=1; AJvYcCVALvQp3O8MzSem54grB3kFg/p99nDFhXNO1wDsF3LLE+5m96MnHerWBdcW+E84kSZ9tg8/ETXffSG2eRwUXwrDltliQs30tkz8I09h
X-Gm-Message-State: AOJu0YzF1lJwcODAhnpp+BofkbVX2dim5anlgI4nwFoMyIB+xUo6kiVJ
	6xn0ScB5xEHXSwlELbODQOoz53KzB+LOs1i80mRNBLBNHNguh8+HAcAKbNLiGUj4x6EmpEKU82b
	73b0W0YdNK2wO/NG/kHXSRYVq+k87JceJ4+5Xepj8CNV2IApiJc3JRHr+L/iZFbeQApQzc7dAqx
	gb4Q==
X-Received: by 2002:a17:90b:33ce:b0:2a0:215f:dc9c with SMTP id lk14-20020a17090b33ce00b002a0215fdc9cmr5203413pjb.35.1714039498204;
        Thu, 25 Apr 2024 03:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkerGAZtBVpYNpabl6fa4ODw4MLi/9vUZ8BidoUeAUkdpOcdSRlbDJ6GDMr9WbPTTtyP66jA==
X-Received: by 2002:a17:90b:33ce:b0:2a0:215f:dc9c with SMTP id lk14-20020a17090b33ce00b002a0215fdc9cmr5203372pjb.35.1714039497570;
        Thu, 25 Apr 2024 03:04:57 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cn19-20020a17090af09300b002a2b06ce909sm14227786pjb.17.2024.04.25.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:56 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 6/7] x86/crash: pass dm crypt keys to kdump kernel
Date: Thu, 25 Apr 2024 18:04:30 +0800
Message-ID: <20240425100434.198925-7-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1st kernel will build up the kernel command parameter dmcryptkeys as
similar to elfcorehdr to pass the memory address of the stored info of
dm crypt key to kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/crash.c           | 15 ++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e74d0c4286c1..d852f9c99f0e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -266,6 +266,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
+	int r;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
@@ -274,7 +275,19 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	/* Exclude elf header region */
 	start = image->elf_load_addr;
 	end = start + image->elf_headers_sz - 1;
-	return crash_exclude_mem_range(cmem, start, end);
+	r = crash_exclude_mem_range(cmem, start, end);
+
+	if (r)
+		return r;
+
+	/* Exclude dm crypt keys region */
+	if (image->dm_crypt_keys_addr) {
+		start = image->dm_crypt_keys_addr;
+		end = start + image->dm_crypt_keys_sz - 1;
+		return crash_exclude_mem_range(cmem, start, end);
+	}
+
+	return r;
 }
 
 /* Prepare memory map for crash dump kernel */
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f7..9c94428927bd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
+
+		if (image->dm_crypt_keys_addr != 0)
+			len += sprintf(cmdline_ptr + len,
+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
@@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		ret = crash_load_segments(image);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = crash_load_dm_crypt_keys(image);
+		if (ret)
+			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
 	}
 #endif
 
-- 
2.44.0


