Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289DF7D69AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjJYLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjJYLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:01:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B644189
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:01:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so8664630a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698231704; x=1698836504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gC1STNfqo/ReIXjrh5ODTmjb0+/6zWRqz5Oi0kVvdL8=;
        b=XDPxJP0gZYInX9OA/c/VCeHS6F/3gWUZATS9yGOaGaM9kVgMaZ26M0/nMT9OTE91n6
         ceWYiMVAt3/7LnXMk+pEoOuBe2bIEOXgHb/vgFOCTuHdrHA2HALlXcmA7qAB/RwE9RgX
         n93o3csd25lrNPkFhY9NUNtUuKJgyCRofGxIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231704; x=1698836504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gC1STNfqo/ReIXjrh5ODTmjb0+/6zWRqz5Oi0kVvdL8=;
        b=uyMFNd0h8gHhCl+9JsUoVapx2IR5DWgQvYyFSPgumiaV77c3cBV6Sdlbh4W4SwO5a5
         nxf2Vh2ouIC0d9S8pHKvDYVj0P2NJWm7zHEdifmqtq4+FU4AkbmV4A0mHGzgHfjP7y4b
         ERKd13LkL6kQx1GEECfT1eEhWZowCmwK+l+Y6Ocm18QoUsPw1dDMJNt44zAaXHcryTmh
         KkNTxgp+cBxYQtaY+kNtfSkJjrqG128c5xfraczg+Kk5M8Y85UmepS+tEbOGxAebgmzl
         CEWyArzatHSKnESagP8E/iao5yg74Lt2/qDx4zOnzaq+DVmdT/TXoWUCWT7JuA0NXCyw
         2h5A==
X-Gm-Message-State: AOJu0Ywck7fnr9v+vVwKjJpQ/vGrdXrUrs1tPZsgdH1s8ZJ+B+ahOcXT
        w7HgnOEuW13aEO6O1sAJNQZkYFDE0g0Usj7B6JD9qw==
X-Google-Smtp-Source: AGHT+IH9w2CN0Aj8bDNQ5kfS1kQwZ9JApoyTHfrWQGMBaOerFMfpeyEW2qCqPLWSXbl29/SfvmGxCA==
X-Received: by 2002:a50:d0c1:0:b0:540:ea03:af81 with SMTP id g1-20020a50d0c1000000b00540ea03af81mr819224edf.41.1698231704313;
        Wed, 25 Oct 2023 04:01:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-50-51-252.retail.telecomitalia.it. [82.50.51.252])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402174f00b0054042ebbb86sm5222999edx.89.2023.10.25.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:01:43 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH] iommu/tegra-smmu: fix error checking for debugfs_create_dir()
Date:   Wed, 25 Oct 2023 13:01:31 +0200
Message-ID: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

The return value of debugfs_create_dir() should be checked using the
IS_ERR() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e445f80d0226..cd1d80c4c673 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
+	if (IS_ERR(smmu->debugfs))
 		return;
 
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
-- 
2.42.0

