Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE567D0652
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbjJTBzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346879AbjJTBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:55:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ABE18A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6be0277c05bso331520b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697766946; x=1698371746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0ry+kzvCHTJ148NbwYm7VhiEmbwaTHh/+gmqtzaSLw=;
        b=SsoWPLM08itiup3EhsdID2JndDp0CXqa7rW+TL5dQD8yHvnJPJN+xiT6CtRnhWCYkK
         iZyUd+xaBW1xB1daReC76bcCDgiUrZ5FEGdmEDJD7jQt65woFb0C19oLOq/DmTlCRBgh
         e4q2yiqgntaG26UT7pjDE7/SNcDYMvVL2ipKKj+dklnOKPkHRCy3Gepjbhkx+WogjLCo
         yTemiHp4XAqsQTFVKrNx9+Ouovhb3NE6TD2S9FEQLSNotdAiNRmdqRoG1zCd/WtU6VLJ
         Ifvcr+cK/xIvUczb+b2fUCVXhbbxzapWQENi90sfHbbN1E4AyEBtnfZZNV2uJIe+n/KR
         He3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766946; x=1698371746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0ry+kzvCHTJ148NbwYm7VhiEmbwaTHh/+gmqtzaSLw=;
        b=Cb4j/k44L+LNWI58uq37srf1toiCq5QLX6QW+9Pf/M5ftUH9ZWe9vw1Jzc5sJIXOKl
         y9JOtk9ZkFvJTsvXJ1eBwGQWSXmAc2QiYqDfT/rxMB7YITlQnhj29JcHkvbrx1HJBin7
         0aggDoSlYwjPAa6yGjGk9NgDEzSeEQiPAcgi071S9440a4Uv+RLLEaqPp3g+YqmBXIAx
         81M4ncXWgKpNZG2SvoF4lyh5cgcTAMIm7KgbEVKo7v7XRAQI3fk1WaLnQmAlADkYkd6v
         7+DbJ+GaZPO9D2dyW6ap6b5dRETLls1XLiylMCfy+f8O33tzZlj3+U64BIeZwF/ADy9D
         N41Q==
X-Gm-Message-State: AOJu0YzVguHzEZ0doEFtvz3n2fssXohrr6JKtfIZf8MhcnF4z8W/Ca62
        JCfupx68C5Clpn/XPMbMNuGrhGVSxbR75w==
X-Google-Smtp-Source: AGHT+IFn/zp+aYLsgb+V9ijWqr1uVXfLKPrE/FA7ILL1PTDKhjIgWawptYIWT2W+n4WuMOmuC1nhzQ==
X-Received: by 2002:a05:6a21:7903:b0:16b:8488:babf with SMTP id bg3-20020a056a21790300b0016b8488babfmr485267pzc.35.1697766945798;
        Thu, 19 Oct 2023 18:55:45 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id bj11-20020a170902850b00b001b9d335223csm364784plb.26.2023.10.19.18.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:55:45 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        julia.lawall@inria.fr, Andi Shyti <andi.shyti@kernel.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v3 5/5] staging: vme_user: Use dev_err() in vme_check_window()
Date:   Thu, 19 Oct 2023 18:55:23 -0700
Message-ID: <221344ede933b1d9e6c31310b0f4dbb8be809c86.1697763267.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697763267.git.soumya.negi97@gmail.com>
References: <cover.1697763267.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vme_check_window() uses printk() for logging error message. This
leads to the following checkpatch warning:
   WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
            dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Use dev_err() instead. Pass VME bridge device to vme_check_window() so
that the error message can be logged with the bridge device context.

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vme_user/vme.c | 10 +++++-----
 drivers/staging/vme_user/vme.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 661d1edfa26a..5c416c31ec57 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -160,8 +160,8 @@ size_t vme_get_size(struct vme_resource *resource)
 }
 EXPORT_SYMBOL(vme_get_size);
 
-int vme_check_window(u32 aspace, unsigned long long vme_base,
-		     unsigned long long size)
+int vme_check_window(struct vme_bridge *bridge, u32 aspace,
+		     unsigned long long vme_base, unsigned long long size)
 {
 	int retval = 0;
 
@@ -195,7 +195,7 @@ int vme_check_window(u32 aspace, unsigned long long vme_base,
 		/* User Defined */
 		break;
 	default:
-		printk(KERN_ERR "Invalid address space\n");
+		dev_err(bridge->parent, "Invalid address space\n");
 		retval = -EINVAL;
 		break;
 	}
@@ -350,7 +350,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 		return -EINVAL;
 	}
 
-	retval = vme_check_window(aspace, vme_base, size);
+	retval = vme_check_window(bridge, aspace, vme_base, size);
 	if (retval)
 		return retval;
 
@@ -552,7 +552,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 		return -EINVAL;
 	}
 
-	retval = vme_check_window(aspace, vme_base, size);
+	retval = vme_check_window(bridge, aspace, vme_base, size);
 	if (retval)
 		return retval;
 
diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index fbcbd0204453..06504dccd5ff 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -133,8 +133,8 @@ void vme_free_consistent(struct vme_resource *, size_t,  void *,
 	dma_addr_t);
 
 size_t vme_get_size(struct vme_resource *);
-int vme_check_window(u32 aspace, unsigned long long vme_base,
-		     unsigned long long size);
+int vme_check_window(struct vme_bridge *bridge, u32 aspace,
+		     unsigned long long vme_base, unsigned long long size);
 
 struct vme_resource *vme_slave_request(struct vme_dev *, u32, u32);
 int vme_slave_set(struct vme_resource *, int, unsigned long long,
-- 
2.42.0

