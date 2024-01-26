Return-Path: <linux-kernel+bounces-40354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1283DEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4506CB21A36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC91EB25;
	Fri, 26 Jan 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/HaRRbu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460631EA8A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287172; cv=none; b=txTZxPVgJZLpjDwk4Vb10YMJWda9RvPdLa9PHNuPWsGob/sKB/AEDP+ZYuo4VE9fqecUlAfEyW8TmU1rvoAgTFcDVe8DruO8aZ68cvQskxz7aEdc7mV+gGkRRM5S9BHlwSCoppAbipDWs9d2MtaIappN9xxL/UVBbQoxT3gvY6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287172; c=relaxed/simple;
	bh=EFByUhMn6o7EKK+3IwvtG+AnT/BrGHBsR+easKAMjCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=amY3XHlxqpqmEWAgF3BTljfHdd3m9B4S2PQ1iiFclz34mvlixEHWEr44rSVMxKyGdmLNvFJr52kAVdtHOGmM4pwBfedsmRWGlzPbNC3WVGcEbI9ZAYdEI7ltSLGPaYksMNtXd+Qn2O68RICIkV/ZseK4+x3TuzR19sIqg6alVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/HaRRbu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6e316bso18306087b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706287169; x=1706891969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xlBgugPCo2xMSajYDfdTWi2w+CeDhsQ4ciWdtvT0oGo=;
        b=z/HaRRbuOSuWhhEq8DUTAuoMTtEsbV/qxaYuTUMdv2U4dkLcNoGSUOZBFRQkALmegD
         lcX69E1OBzFEjC7Lz7OiUMh10bHNrnWaOE/VkEVg9jKEIB73HUVBqC7MLSPnP24/30bD
         YqlolR753MdEr892HsERHYPSXkvcayF8Nwbb8pY+rTxDxtpf3W9SHo0UiSd3nP/nWLzF
         wWSMbusqotYBNHEDDue3GB2x/7xAQMNKZl+0cRYm+elCCtS0ItYSO0h2RIZexxaemKQu
         /VMiaQBxnCd6a2oUZD/47psKPoX2KBCVLIu+EkGyoKjt6j+nHSNGE46sut/lndv2HCMI
         E0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706287169; x=1706891969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlBgugPCo2xMSajYDfdTWi2w+CeDhsQ4ciWdtvT0oGo=;
        b=tkMExTTZFsH0ueo7kYzIKvVxIRSxvd97j1ljmGBVIzIVJLRQ8FQAi+S1ZopEA+gj2P
         VGCQuVtLXrUxE+gNTe9s54fUzPH/+PiLnG+6936BK4ftHYnNfWTVGbRBwXK1HGC7l70s
         3yS0KHyr/RYaL5K+LvTiJeUU5e0XRS0lTqYB8btDsvw3FnsnmqrjbQFkd+dbP6o0HQyA
         JsqbD6g1Aiq4Z7wx3qBnkF3L4HxuYDt/qcp/gH+9gd3/69CLVFPBFWfUD5Z9rMTuvo/j
         8PqPaULc+IOyz2rwCfhsrJRlFFMQCiZV3c29NZ+WMzVY92on8czAWjXzXFIPBiwvD/yS
         nepA==
X-Gm-Message-State: AOJu0Ywaoe3LpLJl7QbPG5B3KWPeChi8RbwR8CQxH8WA15T5hs2Rlc0r
	Hu/RVk8g8pPFB7aZOArhO7jeHcVpzUxmQyCUap4sPakVFhCDlQO/U7EPx3kTJSgVwfN0dpg2Tpc
	AbiBoAjBhUQyAkDArjwi0vOEtGDpmMAJbDsu8XYiRd2JjwJJBQE6PvtCiVx8ibiSmkITXCo9AKl
	kr8QuCLMBnHawJiSNvL89+geYKfYCIlQ==
X-Google-Smtp-Source: AGHT+IH5gDzUjaDEgGQGaNfKWeWPecLFu23Ifvo2PvUI9C53HDvPYQrmFJ1vfP4bVla6CYQYpEq5gbKz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:794d:0:b0:5ff:8269:26 with SMTP id
 u74-20020a81794d000000b005ff82690026mr9234ywc.10.1706287169275; Fri, 26 Jan
 2024 08:39:29 -0800 (PST)
Date: Fri, 26 Jan 2024 17:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=ardb@kernel.org;
 h=from:subject; bh=WUJPBTvb1mHWIXBiHT1P0Ob/I8UvCbEpFlwskhtt8WU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXXzA/MGZR6dfy8uCy1aFy6e2FouXMhTerVceoPs51Otb
 x+nfIvpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO594Phn+W+76uuXlgXblcp
 1uQ8x7zC+fnDzOTdrWUePpPmbypj2cfIcOTL5oVHD8j5OKRul1tRzbdBVPFrjmoEQ86bXasFC75 vYgYA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126163918.2908990-2-ardb+git@google.com>
Subject: [PATCH] x86/sme: Fix memory encryption if enabled by default and not overridden
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in
sme_enable()") 'fixed' an issue in sme_enable() detected by static
analysis, and broke the common case in the process.

cmdline_find_option() will return < 0 on an error, or when the command
line argument does not appear at all. In this particular case, the
latter is not an error condition, and so the early exit is wrong.

Instead, without mem_encrypt= on the command line, the compile time
default should be honoured, which could be to enable memory encryption,
and this is currently broken.

Fix it by setting sme_me_mask to a preliminary value based on the
compile time default, and only omitting the command line argument test
when cmdline_find_option() returns an error.

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Fixes: cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in sme_enable()")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/mm/mem_encrypt_identity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index d73aeb16417f..30df4f1725f4 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -600,15 +600,14 @@ void __init sme_enable(struct boot_params *bp)
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
+	sme_me_mask = active_by_default ? me_mask : 0;
 	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		return;
+		goto out;
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
 	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
 		sme_me_mask = 0;
-	else
-		sme_me_mask = active_by_default ? me_mask : 0;
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-- 
2.43.0.429.g432eaa2c6b-goog


