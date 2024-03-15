Return-Path: <linux-kernel+bounces-104802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EE587D3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F7C1C22FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746A1EB5C;
	Fri, 15 Mar 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4beNS4n"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3481CD02
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528301; cv=none; b=HJHjrpDPOF4vRCPU7uQHp21XHEzOju1ludAppo/Uap3Y5QDaAtzh0EFPgW5t9EMxNRI/7mmj79vgqFcvS9g3ThtFO74dHPAkWBnc4VPpyOqTrR9E8JTTlxwGwcqTxcIjIZG+nsyqmKCAKd8i1XM47RbF3Kpkko0qCzwtND+g8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528301; c=relaxed/simple;
	bh=kB/993s6zM5nsl2ZXYt8C7yUGsnhSABK4nzsJX/jlEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gTEhkgo1PtLNw4jiMynurQnSi9sPcUJpK2xtfwKBasq/3qAaUvZpxSE70Ym2NCQ9mAxEXAo7ET09aouWT3YhZtH3TPMaW5FPAwFDp4+LTFCpILJqkOuqFDN8hSMmptVZAfvxcOm5lrw1DuIqKOMddEVhNJwS4BcCLIZWGLZ1rcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4beNS4n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so4029342276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710528297; x=1711133097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLFV+TJ5jukvAp4sklQYPMZ0aYoTsux/8WqiDKfQ8Ss=;
        b=q4beNS4nPfr6kZ2gX442erBicBd4k3sD9SzLWpTxcVFPyzz9eKoED9kiAQ1nTbvnC1
         AA34WSdqGlGQhavCKV9D1um7mgUe6z9D0veZ68sX6co6YbYg44ExRTM5TbxUgm07GCFl
         r5w8xOEZLAkJlPnjklHm5K9F86OKD+O/fSJiDVle3t0X+m0IyajCnh1N7TYnqYCxSgAu
         vbl0Y5TmuLaWoXx6zONoUfJWUkPYxixThDK0BnZM1emSqdskxUfJYJ6WKh+V/TUMdc2s
         jGCZiBTNxEM9XrT1lfB78elrRGmtSKQ/GlJXSTTTC8VEWrGHt2/YxbYfd+kiWmCS23sN
         E6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528297; x=1711133097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLFV+TJ5jukvAp4sklQYPMZ0aYoTsux/8WqiDKfQ8Ss=;
        b=j0yBWL6pZcS3nph7QjrFfqKKwpgEahzVh73z0WEHNIxsVSEFaRUGa0tRixdxNg1dyi
         P7lpBCdC4rpDXHx0+hDeJaoWcyOsCvfJCQ3fg1qCT4+HuuduUdCixnXjFWEfs9X/pxTz
         vPBFBc6tl0jS7ZmRM/gWYc9kH72aFJgGP24ZngdINvKSn4ValQpuzctBoFpjIe7N6LGO
         vm84YhTdH/BH/GcFR5ZDvKoL8aKxM7/9sA/IJBR64AfyDoq2caI8KCpXEyiWTUaKXrKw
         i1otGXFZnXHdxW5fkRu+GF7NhvUb+nU4sg88AaFmJYiA6G9GPPIhKcNZopoPS3fi4z9X
         GppA==
X-Gm-Message-State: AOJu0YwRaIDahFOPf2fVhQQtGOBfwld8WsbE//7qh49nPvVJ/B193aPA
	dBrB5BC+nj9WYR5otOYJuuJdxYQAxQyZ9EXim0ulpoXDRwhIJWltkofS8v/CqPogaQk4Yw==
X-Google-Smtp-Source: AGHT+IH0lcRGeHyP7wKRBDhcWMcMJBZKUGFEpnqg7uZPPbhpxrtvVDrfVPTq6vA8J6eEWF0ynjVPEMfH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP id
 w4-20020a056902100400b00dc644d4bee0mr194914ybt.7.1710528297666; Fri, 15 Mar
 2024 11:44:57 -0700 (PDT)
Date: Fri, 15 Mar 2024 19:44:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=ardb@kernel.org;
 h=from:subject; bh=hNdFm9ohkKR/E9QgoVEO6nYJkzQJEo9BU623OWEdpzw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXLdHET9Xz3fZEnrzz7IPH087OFqreSJ3xNn1uZo31H4
 dqBxEXaHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAis44yMnQ2b9dO+Fl7N/Sq
 M//K6Yt/BCU0c9hOKVzEOM/+eIThjWOMDK1th5f/erunuG3BgaPHWS/zmfo4XzDb88alMvlBh4Z ZBxcA
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315184438.3609735-2-ardb+git@google.com>
Subject: [PATCH] x86/efistub: Clear decompressor BSS in native EFI entrypoint
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, stable@kernel.org, Radek Podgorny <radek@podgorny.cz>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The EFI decompressor no longer invokes the decompressor as a subsequent
boot stage, but calls into the decompression code directly.

This means that when using the native EFI entrypoint (as opposed to the
EFI handover protocol, which clears BSS explicitly), we are relying on
the firmware PE image loader to ensure that BSS is zeroed before the EFI
stub is called by the firmware.

As Radek's report proves, this is a bad idea. Not all loaders do this
correctly, which means some global variables that should default to 0x0
may have junk in them.

So clear BSS explicitly when entering via efi_pe_entry(). Note that
zeroing BSS from C code is not generally safe, but in this case, the
following assignment and dereference of a global pointer variable
ensures that the memset() cannot be reordered.

Cc: <stable@kernel.org> # v6.1+
Reported-by: Radek Podgorny <radek@podgorny.cz>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 35413c8dfc25..2096ae09438e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -21,6 +21,8 @@
 #include "efistub.h"
 #include "x86-stub.h"
 
+extern char _bss[], _ebss[];
+
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 static efi_loaded_image_t *image = NULL;
@@ -474,6 +476,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
+	memset(_bss, 0, _ebss - _bss);
+
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -967,8 +971,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
 {
-	extern char _bss[], _ebss[];
-
 	memset(_bss, 0, _ebss - _bss);
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 }
-- 
2.44.0.291.gc1ea87d7ee-goog


