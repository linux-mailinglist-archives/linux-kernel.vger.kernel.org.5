Return-Path: <linux-kernel+bounces-42832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C2840769
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0BD1F26D89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A5657DD;
	Mon, 29 Jan 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSB+fDX6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3F55765
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536253; cv=none; b=ZwGvrWeNUfXSR9jGP0WucYJkBJELMSJpyWZ20DbtNed/WFsq4bvCyk+viGD131XaVvTVAlRuh7MFVOz4eYjtPWHmqtLDE6vpt/IdEUO2Qh5ANAB95SzdsU3A1HPjaXJI+6jUflkGn+o2MgqiR73PG3sevZZvFdBH1bwGnDlqsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536253; c=relaxed/simple;
	bh=Y5Lxq98jd2wscGL5X+bHYiCOnZ4Dum0+TiGSXqwle/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ldF7Eb5Tv5e1l8xbiZ349XuPYT10z+/LOoI0x/pK7zB3Bwj0n0JMjJglY9myhRUJMVkapmlQoHyqY1APEAPJUhPLOBpk0RLDkpUtAh1wcIAZMwh7AIKg0zSOlMtNpKKFoyr8znIfVtFgiz5Qi9nOBiduLp5nUMZT8AO1Psqsu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSB+fDX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706536251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLP3YBtiGz95VYsxBR+21UP0cxSRcXeV1OGJ7bAOlDk=;
	b=fSB+fDX6q58E1n7vMBzG5YR5Itjl1rDszQsrj8tlanJd0iB3MyVaw4I03zeqeXyj8tHbYu
	yUKwb5hikWGKrGvvh/kzU01lYS0MjE6cX6SjxkPkvKubH0ZcKgQ+BUJEB7gKQwSs2c+TR3
	KUbKvZ+f4dZAOxR8v81YuDs2qYW7MS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Rx5uj1wdM5eXqYAKo1NPvw-1; Mon, 29 Jan 2024 08:50:45 -0500
X-MC-Unique: Rx5uj1wdM5eXqYAKo1NPvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D07AD1065223;
	Mon, 29 Jan 2024 13:50:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0203B488;
	Mon, 29 Jan 2024 13:50:40 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	nathan@kernel.org,
	mhklinux@outlook.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next 2/3] crash: fix building error in generic codes
Date: Mon, 29 Jan 2024 21:50:32 +0800
Message-ID: <20240129135033.157195-2-bhe@redhat.com>
In-Reply-To: <20240129135033.157195-1-bhe@redhat.com>
References: <20240129135033.157195-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Nathan reported some building errors on arm64 as below:

==========
$ curl -LSso .config https://github.com/archlinuxarm/PKGBUILDs/raw/master/core/linux-aarch64/config
$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig all
..
aarch64-linux-ld: kernel/kexec_file.o: in function `kexec_walk_memblock.constprop.0':
kexec_file.c:(.text+0x314): undefined reference to `crashk_res'
..
aarch64-linux-ld: drivers/of/kexec.o: in function `of_kexec_alloc_and_setup_fdt':
kexec.c:(.text+0x580): undefined reference to `crashk_res'
..
aarch64-linux-ld: kexec.c:(.text+0x5c0): undefined reference to `crashk_low_res'
==========

On the provided config, it has:
===
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
===

For these crash related code blocks, they need put inside CONFIG_CRASH_DUMP
ifdeffery scope to avoid building erorr when CONFIG_CRASH_DUMP is not
set.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240126045551.GA126645@dev-arch.thelio-3990X/T/#u
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/of/kexec.c  | 2 ++
 kernel/kexec_file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 68278340cecf..9ccde2fd77cb 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -395,6 +395,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		if (ret)
 			goto out;
 
+#ifdef CONFIG_CRASH_DUMP
 		/* add linux,usable-memory-range */
 		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
 				"linux,usable-memory-range", crashk_res.start,
@@ -410,6 +411,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 			if (ret)
 				goto out;
 		}
+#endif
 	}
 
 	/* add bootargs */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ce7ce2ae27cd..2d1db05fbf04 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -540,8 +540,10 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+#ifdef CONFIG_CRASH_DUMP
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return func(&crashk_res, kbuf);
+#endif
 
 	/*
 	 * Using MEMBLOCK_NONE will properly skip MEMBLOCK_DRIVER_MANAGED. See
-- 
2.41.0


