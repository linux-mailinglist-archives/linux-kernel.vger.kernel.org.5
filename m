Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878FE7C7EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjJMHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjJMHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:48:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE10121
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:48:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9de3f66e5so12934745ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183297; x=1697788097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0kb1FiHCSEkQxzh7PJsrM1RNssRIDlYu3IfcoLIqjk=;
        b=jWTIDKvF/rzOpPe97OvEHTe7umWdFHhD5GxtTms14bT0yKCpZNfqOcJiqTmgMmTc06
         1as5Gb1HrCuQ0EEEmM0S4UcLZZskKrkasOkhkX6DUdLbi7x0ZCZG+aK7o62TVg43CkGd
         wvH2jLs5ZFmzt99N//LA4sMsdgRif6hVcpV/Aoo/iNckLAQrcq+3HODUI30t9KCtdm/9
         5rfSl1rX5EW6z3xBXHxHTAXcmdJh3sUU1Fe/WasWLEwoEg/vDOwr5cfl9LqycmEFzQE5
         hjVitV2Ly2s7TbjvfZatang697k7kfQDeiFoJ8P975eXJft5mWRGwo7MCx39eLQ3b+zf
         O/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183297; x=1697788097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0kb1FiHCSEkQxzh7PJsrM1RNssRIDlYu3IfcoLIqjk=;
        b=KaNMVU0i3thZEtTpekojIQRa5+TmuFVqdxRKOKOz0oiIV8XnAf+Y9t4PmBC6vXiyk8
         oepIjY7vOIgLHab0dElZLfoHVpVu4kdrSx27vAGvAIKIkDrdcjdZo29Np86VKGScElse
         VafR5II4cSoDEYBqMabHk9uuksVEwqsRzui/6c2rUiKKFf+F9el69vfdSyOusJr47mvY
         T0FjZ4DbRtIah5DZu35vsDkmS9+T94EagaZ9C1K/uUj+Nptk7+RvRch2mf/APkTy9aRU
         E+EfXphpmikb4XvZ7pkegAU+0/zVwdTCNPmlbj/M05fzO2zDwiPKMe8Y2/2EouKKoBZR
         uaaA==
X-Gm-Message-State: AOJu0YxPoiibWnVE2jmp/xCOKOAGcCoWpitmdEjU5odFBnMHKJJru9Fg
        DHguTqY8wnptlHh2SIwtf88Uqm/BTRDcBOZZprg=
X-Google-Smtp-Source: AGHT+IEr3/GGqqC8nXhIEzypzuLKDe4Rc0uWXujjo4TuULJCozbCr3188pVwv0FnPXvQh74Eic8zPg==
X-Received: by 2002:a17:903:54d:b0:1c4:335:b06d with SMTP id jo13-20020a170903054d00b001c40335b06dmr22738543plb.32.1697183297103;
        Fri, 13 Oct 2023 00:48:17 -0700 (PDT)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001c9ccbb8fdasm3200548plg.260.2023.10.13.00.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:48:16 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 6/6] tee: optee: restore efivars ops when tee-supplicant stops
Date:   Fri, 13 Oct 2023 16:45:39 +0900
Message-Id: <20231013074540.8980-7-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013074540.8980-1-masahisa.kojima@linaro.org>
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tee-supplicant stops, tee-based EFI variable service
is no longer available. Restore the efivars generic ops at the
moment when tee-supplicant stops.

Linking error occurs if we set CONFIG_OPTEE=y and
CONFIG_TEE_STMM_EFI=m. Use IS_REACHABLE() guard to call
tee_stmm_restore_efivars_generic_ops() function.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 8 +++++++-
 drivers/tee/optee/supp.c                 | 4 ++++
 include/linux/efi.h                      | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index edc165bc1bb0..e804b260edaa 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -572,10 +572,16 @@ static int tee_stmm_efi_probe(struct device *dev)
 	return 0;
 }
 
-static int tee_stmm_efi_remove(struct device *dev)
+void tee_stmm_restore_efivars_generic_ops(void)
 {
 	efivars_unregister(&tee_efivars);
 	efivars_generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(tee_stmm_restore_efivars_generic_ops);
+
+static int tee_stmm_efi_remove(struct device *dev)
+{
+	tee_stmm_restore_efivars_generic_ops();
 
 	return 0;
 }
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..d07d4fc4e72e 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, Linaro Limited
  */
 #include <linux/device.h>
+#include <linux/efi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "optee_private.h"
@@ -58,6 +59,9 @@ void optee_supp_release(struct optee_supp *supp)
 		complete(&req->c);
 	}
 
+	if (IS_REACHABLE(CONFIG_TEE_STMM_EFI))
+		tee_stmm_restore_efivars_generic_ops();
+
 	supp->ctx = NULL;
 	supp->req_id = -1;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 489707b9b0b0..9b60893d6299 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1365,5 +1365,6 @@ extern struct blocking_notifier_head efivar_ops_nh;
 
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
+void tee_stmm_restore_efivars_generic_ops(void);
 
 #endif /* _LINUX_EFI_H */
-- 
2.30.2

