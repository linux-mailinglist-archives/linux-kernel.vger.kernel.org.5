Return-Path: <linux-kernel+bounces-60944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3A850B6D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BCA2817BA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA75EE61;
	Sun, 11 Feb 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OCC0SkVi"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85425E224
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682772; cv=none; b=qNZpOsRvLgKC6CFpRxdcvr41o9sqzyU2bor6D+oKz0AeNBjP7hGQZcf2X7agNJztp4re7R5rjpfXZUE/sfdcaEBuXdrz1zKc8mnkzEwwSDhUIdQhB92ZY2zMsraah3UR3btxsdNnbLBZKw0gvg/d8W6N+XgSYYnYRdsk1aEB8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682772; c=relaxed/simple;
	bh=nbDFD/TqWUYFdF7uxY/c2JRJpkeHNhciS5fxFdKpRgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b5dtZ1GynVi/rj8Re+GHmL0kyQRCqI0nEUGBqV0ANbEiaZZ5qV06Mc8V8TDBIw/V+c5oyyDsrwtkgxmDeRIO7sW3dcB2+kaPCV5aKy33LAwxddrNECZQZ2maMqHO99YrXIdiqnXA7nyvGltImBFfdBBfIMN1fvz/5WD3z9+Q1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OCC0SkVi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511898b6c9eso526959e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707682767; x=1708287567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FMeMe+UFSzOu4x02i7+Ei2gevYK/Z24NmaoVH1ZdN4=;
        b=OCC0SkVigvA6aBCxQwilkr2BPTgpL9p4baJABc7t6wVoRZ3kYQBkq1iLJO+thTJ8rt
         qQIBSgaQYAhSatQhUcBGmJQdy02OPpRObf2vwddjAURZlnyQiZ02tSrycNMa9yqKQWYu
         4FURW2qNaEplDEbIPzbanA3hL5wkwCSeQbYdoP4bMMKqE5EpVJw63+gBav3z4l4KtRzT
         vzZUlk4GVXm9GWGmtgule8st0dHC4oVOSXJsHhxj65280MQATCgAtujaUUpK4E9prynH
         U2OhqDPdlgTdzYH+M8XdnrN/0SaP6tXLA3UqopWHld1CEqN9PtU+HMbiFxJikQ3F66YJ
         f1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682767; x=1708287567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FMeMe+UFSzOu4x02i7+Ei2gevYK/Z24NmaoVH1ZdN4=;
        b=iPsgyXtsiSozsKl2W33AyjyWeu+eUZxt9AlsnOluhl5rgLOTZmiqepYv9ZLxyFNidb
         5UA4+fteYogLQFUZj5KvZAzsJhM1nv9TwG9c1BYMtrOUU2zOCKug7/y3kK7+w5M/2ETf
         kAHDc6rpahnDYwdZct5/Ol8MMokQBM1HF5+eLi/h2ZdXhjDOa/2Nfua4K7H+AvfC5RsB
         GPGsJXMD4BNheQMKqo6o61Vq2e8PiB5ojm0otRac9YZvgxJaOLGBs50wepwt4FUIJMNs
         R2QeUOZBPDw+C78SYAUwH5Albqod17huRotPjC6NDddhYXVwoQztz1dafa1+NZA98oaQ
         HIRw==
X-Forwarded-Encrypted: i=1; AJvYcCXGMg8/LdN5zmHVqoZ5OtIeUOblQpZWej8g8I7CKOGJHUnqP27bM4LvlU2/XackFn4NrTFc9TEORxz90jtu4cWyrUMkFi2kwhhxjP7W
X-Gm-Message-State: AOJu0Yy1T8tfWUsceRfBZ63NTG+SaikeMts595KjjAhKFD3LCuF+Lriy
	zOJapa9tUMCJEZaZ08TEU+dMNHoWDAZTI/6IKklpFdNTotBIe7RSHpbRtjtLG90=
X-Google-Smtp-Source: AGHT+IHQQmg792AOqBaYpSyBlLcWoqqjQ7Q0vAoOPfmaWNxycd0p70GpLDpxxJuD6SOMGV77gIbPFg==
X-Received: by 2002:ac2:5990:0:b0:511:7681:1853 with SMTP id w16-20020ac25990000000b0051176811853mr3113052lfn.16.1707682767663;
        Sun, 11 Feb 2024 12:19:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWb5XZKpwgH9xx+A38BFP1sYW0fOK2x4MP8ZDj8dl80CVM9iCH5qFj4jBWu2j+WCHYe6CdZZ7EdAg0bspn0xWdzI7mavvJBS21jXsQf443GIO5L2nJ3fI6sdzW1ihXsIrkm5HQaY6po7MtuVai0Uq4zfxN+m/uQ9wEcVARBXWbNcR5zK2DIZ/kS7IdMx0ra0Vyh7cB9l4TPiQ==
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a3bff1d4465sm2720318ejc.165.2024.02.11.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:19:27 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ayala.barazani@intel.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] iwlwifi/uefi: remove CONFIG_ACPI check
Date: Sun, 11 Feb 2024 21:19:19 +0100
Message-Id: <20240211201919.3751551-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a build failure on ARCH=arm when CONFIG_EFI is set but
CONFIG_ACPI is not, because uefi.h declares iwl_uefi_get_sgom_table()
and iwl_uefi_get_uats_table() as dummy inline function, but uefi.c
contains the real (non-inline) implementation:

 drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of 'iwl_uefi_get_sgom_table'
   359 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
       |      ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/intel/iwlwifi/fw/uefi.c:11:
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h:294:6: note: previous definition of 'iwl_uefi_get_sgom_table' with type 'void(struct iwl_trans *, struct iwl_fw_runtime *)'
   294 | void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
       |      ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c:392:5: error: redefinition of 'iwl_uefi_get_uats_table'
   392 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
       |     ^~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h:299:5: note: previous definition of 'iwl_uefi_get_uats_table' with type 'int(struct iwl_trans *, struct iwl_fw_runtime *)'
   299 | int iwl_uefi_get_uats_table(struct iwl_trans *trans,
       |     ^~~~~~~~~~~~~~~~~~~~~~~

I don't know how the driver works, and I do not know why the
CONFIG_ACPI check was added in the first place by commit c593d2fae592a
("iwlwifi: support SAR GEO Offset Mapping override via BIOS"), but
since it did not add the same #ifdef to uefi.c, my first guess is that
this piece of code shall be used even if ACPI is disabled.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 39053290bd59..8617fe8b65cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -285,7 +285,7 @@ static inline int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt,
 }
 #endif /* CONFIG_EFI */
 
-#if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
+#if defined(CONFIG_EFI)
 void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
 int iwl_uefi_get_uats_table(struct iwl_trans *trans,
 			    struct iwl_fw_runtime *fwrt);
-- 
2.39.2


