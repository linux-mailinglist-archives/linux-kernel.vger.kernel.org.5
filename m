Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169A7D064E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346878AbjJTBzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbjJTBzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:55:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE211D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6be840283ceso339787b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697766933; x=1698371733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ9Q+Gp8bBY1rgTAuM/1Ler9ZBRDqDxWeGeuDodFtac=;
        b=hIuc33ie1jNJarNh53136FwhtgEq9st0s/EB1lrZAP4X//90aYaw0JGq9r6sHSGfq4
         PO339tt9XuoMk1IBfp7kPEydzpvq8sdtUmluULGOR0ZyD3IWD8to8lbRUj9rbfS3iHUT
         hVkM7MLYfml7EPa7qR3lXRcFxlo+kw+Ge02PQKrOGMeIcmCIsCTJpurqy9uAMRXFHlCW
         WarZ5v1wzEDkX4R+xWS+5UMb7SVIOEuWb1CaOEfqYIFBvUPs+/xYaysuMDKAHHVmCU1K
         i088CbsqB9KhUTexy8T220iIaoWWoLgxRC8clxd1QzpNZ0LKHln4E9EhCHMH1g8Buzu2
         245w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766933; x=1698371733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ9Q+Gp8bBY1rgTAuM/1Ler9ZBRDqDxWeGeuDodFtac=;
        b=wf3fZWEeWdxrgQnTzfXTEGbvoPgehwVuk0fcBuqsDwmz6nnmLc87viUo5XiMNglWZM
         7Gto9scL34sFDitiFVveMwzxr6+WIYmUlaSZrEUraG+F0vCPoy3jtRn9jbmOjWIlCAeb
         8SbQDfKTzZJEhA743HhJNZy2k85GIP3QawzOYEQ8QkC73hk9Jtv1Aoz3bI62b0OTz1ve
         5JqwQsCh5zAWs6l1iWGrjKbWqVLv+COwzxsCtKHGeD0Cd9TzfTFAcS5WgtvuVeLtsVxa
         EaFcPy0dMI8QB5UBfvFvzCilkDdLiViJhMWQOizxK4FLVy8mYrCxZfkB6VOmPvs+4bzu
         uJ/g==
X-Gm-Message-State: AOJu0Yy6H6OFyr5VlD4bgAYU7HYgDNcJJp1XDPrUQQe/w4QYgrNkb99j
        1GAF5G4ADkK9GaOGpDQE9W0=
X-Google-Smtp-Source: AGHT+IG5M1a+WXDPCZSl3/oRipDWqxiylVgcnshegQbxFFuTufQ6pm5x5LtkQhOgV9nJIqibYX6vGw==
X-Received: by 2002:aa7:9a0e:0:b0:6be:acc:8973 with SMTP id w14-20020aa79a0e000000b006be0acc8973mr418617pfj.20.1697766933598;
        Thu, 19 Oct 2023 18:55:33 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id n14-20020a056a0007ce00b006bb5ff51177sm400665pfu.194.2023.10.19.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:55:33 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        julia.lawall@inria.fr, Andi Shyti <andi.shyti@kernel.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 2/5] staging: vme_user: Use __func__ instead of function name
Date:   Thu, 19 Oct 2023 18:55:20 -0700
Message-ID: <db4ad6b878c4bb08fd5d15cf4a9287d7bb8c30df.1697763267.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697763267.git.soumya.negi97@gmail.com>
References: <cover.1697763267.git.soumya.negi97@gmail.com>
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
Acked-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/staging/vme_user/vme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 25f3cac641ed..c36c2dc095c5 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -422,7 +422,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		dev_err(bridge->parent, "vme_slave_get not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -574,7 +574,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		dev_warn(bridge->parent, "vme_master_set not supported\n");
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1574,7 +1574,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		dev_err(bridge->parent, "vme_lm_set not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1610,7 +1610,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_get) {
-		dev_err(bridge->parent, "vme_lm_get not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1647,7 +1647,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_attach) {
-		dev_err(bridge->parent, "vme_lm_attach not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1680,7 +1680,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_detach) {
-		dev_err(bridge->parent, "vme_lm_detach not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1748,7 +1748,7 @@ int vme_slot_num(struct vme_dev *vdev)
 	}
 
 	if (!bridge->slot_get) {
-		dev_warn(bridge->parent, "vme_slot_num not supported\n");
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.42.0

