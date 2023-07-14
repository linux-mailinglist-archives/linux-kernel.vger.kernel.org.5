Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB8C752F94
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjGNCxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjGNCxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:53:37 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D5F2D48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:53:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnJxHjT_1689303210;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnJxHjT_1689303210)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 10:53:31 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v4 0/3] erofs-utils: introduce xattr name bloom filter
Date:   Fri, 14 Jul 2023 10:53:27 +0800
Message-Id: <20230714025330.42950-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v3:
- patch 3: "-Exattr-name-filter" option rather than "--xattr-filter"
  option is newly introduced to enable this feature (Gao Xiang)

changes since v2:
- patch 2: introduce xattr_filter_reserved in on-disk superblock;
  remove EROFS_XATTR_FILTER_MASK
- patch 3: xattr_filter_reserved is always initialized to 0 by default


changes since RFC:
- the number of hash functions is 1, and now it's implemented as:
    xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index),
  where the constant magic number EROFS_XATTR_FILTER_SEED [*] is used to
  give a better spread for the mapping. (Alexander Larsson)
- fix the value of EROFS_FEATURE_COMPAT_XATTR_FILTER; rename
  EROFS_XATTR_BLOOM_* to EROFS_XATTR_FILTER_* (Gao Xiang)


RFC: https://lore.kernel.org/all/20230621083939.128961-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230705071017.104130-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/all/20230712121331.99671-1-jefflexu@linux.alibaba.com/

The xattr bloom filter feature is used to boost the negative xattr
lookup.

Refer to the kernel patch set [*] for more details.

[*] https://lore.kernel.org/all/20230705070427.92579-1-jefflexu@linux.alibaba.com/


Jingbo Xu (3):
  erofs-utils: add xxh32 library
  erofs-utils: update on-disk format for xattr name filter
  erofs-utils: mkfs: enable xattr name filter

 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 include/erofs/xxhash.h   | 35 +++++++++++++++++
 include/erofs_fs.h       | 12 +++++-
 lib/Makefile.am          |  3 +-
 lib/xattr.c              | 74 ++++++++++++++++++++++++++--------
 lib/xxhash.c             | 85 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  7 ++++
 8 files changed, 199 insertions(+), 19 deletions(-)
 create mode 100644 include/erofs/xxhash.h
 create mode 100644 lib/xxhash.c

-- 
2.19.1.6.gb485710b

