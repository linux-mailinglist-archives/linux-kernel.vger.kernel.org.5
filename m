Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38B80FA70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377693AbjLLWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377677AbjLLWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:09:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616CB3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:10:00 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so4108543b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702419000; x=1703023800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AUQroc3YD1KExvZg7CZoKlnozDJQ13H2P0qin79AMs=;
        b=K9hX+p2UoWn+0LgirSssfSrjwvLWHcyyrZQL992KJ8Epw8COFLUDzK+z5eOp4nGcpL
         G5nGIi564ReabHJpSJNRTLCXkFedyxOnTPdXahUE73R+RkmU7pcykPSKznjdZW4ybSdR
         QEjfQB8KsPar2JZy/k58VmpUqeZ3SbS9oT2pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419000; x=1703023800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AUQroc3YD1KExvZg7CZoKlnozDJQ13H2P0qin79AMs=;
        b=pvpKfpF/ef6q1q4hFTBDudcaSZQDGSvRg9tKNJCYissn+DqoVgKlgRiO9bEl7tnL5N
         aszr4xZQi9RqmucMvSwDC0G94XRwmBU2UK+VfnOIOSY8MteaSZ0ihonyTYrDsXxHBTkL
         Tj5aGhz/jecaoHxVwOa9x4A13TpIQF26ylpa6bu+AjOSTwqyK2vUaBoDl78c4i34hwmm
         91ATmSFVXzqb1ksgnVjuxWqaoA5ViVagwpp2iIidZxLOsxW8d72LL2J788E0Oc/rdbcX
         OtvYkXUmgkEUOoi/lNNdJS7cu8PQSqWCluj5q0ysTM82EHd++Qkbth09q5hvwHcUJ4/n
         TOsA==
X-Gm-Message-State: AOJu0YzPe7tsDia6ElwCM67tytmDA3OMZOYQxqK6OvbNQ8Dy/mWSzsED
        vYDilwcfZ8zGi/YKThljDjeX0w==
X-Google-Smtp-Source: AGHT+IFf+R1A/XR8Jt/9Fz875DIYyIaNu91bfQZimMKleNPgzgfwmHSBFbbtlfKJAsRdJ8rj8kU4YA==
X-Received: by 2002:a05:6a21:1f20:b0:190:2973:5132 with SMTP id ry32-20020a056a211f2000b0019029735132mr3660108pzb.107.1702418999822;
        Tue, 12 Dec 2023 14:09:59 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001c9c5a1b477sm9139392plg.169.2023.12.12.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:09:59 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Raju Rangoju <rajur@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] cxgb3: Avoid potential string truncation in desc
Date:   Tue, 12 Dec 2023 14:09:57 -0800
Message-Id: <20231212220954.work.219-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=keescook@chromium.org;
 h=from:subject:message-id; bh=21c8W8WpyGXddpdivNfij9Z1UgBS9gpwm3BMCk5vJXE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleNo1YdSK7BzSkz1ECFrVzjTTKZu017tFXk7P2
 MuIZKMu6B+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjaNQAKCRCJcvTf3G3A
 JrU6EACVuFlSTH8lVGBKuS1i7DgrLCjEdSotDiCDkaaC5uHjvNymaLN3etMW/BIzpqALRP1VXQe
 +BvMKtmUKXuNjHll4E7H6ZWn6Kma7bX+MaEiZFqCLrr3SKj2GpKBCe3k+9ajHJLxL6MrghA1nlT
 nudc/lmnJeT+ujiOIGLgzMqasPIwcD82I4kuMcDssolDzdPoh0LBAb2ZuxlLiX8CluyR/f1cz5u
 T4NCzvqNNEUDMCiqADL31XkQbMs2NsLVa8xpcBkBYTWwyvjOss3bbagakrYrMGGCEJQBiAHttJz
 1NGygZ9pCL/CSfVnJiTosCA5woY14NI19hTegJlcHd9NT+fnuSBMO3JLs0FDBSjnPnFv9jxB9t5
 ROWEUKlb9PQaQTI2EOOzen8AvyrzZA3t8DDef1Tf2lLMbJ8zSlPswymr2TIFLUAcH5gJg6t8Sil
 Hl8zGlTTzkQoz5CBZ3EdjA0xhuOO1EKLuLKUwAbQ5NPI4W8KV1WMNGk8I5p8kELLmjlDmTsMtmw
 xyUVwFHINyu5yD5VSUxTGAnJDcVM56uX1IuLYRtBHfriKRBwKv7CZ9BAYKTYqATeZKRIAKfe+Y9
 KXP4u+c1c668QPpD99DQMb2n0Zf3z2iF76/vR2JA8ac3BljgNHdUD61MOfF7oHj8qBpFoV6G+Xu
 6LouMnn auXbTADA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Builds with W=1 were warning about potential string truncations:

drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c: In function 'cxgb_up':
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
  394 |                                  "%s-%d", d->name, pi->first_qset + i);
      |                                      ^~
In function 'name_msix_vecs',
    inlined from 'cxgb_up' at drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:1264:3: drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:34: note: directive argument in the range [-2147483641, 509]
  394 |                                  "%s-%d", d->name, pi->first_qset + i);
      |                                  ^~~~~~~
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:393:25: note: 'snprintf' output between 3 and 28 bytes into a destination of size 21
  393 |                         snprintf(adap->msix_info[msi_idx].desc, n,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  394 |                                  "%s-%d", d->name, pi->first_qset + i);
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Avoid open-coded %NUL-termination (this code was assuming snprintf
wasn't %NUL terminating when it does -- likely thinking of strncpy),
and grow the size of the string to handle a maximal value.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100937.ZPZCARhB-lkp@intel.com/
Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb3/adapter.h    | 2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/adapter.h b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
index 6d682b7c7aac..9d11e55981a0 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/adapter.h
@@ -237,7 +237,7 @@ struct adapter {
 	int msix_nvectors;
 	struct {
 		unsigned short vec;
-		char desc[22];
+		char desc[IFNAMSIZ + 1 + 12];	/* Needs space for "%s-%d" */
 	} msix_info[SGE_QSETS + 1];
 
 	/* T3 modules */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index d117022d15d7..2236f1d35f2b 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -380,19 +380,18 @@ static irqreturn_t t3_async_intr_handler(int irq, void *cookie)
  */
 static void name_msix_vecs(struct adapter *adap)
 {
-	int i, j, msi_idx = 1, n = sizeof(adap->msix_info[0].desc) - 1;
+	int i, j, msi_idx = 1;
 
-	snprintf(adap->msix_info[0].desc, n, "%s", adap->name);
-	adap->msix_info[0].desc[n] = 0;
+	strscpy(adap->msix_info[0].desc, adap->name, sizeof(adap->msix_info[0].desc));
 
 	for_each_port(adap, j) {
 		struct net_device *d = adap->port[j];
 		const struct port_info *pi = netdev_priv(d);
 
 		for (i = 0; i < pi->nqsets; i++, msi_idx++) {
-			snprintf(adap->msix_info[msi_idx].desc, n,
+			snprintf(adap->msix_info[msi_idx].desc,
+				 sizeof(adap->msix_info[0].desc),
 				 "%s-%d", d->name, pi->first_qset + i);
-			adap->msix_info[msi_idx].desc[n] = 0;
 		}
 	}
 }
-- 
2.34.1

