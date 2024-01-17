Return-Path: <linux-kernel+bounces-28611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF518300B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9029BB22F01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7DE125A3;
	Wed, 17 Jan 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHVFsrVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82211170B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477528; cv=none; b=TjmTyikMWcUJGiT12CCK9Kf/BNvuniTFjrwSGfWAlWsMGDrVPey3ppvMdIii3k9/vNSTm6OlpzERkgpkkov4hu/AfSGfO0rN6vpUufXZtX7iagKGXHjmFmpPU801uf/1fVfosK8P53JNK5Mix1EyYwcY1ArvrbNyhHJiezNNLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477528; c=relaxed/simple;
	bh=9zAjop8lN3D6O5NChAL30EJTz4jH0ADlFf8VOAAySZI=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NdMp1bKTM1bd0zcaO3Hjf+ABfYd8Fd45A3x1o05YEbW7WPzphZ+UbyreaCIGwpVIOBiCwTPx/4n+CfU3sN/QPeAREJYmQxJcfG8uS7RzEUKbdHj+tw9OCWUE0f/SeFHSmXKr0qLMPz3ZS9SNOvAfNRklOlut86ARvLCOZ5+NS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHVFsrVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705477525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQKf1TFOIk3jRZgYrerpttWoKccvQIBg6Et3VqW5w6c=;
	b=eHVFsrVBShJCb7iBq6vZzJUk4E3eSH4OJIWtatyE7l0riiFPW0qNSb2n1Mforytzp80eRL
	X3+J1v2WsQMNXT7gf4Y+UHdjSCXdhdigOLli/OSDS/A1ywO4gSUJhNLfoqE4vp+iYO183K
	HeCL5liKkMkgSflBGw4Ob8v+DZ0qRSI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-PT1jjxWDO1WrHqg2gJO8KQ-1; Wed, 17 Jan 2024 02:45:19 -0500
X-MC-Unique: PT1jjxWDO1WrHqg2gJO8KQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d4931d651aso111540955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477518; x=1706082318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQKf1TFOIk3jRZgYrerpttWoKccvQIBg6Et3VqW5w6c=;
        b=DgBTwutpEASo57F1s6B/+F17kFh9B+4M+ddCjz6+Rz2s2R2r/s4ZDiIgvCiinS2Ut2
         20t833+WCdRwJq5NjH8shqkftf9RhPC66aNkFsDZDde3+G1EmnHipGoARtDHQ5i8ipOr
         XCWUoVzqRPyafDuFNaVzkk6vlvAucKPnMbbWlA14iHzX6FICDmxVwRXg2xybzrFUJKxj
         yuvFCJ254MbW+lXOugLda01ZCs+LiOmX9j3dwLrz8unC8YZ9sZALo6i66fUndSZi00t4
         sHFWmS5+ptpUNbFYlTLniQ4T0uj8wzS/TRPAyzztaFpWaq1lEZbp+rK3AoAWxpcdOVAv
         X+2w==
X-Gm-Message-State: AOJu0YxLDmjZiGQ/JdyYhxP0pkrdztUhKRJOxkDj/DTYz9WF4LvNZzxW
	yL4HRvXlmBpjCEzv7yvee3mXie7hz113tUA6gC1914E78Mh3aBFVCuQkvkh8HdBmmkyRl4Cpw4o
	7x0B/i0+J1kw667HkdgkJTCr1RCykPX5l
X-Received: by 2002:a17:902:d489:b0:1d5:f223:a27a with SMTP id c9-20020a170902d48900b001d5f223a27amr1978820plg.39.1705477518142;
        Tue, 16 Jan 2024 23:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhEoP2YVi7iCc6R39IopraMkPNMLCAp9KZ0Dbsx8C4gLDT2Oz18uI3tNeXVMGc70+YfqFMaA==
X-Received: by 2002:a17:902:d489:b0:1d5:f223:a27a with SMTP id c9-20020a170902d48900b001d5f223a27amr1978803plg.39.1705477517899;
        Tue, 16 Jan 2024 23:45:17 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902bc4c00b001d6f5ac1ad4sm207349plz.43.2024.01.16.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:45:17 -0800 (PST)
Date: Wed, 17 Jan 2024 15:39:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ondrej Kozina <okozina@redhat.com>
Cc: kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: Re: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Message-ID: <isgawrvqwuyaitkxgikkcgw3g5mxt3x3tubgpsy2kqos3t4nwr@soy5s6ypm6nt>
References: <20240110071522.1308935-1-coxu@redhat.com>
 <20240110071522.1308935-3-coxu@redhat.com>
 <750d9e17-d8b8-44c0-ba47-74a686333a01@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <750d9e17-d8b8-44c0-ba47-74a686333a01@redhat.com>

On Tue, Jan 16, 2024 at 11:40:53AM +0100, Ondrej Kozina wrote:
>On 10/01/2024 08:15, Coiby Xu wrote:
>>User space is supposed to write the key description to
>>/sys/kernel/crash_dm_crypt_key so the kernel will read the key and save
>>a temporary copy for later user. User space has 2 minutes at maximum to
>>load the kdump initrd before the key gets wiped. And after kdump
>>retrieves the key, the key will be wiped immediately.
>>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  include/linux/crash_core.h   |   7 +-
>>  include/linux/kexec.h        |   4 ++
>>  kernel/Makefile              |   2 +-
>>  kernel/crash_dump_dm_crypt.c | 121 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  23 ++++++-
>>  5 files changed, 153 insertions(+), 4 deletions(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
>>diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>index 5126a4fecb44..7078eda6418d 100644
>>--- a/include/linux/crash_core.h
>>+++ b/include/linux/crash_core.h
>>@@ -125,6 +125,12 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
>>  {}
>>  #endif
>>+struct kimage;
>>+
>>+int crash_sysfs_dm_crypt_key_write(const char *key_des, size_t count);
>>+int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz);
>>+int crash_load_dm_crypt_key(struct kimage *image);
>>+
>>  /* Alignment required for elf header segment */
>>  #define ELF_CORE_HEADER_ALIGN   4096
>>@@ -140,7 +146,6 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>>  				       void **addr, unsigned long *sz);
>>-struct kimage;
>>  struct kexec_segment;
>>  #define KEXEC_CRASH_HP_NONE			0
>>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>index 6f4626490ebf..bf7ab1e927ef 100644
>>--- a/include/linux/kexec.h
>>+++ b/include/linux/kexec.h
>>@@ -366,6 +366,10 @@ struct kimage {
>>  	void *elf_headers;
>>  	unsigned long elf_headers_sz;
>>  	unsigned long elf_load_addr;
>>+
>>+	/* dm crypt key buffer */
>>+	unsigned long dm_crypt_key_addr;
>>+	unsigned long dm_crypt_key_sz;
>>  };
>>  /* kexec interface functions */
>>diff --git a/kernel/Makefile b/kernel/Makefile
>>index 3947122d618b..48859bf63db5 100644
>>--- a/kernel/Makefile
>>+++ b/kernel/Makefile
>>@@ -119,7 +119,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
>>  obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
>>  obj-$(CONFIG_PADATA) += padata.o
>>-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
>>+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o crash_dump_dm_crypt.o
>>  obj-$(CONFIG_JUMP_LABEL) += jump_label.o
>>  obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
>>  obj-$(CONFIG_TORTURE_TEST) += torture.o
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>new file mode 100644
>>index 000000000000..3a0b0b773598
>>--- /dev/null
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -0,0 +1,121 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+#include <keys/user-type.h>
>>+#include <linux/crash_dump.h>
>>+
>>+static u8 *dm_crypt_key;
>>+static unsigned int dm_crypt_key_size;
>>+
>>+void wipe_dm_crypt_key(void)
>>+{
>>+	if (dm_crypt_key) {
>>+		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
>>+		kfree(dm_crypt_key);
>>+		dm_crypt_key = NULL;
>>+	}
>>+}
>>+
>>+static void _wipe_dm_crypt_key(struct work_struct *dummy)
>>+{
>>+	wipe_dm_crypt_key();
>>+}
>>+
>>+static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
>>+
>>+static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
>>+
>>+static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
>>+{
>>+	const struct user_key_payload *ukp;
>>+	struct key *key;
>>+
>>+	if (dm_crypt_key) {
>>+		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
>>+		kfree(dm_crypt_key);
>>+	}
>>+
>>+	pr_debug("Requesting key %s", key_desc);
>>+	key = request_key(&key_type_user, key_desc, NULL);
>
>If we don't read the key copy form userspace (my reply to top level 
>message) you could use key_type_logon here.

I'll use key_type_logon, thanks!

-- 
Best regards,
Coiby


