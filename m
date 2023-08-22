Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6073A783E76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjHVK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjHVK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:58:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C37DCD8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589cc9f7506so62624567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701901; x=1693306701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xwW+v61rdPoCKQce2vPFjbmpLjAsPrfEpwPotlFF+U=;
        b=ih84672TYQ0uR36sTapzunrkuaUbWHstif3b6iKv7mV3HpIc9cWZ/oYc7uNRCSLHII
         2pHZd83QwfjJv/p3f29R0trlm8vijxENfi7yMuVBaY2+T5CCUyaUJS2KkqT9Jorm3XyA
         F4CKy9vVBhIcyEG+ZlJR3RgTozztbPtNsvxGcUzwgmX8MvrZ72+oxt2V2nNn9EAFgnZd
         eMI7hjX/T68tgwFc11i6TnaPMU0k2YP/zpC4v7zSsVJ90z2wWeWwpZtxjLTYUJzRvz1S
         uJ/x16oIz4Tkeb54hZV8Q6cD5KoMVbD2Mj8OWAieMWxQdl+7RGvaPgogdL6XCaL/ypW3
         BHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701901; x=1693306701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xwW+v61rdPoCKQce2vPFjbmpLjAsPrfEpwPotlFF+U=;
        b=LVu3JxnGbW7xDv0sl1fbbsRAXob0C5+cg2XdgZI9bEt1ZOs8qfiG02ftV7jsyclmxD
         swWFxpzgc2EAaWgfaNeEl4X52AmuQxduYeuOeiKCRZFvYGLwrheNl1wZfehlKbc+gJY5
         l2gkUHQVNMYeRs+0mo+kftrOeYgabNcyTpVDiaOBOXdGHuDP9UOSFEHlxQ93ivUWWxbZ
         Pv+Kn81eVhgHJjA27rVXI6AH/TU43PEChVHHkxBdNOFIMuC4EXfjs8eYR9VQOIdHMYwZ
         5/9lI6Bqdbc6Zu9tC5c80ePY3NrwAgdRvsRL8rb2k01qLJ3d/qqcvHGa/mTIJFrax1mK
         J54A==
X-Gm-Message-State: AOJu0YzkABWZttCapqpWidsBvlj4Y+n8m4nN3z/JSVHmBY4mTh4AVAOH
        XvXSwoX8KmUWOTWngPAXHCzrnq/BLSjC
X-Google-Smtp-Source: AGHT+IGuW/3tPdCQ3blX7ef1nckHZq80wU2cX1yfJoUAETquSTLyTg4Dg7WC4rSmY3PWOYxMSvKC8jV1/Uko
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a81:af23:0:b0:562:837:122f with SMTP id
 n35-20020a81af23000000b005620837122fmr87489ywh.9.1692701901552; Tue, 22 Aug
 2023 03:58:21 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:57:04 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.8.I65dd382de382428dcb33333342b35405903ac768@changeid>
Subject: [RFC PATCH v2 8/9] iommu/arm-smmu-v3: check for domain initialization
 using pgtbl_ops
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, Michael Shavit <mshavit@google.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove smmu_domain->smmu in the next commit

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7c9897702bcde..9f8b701771fc3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2894,7 +2894,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	int ret = 0;
 
 	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
+	if (smmu_domain->pgtbl_ops)
 		ret = -EPERM;
 	else
 		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-- 
2.42.0.rc1.204.g551eb34607-goog

