Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F47CCF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJQV6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQV6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:58:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72BC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:58:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81cd8d267so73318747b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697579929; x=1698184729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtA0QmfTazD4bejJUvxhW4u+owAfFqWpqMd8aiBPDi0=;
        b=fX1WOxuMpKW1tvMyO4Aleww+sSym9wGDCa/ORANY60YXXEbKr7se7bxsRoSIOi3cWv
         Sva/Kjm2n7l+GzUiGPirCKlelh8BwrODtmdXjAxCfa4zjDORuRCShlxqPsmwXMvkHAdF
         2SF/8TZSNYCZJ/svpNG+qrkic75vth7PVMkKED6fxCDEJ8wOf50kCpUREOeKbej2P0sg
         UyaLok7GBxfJLVEzmgJ4nddpVSHsv5aymQQSRnf0GWKWO2JncfZ73RVbd54yLtfBLuHu
         ltYEapBgQ03ks7TiyMvJCJgRB4k5mnRwMdjntGqCLbIMhkZHEijCcOv9qQOxfXmhlos5
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579929; x=1698184729;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtA0QmfTazD4bejJUvxhW4u+owAfFqWpqMd8aiBPDi0=;
        b=h4JNV8qDsJK9tEdpgOCGsWi6+PDUuK4EIQzs+Gf1BD7J8cnsK/qVjohIKOp5zO3feP
         KVX1QwA5evSRsYGj2mlCNuDI99S19oApQL+m5Ueq3r/a3WhycA2mG3CaiOG45EvdMyMn
         KviHtCsyDwYsOc3Bou7Wh7go+nVSRIh1qLOP2zCWGQa3rcs1YJ2KMNP2Hi02H82fHpmF
         iALHc4HKi9G+clCUKw27s+99+8Aigg4M1yQ3kOssBLg5x++dQrD36Mpu5/ouc3rdQcG2
         gc6y6dC/sZWiGW/PPpY3GfeCY9mQG8hMRQhFUkBemKPpNy5bioJILBOBsMLnzUiyRbv6
         Hd+A==
X-Gm-Message-State: AOJu0YzzGcT62OpDnmMBfiNT/ulB8zlMmhHeWMx0vMLUoQVglY6nqs/Q
        hlSH9RsaeGVEOoIuS3czlTxULlPD/q/z5SPQeQ==
X-Google-Smtp-Source: AGHT+IHDs3y1E7k+8uXlkij8vcC0qgc1jSTYg965KjyTu12FZPFdJux12EXTyV9h27znP+YEVJYXB6E2gitoCo3PCg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d787:0:b0:59b:f863:6f60 with SMTP
 id z129-20020a0dd787000000b0059bf8636f60mr81791ywd.4.1697579929629; Tue, 17
 Oct 2023 14:58:49 -0700 (PDT)
Date:   Tue, 17 Oct 2023 21:58:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJMDL2UC/x3NSwrDMAwA0asErSuw3UI/VyldJLaUCowbJBOnh
 Ny9psu3mdnBSIUMHsMOSquYfEqHPw0Q32OZCSV1Q3Dh7J2/olUtcfliUllJDQtVbKKUyQylVMo oLTdhQW6Yphkjer7c2bnpNgaCXl6UWLb/9fk6jh8QFOZMhQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697579928; l=2481;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ssxs2Jsrs2hPLtwX1Sk+1Tw5TTVcJVG2jRbLqY3Nmzo=; b=euoX0Jg9LbRcp6r/+6JIqUrfaDAKuWxPOT7SWUWCkFd9tCFkFL1KEXgYs5MQi+IMRc0kTTReU
 jDmNrXF5LRuAIyY/fyEHQCdk0cZLzPa3Qi6V64hHwnsB9k/dZM+P3Tf
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com>
Subject: [PATCH] wifi: iwlwifi: fw: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
both dump_info->dev_human_readable and dump_info->bus_human_readable are
intended to be NUL-terminated.

Neither of these symbols seem to be actually used after being assigned.
Which means our replacement doesn't really matter. At any rate, it would
seem NUL-padding is not required so let's use `strscpy` [2] due to the
fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. (but maybe these should be
used or removed).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3ab6a68f1e9f..5455f8d1aab0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -880,10 +880,10 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			cpu_to_le32(fwrt->trans->hw_rev_step);
 		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
 		       sizeof(dump_info->fw_human_readable));
-		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
-			sizeof(dump_info->dev_human_readable) - 1);
-		strncpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
-			sizeof(dump_info->bus_human_readable) - 1);
+		strscpy(dump_info->dev_human_readable, fwrt->trans->name,
+			sizeof(dump_info->dev_human_readable));
+		strscpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
+			sizeof(dump_info->bus_human_readable));
 		dump_info->num_of_lmacs = fwrt->smem_cfg.num_lmacs;
 		dump_info->lmac_err_id[0] =
 			cpu_to_le32(fwrt->dump.lmac_err_id[0]);

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-1f49f00b8a2e

Best regards,
--
Justin Stitt <justinstitt@google.com>

