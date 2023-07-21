Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22F75C502
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGUKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGUKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:49:30 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920810FE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:49:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnuH80X_1689936563;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnuH80X_1689936563)
          by smtp.aliyun-inc.com;
          Fri, 21 Jul 2023 18:49:24 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v5 0/2] erofs: introduce xattr name bloom filter
Date:   Fri, 21 Jul 2023 18:49:21 +0800
Message-Id: <20230721104923.20236-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v4:
- patch 2: polish commit message; declare erofs_inode.xattr_name_filter
  as unsigned int instead of unsigned long; rename `bit` to `hashbit`;
  use bitwise and instead of test_bit() to test the hashbit (Gao Xiang)

changes since v3:
- patch 1: add "Reviewed-by" tag (Gao Xiang)
- patch 2: make CONFIG_EROFS_FS_XATTR select CONFIG_XXHASH (Gao Xiang)

changes since v2:
- patch 1: polish the commit message; introduce xattr_filter_reserved in
  on-disk superblock; remove EROFS_XATTR_FILTER_MASK (Gao Xiang)

changes since RFC:
- the number of hash functions is 1, and now it's implemented as:
    xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index),
  where the constant magic number EROFS_XATTR_FILTER_SEED [*] is used to
  give a better spread for the mapping. (Alexander Larsson)
  Refer to patch 1 for more details.
- fix the value of EROFS_FEATURE_COMPAT_XATTR_BLOOM; rename
  EROFS_XATTR_BLOOM_* to EROFS_XATTR_FILTER_* (Gao Xiang)
- pass all tests in erofs-utils (MKFS_OPTIONS="--xattr-filter" make
  check)

[*] https://lore.kernel.org/all/74a8a369-c3b0-b338-fa8f-fdd7c252efaf@linux.alibaba.com/
RFC: https://lore.kernel.org/all/20230621083209.116024-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230705070427.92579-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230712115123.33712-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230714031034.53210-1-jefflexu@linux.alibaba.com/


Jingbo Xu (2):
  erofs: update on-disk format for xattr name filter
  erofs: boost negative xattr lookup with bloom filter

 fs/erofs/Kconfig    |  1 +
 fs/erofs/erofs_fs.h | 10 ++++++++--
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  1 +
 fs/erofs/xattr.c    | 14 ++++++++++++++
 5 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.19.1.6.gb485710b

