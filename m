Return-Path: <linux-kernel+bounces-158356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB418B1EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB72282D63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331486641;
	Thu, 25 Apr 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSJ9utcd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91D127B60
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039494; cv=none; b=PiJZLeSkFiITL6sNDj39qMwK92zIj5Z05dmAFubVXWS6Nvz78UG/CCHGDyyQDksyDmBEUP5gJjHA1iVC1zbJAUh1dUurt63F377NU625oMp6OP1AXRi+tZNhus8g4PemeATAhl0nq1yk/2b9oiOff/CpCjDN7tAZLb6+BZIHCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039494; c=relaxed/simple;
	bh=E3vPo8rJPlRUqYbxvgoITxG9JVj+FDFh4EQqeMNQYVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REqjBVH+DwIhcK5VYtvL7BjBAbG2uL52QrWWkfSOIxZJsJuxHY4XM/7q0xYye4qcGpUcGb7wu3AHeuhPhc9i/i9PXg/FLkvwoOXsridXUe6tK6BHKIbS36RJAlhVtov73fsmESaQ+kV4vc38deNie7HjWMLZcswSSnAyy66pvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSJ9utcd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSAzgqiOHIuKA09Cs5shkE69JGVMkIODKj0EL1ZNyW4=;
	b=WSJ9utcdzL4FnlkZyKkutNhN3HEBS6z+nlt1Ppqo4l/sUJvGiX/UNChnVVvUJwTQvPN/xN
	xHvQmq5pcRNMEzOlIZ1CdiS/YFTFF4aMnq4umyayLNZ43iLfYo3ei1z4Pox6+hsWyg/T9P
	5YVX9s8pPkKNPccFNtRNpTV93cH7CNk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Kjp_WYYiP3ivxSm2rmT7ew-1; Thu, 25 Apr 2024 06:04:49 -0400
X-MC-Unique: Kjp_WYYiP3ivxSm2rmT7ew-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c2ff79144so2494905ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039489; x=1714644289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSAzgqiOHIuKA09Cs5shkE69JGVMkIODKj0EL1ZNyW4=;
        b=JwBUVKqf7bXRx+DYdMF02lag2rn1l9DHBaHKt8zoeeY8YmHvgUJGOnxBr2hM6dN7JT
         +8kSMnwSPoVeJz/eoyXNAxgYrxrTS0v6USJGeRUUi7iJ5H3I5V6INVaDjKCK4eePK2j6
         uhhIQtB8zfkqErg4tzkktSh1/JhWicDeOUSFYJZ4+Js4YHPmyRAK2hsPVHT6YqTqWBsA
         sRw0lVoPQmE6dVjuTBno7pJsYfK5WRc71h5mieQIQJzfkfgj2pxKRRQIfCl0w5LSGCop
         Z+RjEmWikPM2YlQNnze0gHAiUED3ytdI/yZtCFkWFQhOZsaYTceb1Dt28nyKf/+PkUm5
         Engg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6Q9de5/itr3pD84DbquDJKsk3Da78C1ZMaeXqqWWYBWrqj5a7jqNHQyYWPRQP7Lb2hwg3tnjG0UP4BNVv3wRx+QXvZ0doLOu+qid
X-Gm-Message-State: AOJu0Yzi/E/52IG6Q+BzSShWY+zIzUDZIUroZoQOpqSxwSHSg6hdgTVo
	vg9TQGOo0bHSlvFupfimSs7ub0JIlvS/1jx681hToPqS3GQCxWtBxBhjqcWfouo+TPsrGy78Kvm
	eBkBIS7Hph22PLJVrLspycIgnyLklvrGFw3WAUarIQt9/mJOq1bJ+drCw17i0ig==
X-Received: by 2002:a05:6e02:1745:b0:36a:2934:a8e5 with SMTP id y5-20020a056e02174500b0036a2934a8e5mr5635760ill.9.1714039488429;
        Thu, 25 Apr 2024 03:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoMQilVk8BI7H+0dXhYwX2dauRoxQgUM6e36ENJnKqLls92oinsXqpyWO930vlNvqn3rst5Q==
X-Received: by 2002:a05:6e02:1745:b0:36a:2934:a8e5 with SMTP id y5-20020a056e02174500b0036a2934a8e5mr5635712ill.9.1714039487818;
        Thu, 25 Apr 2024 03:04:47 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v28-20020a63481c000000b005f7536fbebfsm12282033pga.11.2024.04.25.03.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:47 -0700 (PDT)
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
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v3 3/7] crash_dump: store dm keys in kdump reserved memory
Date: Thu, 25 Apr 2024 18:04:27 +0800
Message-ID: <20240425100434.198925-4-coxu@redhat.com>
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

When the kdump kernel image and initrd are loaded, the dm crypts keys
will be read from keyring and then stored in kdump reserved memory.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |  3 ++
 include/linux/crash_dump.h   |  2 +
 include/linux/kexec.h        |  4 ++
 kernel/crash_dump_dm_crypt.c | 87 ++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 98825b7e0ea6..1f3d5a4fa6c1 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -37,6 +37,9 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 #ifdef CONFIG_CRASH_DM_CRYPT
 int crash_sysfs_dm_crypt_keys_read(char *buf);
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
+int crash_load_dm_crypt_keys(struct kimage *image);
+#else
+static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..dfd8e4fe6129 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long dm_crypt_keys_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index fc1e20d565d5..b6cedce66828 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -368,6 +368,10 @@ struct kimage {
 	void *elf_headers;
 	unsigned long elf_headers_sz;
 	unsigned long elf_load_addr;
+
+	/* dm crypt keys buffer */
+	unsigned long dm_crypt_keys_addr;
+	unsigned long dm_crypt_keys_sz;
 };
 
 /* kexec interface functions */
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 847499cdcd42..b9997fb53351 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/key.h>
+#include <linux/keyctl.h>
 #include <keys/user-type.h>
 #include <linux/crash_dump.h>
 
@@ -111,3 +113,88 @@ int crash_sysfs_dm_crypt_keys_read(char *buf)
 	return sprintf(buf, "%s\n", STATE_STR[state]);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
+
+static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+	pr_debug("Requesting key %s", dm_key->key_desc);
+	key = request_key(&key_type_logon, dm_key->key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_warn("No such key %s\n", dm_key->key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	memcpy(dm_key->data, ukp->data, ukp->datalen);
+	dm_key->key_size = ukp->datalen;
+	pr_debug("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
+		 dm_key->key_desc, dm_key->data);
+	return 0;
+}
+
+static int build_keys_header(void)
+{
+	int i, r;
+
+	for (i = 0; i < key_count; i++) {
+		r = read_key_from_user_keying(&keys_header->keys[i]);
+		if (r != 0) {
+			pr_err("Failed to read key %s\n", keys_header->keys[i].key_desc);
+			return r;
+		}
+	}
+
+	return 0;
+}
+
+int crash_load_dm_crypt_keys(struct kimage *image)
+{
+	struct kexec_buf kbuf = {
+		.image = image,
+		.buf_min = 0,
+		.buf_max = ULONG_MAX,
+		.top_down = false,
+		.random = true,
+	};
+
+	int r;
+
+	if (state == FRESH)
+		return 0;
+
+	if (key_count != keys_header->key_count) {
+		pr_err("Only record %u keys (%u in total)\n", key_count,
+		       keys_header->key_count);
+		return -EINVAL;
+	}
+
+	image->dm_crypt_keys_addr = 0;
+	r = build_keys_header();
+	if (r)
+		return r;
+
+	kbuf.buffer = keys_header;
+	kbuf.bufsz = keys_header_size;
+
+	kbuf.memsz = kbuf.bufsz;
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	r = kexec_add_buffer(&kbuf);
+	if (r) {
+		vfree((void *)kbuf.buffer);
+		return r;
+	}
+	state = LOADED;
+	image->dm_crypt_keys_addr = kbuf.mem;
+	image->dm_crypt_keys_sz = kbuf.bufsz;
+	pr_debug("Loaded dm crypt keys at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		 image->dm_crypt_keys_addr, kbuf.bufsz, kbuf.bufsz);
+
+	return r;
+}
-- 
2.44.0


