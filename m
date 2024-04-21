Return-Path: <linux-kernel+bounces-152458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2308ABEBD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EE81F2112E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F55DDC1;
	Sun, 21 Apr 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF2R8uUs"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10D205E15;
	Sun, 21 Apr 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713685259; cv=none; b=HVEds/qok+5pn8qE7P0Y0ddNM0Jp9TVjmgp+JcGnfFcEY1gqNIZp8k/QaajCZb7C5DCnkTnerzm79FSwZzhdQjTMaK/XApUtxEBDcg6ebXFVyA2u7aEWoGNQV137RXzIQyLjG1bYpClG4qERYREFy/2weZvE7+3yFb5LqgOEuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713685259; c=relaxed/simple;
	bh=YOKxoe3SrtVy2khz2PESFOpTj/hp5kiJGM+lZe4h2rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwUtT6bcrOcyFl/I190FJNVxleyIfDaBWSYbki/8tIu6EgRA6ZPPeaETeGtxz5fMh5hkwYLm8SHAFBZHM5fir+2DY7EEn7ZSp2c4v5glKhF87Db8nHaMjYZAG/yfJKj35XX6dkKLGww/sLDw7t4yGJPSEMHZWwTze3r10QzZXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF2R8uUs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so3436901b3a.2;
        Sun, 21 Apr 2024 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713685257; x=1714290057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=If2EJ9tXmFBEIo82rnclRDWl2DPDE/IPaJVQzbx3uGM=;
        b=UF2R8uUsUVOWJ9bW6ySkNT+vHEqlGse/jk4uCNtYOMUCCSaxv2ebpyBZFExk4naAHY
         7WHklqDZmkhctHqjk/fDYTookBkNdkWGE3xmHdomiA6Un8no7a/aDJT+mnbSt8w29HB8
         uyK6z5tQ/QeG1WSZpsaOTbgVyATJUrbBOm7w4MW0oUzqsgl2d/drODZpJoDamxpeXh/Q
         h+y0xGQ69EhEEViilP6X2+SEjca6RS7Korss2l5GJ0eJobdjrRyMF4+hi+Ifea/35BPK
         +SslT8urFOxtnrUdC/c1bGcr2/+wmMMNcStlbaYI+5qxl16HKoMTWTRYCrxAcJqjoD7E
         scKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713685257; x=1714290057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If2EJ9tXmFBEIo82rnclRDWl2DPDE/IPaJVQzbx3uGM=;
        b=RDd1qOyOPF6Ss0E1xuV+k7iS9hlHMra5r5nt2Q1lPQJ7EoYvsUWOBmtRyTxAtoEg/K
         YxOp2plBq3I1nlxJj1ytXDtTIsxWEkvbs7UnqU0YDX+XZ8xSUUXKSUE/RLzPn26jkQan
         VzXA/hF09M/qvLXJgLOTsvhwijBymUmMH4gCrtscACgT+V884+qmGP93pLLXgh0jqjqi
         QlOhJPOQbQCNJu6M5WW9basUkmNj5VZhdyUKsut+b2+8VXrlXH2yG6oSJqjHdDYsh0QN
         JzjSMhDgV2Nkwehji372ydIw/paM5K2/vip/m0DYM2/nOhf0YT4eWlzxOUoT7CU0HltC
         DUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1/g/olGmyTa/LW2gZFqeGiY4Elhk0n2Zo4ipDM59ZBFXVZl/bC8sAhtjEC4vewIYMFZG323CqiAdJUzLKVu6Qf0NCI6HapDS51U4Dk20jVDwLJ4Wo421eCFdPF6i2Z0nyWJIAQFqG6kA=
X-Gm-Message-State: AOJu0YzyMCEXO5LMGGKuikSbdKGh4/VKrzgGzhEJITqUl5sAswHF8U8E
	tcjPqt6k3VC0V/pbj4krvs8V5r2uRane/msJk8x5ZUAFFh+ZdWy7luKWXg==
X-Google-Smtp-Source: AGHT+IHHiblwgvWLTE/ilfUWIqRiPqjMpOWLIv7WlmTuIB+OUKMng6kXsn5ov911Vp95J6XYqa4glw==
X-Received: by 2002:a05:6a21:2d8e:b0:1a7:5ce1:b647 with SMTP id ty14-20020a056a212d8e00b001a75ce1b647mr9774323pzb.39.1713685257005;
        Sun, 21 Apr 2024 00:40:57 -0700 (PDT)
Received: from localhost.localdomain (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id q100-20020a17090a17ed00b002abb83331afsm6094232pja.27.2024.04.21.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 00:40:56 -0700 (PDT)
From: INAGAKI Hiroshi <musashino.open@gmail.com>
To: axboe@kernel.dk
Cc: yang.yang29@zte.com,
	justinstitt@google.com,
	xu.panda@zte.com.cn,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Naohiro Aota <naota@elisp.net>
Subject: [PATCH] block: fix and simplify blkdevparts= cmdline parsing
Date: Sun, 21 Apr 2024 16:39:52 +0900
Message-ID: <20240421074005.565-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the cmdline parsing of the "blkdevparts=" parameter using strsep(),
which makes the code simpler.

Before commit 146afeb235cc ("block: use strscpy() to instead of
strncpy()"), we used a strncpy() to copy a block device name and partition
names. The commit simply replaced a strncpy() and NULL termination with
a strscpy(). It did not update calculations of length passed to strscpy().
While the length passed to strncpy() is just a length of valid characters
without NULL termination ('\0'), strscpy() takes it as a length of the
destination buffer, including a NULL termination.

Since the source buffer is not necessarily NULL terminated, the current
code copies "length - 1" characters and puts a NULL character in the
destination buffer. It replaces the last character with NULL and breaks
the parsing.

As an example, that buffer will be passed to parse_parts() and breaks
parsing sub-partitions due to the missing ')' at the end, like the
following.

example (Check Point V-80 & OpenWrt):

- Linux Kernel 6.6

  [    0.000000] Kernel command line: console=ttyS0,115200 earlycon=uart8250,mmio32,0xf0512000 crashkernel=30M mvpp2x.queue_mode=1 blkdevparts=mmcblk1:48M@10M(kernel-1),1M(dtb-1),720M(rootfs-1),48M(kernel-2),1M(dtb-2),720M(rootfs-2),300M(default_sw),650M(logs),1M(preset_cfg),1M(adsl),-(storage) maxcpus=4
  ...
  [    0.884016] mmc1: new HS200 MMC card at address 0001
  [    0.889951] mmcblk1: mmc1:0001 004GA0 3.69 GiB
  [    0.895043] cmdline partition format is invalid.
  [    0.895704]  mmcblk1: p1
  [    0.903447] mmcblk1boot0: mmc1:0001 004GA0 2.00 MiB
  [    0.908667] mmcblk1boot1: mmc1:0001 004GA0 2.00 MiB
  [    0.913765] mmcblk1rpmb: mmc1:0001 004GA0 512 KiB, chardev (248:0)

  1. "48M@10M(kernel-1),..." is passed to strscpy() with length=17
     from parse_parts()
  2. strscpy() returns -E2BIG and the destination buffer has
     "48M@10M(kernel-1\0"
  3. "48M@10M(kernel-1\0" is passed to parse_subpart()
  4. parse_subpart() fails to find ')' when parsing a partition name,
     and returns error

- Linux Kernel 6.1

  [    0.000000] Kernel command line: console=ttyS0,115200 earlycon=uart8250,mmio32,0xf0512000 crashkernel=30M mvpp2x.queue_mode=1 blkdevparts=mmcblk1:48M@10M(kernel-1),1M(dtb-1),720M(rootfs-1),48M(kernel-2),1M(dtb-2),720M(rootfs-2),300M(default_sw),650M(logs),1M(preset_cfg),1M(adsl),-(storage) maxcpus=4
  ...
  [    0.953142] mmc1: new HS200 MMC card at address 0001
  [    0.959114] mmcblk1: mmc1:0001 004GA0 3.69 GiB
  [    0.964259]  mmcblk1: p1(kernel-1) p2(dtb-1) p3(rootfs-1) p4(kernel-2) p5(dtb-2) 6(rootfs-2) p7(default_sw) p8(logs) p9(preset_cfg) p10(adsl) p11(storage)
  [    0.979174] mmcblk1boot0: mmc1:0001 004GA0 2.00 MiB
  [    0.984674] mmcblk1boot1: mmc1:0001 004GA0 2.00 MiB
  [    0.989926] mmcblk1rpmb: mmc1:0001 004GA0 512 KiB, chardev (248:0

By the way, strscpy() takes a length of destination buffer and it is
often confusing when copying characters with a specified length. Using
strsep() helps to separate the string by the specified character. Then,
we can use strscpy() naturally with the size of the destination buffer.

Separating the string on the fly is also useful to omit the redundant
string copy, reducing memory usage and improve the code readability.

Fixes: 146afeb235cc ("block: use strscpy() to instead of strncpy()")
Suggested-by: Naohiro Aota <naota@elisp.net>
Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 block/partitions/cmdline.c | 49 ++++++++++----------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index c03bc105e575..152c85df92b2 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -70,8 +70,8 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 	}
 
 	if (*partdef == '(') {
-		int length;
-		char *next = strchr(++partdef, ')');
+		partdef++;
+		char *next = strsep(&partdef, ")");
 
 		if (!next) {
 			pr_warn("cmdline partition format is invalid.");
@@ -79,11 +79,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
 			goto fail;
 		}
 
-		length = min_t(int, next - partdef,
-			       sizeof(new_subpart->name) - 1);
-		strscpy(new_subpart->name, partdef, length);
-
-		partdef = ++next;
+		strscpy(new_subpart->name, next, sizeof(new_subpart->name));
 	} else
 		new_subpart->name[0] = '\0';
 
@@ -117,14 +113,12 @@ static void free_subpart(struct cmdline_parts *parts)
 	}
 }
 
-static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
+static int parse_parts(struct cmdline_parts **parts, char *bdevdef)
 {
 	int ret = -EINVAL;
 	char *next;
-	int length;
 	struct cmdline_subpart **next_subpart;
 	struct cmdline_parts *newparts;
-	char buf[BDEVNAME_SIZE + 32 + 4];
 
 	*parts = NULL;
 
@@ -132,28 +126,19 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
 	if (!newparts)
 		return -ENOMEM;
 
-	next = strchr(bdevdef, ':');
+	next = strsep(&bdevdef, ":");
 	if (!next) {
 		pr_warn("cmdline partition has no block device.");
 		goto fail;
 	}
 
-	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
-	strscpy(newparts->name, bdevdef, length);
+	strscpy(newparts->name, next, sizeof(newparts->name));
 	newparts->nr_subparts = 0;
 
 	next_subpart = &newparts->subpart;
 
-	while (next && *(++next)) {
-		bdevdef = next;
-		next = strchr(bdevdef, ',');
-
-		length = (!next) ? (sizeof(buf) - 1) :
-			min_t(int, next - bdevdef, sizeof(buf) - 1);
-
-		strscpy(buf, bdevdef, length);
-
-		ret = parse_subpart(next_subpart, buf);
+	while ((next = strsep(&bdevdef, ","))) {
+		ret = parse_subpart(next_subpart, next);
 		if (ret)
 			goto fail;
 
@@ -199,24 +184,17 @@ static int cmdline_parts_parse(struct cmdline_parts **parts,
 
 	*parts = NULL;
 
-	next = pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
+	pbuf = buf = kstrdup(cmdline, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	next_parts = parts;
 
-	while (next && *pbuf) {
-		next = strchr(pbuf, ';');
-		if (next)
-			*next = '\0';
-
-		ret = parse_parts(next_parts, pbuf);
+	while ((next = strsep(&pbuf, ";"))) {
+		ret = parse_parts(next_parts, next);
 		if (ret)
 			goto fail;
 
-		if (next)
-			pbuf = ++next;
-
 		next_parts = &(*next_parts)->next_parts;
 	}
 
@@ -250,7 +228,6 @@ static struct cmdline_parts *bdev_parts;
 static int add_part(int slot, struct cmdline_subpart *subpart,
 		struct parsed_partitions *state)
 {
-	int label_min;
 	struct partition_meta_info *info;
 	char tmp[sizeof(info->volname) + 4];
 
@@ -262,9 +239,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
 
 	info = &state->parts[slot].info;
 
-	label_min = min_t(int, sizeof(info->volname) - 1,
-			  sizeof(subpart->name));
-	strscpy(info->volname, subpart->name, label_min);
+	strscpy(info->volname, subpart->name, sizeof(info->volname));
 
 	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
 	strlcat(state->pp_buf, tmp, PAGE_SIZE);
-- 
2.25.1


