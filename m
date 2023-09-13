Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7EA79F23A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjIMTiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjIMTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:38:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ECB91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:38:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8109d3a3bbso229422276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694633924; x=1695238724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5D9cmGNnxZclEaUPRp7dDRkIa3NaBWA/5YbPgcSOdlU=;
        b=FLlzdeFavhqlzy4MC1JUgkhtQCIAqORJqP4YlKTbXRHHW4SDPUKHATV5MG7sWtoqyw
         JlOk3w3zl5eiGAfXS3M3FGmu4NefugskyB0wyPlnHqKdpRKDM9trNLQkOF5sP1b9JFfp
         KwMvVJWqug/Q7aEmu8arEKEGdzhl2pRpVZ/twXErX9CSaUC7i1cx9nhoJvZanZM8Vb4E
         eWt8veY6YDfVS8EGtK3LT0OLIddNGlWCJBnW8Y1DF/dCIe0tIpMHRgOLRj//eQCr55jy
         yrEW/Qadkl2zT1V/439SdGxhci5KOcuulo7OIwwAgw0Bb6+75oyxGOXn6GjYg6FPqhlc
         Nd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633924; x=1695238724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5D9cmGNnxZclEaUPRp7dDRkIa3NaBWA/5YbPgcSOdlU=;
        b=dTZxDNcutjvpiDkoXN0EFpkCSQ0uEl9LUHHiu/h057Q11w7xzWG8uhhBaiHipt7isL
         FrI1CTlEMfBOQKkaG9YDvVgstJjB6K7IETJ09tNjxVnfV2krjsK1ecbHASjN/9BATZWk
         8oTcAmIGL+lXTHM9F9+GKyceWL8yk2ZXTCNtgnFxfLMkv80mxR4qlk91bLSIu1KlhVq6
         f2JCIE68H4Vj+qTa3jpHQJuENS2Ke3wvGgb+KLDdg9vy6tldWGtbWi+HJXQLKM9oZZsR
         C4nXDJN60muPt5c98w0jIuEJuZUEH42N+h2Jas1jCl/HjXqUUouV+BsiqN5DnBd1RtUg
         mxZw==
X-Gm-Message-State: AOJu0YzVT256Drs4q/m3nA65aG4p0kXeseLpMjUmhfXIamVb/j8C0ZUo
        K2cEvhggedR+5AdbzwXj0W7lxZMtpwDR2znHKA==
X-Google-Smtp-Source: AGHT+IH31Zv0S2pEtOg8E5M6+3MG2ReqXhMlUlaKfNdDCbhIRCrg8Sj/H6HMaMvc1v62WHB41McV9U9S28iHMvwAYA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:41ca:0:b0:d77:f6f9:159 with SMTP
 id o193-20020a2541ca000000b00d77f6f90159mr78122yba.9.1694633924538; Wed, 13
 Sep 2023 12:38:44 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:38:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMMPAmUC/x3NPQ7CMAxA4atUnrGUJkUIroIY8uMEDw2RXQqo6
 t0bMX7LexsoCZPCbdhAaGXlV+0YTwPEp6+FkFM3WGOduY4OdZEa2w+T8EqimFnmjxfChYp4DG1 umCi8S1aMeJ7yJXifnY0GerMJZf7+f/fHvh9c242qfwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694633923; l=1807;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tFl2PNzqL8STywNv0UTNztdqinU7Ek8sPp6wO3F9Txw=; b=Qx9x2TQmkLa2oDNyG2+vl9LZXozyDkyNECZv70nQl8TbYysev2y1AlZud6Hv+kgnjZSkpklKS
 SwXrDu/ddO6AXv7TOSpT/PXQeIdImLO9VBF1J2iLFHssovmlcAAlMxf
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
Subject: [PATCH] firmware: tegra: bpmp: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

It seems like the filename stored at `namevirt` is expected to be
NUL-terminated.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees NUL-termination on the destination buffer whilst maintaining
the NUL-padding behavior that strncpy provides.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: compile tested only.
---
 drivers/firmware/tegra/bpmp-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 6dfe3d34109e..bbcdd9fed3fb 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -610,7 +610,7 @@ static int debugfs_show(struct seq_file *m, void *p)
 	}
 
 	len = strlen(filename);
-	strncpy(namevirt, filename, namesize);
+	strscpy_pad(namevirt, filename, namesize);
 
 	err = mrq_debugfs_read(bpmp, namephys, len, dataphys, datasize,
 			       &nbytes);
@@ -661,7 +661,7 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 	}
 
 	len = strlen(filename);
-	strncpy(namevirt, filename, namesize);
+	strscpy_pad(namevirt, filename, namesize);
 
 	if (copy_from_user(datavirt, buf, count)) {
 		err = -EFAULT;

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-54f7baaf32c0

Best regards,
--
Justin Stitt <justinstitt@google.com>

