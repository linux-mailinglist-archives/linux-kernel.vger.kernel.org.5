Return-Path: <linux-kernel+bounces-81628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60006867884
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C6BB2650A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8112AAEE;
	Mon, 26 Feb 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkVllO0y"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02F12BE9A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957816; cv=none; b=svDtmr9luhJNWaLtZcHbWqHP6W+lM0zvF8IqM1GCAXQKc2R5xEfoZXR+gnqtpNuoxich7rbBfmgdVEsGnxUAWQL6qK6+ccDEvdA1L4DIrhgigUTB2HhpYV/aaqgsValEDHzUV0DkGsoXmTwOHMDkchO8qUZ9rSULhfioKQPI3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957816; c=relaxed/simple;
	bh=e/CqAzmvAxdJ7SZXVlU7ObmDh2K2WYB6MEyzEq28Se4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G/34nLjQNCjp5pOTsB24ERR68bpbx2n71rJ/tDIECdWZiahV3Ow2KHYJlsvHydkuwTaizhndAHGGd3YctDPz56hBHdFG755GPnHVNwmuGg7cbMMHk41EyYTRfzwTHrKS+4e4EfSDY7ALhlrzaYgv4Yhw98yhLNwKcMTjVZ9yG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkVllO0y; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso5303803276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957814; x=1709562614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P75XCjLnB2v5ig5LKSiFYmfdvurR1I1hUffUvu8kLLQ=;
        b=RkVllO0yYRo8m+z55GwrpzIHoVKZpVvF8roY26eblnUDDqJLy7JP5gwkO9Z8zIHHYF
         FsF6WiOHbsFhacOqcY1txwBGeG6q9LIrDzJH9/ScWtflI2PK7gD0Nh039V0o3Fkjeq19
         wCRfxxJXGpjO5qJT9PmMG9TXh3vLyGWq6xllpo6QLdqCHO7jqBVFQhiBgbCvO979ykWU
         q5jBKX/uzeqkP87605JJFUfozyKClaB25F8FhxOZlpfrWRAGpb1ca4uH9YeNwXnxQcHZ
         fWcXapVPNkAXugut3aFcPMz/5phkB6GF1EXsS5CwiR6Ro/OFWTOwrjbg3wm2VYWJjUM/
         lY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957814; x=1709562614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P75XCjLnB2v5ig5LKSiFYmfdvurR1I1hUffUvu8kLLQ=;
        b=eTzzlpcoXTcbl8wxQWm9TQkRqttqnf+xdjyY7OqJmhsf+fG/xOUdjBkROYzTI3/T2y
         vZ1eRl/ENHAQBDWL1VnLBmH4pv3SfGgu2IY0LzYe1ozabFmo4TU1RtefTNkFmzjHXg96
         mZerkC2/oQwmFbyW9Hc//6XNeiGiCuAxwMXY/b2AQEvcq7JJJe2eZJE/mlVIHVkyPax8
         G/G2hocgY/gfpV8ljzZoJmk+wCSqDDC7yx3fHmVfq5QPJGf6SM9+wV2p/wKKTrtJEdcv
         Z1N/t9ceXzkT3iOdMj3pb5mtdZaTxTeom7hj/fyw5EoCzbjoLxgmTMzbE0kOkCCb/uUY
         uyBQ==
X-Gm-Message-State: AOJu0YwRe6SkBggq6VhBQA+XbtANqjoG81Lh9OSWZl9381aHK6CgQ0Gf
	RM/9gBF/Zjwx8zPNsHIOyUWtgbcf0DyjTnvHuvC3/XQ33+GWUSNjOqZVc2ISpJoYY+3zzv4Istk
	PXt52MlcHR9GCFoiFV9KACet+nGoOoFxHg3t8qdx3bXbLacaptUCct7c/Q9IMoXC0FG1X9t3Q9g
	/+iIZ0QAvrcIIPnS05UHa3KIfXxbKrIw==
X-Google-Smtp-Source: AGHT+IFkhUbKPQSvnYVDIkijn4hVMNiX4u0b3AUyvAU08al4Mw8VGTXeKgN2pdcDQppUtzsHKfYTnbrm
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:69ce:0:b0:dc7:9218:df47 with SMTP id
 e197-20020a2569ce000000b00dc79218df47mr2124240ybc.5.1708957813722; Mon, 26
 Feb 2024 06:30:13 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:59 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-18-ardb+git@google.com>
Subject: [PATCH v6 06/10] efi/libstub: Add generic support for parsing mem_encrypt=
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
2.44.0.rc0.258.g7320e95886-goog


