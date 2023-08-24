Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A83786FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjHXNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbjHXNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:10:18 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC121987;
        Thu, 24 Aug 2023 06:10:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 641B71866664;
        Thu, 24 Aug 2023 16:10:12 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fThewjPZHioT; Thu, 24 Aug 2023 16:10:12 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 17BC31867F66;
        Thu, 24 Aug 2023 16:10:12 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uK8xMjecZl51; Thu, 24 Aug 2023 16:10:12 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.235])
        by mail.astralinux.ru (Postfix) with ESMTPSA id D2124186765A;
        Thu, 24 Aug 2023 16:10:10 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH 5.10] iommu/mediatek: remove redundant comparison
Date:   Thu, 24 Aug 2023 16:09:54 +0300
Message-Id: <20230824130954.29688-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_device_register always returns 0 in 4.11-5.12, so
we need to remove redundant comparison with 0

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b16c0170b53c ("iommu/mediatek: Make use of iommu_device_register i=
nterface")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/iommu/mtk_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 051815c9d2bb..208c47218b75 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -748,9 +748,7 @@ static int mtk_iommu_probe(struct platform_device *pd=
ev)
 	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
 	iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
=20
-	ret =3D iommu_device_register(&data->iommu);
-	if (ret)
-		return ret;
+	iommu_device_register(&data->iommu);
=20
 	spin_lock_init(&data->tlb_lock);
 	list_add_tail(&data->list, &m4ulist);
--=20
2.30.2

