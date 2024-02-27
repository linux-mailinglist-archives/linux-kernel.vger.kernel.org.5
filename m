Return-Path: <linux-kernel+bounces-83491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF0869A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D6284F49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74331474C9;
	Tue, 27 Feb 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YutPEzYp"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE78146E60
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047177; cv=none; b=BFMtE45LkOJri2bDgPzbteskeUR/JC5q13cR7urGI8ozwhwr96NHjVgqYW9Gq/INdCsCf1V8B/Ad2mzuyJAuZW8LN33EJ8EcZuon6UpNqIEYqstLeFQ76z2vwzqIplt2q36zXiBQdgMM8uaoxXPFeLr/KaSyS1WScvUWw4aEef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047177; c=relaxed/simple;
	bh=bLDe3KG0XYavXQhiwPBF6RL6baBIW+tOuHgPkuSkJWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J81MdG6rlRJeFGLOJquETNdc679yrAvUFV8Rb4Pq6UbWVQuzBrkQMEx/1nTk0keC7hFT5qNB+5HJ69qWjCHctdqHLV6zZKFiiC1uT/zwhhIBNl61y5j0GVA2udxljT8qiqbsa/iF5L0L2kwf+IkVAOyBnH/J8TV+E7VlzXenoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YutPEzYp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso6039049276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047174; x=1709651974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rh1bAQtKMaIJdR87zlJE2orPGq4tRSmOiy/LVJJ6Lnk=;
        b=YutPEzYp6GlsFGql46at+AqpHrmrJn/FU90UQO4nH4yBZJ7LBKJg6M8YdHUEJ8BlXV
         Qx5W305Zls+L4m1JcVOGCp/fix7Y9PIQoROKUVb/9hm+dhWGIVT80fWYUJ4LsmA2yGe0
         O+jmLktpJo1yilBjcM5Bd9KB5RP+qeV4r32sd7XmRkIt+LbpZmgJKfQ6WwzBzKkTGYMX
         2ijC1GR9KdV05vZfAkaheYxH2F06uBawJUXlYJ25A7N65rtiKQsIGAa3hjgQc0QxRHcA
         JTd7aPRRwjiafXbrc5KGM7bt+va19Yn0CxXnqgXheVP3/3XQYqAoa1lag4IQbqJJqAaw
         3gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047174; x=1709651974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh1bAQtKMaIJdR87zlJE2orPGq4tRSmOiy/LVJJ6Lnk=;
        b=dohPSC0EebcgvDeqVZdqqxRItLpfGz4ahhLbqpCF0ka09a09litwL6SOCOW+lRofRo
         2DE0tkV0xAi2Gbc5/OwZXCcsXb4EALEN1KmM22h6GDw2ec6xh/rm61SIAxmXSIwB2gJb
         D0ICj4LGhXwf/tL/6VdcaDtrcIYqRTMihw1zgGIsWfYn5/3VEI8C8A5F+kXgnItRdMa7
         e1IhLYoclEGIS75bq+6j+nv+Z15nhEtETTjUoChq/NQyK8Kr/9O3ub9d7uXWsHEzErM/
         lPaTz14tUukiq4QIjrNoOp93kb6e1nTsaBeL3ZYDJUrnjis0wH8bh+51cuDzNe04aOhC
         IcDw==
X-Gm-Message-State: AOJu0YzO5O9J/wXNgnggmYi0J3PpH5z/F8gfPNYaHvCHbphFlc1lQOZU
	YkRPqpUch1zb00xQm5rHA2FbnKyB3QrPed8WjOnz6QvxTu2BxOsb3PNLZrJuP708gGGJ3QCV/Zs
	d4K+SQpBiXb6OnHlm/xjP2YCuSs5COazV91Qs05q4ywIMEdiW0LiVdYHeMg1LH6aW9VPuX0WojU
	VSWCuQBrgtsxnoXWkDc4Hm7DvPemkigw==
X-Google-Smtp-Source: AGHT+IHF9DwVbvdQ355Xv1NwvlOTAQziWiViVq6klBSKrs3f1IEAEOvsjGO9thVY7qh7+snUqzOKzjgj
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2484:b0:dc7:4af0:8c6c with SMTP id
 ds4-20020a056902248400b00dc74af08c6cmr133232ybb.6.1709047174691; Tue, 27 Feb
 2024 07:19:34 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:13 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-16-ardb+git@google.com>
Subject: [PATCH v7 5/9] efi/libstub: Add generic support for parsing mem_encrypt=
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Parse the mem_encrypt= command line parameter from the EFI stub if
CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
boot code by the arch code in the stub.

This avoids the need for the core kernel to do any string parsing very
early in the boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..3dc2f9aaf08d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -24,6 +24,8 @@ static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
+int efi_mem_encrypt;
+
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
@@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
+		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
+			   !strcmp(param, "mem_encrypt") && val) {
+			if (parse_option_str(val, "on"))
+				efi_mem_encrypt = 1;
+			else if (parse_option_str(val, "off"))
+				efi_mem_encrypt = -1;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c04b82ea40f2..fc18fd649ed7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -37,8 +37,8 @@ extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
+extern int efi_mem_encrypt;
 extern bool efi_novamap;
-
 extern const efi_system_table_t *efi_system_table;
 
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
-- 
2.44.0.rc1.240.g4c46232300-goog


