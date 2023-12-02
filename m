Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA2801A2D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjLBDDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjLBDDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:03:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B70C121
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:03:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca2a6f07b6so48089547b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 19:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701486235; x=1702091035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/X+nKitsMY3rmCpR7SNJX2uebsoXggelnHWtO9TTwsU=;
        b=Z3+ATEVrkedU4cIbDGxutnDBLF9ZroKt4POUuX+ajO/ZxC5tbDvMgOxxzxejiEfuyj
         5d2BRTCk3DGaPNUiBQiu5UersYzPihvbtVwUUcbyyFRI8POnsmpD3oIlTjBMZyvQZjg1
         dlYAA5OpIBjLFUDNBVbrdFm1QuotKhBvqWv0fwAdHdEgRtuP+u4qIO3H+1Z3qc1cMKce
         QcJNezPSxm7EBCAwDtMWkT5wVyHD57LBoKNvAJ/0vsA+PsNI68JbsgRazgLfb61Z4YP/
         5ZAtiw84Xi8hPClTKlRN2sfbCaSYkkUo2howqPL87+C/t1Tt+jcyWZ47iI1GnzfwwRsQ
         k17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701486235; x=1702091035;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/X+nKitsMY3rmCpR7SNJX2uebsoXggelnHWtO9TTwsU=;
        b=plM/k/ASw+BbVx9ds/P9ixzAdUAJ6iC/VD4hJJU8Q05g1t+Db6XXqNKZRrS9UKaElp
         5nKkoAv7QSVl5rCjxJlvg6Uexug1C4hocSVJ1qxSBZNszIxfGyNSXRhpzgEFjvmO2WLO
         xkl4XPi+BHvyzbSqP+9m+wl5rrqsTbK2U/CbUvIxOKaXpQoh2oL3YhBVEdBGuOG3er0v
         IXjVzI8SQenfqTqQGPCqkzfLWOuM4wfiYKq+mZ+9M+K9Rfiduuy5xjqAfvzlCaVN6wPv
         NSCPOW0wqFNjVLNa1gq3a1z+w1Ly4shQ+WBivf6se7whOhB3AmGlysckgxGpEfyHFO0q
         CPJg==
X-Gm-Message-State: AOJu0YwpTimiUdr68ZjMxX7t30qXHuocLyYdbwM13kgR5+jupDmHjiq0
        hG7gtVKtRvgDwFJY/KiDOG+5WWVMfu4=
X-Google-Smtp-Source: AGHT+IH42DMKj1tZvdadBCiyzi+jWhB4e+Q9vl9z0MYQIBZPNOzJRZZlM8zL00FjfO3gt0OacECQ7XP0uGs=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e3a2:452f:f377:df27])
 (user=drosen job=sendgmr) by 2002:a05:690c:fd3:b0:5cc:41c1:606 with SMTP id
 dg19-20020a05690c0fd300b005cc41c10606mr1127954ywb.6.1701486235257; Fri, 01
 Dec 2023 19:03:55 -0800 (PST)
Date:   Fri,  1 Dec 2023 19:03:47 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202030347.2330936-1-drosen@google.com>
Subject: [PATCH] f2fs: Restrict max filesize for 16K f2fs
From:   Daniel Rosenberg <drosen@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blocks are tracked by u32, so the max permitted filesize is
U32_MAX * BLOCK_SIZE. Additionally, in order to support crypto block
sizes of 4K with a 16K block size, we must further restrict max filesize
to U32_MAX * 4096. This does not affect 4K blocksize f2fs as the natural
limits for those are well below that limit.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..7258a8bd6433 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3364,6 +3364,15 @@ loff_t max_file_blocks(struct inode *inode)
 	leaf_count *= NIDS_PER_BLOCK;
 	result += leaf_count;
 
+	/* For compatibility with 4K crypto unit size, we must restrict
+	 * the max filesize to what can fit within U32_MAX 4K units.
+	 * Since the blocksize must currently be equal to the page size,
+	 * we can grab that from there. inode is NULL when setting up
+	 * the superblock.
+	 */
+
+	result = min(result, ((loff_t) U32_MAX * 4096) >> PAGE_SHIFT);
+
 	return result;
 }
 

base-commit: d346fa09abff46988de9267b67b6900d9913d5a2
-- 
2.43.0.rc2.451.g8631bc7472-goog

