Return-Path: <linux-kernel+bounces-36458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730F83A11A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888781C273E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC41426C;
	Wed, 24 Jan 2024 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4afQVsR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8128F17575
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073254; cv=none; b=Lc5M0A31WzuCKWYzCJ/muq6TlJgwsqaeyaPH1QrfgwecxB9p/MppajOKx4VuAC3DLZT5fiMqQr0LXmAdmlURHjaxRMgaZz/SIXzQ43vHbtI9i+Q035BYz6lEjOH9MfQ3l8/FposeK3zpD0OUKrK+IFbxfJ/jrvRGXbhDRQJdzus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073254; c=relaxed/simple;
	bh=4OLku53QZ0JcIhWOC5lpSpfsCOe7WyE8PhE4np3c32c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=BxSBy9oRqmViYoR8d9sl09NAGMgZuThHHYNwh0jWhnkCG/YUQC4+kkfvJrktr1kW/NG+bwZTQKrN0aBwTvfNxkCMPnzSBXTeOKeEArgKBDEY2z6WnscErgHMNFrZYaF2Gb8StugzMLEODSHfil0DT5SmBqVsCGbQSJ5B9TdzBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4afQVsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ELQbTPNyx4L6Rjica+79k486cYCM/jEDd+jz77hDLU=;
	b=H4afQVsRpYOLVAuooWagXOZcbk1hKtebB5Il0hTbS/ROdae0t3CDydTbVvcC8wTxC3ML2l
	8rBATiVYG8V/lA9wPKzEkoKhELi7qGdafVkauGM8/xaPTTSNvpzo9D4K4IIoIu4ju5G/QZ
	Dx+x5Um1bRno6Ra3bt1DUfrivYK1iJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-6y3KZd9xNXOZOuwb7FQaow-1; Wed, 24 Jan 2024 00:14:08 -0500
X-MC-Unique: 6y3KZd9xNXOZOuwb7FQaow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 764E885A58A;
	Wed, 24 Jan 2024 05:14:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 719011C060AF;
	Wed, 24 Jan 2024 05:14:01 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 09/14] s390, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:49 +0800
Message-ID: <20240124051254.67105-10-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on s390 with some adjustments.

Here wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/kernel/kexec_elf.c          |  2 ++
 arch/s390/kernel/kexec_image.c        |  2 ++
 arch/s390/kernel/machine_kexec_file.c | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 9da6fa30c447..4d364de43799 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -40,8 +40,10 @@ static int kexec_file_add_kernel_elf(struct kimage *image,
 		buf.bufsz = phdr->p_filesz;
 
 		buf.mem = ALIGN(phdr->p_paddr, phdr->p_align);
+#ifdef CONFIG_CRASH_DUMP
 		if (image->type == KEXEC_TYPE_CRASH)
 			buf.mem += crashk_res.start;
+#endif
 		buf.memsz = phdr->p_memsz;
 		data->memsz = ALIGN(data->memsz, phdr->p_align) + buf.memsz;
 
diff --git a/arch/s390/kernel/kexec_image.c b/arch/s390/kernel/kexec_image.c
index af23eff5774d..a32ce8bea745 100644
--- a/arch/s390/kernel/kexec_image.c
+++ b/arch/s390/kernel/kexec_image.c
@@ -24,8 +24,10 @@ static int kexec_file_add_kernel_image(struct kimage *image,
 	buf.bufsz = image->kernel_buf_len;
 
 	buf.mem = 0;
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH)
 		buf.mem += crashk_res.start;
+#endif
 	buf.memsz = buf.bufsz;
 
 	data->kernel_buf = image->kernel_buf;
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8d207b82d9fe..c2bac14dd668 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -105,6 +105,7 @@ static int kexec_file_update_purgatory(struct kimage *image,
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
 		u64 crash_size;
 
@@ -121,6 +122,7 @@ static int kexec_file_update_purgatory(struct kimage *image,
 						     sizeof(crash_size),
 						     false);
 	}
+#endif
 	return ret;
 }
 
@@ -134,8 +136,10 @@ static int kexec_file_add_purgatory(struct kimage *image,
 
 	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
 	buf.mem = data->memsz;
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH)
 		buf.mem += crashk_res.start;
+#endif
 
 	ret = kexec_load_purgatory(image, &buf);
 	if (ret)
@@ -158,8 +162,10 @@ static int kexec_file_add_initrd(struct kimage *image,
 
 	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
 	buf.mem = data->memsz;
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH)
 		buf.mem += crashk_res.start;
+#endif
 	buf.memsz = buf.bufsz;
 
 	data->parm->initrd_start = data->memsz;
@@ -223,8 +229,10 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		data->kernel_buf + offsetof(struct lowcore, ipl_parmblock_ptr);
 	*lc_ipl_parmblock_ptr = (__u32)buf.mem;
 
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH)
 		buf.mem += crashk_res.start;
+#endif
 
 	ret = kexec_add_buffer(&buf);
 out:
@@ -268,10 +276,12 @@ void *kexec_file_add_components(struct kimage *image,
 	memcpy(data.parm->command_line, image->cmdline_buf,
 	       image->cmdline_buf_len);
 
+#ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
 		data.parm->oldmem_base = crashk_res.start;
 		data.parm->oldmem_size = crashk_res.end - crashk_res.start + 1;
 	}
+#endif
 
 	if (image->initrd_buf) {
 		ret = kexec_file_add_initrd(image, &data);
-- 
2.41.0


