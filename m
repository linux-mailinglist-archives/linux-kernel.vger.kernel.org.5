Return-Path: <linux-kernel+bounces-158357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D078B1EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BB228782F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B81127B60;
	Thu, 25 Apr 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlVXKWZ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20E8627A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039497; cv=none; b=n0vyDE72rzuGSzZKlKA5fzaqFUq9SzqEEpPQR1dcAn+s4yFCPr2oliCbeRQxlYP+VwZc5y8al+5ZZ4qDHtgTksc9J/2McC8QwNeSzVXPYSUTJ+hhMRDnjCdb4aPe7OrYK1fwP49UDG1E3u2zPoLGBcQHAObnQ6Fm+V0sRzKNTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039497; c=relaxed/simple;
	bh=jiH4fu8/d34YSy0cFMMAzSQZSVdjtoDG5y3BIOP84IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOu1II0WcJsP+B4gKc0xISvEwt4lqGA8WTkg7/BAEquPJhzFPOlLQ3Uc+gG8OrdYhHuvI6TchaQIyyusR3r7Dhzi1hLIw1jS2MeZImQmDKYKAe5Xh34/RtFwKwijro7+FhM3uzQAdsgjijfCtBU1/XDPohKswEvO6hbz09moBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlVXKWZ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLflBXNszRtBuRpxO//dVzBazjZLk2Gj5DkRzwtS+Dk=;
	b=MlVXKWZ0A5uttu+oUk1nhmo6aTn7SCs3uU9EF+t12BaeLqrlRteqlTku6GiL1iSjauoMnK
	jPnATQvLtt10mjqfPIUawfM5eKIj7em0ezi7SJT6P3Yr0D4W7BzM1HlZEBL3hw5jT8OEmS
	2+FW2uCMultokFXuBgTxxiH6rKnHJsg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-a74Ll2uBOLmqtkbugER6xA-1; Thu, 25 Apr 2024 06:04:54 -0400
X-MC-Unique: a74Ll2uBOLmqtkbugER6xA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e8fc91661fso9157835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039492; x=1714644292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLflBXNszRtBuRpxO//dVzBazjZLk2Gj5DkRzwtS+Dk=;
        b=MFWtJkRvQ2Qou1WUy9Xkq0X3x+dwAjVqjp7i6XmBl7s1e7ir5OrQ9F6TPG7gyquaH2
         jGJEXGba5nS86nG0MwYTf0F9D9U6UiJkxNaTD40WE0+GbUPoxdq8G06ewsqLj6of2lbM
         QYTgmsWSRtkEg8rLqgYujE7HRenh5np3w+jZyI/ks1UAsZ2nX6ttTNzBtPNkMcxZZpDC
         E7RxXSxhrlbu8jND+YHE909hTyfpQDlTjMnwzplTdysulyo1VbaWc790OP2SdxhpWxb8
         /TmcaSP0bx7pXgpgyhKjlaosf2MYVyVX7jpMek+ygv/S8Z6ePtXvIBLko7+ZhZ/K/yDa
         nPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4wzb/G3Qux5aFjKYjf/7lq042NkFafhX9x3JY/6C/GgilPcpB2u+sb1olLWEJPBUokKVMZ0gwnKOfnl8xU2Ba2mqDqvb2dzxpu1RB
X-Gm-Message-State: AOJu0YyCKC14/GSGhtg3ln92zRZgBYW4LsR/az4Rr43m1XUNgRSdBdkj
	kGsVa46glY/tfd5aPqVWWPNRuc6m7LO1vKs52WpTyJW/OM0wfLQREpPzK1KfD8gpR0vzpw2LZoT
	QVifJi4ZYKJqi3GWd8X0Md4/e4yfczZrSIdvVBg3YU+8ur6CNWJIvHUK3Ejb58g==
X-Received: by 2002:a17:903:2288:b0:1e4:49:de46 with SMTP id b8-20020a170903228800b001e40049de46mr6875486plh.47.1714039491569;
        Thu, 25 Apr 2024 03:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZFjoqzqm/eHvCHGiqfc9ChhdN+leiDzn4HzL+638L4OQVPvBwwbFi4eWPAqIrNcCbrUhKgA==
X-Received: by 2002:a17:903:2288:b0:1e4:49:de46 with SMTP id b8-20020a170903228800b001e40049de46mr6875447plh.47.1714039490967;
        Thu, 25 Apr 2024 03:04:50 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kp7-20020a170903280700b001e99fdbc515sm7461086plb.3.2024.04.25.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:50 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v3 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Thu, 25 Apr 2024 18:04:28 +0800
Message-ID: <20240425100434.198925-5-coxu@redhat.com>
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

When there is CPU/memory hot-plugging, the kdump kernel image and initrd
will be reloaded. The user space can write the "reuse" command to
/sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.

Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support")) and ppc (WIP) supports the new infrastructure
(commit 247262756121 ("crash: add generic infrastructure for crash
hotplug support")). If the new infrastructure get extended to all arches,
this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index b9997fb53351..6ac1fabdb6cb 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -10,12 +10,13 @@
 // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
 #define KEY_DESC_LEN 48
 
-static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
 enum STATE_ENUM {
 	FRESH = 0,
 	INITIALIZED,
 	RECORDED,
 	LOADED,
+	REUSE,
 } state;
 
 static unsigned int key_count;
@@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
 	return 0;
 }
 
+static void get_keys_from_kdump_reserved_memory(void)
+{
+	struct keys_header *keys_header_loaded;
+
+	arch_kexec_unprotect_crashkres();
+
+	keys_header_loaded = kmap_local_page(pfn_to_page(
+		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
+
+	memcpy(keys_header, keys_header_loaded, keys_header_size);
+	kunmap_local(keys_header_loaded);
+	state = RECORDED;
+}
+
 static int process_cmd(const char *buf, size_t count)
 {
 	if (strncmp(buf, "init ", 5) == 0)
 		return init(buf);
 	else if (strncmp(buf, "record ", 7) == 0)
 		return record_key_desc(buf, &keys_header->keys[key_count]);
+	else if (!strcmp(buf, "reuse")) {
+		state = REUSE;
+		get_keys_from_kdump_reserved_memory();
+		return 0;
+	}
 
 	return -EINVAL;
 }
@@ -175,9 +195,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	}
 
 	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (state != REUSE) {
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = keys_header_size;
-- 
2.44.0


