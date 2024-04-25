Return-Path: <linux-kernel+bounces-158360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E508B1EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2B3282819
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA786658;
	Thu, 25 Apr 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA4n1fT9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFF128835
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039507; cv=none; b=bSC1wVUx1sohtm549L9idbiYm4tR0NtNdQRFg9anz0reQkUdIEK3WD2OpcU0j4GGPoicGzCTVnrk9JGbOHut9p79JSTM3Ih08bvh3QLE7x9GQwJAPk0aVexdONtDeSHZNI/5JJQcriirTZfDAgkDtxceny2tmbEG/oCuZ51Ksu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039507; c=relaxed/simple;
	bh=Hkn63e39De+KrbUDiC4Z4XQ0/IcYP+DaMu0hP96eE7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGv3ssTWhJ6J8+JfYDPHZOxxZekam/RCaWALPk1KkkT0KA61Y/bPavnUh4OzbVa+8ht0wZPb9R7Gbd4P2c3DJ0GGbdfKS+jwrA8MPlO73mUTvGQul4HDQW8k6ftdauNXp04gtc1n5lUddXfDLMB7txv0ATTHhUa8gzPFc2Yg+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eA4n1fT9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Xe1JC3zOdrEKx3bfWos3eNZ27bBtqkJg+ds4Xh05xA=;
	b=eA4n1fT9TH8+QrFJ9KTrjxLRuTk05Qm5hHHnQ6Ra4TySsdqTNjImLmV0TJWaIu6MkLZVC2
	44L3HxURVnpH2M05xXZxNEfkAR8/UGTGbr/BD5FZQspt6mqK/nQylWkZRVxJvkMbt0Q6oT
	+0bjiB3MNClfAT/KKQ2iSIjWxiENuvo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589--CFCuM0bNQCZSUNuHWQseg-1; Thu, 25 Apr 2024 06:05:03 -0400
X-MC-Unique: -CFCuM0bNQCZSUNuHWQseg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ed25eb8e01so687446b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039502; x=1714644302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Xe1JC3zOdrEKx3bfWos3eNZ27bBtqkJg+ds4Xh05xA=;
        b=sqYa3I5mHeygbUXDlQQsYtB+FVHVpWGVNz5zNk2b8ipcGVOTWg/mMnv9mY71m86Xga
         DLq8173PS/hZXvcYxBG7qjPuU6wc94i955mxYH5Dldqbjn/P4Y/eLlY2MnU+eTaPCCnn
         GurN9tt1Y3E93VdYg7tkUAwuPMN2nu5gqSOXl870DuCbRrC9lwZ9TBgd4Li7k1doO5P8
         mnnN4HfUbnnl64nAxxzRGeS2cchSfA2nAA+x3Z+FCAjy430RqPkZS92od2xOAPlrNyjB
         w89CYUjVObP0nwXjeQm9vQIDzuNwy5+SolnZmTfb1vlyR3Lnm5PudpW6nm4J4gHKcj4/
         Amqg==
X-Forwarded-Encrypted: i=1; AJvYcCXee5XpnxI5Vc3Yy/gLPuWb6Yu2ZVR6muVfgjvmJ4dtjH8KopXzp0BE/72Q0y29P3i6B4UV5/RZIdLQUAEI7YqYQZ+gt7cjhqg5yLO6
X-Gm-Message-State: AOJu0YwL+knqmXGNBtCqlLHEpZOENxgPWoohrChVjjz714uDECm8YOcf
	UzxK1J7iHLX2/GOZcM0XvVcGFJ3odngYVOF2lyLjbyHz8MczSE+Bh4UMvePyi/kW8IHJMbrMdIa
	/z3RtiHSYHXOAgUtj2oq8jx/zSQusTtlaPYQrPwI9slZ52iW0JjFGdKV5O7Xvlw==
X-Received: by 2002:a05:6a00:2d87:b0:6ed:60a4:6d9c with SMTP id fb7-20020a056a002d8700b006ed60a46d9cmr6295351pfb.4.1714039501844;
        Thu, 25 Apr 2024 03:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlZH/ckE52CwcRJf2H+llCxl7yd6By1lfHpxqvpexbrw9hs0sai3i4uDCf98L8TPTdXJ+Vcw==
X-Received: by 2002:a05:6a00:2d87:b0:6ed:60a4:6d9c with SMTP id fb7-20020a056a002d8700b006ed60a46d9cmr6295321pfb.4.1714039501295;
        Thu, 25 Apr 2024 03:05:01 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id go20-20020a056a003b1400b006e6233563cesm12775607pfb.218.2024.04.25.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:05:00 -0700 (PDT)
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
Subject: [PATCH v3 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Thu, 25 Apr 2024 18:04:31 +0800
Message-ID: <20240425100434.198925-8-coxu@redhat.com>
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

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..fc0a80f4254e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+static void kexec_mark_dm_crypt_keys(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_keys_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			__set_memory_prot(
+				(unsigned long)phys_to_virt(start_paddr),
+				nr_pages,
+				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_keys(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
+	kexec_mark_dm_crypt_keys(false);
 	kexec_mark_crashkres(false);
 }
 #endif
-- 
2.44.0


