Return-Path: <linux-kernel+bounces-132329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C681E89932A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BC91F224B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A2134A9;
	Fri,  5 Apr 2024 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CPDL28pS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D09FC19
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284442; cv=none; b=Rson+j2/oxXZxe0KXl3nBxBC62bUxxZsZ14ru3XXzNI5Yz5zM2qgc0XpKWaKBd74JhWV0gfRDOV9qHZddXMZ5pVr8zAA5tC1qJL+1VOqRVSUaWDrL3w/diq4pN45qIdy2+36pwcpeg5H1MMoTqHPk0elX+szJt/bsM8izl4n6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284442; c=relaxed/simple;
	bh=wO+X3saS4uyVLQDMRU+NaQhCLOWmvrK0q75shb6+LmM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ougXhMlxGheCv3XsOj1pAdNjPctJB8BriQ/A0rQEDPQSq0BjbGtBZC8eFZlvxtjJHe/ATKDCiAU+i5zvgmMqr8fWRWSb6Ud8yP8Nel714w37Z6e4QyHavmFV9QOtz7t7GIsjDxPTuuNpFCb+zfdlcqQ3BbA5jlMz7AisxoIuoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPDL28pS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso27970467b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 19:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712284439; x=1712889239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iwbHBqeRFEUfVJ+3aD1i4LMY2bXuO8BYqPMFzWHirHE=;
        b=CPDL28pSutYnXXeiACDcwD0Q7V8wI6yNVIzL617Zopvjo2fbyTRb/LtVKdbt8SggTV
         iRmSR39VVZZ5xPRkVLITTlYesBFrtWTfdkeWukVJwM2c/wOrrcfg2dnRr3XetxCArnJv
         V3j/89FQ7AclXucc7gkuBSnRvqTaScCRvtzpHjeE7Kf/ordpUJmRw0AdSDCN84eYH9C9
         e9TXPjtHsHdS+K7SKUqlNS0Sr0LHydZ9IzveHF9ZwbaU1Mh8H+EVfN2kVzI3jYOLP7SO
         M1Xk4clbXAvK55WbZ0qMM/JiOwhxK7PV1ScIw0HdtPe/hLCHjq/KwOaGDdsJX/LM3Juf
         xa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284439; x=1712889239;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwbHBqeRFEUfVJ+3aD1i4LMY2bXuO8BYqPMFzWHirHE=;
        b=nWxgphXBywh7EJNg3sCN6kUYtYMHlgWEdbSOy6913VXTbumHw6iExKfGasq1pqoLRU
         QdRWDuiaeLIZGrbYIw94085xrRxvYlH4+KMPurSibIyiyQlo5yFbwaF8gWm+vLMSb1Rw
         HY2bWRTiqfkvrUgS7MgNIXnkXjLleVVyoqW0Oj1FWQ3AMnHXUhkhXWcUildt6cm3bUdc
         qMlTI4aBxfYHVaObC5OMZlKkbJYYSLDcAnx6oxVP2xsr1AQf5XKbzN6KYyZvCkiQQMqX
         E01txaCfW77Edviba+zhmhSSeq8ztNHMMSMOYxO5YblMx2nmTFbDpjN2FjWgklDaouNx
         Ywtw==
X-Forwarded-Encrypted: i=1; AJvYcCVl/IGsoLlZSo5t/G5g6r38pwl/CLv8gKMUjRnwj9Y48GAJa0i4clIjkAIYp+KklveWOVDr3cMGcAyj1kNjVTy2ogdMcvv1pNYfPjU1
X-Gm-Message-State: AOJu0YxDNF6K0uQbtep3/bFfha44bOlwxFNzPgE6wISUJF2F8i8PucPX
	FefbHIsjgu/sG2yY6SA8iB/Dwyk7g9v6mdDkvRpoUQQngvPXPb158ZeEfvaFRxHXOMZuoSbKKza
	iaEkIf6xUjoFhbsBdwZXKGA==
X-Google-Smtp-Source: AGHT+IEZvT3gn3hf4hHPSv3p3Ssos4Ig8JcIIIdsmab32//XdptkM2Ej7aJXeeyV6n+4mylECLbx+EvZkt8mAqr8xw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100a:b0:dc6:c94e:fb85 with
 SMTP id w10-20020a056902100a00b00dc6c94efb85mr476ybt.2.1712284439335; Thu, 04
 Apr 2024 19:33:59 -0700 (PDT)
Date: Fri, 05 Apr 2024 02:33:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABVjD2YC/42NwQ6CMBAFf4X07JpSQNCT/2GIgXZbNmBLWiQSw
 r9bSLx7eId5h5mVBfSEgd2SlXmcKZCzEcQpYbJrrEEgFZkJLnKecwFh8laOC/ToLQ6gsH0b6FW
 770kOJBQZFqjERTWZYtEzetT0ORqPOnJHYXJ+OZJzur8/e/aHfU4hhVKXVcMrvGqd341zZsCzd C9Wb9v2BejKJwHTAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712284438; l=2619;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wO+X3saS4uyVLQDMRU+NaQhCLOWmvrK0q75shb6+LmM=; b=uqRBHljMePkjFgGA0deBKFCE5V0apxMiuEMkeOwlan7tyHSjXUKzCeg0mE+95hPCVFwwbSokl
 ESs9XgcTc+DDjmV0K//0Bq6uIuu5zDuqfFSrMH8KvRmXFvYxKVLM0j2
X-Mailer: b4 0.12.3
Message-ID: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>
Subject: [PATCH v2] kdb: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

We should move away from using strncpy because it is deprecated [1].

Since these buffers want to be NUL-terminated, let's use strscpy() which
guarantees this behavior.

The code in question enables the visual autocomplete when using kdb tab
completion. After pressing tab a couple times when sitting on a partial
symbol it will attempt to fill it in. In my testing, strscpy() provides
the exact same autocomplete behavior that strncpy() provides here (i.e:
it fills in the same number of characters for the user).

You can confirm this by enabling kdb [3] and booting up the kernel. I
performed my tests with qemu with this incantation (wow these get long):

$ /usr/bin/qemu-system-x86_64 -display none -nodefaults -cpu Nehalem
-append 'console=ttyS0,115200 earlycon=uart8250,io,0x3f8 rdinit=/bin/sh
kgdboc=ttyS0,115200 nokaslr' -kernel $BUILD_DIR/arch/x86/boot/bzImage
-initrd $REPOS/boot-utils/images/x86_64/rootfs.cpio -m 512m -serial
mon:stdio

.. then you can type some symbols and see that autocomplete still kicks
in and performs exactly the same.

For example:
tes <tab><tab> gives you "test",
then "test_ap" <tab><tab> gives you "test_aperfmperf"

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://www.kernel.org/doc/html/v5.0/dev-tools/kgdb.html#using-kdb [3]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use strscpy over memcpy (thanks Daniel T.)
- Link to v1: https://lore.kernel.org/r/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com
---
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9443bc63c5a2..60be22132020 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -368,9 +368,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("%s", buffer);
 		} else if (tab != 2 && count > 0) {
 			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
+			strscpy(p_tmp+len_tmp, cp, lastchar-cp+1);
 			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
+			strscpy(cp, p_tmp+len, len_tmp-len + 1);
 			len = len_tmp - len;
 			kdb_printf("%s", cp);
 			cp += len;

---
base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
change-id: 20240402-strncpy-kernel-debug-kdb-kdb_io-c-53e5ed26da3d

Best regards,
--
Justin Stitt <justinstitt@google.com>


