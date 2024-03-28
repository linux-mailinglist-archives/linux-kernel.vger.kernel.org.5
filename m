Return-Path: <linux-kernel+bounces-123133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F189029B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995E81C282D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60E128826;
	Thu, 28 Mar 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuYVPnyW"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8347E772
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638333; cv=none; b=Is16FNttQtmSkoQDqqQ1iG/supOJs/g9KpCU4Q5vRbwyzTe4AR3eohEqSnbI28VAMVG9XQWe2P155v/VzQGMZyRUlV/l7ksGnh/hCdMDjwRIfphliBCILsfiel2BPLubO4NBy83tesfo5Nqu76yxazoFysAWLn7bQs7yYvd4lAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638333; c=relaxed/simple;
	bh=DvVtVkdj/xq9SPMDDWqV0PydJ85/r49KUBHLzmjWpFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tUUoT75r/HFY1N8qY9Oiaak3W7GzN8wZcHY1SQTYEqcyT/gxdoulwm6DNW4/QCxF655KJN9tOxR53hlqc4B3rthmWPC0BeoKYhOrzEO/nmeNn1do3N1q0sWdwQ7CKXZ7U5+qhrK0EbuQl8w8RYti0hI+TWEo3a3EL0nprs4j+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuYVPnyW; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33ec06aac83so777560f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711638330; x=1712243130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmyU6Yu7TOVivZ+D+Eulo3umiyHrJM2iYAbO8iKOjRU=;
        b=HuYVPnyWiNdzdrAJ7vnssUFkd7g1XfSItNCwNViBDMtbHY/ayMUHVVHbcki8g/jwcP
         5xUaIGo9ttQzds6Gri0KNsbk3xO3gPoVz/kvZSqBrAW9XTb5xSAmtfb6YQrspjBhi9+G
         rHSA+hGRhJXcU6IIZAiSm0n+OPnnpJFcK0ZJYLQp8F9q3fq4mpKs/THxcw8g0Wt2tc4m
         c3mgpk+T7E2iwy77wrJk7ujxnwg4VzWJn2Q5Q2weknWH+BbcezOs+I/iNv5i4/F1+HxE
         c+DTXhYG3/oobV8YGWMabL7YHrfcIELtj9ohV0yrGClb8nbl+FStnv4iLAXIumtVJ6T6
         yugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711638330; x=1712243130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmyU6Yu7TOVivZ+D+Eulo3umiyHrJM2iYAbO8iKOjRU=;
        b=UaLsDNUwdC+3nYiMJgBvd4WZ+W2C66JviXq97oG4XFr3lPQdTwaS3MvjnGZymj0xSd
         ivrJGPV20Yr1ic5Xf+7QTRseVKUVEv40w2rt8OFgp76FRdKipdnmgafpuHobZUEiCMtC
         c+eEnoaOpeYxIOxuQR41Xh0q7SlybRzPz7wl7/GS+khTq+pk7z11eQr8/FPlz4I2atg8
         zrSPoePXBPXHidwM7ftKlUuDOBomYCEDLWIUIjx7wk7tUgT7rHHChQih+MT1P5hY+QQ8
         MTBVP1Qjo9U3vdZzEW7ELEhDAopdOIw2SGUqLsT5aFjR5GhDnLB3Uennb0rzRXd83Oay
         fLtA==
X-Forwarded-Encrypted: i=1; AJvYcCU94lNffmXNDE709D88C7BKKXolZBSuaWPgyFG9E/pa0Of9BzJgu66f+RVA9PA7hjDSWDvWTUpTzqN2J0tnyT9OTcG1nAE3uen71uBe
X-Gm-Message-State: AOJu0Yyr4MbSEL9MinNs4dtBDb6GhQWGZbGih+EKU3wN22flrUqKWzNF
	9vfqz0cmuoQfc4dI3d5z6oi0u9NRfzJ56V1htQootoQ5UXtQnNxoGbu45JGqDU4Yux4Inw==
X-Google-Smtp-Source: AGHT+IHeQavSUikChNW3HWA6yHXSdwGP1+pS+iG/BsqefW9XS1E63O6QhSB+Rx7xIOBwQ0pIy9D5+P6V
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:484b:0:b0:33d:7187:3102 with SMTP id
 n11-20020a5d484b000000b0033d71873102mr6600wrs.9.1711638329971; Thu, 28 Mar
 2024 08:05:29 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=ardb@kernel.org;
 h=from:subject; bh=ZTMdFQoy1C+mpy8vjsEBBo2nOP7zfUzVYdaGjwTiF4M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY21XXfJxkkuS05/fLcpLXuH846uB3tm6WUyPnkjUx5Sx
 vjjrOzKjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRLhNGhh3yn9Puc8bFPPpR
 b+F72jNpzQr2KZ/tNp7MyUnzmsOac4SR4cOhVSmCO3ZfXn5mtuTHZxG3JJuj70kJFxUH7d543PD NcQYA
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328150517.2584470-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Reinstate soft limit for initrd loading
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Radek Podgorny <radek@podgorny.cz>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit

  8117961d98fb2 ("x86/efi: Disregard setup header of loaded image")

dropped the memcopy of the image's setup header into the boot_params
struct provided to the core kernel, on the basis that EFI boot does not
need it and should rely only on a single protocol to interface with the
boot chain. It is also a prerequisite for being able to increase the
section alignment to 4k, which is needed to enable memory protections
when running in the boot services.

So only the setup_header fields that matter to the core kernel are
populated explicitly, and everything else is ignored. One thing was
overlooked, though: the initrd_addr_max field in the setup_header is not
used by the core kernel, but it is used by the EFI stub itself when it
loads the initrd, where its default value of INT_MAX is used as the soft
limit for memory allocation.

This means that, in the old situation, the initrd was virtually always
loaded in the lower 2G of memory, but now, due to initrd_addr_max being
0x0, the initrd may end up anywhere in memory. This should not be an
issue principle, as most systems can deal with this fine. However, it
does appear to tickle some problems in older UEFI implementations, where
the memory ends up being corrupted, resulting in errors when unpacking
the initramfs.

So set the initrd_addr_max field to INT_MAX like it was before.

Fixes: 8117961d98fb2 ("x86/efi: Disregard setup header of loaded image")
Reported-by: Radek Podgorny <radek@podgorny.cz>
Closes: https://lore.kernel.org/all/a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 6a6ffc6707bd..d5a8182cf2e1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -496,6 +496,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->vid_mode	= 0xffff;
 
 	hdr->type_of_loader = 0x21;
+	hdr->initrd_addr_max = INT_MAX;
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
-- 
2.44.0.396.g6e790dbe36-goog


