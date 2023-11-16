Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128C7EE58E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbjKPQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:52:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B2D31A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:52:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ABAB1595;
        Thu, 16 Nov 2023 08:53:10 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F54E3F6C4;
        Thu, 16 Nov 2023 08:52:23 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     kevin.tian@intel.com, jgg@ziepe.ca
Cc:     joao.m.martins@oracle.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Date:   Thu, 16 Nov 2023 16:52:15 +0000
Message-Id: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASSERT_EQ() macro sneakily expands to two statements, so the loop
here needs braces to ensure it captures both and actually terminates the
test upon failure. Where these tests are currently failing on my arm64
machine, this reduces the number of logged lines from a rather
unreasonable ~197,000 down to 10. While we're at it, we can also clean
up the tautologous "count" calculations whose assertions can never fail
unless mathematics and/or the C language become fundamentally broken.

Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 050e9751321c..ad9202335656 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -293,15 +293,13 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
 				    __u64 bitmap_size, __u32 flags,
 				    struct __test_metadata *_metadata)
 {
-	unsigned long i, count, nbits = bitmap_size * BITS_PER_BYTE;
+	unsigned long i, nbits = bitmap_size * BITS_PER_BYTE;
 	unsigned long nr = nbits / 2;
 	__u64 out_dirty = 0;
 
 	/* Mark all even bits as dirty in the mock domain */
-	for (count = 0, i = 0; i < nbits; count += !(i % 2), i++)
-		if (!(i % 2))
-			set_bit(i, (unsigned long *)bitmap);
-	ASSERT_EQ(nr, count);
+	for (i = 0; i < nbits; i += 2)
+		set_bit(i, (unsigned long *)bitmap);
 
 	test_cmd_mock_domain_set_dirty(fd, hwpt_id, length, iova, page_size,
 				       bitmap, &out_dirty);
@@ -311,9 +309,10 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
 	memset(bitmap, 0, bitmap_size);
 	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,
 				  flags);
-	for (count = 0, i = 0; i < nbits; count += !(i % 2), i++)
+	/* Beware ASSERT_EQ() is two statements -- braces are not redundant! */
+	for (i = 0; i < nbits; i++) {
 		ASSERT_EQ(!(i % 2), test_bit(i, (unsigned long *)bitmap));
-	ASSERT_EQ(count, out_dirty);
+	}
 
 	memset(bitmap, 0, bitmap_size);
 	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,
-- 
2.39.2.101.g768bb238c484.dirty

