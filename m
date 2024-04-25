Return-Path: <linux-kernel+bounces-158355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA18B1EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F40B272F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D2127B4B;
	Thu, 25 Apr 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h27tuwEA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AC1272AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039490; cv=none; b=pKnXOcLixAHvGYEPjeNmd/UGuULRprxFcAkAVjXZEkJ1NYbbCh2OqbCKJfrE/AYoTa4LKPFI51ImJPu+J52CYVlgUNlBHkp5oEfe9CjAb18mJAJUgUDy5qr/q5tvbeADhrmXK0jmRtFnLhMNqaWYCe0RphYoGOdwhKyTYWWL0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039490; c=relaxed/simple;
	bh=mIDQVZmFbIOBvbRSr2aBeVxgZJBoH7unnRDUUvfDlxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeM2CulJ7IjbBZokYZi1x1FJ+/6GVcJXHW1caWLuMCX6aDrTm/SMJLPxOrNvQ6H6Rr7hbegCoedhor9nYtPglS/7NmBA9/eBLYVXKgnKJ6q4baefs/3+iwWOaQA5h6izliYkKmhMxGBBXXJWjPzQXH7E8UAq5OS9yH2uXoage4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h27tuwEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1WvQVElEBbzuyapN0iJk9xUP1lV1tjo8L1zhcJQztk=;
	b=h27tuwEArr6AE6j3nhOXWvsk+Q0DD/m/Sm5+eyo1r3LODi2iCOpCHf5bSSvcXLiz3FiHPh
	w0f9l3Ga6ZoQS+04+SBlXCAYC8mNO36F/TQDgB9AgGpN5Xo15K0rj8GvE15Bl0UumoGOd8
	AXH8ZNOym1Q9WNCy5Eqpm3Svp5nnZtY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-L9Q3fzJuODCO6ytypwpqog-1; Thu, 25 Apr 2024 06:04:46 -0400
X-MC-Unique: L9Q3fzJuODCO6ytypwpqog-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e2c1ce5d14so10401525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039485; x=1714644285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1WvQVElEBbzuyapN0iJk9xUP1lV1tjo8L1zhcJQztk=;
        b=u1vKAumkWEEqXLFFH0m7L63DtClg49uNBDjfMx67bEblrmfHfk0l7TghQYRJq8xkoa
         7AywdYCMxKzvnEnXHDLouvqPrswAof5/wE1PpSwuyw1eaTWrnW/R0u5fMXVJglm+MMUv
         ENfG1qqQvxBoBqmk86nvWLUtEmNuCCtEUU19PRnXtcHd0kOKB8dqF98r2P9QjJW7BdNw
         KnDEO2aOjApsFJqdvLn7RyFC/8OfuDODu6q2FehHTRcEmIhj7FlzQeQBd0UzEfUj/EzW
         IRUoerqiB2jNRL4L1RMiZTpP/cElH/LXoXRA2cxUjKiRECdOgeVSXMlk8gaMQ20gD0Ip
         rasQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPF0MapawEtkRD2K0N+BmuM1HnGiUcsD7kBjhp8mD3MNfEFYUHcK6cWgl+8x252kh3UpIEOEJ1yurhKk2wUr78qMavEVTHphQEXUoe
X-Gm-Message-State: AOJu0YwuGQnlqXLzrwSGX56J9jORPeulBUeiHSwAmtxyYaABqICYF7jR
	mjr4qOM7g1t7DtE1mZKvJafmv1+fTKRCozU+4nIBaQIeTi7mZBVcsGi/dIes3zA+MSbRY2QU8KX
	BzxJt+ltmxsahn2fMSLazkBlWHRGYWz5qIEdrLGMJwcGZK2Dr1vY3QdezR2uALg==
X-Received: by 2002:a17:903:32c6:b0:1e4:dcfe:848f with SMTP id i6-20020a17090332c600b001e4dcfe848fmr6586828plr.16.1714039484810;
        Thu, 25 Apr 2024 03:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6pO2drBoU+AkObmupaAop6L5yQaI22V7bV87rZpQugB2zH3HfS0+Y89xAPgCuV9dfoJZNjw==
X-Received: by 2002:a17:903:32c6:b0:1e4:dcfe:848f with SMTP id i6-20020a17090332c600b001e4dcfe848fmr6586754plr.16.1714039483991;
        Thu, 25 Apr 2024 03:04:43 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001e107222eb5sm13626951plk.191.2024.04.25.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:43 -0700 (PDT)
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
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by\b)
Subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
Date: Thu, 25 Apr 2024 18:04:26 +0800
Message-ID: <20240425100434.198925-3-coxu@redhat.com>
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

A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
the dm crypt keys persist for the kdump kernel. User space can send the
following commands,
- "init KEY_NUM"
  Initialize needed structures
- "record KEY_DESC"
  Record a key description. The key must be a logon key.

User space can also read this API to learn about current state.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |   5 +-
 kernel/Kconfig.kexec         |   8 +++
 kernel/Makefile              |   1 +
 kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c              |  22 +++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d33352c2e386..98825b7e0ea6 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
-
+#ifdef CONFIG_CRASH_DM_CRYPT
+int crash_sysfs_dm_crypt_keys_read(char *buf);
+int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
+#endif
 
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 6c34e63c88ff..88525ad1c80a 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -116,6 +116,14 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 
+config CRASH_DM_CRYPT
+	bool "Support saving crash dump to dm-crypt encrypted volume"
+	depends on CRASH_DUMP
+	help
+	  With this option enabled, user space can intereact with
+	  /sys/kernel/crash_dm_crypt_keys to make the dm crypt keys
+	  persistent for the crash dump kernel.
+
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..f2e5b3e86d12 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_CRASH_DUMP) += crash_core.o
+obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
new file mode 100644
index 000000000000..847499cdcd42
--- /dev/null
+++ b/kernel/crash_dump_dm_crypt.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+#define KEY_NUM_MAX 128
+#define KEY_SIZE_MAX 256
+
+// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
+#define KEY_DESC_LEN 48
+
+static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
+enum STATE_ENUM {
+	FRESH = 0,
+	INITIALIZED,
+	RECORDED,
+	LOADED,
+} state;
+
+static unsigned int key_count;
+static size_t keys_header_size;
+
+struct dm_crypt_key {
+	unsigned int key_size;
+	char key_desc[KEY_DESC_LEN];
+	u8 data[KEY_SIZE_MAX];
+};
+
+struct keys_header {
+	unsigned int key_count;
+	struct dm_crypt_key keys[] __counted_by(key_count);
+} *keys_header;
+
+static size_t get_keys_header_size(struct keys_header *keys_header,
+				   size_t key_count)
+{
+	return struct_size(keys_header, keys, key_count);
+}
+
+static int init(const char *buf)
+{
+	unsigned int total_keys;
+	char dummy[5];
+
+	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
+		return -EINVAL;
+
+	if (key_count > KEY_NUM_MAX) {
+		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
+		       KEY_NUM_MAX);
+		return -EINVAL;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header, total_keys);
+	key_count = 0;
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	keys_header->key_count = total_keys;
+	state = INITIALIZED;
+	return 0;
+}
+
+static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
+{
+	char key_desc[KEY_DESC_LEN];
+	char dummy[7];
+
+	if (state != INITIALIZED)
+		pr_err("Please send the cmd 'init <KEY_NUM>' first\n");
+
+	if (sscanf(buf, "%6s %s", dummy, key_desc) != 2)
+		return -EINVAL;
+
+	if (key_count >= keys_header->key_count) {
+		pr_warn("Already have %u keys", key_count);
+		return -EINVAL;
+	}
+
+	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
+	pr_debug("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
+	key_count++;
+
+	if (key_count == keys_header->key_count)
+		state = RECORDED;
+
+	return 0;
+}
+
+static int process_cmd(const char *buf, size_t count)
+{
+	if (strncmp(buf, "init ", 5) == 0)
+		return init(buf);
+	else if (strncmp(buf, "record ", 7) == 0)
+		return record_key_desc(buf, &keys_header->keys[key_count]);
+
+	return -EINVAL;
+}
+
+int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
+{
+	if (!is_kdump_kernel())
+		return process_cmd(buf, count);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
+
+int crash_sysfs_dm_crypt_keys_read(char *buf)
+{
+	return sprintf(buf, "%s\n", STATE_STR[state]);
+}
+EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 495b69a71a5d..98cc84d5510c 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -167,6 +167,25 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_DM_CRYPT
+static ssize_t crash_dm_crypt_keys_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return crash_sysfs_dm_crypt_keys_read(buf);
+}
+
+static ssize_t crash_dm_crypt_keys_store(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	int ret;
+
+	ret = crash_sysfs_dm_crypt_keys_write(buf, count);
+	return ret < 0 ? ret : count;
+}
+KERNEL_ATTR_RW(crash_dm_crypt_keys);
+#endif /* CONFIG_CRASH_DM_CRYPT */
+
 #ifdef CONFIG_CRASH_HOTPLUG
 static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -271,6 +290,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_VMCORE_INFO
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_DM_CRYPT
+	&crash_dm_crypt_keys_attr.attr,
+#endif
 #ifdef CONFIG_CRASH_HOTPLUG
 	&crash_elfcorehdr_size_attr.attr,
 #endif
-- 
2.44.0


