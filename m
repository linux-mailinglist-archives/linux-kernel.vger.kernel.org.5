Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E947EABD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjKNIph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjKNIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:45:36 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19E1A8;
        Tue, 14 Nov 2023 00:45:32 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d2de704f53so3306647a34.2;
        Tue, 14 Nov 2023 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951532; x=1700556332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmPI87GXXhzcCcyXWnBkmBBMe8gHKSUCEC5PcL6O7N8=;
        b=lzKdzWJRsXS28TbHKF/sIMU5GeCVUo+lFWon+9ABQ3YPFcz4aFCYS9JIKz3o/JBM1F
         wdUZeqPoc7GWjCJyyR6cDOBBCbjQ1/czoJl7XucKxpXkyaUfxV9ecx3ZJ1zZJzXFRvp0
         jX4og2x8O62qE9yc6hAKnNdNJJ1fLKNhEFmJu4htGr2PSwgx98KoL+dy29rcxfooV/jz
         0IOMT0y88ybRCXQMzHRR6TFrFkDeOvqJPDbX5D8xJhhFzb8fJlgYeSIQKJG8oBraKORI
         RBtlgiMSJnuKVxU69Lg0n1mbchLf3NXV4lpGk1/yntowE+49Jupl7DWyubu7M2iL1yX1
         UwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951532; x=1700556332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmPI87GXXhzcCcyXWnBkmBBMe8gHKSUCEC5PcL6O7N8=;
        b=Ywva3E3PFiaCv1dwTjIg5l5zsiMGp2tE6mBU9KsThz0dl5DRSwbWO2d5BfzNdg9bGA
         A45cUZZgkdBGtf/cCTIdCsPNTWbl0a9EoDxrHcI3/l67modkFjL0ebU28M90MTj2gEkq
         DKAu7SKvFsErQ3sOed13Rz3PuBZIpbPL9a4L1aIY6lJDSLSZgPrek6n3Q0wMExY9H+sB
         wT4Bho6RI/2PWHeJnD81q1ebLF0c/trv7kt1vBoQ3o20aE1A0GvmABPT+79Bm6+bgHSd
         Hi6FLwMLxdg62z9zL01EBUW5qPskLFcKkSFAjtN/lup0wos9wfi0l2A1sd5OSL9KQ8ap
         sPsw==
X-Gm-Message-State: AOJu0Yzi+BxYqwW2nkieNcTDQIc4m6oUteYXPYNK4hmxuwRfhjbLExoZ
        ouQHFZJRAKO6WkqMAExj+B8kGbEjWK8=
X-Google-Smtp-Source: AGHT+IEX7RjXev2XQltkrJXPfVRcuBRK0VCen1Onv2L8UNWzex6MaDtzPKTDE4jw6g5Fj8QP4FZ4jA==
X-Received: by 2002:a05:6870:7886:b0:1e9:896a:8055 with SMTP id hc6-20020a056870788600b001e9896a8055mr12703000oab.25.1699951532104;
        Tue, 14 Nov 2023 00:45:32 -0800 (PST)
Received: from carrot.. (i223-218-133-131.s42.a014.ap.plala.or.jp. [223.218.133.131])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b006c4d2479c1asm748083pfk.219.2023.11.14.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:45:31 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] nilfs2: Folio conversions for file paths
Date:   Tue, 14 Nov 2023 17:44:16 +0900
Message-Id: <20231114084436.2755-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, please queue this series for the next merge window.

This series advances page->folio conversions for a wide range of
nilfs2, including its file operations, block routines, and the log
writer's writeback routines.  It doesn't cover large folios support,
but it saves a lot of hidden compound_head() calls while preserving
the existing support range behavior.

The original series in post [1] also covered directory-related
page->folio conversions, but that was put on hold because a regression
was found in testing, so this is an excerpt from the first half of the
original post.

[1] https://lkml.kernel.org/r/20231106173903.1734114-1-willy@infradead.org

I tested this series in both 32-bit and 64-bit environments, switching
between normal and small block sizes.  I also reviewed all changes in
all patches to ensure they do not break existing behavior.

There were no problems, so I'm sending this part first because I would
like you to keep it in the -mm tree at an early stage.

Thanks,
Ryusuke Konishi


Matthew Wilcox (Oracle) (20):
  nilfs2: Add nilfs_end_folio_io()
  nilfs2: Convert nilfs_abort_logs to use folios
  nilfs2: Convert nilfs_segctor_complete_write to use folios
  nilfs2: Convert nilfs_forget_buffer to use a folio
  nilfs2: Convert to nilfs_folio_buffers_clean()
  nilfs2: Convert nilfs_writepage() to use a folio
  nilfs2: Convert nilfs_mdt_write_page() to use a folio
  nilfs2: Convert to nilfs_clear_folio_dirty()
  nilfs2: Convert to __nilfs_clear_folio_dirty()
  nilfs2: Convert nilfs_segctor_prepare_write to use folios
  nilfs2: Convert nilfs_page_mkwrite() to use a folio
  nilfs2: Convert nilfs_mdt_create_block to use a folio
  nilfs2: Convert nilfs_mdt_submit_block to use a folio
  nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
  nilfs2: Convert nilfs_btnode_create_block to use a folio
  nilfs2: Convert nilfs_btnode_submit_block to use a folio
  nilfs2: Convert nilfs_btnode_delete to use a folio
  nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
  nilfs2: Convert nilfs_btnode_commit_change_key to use a folio
  nilfs2: Convert nilfs_btnode_abort_change_key to use a folio

 fs/nilfs2/btnode.c  |  62 ++++++++---------
 fs/nilfs2/file.c    |  28 ++++----
 fs/nilfs2/gcinode.c |   4 +-
 fs/nilfs2/inode.c   |  11 ++--
 fs/nilfs2/mdt.c     |  23 +++----
 fs/nilfs2/page.c    |  68 +++++++++----------
 fs/nilfs2/page.h    |   6 +-
 fs/nilfs2/segment.c | 157 ++++++++++++++++++++++----------------------
 8 files changed, 183 insertions(+), 176 deletions(-)

-- 
2.34.1

