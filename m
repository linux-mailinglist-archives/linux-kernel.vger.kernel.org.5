Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D027AB43F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjIVOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjIVOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:55:50 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C4C6;
        Fri, 22 Sep 2023 07:55:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 58FD83FA0B;
        Fri, 22 Sep 2023 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1695394541; bh=JC8yv+fNB5FiwOtZSD3GUGqW+YmVjy5b00Y4p97vKL8=;
        h=From:Date:Subject:To:Cc;
        b=JDUrN5GZzfN7QRRqw3OCK6PfL1j62nZYru/sYrDEuW7xLEduVTG9OfIn4T3caU8Fu
         I/EUTB1RuHPQNNbc/WrygHwkefF9ES735utJRbBLPPBw4PZxHNAJuzNTOLqfam5ely
         Emd0DSV7Vtikl6K6m3rRgDm37H4681WqNNpMalM5fznq1d/FgG3NtDzT6S1OoH8YMe
         keDDZ3FKBAUy7vlSBjyqpeuun5lTQWXthhxqxRFzHGEBPo892T8QQbpDurZHO3Z3dQ
         naSP+V3QRqJdSnZsostSD5OedWAt4g6QIQS7KN/aXiByU7aE3/gXXVoByFHPUS/H2J
         hxUc9NIeOW75A==
From:   Hector Martin <marcan@marcan.st>
Date:   Fri, 22 Sep 2023 23:55:23 +0900
Subject: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in
 attach_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
X-B4-Tracking: v=1; b=H4sIANqqDWUC/4WNQQ6CMBBFr0JmbQ1MMaAr72FYYBlgFi1kWhsJ6
 d0tXMD81fvJf38HT8Lk4VHsIBTZ8+Iy4KUAM/duIsVDZsASdXlHVLxY+1FhW0kJTUL+WCi8veu
 x1sPYNCXk7So08vf0vrrMM/uwyHbexOpo/xljpXJo0G12o9Ht0/Zienf1AbqU0g9xazpTugAAA
 A==
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=marcan@marcan.st;
 h=from:subject:message-id; bh=JC8yv+fNB5FiwOtZSD3GUGqW+YmVjy5b00Y4p97vKL8=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhlTeVS93Trj9L0JplduMZSwXqx/5/ztYtWfSY8bgq27d/
 9c0NZcHd5SyMIhxMciKKbI0nug91e05/Zy6asp0mDmsTCBDGLg4BWAi/O4M/91/HBGsdnI9PldN
 fbHjg7fHI5e3PN+b3pD3IelHnTlPKRvDf+/I5YI5Ov5yn+QFJ2kohG2Wz5vyVi57Peup+1nuN0q
 UeAA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
introduced in iommu_dma_init_domain() to fall back if not supported, but
this check runs too late: by that point, devices have been attached to
the IOMMU, and apple-dart's attach_dev() callback does not expect
IOMMU_DOMAIN_DMA_FQ domains.

Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
instead of explicitly enumerating all types.

Fixes an apple-dart regression in v6.5.

Cc: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
Changes in v2:
- Fixed the issue in apple-dart instead of the iommu core, per Robin's
  suggestion.
- Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st
---
 drivers/iommu/apple-dart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 2082081402d3..0b8927508427 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 		return ret;
 
 	switch (domain->type) {
-	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_UNMANAGED:
+	default:
 		ret = apple_dart_domain_add_streams(dart_domain, cfg);
 		if (ret)
 			return ret;

---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20230922-iommu-type-regression-25b4f43df770

Best regards,
-- 
Hector Martin <marcan@marcan.st>

