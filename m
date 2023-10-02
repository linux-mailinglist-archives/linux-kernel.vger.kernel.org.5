Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2AE7B5D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbjJBXJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjJBXJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:09:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118AAAB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:09:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81486a0382so497906276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696288179; x=1696892979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h+VrPtOekhb8+q73onDrKN45JQ6nX1n1Q4LL4kdfewA=;
        b=hRSehPpjqhUSg6MV5R6FS+cS6YVmzumQXNNzH7UIghZ0vI+KeLotbkC7dgObCX6CBD
         r9lRmNSRQ+TSIQqIL9YAzHZ+F69FYqavNv6Jih6j5HCxTGYW6++bs9ohglRRYe1QR+xN
         94b6od9RNMZKMzdkWv18EVrSyW/5kjCcFwPh+PlPXGuzz2gmXekrwlDNzXctujws3HLN
         sS2n2W+rB+TEKwLvlLy1jlzJTChHEAajZXVV2u0AjUtLz4IBi2atztmVyPfdIJIBH6WP
         n9QVV4osNRS2dO6cossOjl/91VTapNmvDLrWpNFsZ5g3D/TFZlLruAkvaxvHzghtxnSU
         1aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288179; x=1696892979;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+VrPtOekhb8+q73onDrKN45JQ6nX1n1Q4LL4kdfewA=;
        b=hWRHcZmXre2Ml1eGT5czaTq/cKjXGqSkj55IW4SmNZp5TFROGXmzmm7ZlcCCf57Ba3
         I74LGN2oTMSXqulIIZjTIB0MpjtZpk0hXoPx7lyCMcUI/VII7l+qCgWL91qwYtTDimIk
         jq0tgEz/1nsPvqLRRC7t90xiAwbzb/+nPpi0hY+1cvoeT/As1Vw4FbMheKLFDfeDBlyl
         nAZnsAOQ6vmwutbdBNadLr7BZssRG9zQfAi1cmchR9k5A3bORD5YgOvAlFA5GEU8tHM1
         OM+wYS3iHYqh0kbw4Xm/whBl0nnCjwrlOm2kIpWPb3NUboUvGUFnj5gEsS/LGHFyFS9v
         kCeA==
X-Gm-Message-State: AOJu0YyIOsIUb1BLuVJqkgEZfQJZmBBRr7KPUc3tlyyy9g5UPU3mRPoh
        Rf8jFOpQAG92bwJYKz/jHiuhdT/Q++0=
X-Google-Smtp-Source: AGHT+IEiQymAa7emMibbrofWKTUTBTNmFDJ5Vgb2eeRJ4K+AIcSgV+sbogBvdxPrJYARMPwpiTai1QF3ZeE=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:459f:6e1a:6be7:55da])
 (user=drosen job=sendgmr) by 2002:a25:910:0:b0:d86:55b7:97b0 with SMTP id
 16-20020a250910000000b00d8655b797b0mr231052ybj.9.1696288179184; Mon, 02 Oct
 2023 16:09:39 -0700 (PDT)
Date:   Mon,  2 Oct 2023 16:09:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002230935.169229-1-drosen@google.com>
Subject: [PATCH v2 0/1] Add 16K Support for f2fs
From:   Daniel Rosenberg <drosen@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
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

F2fs filesystems currently have two large restrictions around block size.
The block size must equal the page size, and the block size must be 4096.

The following patch, along with the associated f2fs-tools patch set, relax the
latter restriction, allowing you to use 16K block size f2fs on a 16K page size
system. It does not allow mounting 4K block size f2fs on a 16k page system.

Doing that would require a lot more work, requiring a refactor of all block
sized struct similar to the userspace patches, as well as handling the block
reading/writing at sub page boundaries. I'm currently leaving that to future
work.

changes for v2:
Adjusted format string

Daniel Rosenberg (1):
  f2fs: Support Block Size == Page Size

 fs/f2fs/data.c          |  2 +-
 fs/f2fs/inode.c         |  2 +-
 fs/f2fs/node.c          |  2 +-
 fs/f2fs/super.c         |  4 +--
 include/linux/f2fs_fs.h | 69 ++++++++++++++++++++++++-----------------
 5 files changed, 46 insertions(+), 33 deletions(-)


base-commit: 3e729e50d01e6a336132d1739866a6463f82faa9
-- 
2.42.0.582.g8ccd20d70d-goog

