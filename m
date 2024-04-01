Return-Path: <linux-kernel+bounces-126957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6E8944EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF07B216FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F1B481AA;
	Mon,  1 Apr 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="youQA+fI"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9E22085
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711996801; cv=none; b=NQLNjXpu9pJ1eSQdOB3Hwpy6Gxir8TZAAQeuXQkbaGWCRruoavrfikzfus/9M35vDInEbIsta+55Wb+AAbMAXGXzyYCA+61ZJN/Hc0j4Hvx0An3EeIZGtguEdCQZFSBGURrhWXKhkjhJCs4g0f8mKZoZQQpPr8aiaM5fTihg69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711996801; c=relaxed/simple;
	bh=2MbhgQj8cVkDP038ndgOY503dVX+Ax4mZCM7tpCQcQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TKJa+cvTl7dCo06ZWu4UNwuJDC5v/3EiVtNsmuxxFaFZ9mdbcMe9g/OMXHj/xPUyBVpzN+LOd+raoXg+U3VWTMaALh4Z0qhTg9D4QwIIaeFddxfoSbuny3dcI3aWW8VI7oByRLOwYTFqXPC+sdGwzEv7QPp2XT1uENOfkTqp5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=youQA+fI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so7552320276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711996797; x=1712601597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgMheuDZ9q8sO5WzCyu4uSNRV4Oc3mqdwzajDlVhWIU=;
        b=youQA+fIeC+hyV6lUUv/206egygjVkPcYGWVXG4m10SlukXEvQFM6C2A5hFBXSTSBy
         IxZ+bLgQIa81ZR4kGbolVbBmoMEcuNoVZ/PEcsXecYc4YSFw9/4dJzbEYKglP3PjIr8M
         CSQkbrOx5jnRpXJbQrf7xGItkOWMWrvxcEquj4+Ib3OzKN0ozldmsidB3Sntftj20WHH
         AVHfo8VKmRUIutBh7TZXa4JZWL9loGV2pXxv1Iikb8WzzTN2dRSZZhn+CJeX7MLndXhk
         9nPnQ0m898l/TmLGJCFsrCbaJf+Req5LaAAHdFWzLh2uH2ULWlHJ5sDGM4SNjVQooa9q
         l3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711996797; x=1712601597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgMheuDZ9q8sO5WzCyu4uSNRV4Oc3mqdwzajDlVhWIU=;
        b=O2lOJWgvQt63a95l+WSdZwOmxKkx0ANxEiBVYSLzJ6kr/VcgEjMEZyHR56LnZ+qQsN
         naPA2Ru39/QKgvxPSCs55/sog2fKGMl+TH8FsHOlhyWiIyfQiFIwpwM0S5kyObT8tsIt
         YgBYgUNNd/ZKzFegWJKHED2GJ36b7xeGAQTXbGozi4lTXHwieWHTbdjttx4g05i4sMxc
         8d5+Rk6GhR1at1UwBwdTiom5T35IEir1ibw5X7tiP9KoZU0TJ9r+Ca8PGGMumMxyUsPx
         nJyrv7gzsjx3nyAdw8Lfv/Qqg7hbH/JyeWBErh720xV/72P6901chyqCdbJdxXC6oGYg
         O9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUTulkctTEnaoUcw5ydKPrJfzcA7SDR7SZq24V2aqoOmInzXu8E19VL1miAmTEbcfer7OwNXF8PnKMxkF0ryAkjKKVe6+xls5WvLOMB
X-Gm-Message-State: AOJu0Yz3hNF/kbAkXDt+8cP5vPBgOz2ALgSMsYq6VYTGhrejw3Kk+HsE
	C0PPW08GTQqswRVqAbYsHS5A18oz8aOoWLnsn5l1HNLVf+w6QVlQatwVLgk72CAGVWYY7791yaj
	eYApUvoPz/15kDkzLXjOL0Q==
X-Google-Smtp-Source: AGHT+IHSmFegPY5LrkmIhHmV2aW8Fujix6RmCEZ5xbkPgSlx7/Qdn60CtjV4+JrWRC8OnVdY8bMiErkNetC/FspRww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1893:b0:dc6:fec4:1c26 with
 SMTP id cj19-20020a056902189300b00dc6fec41c26mr3327875ybb.1.1711996797754;
 Mon, 01 Apr 2024 11:39:57 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:39:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHr/CmYC/42NTQqDMBBGryKz7pQk/VG66j2KCxMnMVAdmUioi
 Hdv6gm6fA++922QSCIleFQbCOWYIk8FzKkCN3RTIIx9YTDKXNXF1JgWmdy8ok84CzvMo2MhdGh
 109d37akjD2U+C/n4OdKvtvAQ08KyHk9Z/+wf0axRIylzo141Vlv1DMzhTWfHI7T7vn8BS8M/5 cEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711996796; l=2314;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2MbhgQj8cVkDP038ndgOY503dVX+Ax4mZCM7tpCQcQA=; b=QK8nLukocBQU9jplQm8cs3ucevtjDWazF2fw9lAMxYf+e9BuLtUEVXrqzKXK3RvJsRteZolGw
 XJfs74WA4giCbUveTWR8xEsOJ1EhMVcg46SafcYUkIELkNIvOLYJBFW
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
Subject: [PATCH v2] vmcore: replace strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is in the process of being replaced as it is deprecated [1].
We should move towards safer and less ambiguous string interfaces.

Looking at vmcoredd_header's definition:
|	struct vmcoredd_header {
|		__u32 n_namesz; /* Name size */
|		__u32 n_descsz; /* Content size */
|		__u32 n_type;   /* NT_VMCOREDD */
|		__u8 name[8];   /* LINUX\0\0\0 */
|		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
|	};
.. we see that @name wants to be NUL-padded.

We're copying data->dump_name which is defined as:
|	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
.. which shares the same size as vdd_hdr->dump_name. Let's make sure we
NUL-pad this as well.

Use strscpy_pad() which NUL-terminates and NUL-pads its destination
buffers. Specifically, use the new 2-argument version of strscpy_pad
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- don't mark buffers as __nonstring, instead use a string API (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/proc/vmcore.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..5d08d4d159d3 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
 	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
 	vdd_hdr->n_type = NT_VMCOREDD;
 
-	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
-		sizeof(vdd_hdr->name));
-	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
+	strscpy_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME);
+	strscpy_pad(vdd_hdr->dump_name, data->dump_name);
 }
 
 /**

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240327-strncpy-fs-proc-vmcore-c-b18d761feaef

Best regards,
--
Justin Stitt <justinstitt@google.com>


