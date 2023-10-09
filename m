Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4FB7BE723
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377815AbjJIQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377354AbjJIQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:57:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD1AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:57:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32003aae100so3545740f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870672; x=1697475472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBjS1gShjaJkPyX/KQvNob7ffrl0lyd3plKPyysabEY=;
        b=KWSsWKwFhuZjxNlw57LlhSLmB000RjfrYKSEWyZFpizdKupo89jsTs+1Pn1dj3r6VN
         l0/CuLolEgtuG1LnUrIBr/Cvel6LQ06QQ2qUJwqJVbJRGpoIZjC2CFJ9GQhFI5fSa8R0
         PTsfZkHvwt67JoQH9OZ+eR2bFjP8gTipg35fkJovfSCM8+X2i9lchx9ap1wyJmPZO4d9
         YMIoftOEy8yY9XyiQxE8QWjsj3pGWzpjLwQffhfxyEXPr4Wu/Rv1lQrRGFvqX4PHdspl
         zWAJLo+oYMNn6tIlJ75Vfui+IDeDZZWuD/kpkd5wqeGAWCCicZf4BUfBH0thUKTfwETq
         SI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870672; x=1697475472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBjS1gShjaJkPyX/KQvNob7ffrl0lyd3plKPyysabEY=;
        b=hEUbXJNM1iL6Y6x9i4vuU4Tq+i3fvixr+lSnH1we1t7HU9CHqfvRDZUKoxXRQFpora
         UEsUlaKCn0/ArIgUOotOm5s7Mpys/Q186hgHqYLU0DIrkCFS6k6KxcPI8dbfdupG+qBo
         6EpWqW9q8FAa99TyKlQkBI3MFQSuGg+342YCGG0Q5jY+Iu+D/evhdKh8QZdc+2EGXKXE
         26WKVrU6ddikcpwdUIldM/WG8jQ9zLF5nttfLDijI2RotYvVBETQlc+anqVSAAfAKVaz
         PzGXWZ9AMXwx3PU1Jj0jTTBcq+JkHOX+DGIdO8n1ud7k6JkAsS6srJShgLsLJZn6m+si
         C6oA==
X-Gm-Message-State: AOJu0YwaEmrISc0oDs4tn9jEyo3HBqG/1/PH9lQJ6b7mFs1j9OVD352f
        Zju/mkDx/q9AJ4cYiS7eEzxBeQ==
X-Google-Smtp-Source: AGHT+IFEnPLCDz9AAdq40DaxX8ZquOKIsrHKI3OMUwEn9b4U4wZGnFE9tN3VQgf5iQvSNpEWrOsm9A==
X-Received: by 2002:a5d:6b11:0:b0:323:1d0a:5562 with SMTP id v17-20020a5d6b11000000b003231d0a5562mr9559403wrw.6.1696870672140;
        Mon, 09 Oct 2023 09:57:52 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:57:51 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] drivers/extcon: add local variable for newly allocated attribute_group**
Date:   Mon,  9 Oct 2023 18:57:36 +0200
Message-Id: <20231009165741.746184-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the compiler to keep the pointer in a register and
prepares for making the struct field "const".

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/extcon/extcon.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 6f7a60d2ed91..e879690d4fef 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1202,6 +1202,7 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
  */
 static int extcon_alloc_groups(struct extcon_dev *edev)
 {
+	const struct attribute_group **groups;
 	int index;
 
 	if (!edev)
@@ -1210,20 +1211,20 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
 	if (!edev->max_supported)
 		return 0;
 
-	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
-					  sizeof(*edev->extcon_dev_type.groups),
+	edev->extcon_dev_type.groups = groups = kcalloc(edev->max_supported + 2,
+					  sizeof(*groups),
 					  GFP_KERNEL);
-	if (!edev->extcon_dev_type.groups)
+	if (!groups)
 		return -ENOMEM;
 
 	edev->extcon_dev_type.name = dev_name(&edev->dev);
 	edev->extcon_dev_type.release = dummy_sysfs_dev_release;
 
 	for (index = 0; index < edev->max_supported; index++)
-		edev->extcon_dev_type.groups[index] = &edev->cables[index].attr_g;
+		groups[index] = &edev->cables[index].attr_g;
 
 	if (edev->mutually_exclusive)
-		edev->extcon_dev_type.groups[index] = &edev->attr_g_muex;
+		groups[index] = &edev->attr_g_muex;
 
 	edev->dev.type = &edev->extcon_dev_type;
 
-- 
2.39.2

