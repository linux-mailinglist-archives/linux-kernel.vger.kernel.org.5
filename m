Return-Path: <linux-kernel+bounces-91832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5753871743
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AE1F21D67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A37EEF4;
	Tue,  5 Mar 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKhZ7Fxh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4D7EEF0;
	Tue,  5 Mar 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624968; cv=none; b=VXe2zZdeOJ7JBu7keHH2+r8+Z+aJiyncSA4BKuEdiHoaY+TbgMYEJwpS/QzjEQoWi+sV0GlJjCfMF9ab9LhSaE1mF6yeMBCakoc8FXSOnKqjNv9BBR8idpeAcEWZUlVdu5ToqGPy/ZshuXBV8gW4TKhI7OiB+tbymW2mQaFXapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624968; c=relaxed/simple;
	bh=p8ryLph/njcF2yJzCOz7CWGFDn156k5T+hsD21HoS24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=atGGFgJXoQE74525zrQDNPu86OlrBB3HPI2AIclMXmOhlujPd5vfahKMidSYT6ITIVNK9qapYw+aVw6sbX65uSckBzhAxaMAd9ZsbwFnd3FkcoqJADsvLORf7VJxtwrv4hA6jcq7zHLQuxNq09qejEsvTyFZl/JqG+myQyHOTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKhZ7Fxh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso6630152a12.3;
        Mon, 04 Mar 2024 23:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624963; x=1710229763; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCX0auiZryC5KrHPpTHfRcR6iRuzPAFogV7EnoE+qzQ=;
        b=RKhZ7Fxhrhj0YcAnWwo8QayHJii091RT6xLLYfxci7iZs5VKgnyxyDejoDh+NIN3RU
         s2rknqW0fHDniZnTn/nU1e+RnrFC7gwkhp8l81MRltWk2wsikHRifmSSwSP88kR48E4S
         hWQuXfoAnnDK7Xrv+N4Ax4GV7H1iKRF5JJvaUXsGA776+8v8m5s9KOkpWBb7W8yyb2/O
         Qdyp9hFUuORORJ8p+Fw5YWCqcyPHEjX0YgRVot5385WOZ7cVHUxa9/37y89WERU6tDJu
         bHarCnSHMyxfW939hKuRcrVfbSF7gs0W7EjAsb11G/gi6A2HIcu9otSHmijd1AfwBB1+
         sQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624963; x=1710229763;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCX0auiZryC5KrHPpTHfRcR6iRuzPAFogV7EnoE+qzQ=;
        b=ePTZOoHAQdbRjGSIMdbjYV2xUHKrGCvspuEJEt5WWtOKaFh5VYr4G2UtPctEAusIdi
         Qkr+MEPEe5o7hJfNoMBufIVWqZaCObruIJzpH5oYipqE3gS6N+HL9wVHlRC+mhd7+YET
         vV4k+i57clf7ks7yoVRB++FetWA6xVbLNdMaJ2/umv0QbuCzTeTt7sSnpBIpK9KVGVgJ
         ES9nFbVH6zUZqM92df7jLM04qAxzdQvRFYzRzB8V/88trQ86Stvj1BO7+K/ThXGLmXne
         KFQ2vVZMLB6tnCjWtvAGeWNEl/54fQe8j1B6CojP8cnpAc8rale/aKViNUYs/DUehkKR
         Td1A==
X-Forwarded-Encrypted: i=1; AJvYcCUkiNC7Jj6cqXa2aAOC3avsGqt7+x7HIVyK49POqjImUeA4S4yXTaZMCrp/50bb3hNrHTNLsPaNLaGvAgIfPY9Y4yxv5HiU4U7okFSr
X-Gm-Message-State: AOJu0YyqypKmfMtB2HTI5QRuNKmO06HAF/OaIRmGFJyMaqdBGCvo8+Gz
	4TFX+xQJ6H9RbGThEM1fozupjQep3edibRpr718tHZHg2u95cWEL
X-Google-Smtp-Source: AGHT+IE/XJ27OlyWsKMMWaLgtL4MZp+77EW7cyIhqW256NIrNdQvYrxhtMwWQYOia9iaYwlUJbFRcg==
X-Received: by 2002:a17:906:ad9a:b0:a45:2601:56b with SMTP id la26-20020a170906ad9a00b00a452601056bmr3618927ejb.51.1709624963380;
        Mon, 04 Mar 2024 23:49:23 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id mb17-20020a170906eb1100b00a4490267ecfsm4598596ejb.221.2024.03.04.23.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:49:22 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 05 Mar 2024 08:49:21 +0100
Subject: [PATCH v3] Revert "Input: bcm5974 - check endpoint type before
 starting traffic"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-revert_bcm5974_ep_check-v3-1-527198cf6499@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIDO5mUC/43NSw7CIBCA4asY1mJgCpa68h7GNECHlmgfgYZom
 t5d2pU7Xf6TmW8WEjF4jORyWEjA5KMfhxzF8UBsp4cWqW9yE2AgWMEkzUsY5trYXlalqHGqbYf
 2QYvSgT5rAyUXJF9PAZ1/7fLtnrvzcR7De3+U+Db9bSZOOW2McEwASKXcte21f57s2JPNTPCnA
 9mpQGqsDFeqqb6ddV0/oqg5yQYBAAA=
To: Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, Jacopo Radice <jacopo.radice@outlook.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709624962; l=3696;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=p8ryLph/njcF2yJzCOz7CWGFDn156k5T+hsD21HoS24=;
 b=889uq/KVEa8XMPw0IgKRlPpM2l+N9bsJeYtZu3ygyFiwZhfLSCz55upk+02VJ60L90JGfGG12
 hap7T8P1lGzBpU1gNDokGt+k5ZduQQZbtMKYqhrmI1ZRc5/HOz1c65Q
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This patch intended to fix an well-knonw issue in old drivers where the
endpoint type is taken for granted, which is often triggered by fuzzers.

That was the case for this driver [1], and although the fix seems to be
correct, it uncovered another issue that leads to a regression [2], if
the endpoints of the current interface are checked.

The driver makes use of endpoints that belong to a different interface
rather than the one it binds (it binds to the third interface, but also
accesses an endpoint from a different one). The driver should claim the
interfaces it requires, but that is still not the case.

Given that the regression is more severe than the issue found by
syzkaller, the best approach is reverting the patch that causes the
regression, and trying to fix the underlying problem before checking
the endpoint types again.

Note that reverting this patch will probably trigger the syzkaller bug
at some point.

This reverts commit 2b9c3eb32a699acdd4784d6b93743271b4970899.

Link: https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622 [1]
Link: https://lore.kernel.org/linux-input/87sf161jjc.wl-tiwai@suse.de/ [2]

Fixes: 2b9c3eb32a69 ("Input: bcm5974 - check endpoint type before starting traffic")
Reported-by: Jacopo Radice <jacopo.radice@outlook.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1220030
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Fix "Fixes:" tag.
- Link to v2: https://lore.kernel.org/r/20240305-revert_bcm5974_ep_check-v2-1-925ae9b188d9@gmail.com

Changes in v2:
- Add "Reported-by", "Closes" and "Link" tags.
- Use shorter lore link.
- Link to v1: https://lore.kernel.org/r/20240305-revert_bcm5974_ep_check-v1-1-db4f0422588f@gmail.com
---
 drivers/input/mouse/bcm5974.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 953992b458e9..ca150618d32f 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -19,7 +19,6 @@
  * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
  */
 
-#include "linux/usb.h"
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -194,8 +193,6 @@ enum tp_type {
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
-/* maximum number of supported endpoints (currently trackpad and button) */
-#define MAX_ENDPOINTS	2
 
 /* trackpad finger data block size */
 #define FSIZE_TYPE1		(14 * sizeof(__le16))
@@ -894,18 +891,6 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
 
-static bool bcm5974_check_endpoints(struct usb_interface *iface,
-				    const struct bcm5974_config *cfg)
-{
-	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
-
-	ep_addr[0] = cfg->tp_ep;
-	if (cfg->tp_type == TYPE1)
-		ep_addr[1] = cfg->bt_ep;
-
-	return usb_check_int_endpoints(iface, ep_addr);
-}
-
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -918,11 +903,6 @@ static int bcm5974_probe(struct usb_interface *iface,
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
 
-	if (!bcm5974_check_endpoints(iface, cfg)) {
-		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
-		return -ENODEV;
-	}
-
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
 	input_dev = input_allocate_device();

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-revert_bcm5974_ep_check-37f2a6ab2714

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


