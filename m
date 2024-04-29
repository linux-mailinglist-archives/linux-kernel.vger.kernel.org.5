Return-Path: <linux-kernel+bounces-163089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A368B6553
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6698D1C2180B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA00190698;
	Mon, 29 Apr 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SMMJ4PDT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710217798F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428482; cv=none; b=GPDipHRWfDJfbJrjX47eTn7zamVJSyHBziLIXkiuu1umP2+gnmy2vQdjfiNLHPXQA0XQG4fdI3Sy3jzeLrFLlL94oHXnn665K+RuxFcg1Eb3L2GB9NU4otrZFveCSb5UxW26M+Aq4ZEXZgHRHymtBKsQKDA44vXATbyC/eSXQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428482; c=relaxed/simple;
	bh=c6DOXNFSE9LC756AIalg/cV64lMokKtaCuXo91v+i34=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cgJigREYGyhCfz4lRsbepmK34k/IPA2utOLoLejPkjG8/dXLvaXYXDlHD57AI1ktCuIxt4wixruAlo+LS7MRkBFY7tV7F2LHeRJ1Sris7Gqcg/BtruzCYjbyepAQIXTmuXwHnyz1n3FzJTnc5VdQ1mcRsNaOf1vjC14Rn4V8CGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMMJ4PDT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elsk.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so1025442276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714428480; x=1715033280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FA8V8gAzYFmHUQzg7LC2FwIVOm15GM/FHQJrgNvwAkE=;
        b=SMMJ4PDTcv7H2i4o0zGzlZV8x1icw8CD0NzK9zl8mpEWyXeXFn3frAbLOVUUcyaysA
         NwWUcL+uMl1kJ9IJ6ecIp0v3do1ONpTluevTTEJhWkFPSt7qGJAaZrCE9H3eBeruE4Vg
         peOUvT1GeHvCPjoccobTY9zhOuI4cVCSOG3HD0Ysa1Lc18S/QPuDTGOJbxqxrnSSpTjB
         4jSla7YurIdmJZOd0f4uhgHHLduj4lVggtUlKVWP2V1etTjjI3LYG7erRzMmtR7bi7Yw
         yo0ryGQj0oyN1a6LEq0nzx1Di0RdnxcQzeLJ8vzSG21Y8ZM2kjy5WhHenaFo4q81XtT7
         H9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428480; x=1715033280;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FA8V8gAzYFmHUQzg7LC2FwIVOm15GM/FHQJrgNvwAkE=;
        b=LjTO9V18IfAUW9coyIJ1B+SsfMdXocXnf9I6Xpn7U3xFyRGyPbi80+9oYQHK59/cq0
         qYK8YB9GvBgq3KNornIyXcZDitIQrKICAOXy+Uns8TGHW4NtFKsQMnNe0WaRTypnLodM
         6wAl4mjy6ecEKvyfqQtAS19JCNCCZhabgc1qdT+TTIjvROJA2VzW+GN/59utrYBuEl/x
         bZZPoVrfyaS2tkGkLRIMIxUubuDB0FjpARV7+HiaoXuHTH5JinFtZN7eBTn3WPd0pMYn
         1vAIk0PmeoSpJx3tIMI5OLTHHi64uE339idwEYHpUEJMcY6fKawSyjJ6VbzkZT+R2+LF
         X2yg==
X-Forwarded-Encrypted: i=1; AJvYcCUVd56pm2sd727O0T2h2Ub3P17uRK0eKOzzg1vgHNv6qSx1x0UolSmm2GAvG4HQzjRFqY/gSys07ga6QmMIVFBbhdPPV/wV0u+WVmih
X-Gm-Message-State: AOJu0YyRHsbZ87kpAKijaGweI8z6/cSrv5VI3xN2VgXD9uKJ6ziYxUFj
	584gcdeNlROm+jcAyS6cwAJdlbc+Hyq8WFgcm0QUAZ28nlgoBOTSmWzMlWxrYyI/FavZ+A==
X-Google-Smtp-Source: AGHT+IE+uWIumkI/51wfaF//38ql/5Ay511pPM+gcPsmGC0cRdqsl57WUREGxwArKrVla/CcvxgSb9Cn
X-Received: from elsk.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:dbd])
 (user=elsk job=sendgmr) by 2002:a05:6902:c04:b0:dd9:20c1:85b6 with SMTP id
 fs4-20020a0569020c0400b00dd920c185b6mr310500ybb.2.1714428480334; Mon, 29 Apr
 2024 15:08:00 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:07:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240429220756.979347-2-elsk@google.com>
Subject: [PATCH] kernel/configs: Disable LTO on kernel/configs.o
From: Yifan Hong <elsk@google.com>
To: Yifan Hong <elsk@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This solves an incremental
build issue that, when a config changes, config_data
and config_data.gz is rebuilt, but because the
thinlto-cache cannot be updated, the config is not
reflected in the final vmlinux binary.

The issue is described in
https://github.com/ClangBuiltLinux/linux/issues/2021.

Signed-off-by: Yifan Hong <elsk@google.com>
---
 kernel/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..76d9acc49c5f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -140,6 +140,10 @@ obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
 
 $(obj)/configs.o: $(obj)/config_data.gz
 
+# Disable LTO on configs.o so changes in .config is reflected in vmlinux. See
+# https://github.com/ClangBuiltLinux/linux/issues/2021
+CFLAGS_REMOVE_configs.o += $(CC_FLAGS_LTO)
+
 targets += config_data config_data.gz
 $(obj)/config_data.gz: $(obj)/config_data FORCE
 	$(call if_changed,gzip)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


