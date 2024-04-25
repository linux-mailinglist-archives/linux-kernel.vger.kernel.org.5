Return-Path: <linux-kernel+bounces-158358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F07B8B1EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD191F23D59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94761127E30;
	Thu, 25 Apr 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKuY58KF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D49127E24
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039499; cv=none; b=lzKXRlJMK8ytblrE5F4uo3YZqIFr64luWYKPpxvgl/mRU/yc5mD/nmeYjYiMMpDpLe/coavoDHwOMIJqqhX/eNVLpOfwfcoVAfGCW6F4GtILXAzBO/QvsMETtJdYQdxAgyjMw22BQY+FDQ4HNWmFxTbqBf+6d5Kk6QIge/J8sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039499; c=relaxed/simple;
	bh=3Zp9ieU/+pUZuIcCJheRv35aOHQNsKellXzxSbAo2yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ofh1tlen/Q3SToyZxfDhJhcN7T6QZIUU7Vly8BfymJ5EJt9KRuTh2y5BcHvaLcMMnpJu/7vt++DMtoYHs9w+bYx7jW2nMp85XGYqM0e0m/X8z/jWTRdIxrnabXlObeFgE+3pNj2cJUPU5tipIqbDAy76lYVzImW6iepDJgxFRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKuY58KF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtIYIJYKyy/5qzi0n/PqpS95u6O7t7oyOgbotIXFy7M=;
	b=aKuY58KFvCTYQislQUKkrssfVfIrY8dGIDx8tlcx2y6PdU3inFcm5XMdW4Qf1fLt7/Ykta
	5alzQLlB0X1KQsnrypBC0bX21nKuQ1pa7UKOE4nst2JnvrXtEl5AGwKU6UR8YmDf9rl0Q6
	2NxIG3Toa1FV3sJlRghyOAeN1BOeJek=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-utERWzpXMNuAcWIXDpr8Lg-1; Thu, 25 Apr 2024 06:04:56 -0400
X-MC-Unique: utERWzpXMNuAcWIXDpr8Lg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e851c0204aso9554145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039495; x=1714644295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtIYIJYKyy/5qzi0n/PqpS95u6O7t7oyOgbotIXFy7M=;
        b=Z7M3ge0BChHJ2ScniKrtJ8LBOvXaSWiJahHljGim5HcsI/rVrSpWmPG3Nx596IeqmD
         /9DyZ/FIeT13hxTGek+qBYo1y7NIDLlT/AQR9TjZqkE5nfZ/F0BEbAbgV/xztGu+aFDr
         SshgLNwMcYLqrz/9zVlQ1hJ40w6hYdDw736msYbab6UEJL3Vigmm4D65FCa0el+mZBVl
         ecSh17g7yahhClG+DJZ0qYcPbEcQZM842OyB78KYOm2u3jx8NXr7lvb5fkbP4evFk7Eb
         LAwe0zB+pJXxqiAQdco3LUsKUOQ+nShztnWYWhVGv6ShEzJu6StEEaK9JoGTXi/Tdc3N
         SUHg==
X-Forwarded-Encrypted: i=1; AJvYcCW5+4GtvMVKWO23YPMUdegvG7/4FTobBSfgRUmZmy8kgMR42q/KcmhgRyRTevSeBMqIFy2wAKd1ikVZdYRu+zIwF4V4gyuftYRrBvPW
X-Gm-Message-State: AOJu0Yyw2VC3z/LUJGX3tpWlY13BI7AMc6MGBWrCkLD/fCMSkTOaB18x
	N+Y8HquM+WlxseO7lWDFwsePqltKvx6LVNrhXGOyek6WBP/YqK/+WjjcLio+5PpB/+VQI8E0+82
	EiAd/oebPFi8F+3iZff1oa/AingA6M6lMPEJ4wfChnMCv5XqFzE9ixtOAGvVdxQ==
X-Received: by 2002:a17:902:f60c:b0:1e4:514a:55af with SMTP id n12-20020a170902f60c00b001e4514a55afmr6469093plg.68.1714039494623;
        Thu, 25 Apr 2024 03:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4PhFmtr7NGtfSylsFrnAzg2TwlhAltH+JWa9HYv31v9hDfa9bCYeS47K2qWKVTo0k9n+0Ng==
X-Received: by 2002:a17:902:f60c:b0:1e4:514a:55af with SMTP id n12-20020a170902f60c00b001e4514a55afmr6469053plg.68.1714039494088;
        Thu, 25 Apr 2024 03:04:54 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001dcfaf4db22sm13411417ple.2.2024.04.25.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:53 -0700 (PDT)
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
Subject: [PATCH v3 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Date: Thu, 25 Apr 2024 18:04:29 +0800
Message-ID: <20240425100434.198925-6-coxu@redhat.com>
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

Crash kernel will retrieve the dm crypt keys based on the dmcryptkeys
command line parameter. When user space writes the key description to
/sys/kernel/crash_dm_crypt_key, the crash kernel will save the
encryption keys to the user keyring. Then user space e.g. cryptsetup's
--volume-key-keyring API can use it to unlock the encrypted device.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h   |  1 +
 kernel/crash_dump_dm_crypt.c | 99 +++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 1f3d5a4fa6c1..1996e0739b6d 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -38,6 +38,7 @@ static inline void arch_kexec_unprotect_crashkres(void) { }
 int crash_sysfs_dm_crypt_keys_read(char *buf);
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
 int crash_load_dm_crypt_keys(struct kimage *image);
+ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 #else
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 6ac1fabdb6cb..9ddfe4c4d755 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -33,12 +33,67 @@ struct keys_header {
 	struct dm_crypt_key keys[] __counted_by(key_count);
 } *keys_header;
 
+unsigned long long dm_crypt_keys_addr;
+EXPORT_SYMBOL_GPL(dm_crypt_keys_addr);
+
+static int __init setup_dmcryptkeys(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	dm_crypt_keys_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	dm_crypt_keys_addr = 0;
+	return -EINVAL;
+}
+
+early_param("dmcryptkeys", setup_dmcryptkeys);
+
 static size_t get_keys_header_size(struct keys_header *keys_header,
 				   size_t key_count)
 {
 	return struct_size(keys_header, keys, key_count);
 }
 
+/*
+ * Architectures may override this function to read dm crypt key
+ */
+ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+static int add_key_to_keyring(struct dm_crypt_key *dm_key,
+			      key_ref_t keyring_ref)
+{
+	key_ref_t key_ref;
+	int r;
+
+	/* create or update the requested key and add it to the target keyring */
+	key_ref = key_create_or_update(keyring_ref, "user", dm_key->key_desc,
+				       dm_key->data, dm_key->key_size,
+				       KEY_USR_ALL, KEY_ALLOC_IN_QUOTA);
+
+	if (!IS_ERR(key_ref)) {
+		r = key_ref_to_ptr(key_ref)->serial;
+		key_ref_put(key_ref);
+		pr_alert("Success adding key %s", dm_key->key_desc);
+	} else {
+		r = PTR_ERR(key_ref);
+		pr_alert("Error when adding key");
+	}
+
+	key_ref_put(keyring_ref);
+	return r;
+}
+
 static int init(const char *buf)
 {
 	unsigned int total_keys;
@@ -120,11 +175,53 @@ static int process_cmd(const char *buf, size_t count)
 	return -EINVAL;
 }
 
+static int restore_dm_crypt_keys_to_thread_keyring(const char *key_desc)
+{
+	struct dm_crypt_key *key;
+	key_ref_t keyring_ref;
+	u64 addr;
+
+	/* find the target keyring (which must be writable) */
+	keyring_ref =
+		lookup_user_key(KEY_SPEC_USER_KEYRING, 0x01, KEY_NEED_WRITE);
+	if (IS_ERR(keyring_ref)) {
+		pr_alert("Failed to get keyring");
+		return PTR_ERR(keyring_ref);
+	}
+
+	addr = dm_crypt_keys_addr;
+	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
+	if (key_count < 0 || key_count > KEY_NUM_MAX) {
+		pr_info("Failed to the number of dm_crypt keys\n");
+		return -1;
+	}
+
+	pr_debug("There are %u keys\n", key_count);
+	addr = dm_crypt_keys_addr;
+
+	keys_header_size = get_keys_header_size(keys_header, key_count);
+
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header)
+		return -ENOMEM;
+
+	dm_crypt_keys_read((char *)keys_header, keys_header_size, &addr);
+
+	for (int i = 0; i < keys_header->key_count; i++) {
+		key = &keys_header->keys[i];
+		pr_alert("Get key (size=%u): %8ph...\n", key->key_size, key->data);
+		add_key_to_keyring(key, keyring_ref);
+	}
+
+	return 0;
+}
+
 int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
 {
 	if (!is_kdump_kernel())
 		return process_cmd(buf, count);
-	return -EINVAL;
+	else
+		return restore_dm_crypt_keys_to_thread_keyring(buf);
 }
 EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
 
-- 
2.44.0


