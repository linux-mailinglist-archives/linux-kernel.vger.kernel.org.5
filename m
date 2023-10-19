Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0F7CF10A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbjJSHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjJSHUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:20:33 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C32130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:20:31 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6cd09f51fe0so738226a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697700030; x=1698304830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFWmc4leeJU0JvtOUCdlOewkD9kkUgR6yLJHBt3j+jY=;
        b=YN9gU8JRXkv2hXpXE4lXi+qwUkOf0XBsK9BrBWv83V5mrLNQm/pHR5TNCIacoqbxjS
         gDEJQyMq43UKUY4pv7iJQh7yXAwSYpHpFfaFoIrKCFhfy+c1D8ZcgNqFbblScGRc5c8u
         o3bHRpp9FnZfs1NEbhyFfRjBbvi39BcbS4uC69NXZKdWR/XAM7CPFdIlcQh5u6juDNaK
         ylgKJmy7mwrx3TxD1WFXz9DOXDUGLlCeMY/VkcHlit+FmSDg9Z5MpZY+UDKtWAgOS368
         odP8jSOawNyEoas2n5YQB9k4VGeMj3KVQuvP6wIflXFJuTLIKIZJCXshx0mTWYmxER+v
         HT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700030; x=1698304830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFWmc4leeJU0JvtOUCdlOewkD9kkUgR6yLJHBt3j+jY=;
        b=TerEoU5naEce8eqc1aJcpk78fXmczRdUHqpX+wWxcExFDg+ZYsyC1yZFHKrluGloWq
         Y7vXiOhsbIeaMA4Fd1HH5vCqIk8hnuItxwKw3hy2/c0P9b7HawGKG1NT/Z9k5f1W/W79
         iFD+FdLr7LElnbjzFLoAUaPvayDr/D+7a9qcPD0W3tkf910VuQMSNt+4PULvQgxXNZhG
         GthWOW2FGu0WpMNec3iGqLRQl8LFXWDFAi/4Bc+AELqlFw40M0RwS6aFpaYpj5iBMiqn
         YZYdMEyOz3TDc3/mo80zhHxFpzXjXCozVu0pwcE4C3K83K8X5siFj6YqRepvSCOo4zwV
         RgIQ==
X-Gm-Message-State: AOJu0YyIvJy1CU9U4NnywEiGCxYaay+xAq+kL3CDyy3345xpXe1gg7CI
        ljOI4yhZlp4JSvmoQRH5kWZNkeTASXAGyA==
X-Google-Smtp-Source: AGHT+IFhfqS+9PkzSgvH/94GRdjTN4G4Ebor8Y3l7RWGbuV8foAtwJqJoXeoSgt0dumdo5kfN502Tw==
X-Received: by 2002:a05:6830:410b:b0:6b9:146a:f1c9 with SMTP id w11-20020a056830410b00b006b9146af1c9mr1674172ott.0.1697700030357;
        Thu, 19 Oct 2023 00:20:30 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id t6-20020a625f06000000b0068fe7c4148fsm4613445pfb.57.2023.10.19.00.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:20:30 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v2 2/2] staging: vme_user: Use __func__ instead of function name
Date:   Thu, 19 Oct 2023 00:20:10 -0700
Message-ID: <996c9f92e7fd288f67c02dfb0ba524ab7c5fe421.1697696951.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697696951.git.soumya.negi97@gmail.com>
References: <cover.1697696951.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace function names in message strings with __func__ to fix
all checkpatch warnings like:

    WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
             this function's name, in a string

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
Changes in v2:
* None

 drivers/staging/vme_user/vme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 640b2dda3ac6..e533cce8e54e 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -424,7 +424,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		dev_err(bridge->parent, "vme_slave_get not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -576,7 +576,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		dev_warn(bridge->parent, "vme_master_set not supported\n");
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1576,7 +1576,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		dev_err(bridge->parent, "vme_lm_set not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1612,7 +1612,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_get) {
-		dev_err(bridge->parent, "vme_lm_get not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1649,7 +1649,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_attach) {
-		dev_err(bridge->parent, "vme_lm_attach not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1682,7 +1682,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_detach) {
-		dev_err(bridge->parent, "vme_lm_detach not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1750,7 +1750,7 @@ int vme_slot_num(struct vme_dev *vdev)
 	}
 
 	if (!bridge->slot_get) {
-		dev_warn(bridge->parent, "vme_slot_num not supported\n");
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.42.0

