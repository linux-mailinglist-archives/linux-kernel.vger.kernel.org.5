Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2880DAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjLKTas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:30:46 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D4D5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:30:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d0544c07c3so22869015ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702323052; x=1702927852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zg8AR05UHVq8cdvaCLIRoC/0NFp4lFWlQJeIXd72AHI=;
        b=dDsf8FA0wFzn77vPL6A4/RdEy1AZpMSWVA/FQL3czPbjtuRKRarsadrEci9Nxx1Bzt
         C5esFW1gRGWiCLAa9EK4m64MwTFk9MS4UykMvI67NnJBcFlbGM/TWXlQ58D1GuRZVEXV
         riBDCY3Y0I2v0m6zL+rEtvUQFzW10PfIv4+8aKvig3KG1A+GBafwsqaaefx2J93Wj65v
         Pqypumeu0nSrTvzTdmYcKd889cg7eC4fuRWD0AXHsC4tZ7rqP0N4lg6ucdt+8h+Uhz5v
         HGljVxjkFJsUzd3RGV03VZ9CRCifKKOwyXhlZvC3AFE9wPVMe2fr4pjf83/Fh3BBR79p
         4IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323052; x=1702927852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg8AR05UHVq8cdvaCLIRoC/0NFp4lFWlQJeIXd72AHI=;
        b=GLuHvUaszBG22CwJUe03cj98Gg+1Lu5S5LTXOJDGyrpsi0WUg4bN0O2a++EfnZRDky
         WbCYPXW20I0Ffxx6IZP/G5lJtCwn077i+gCv9IZZJVChhlZOl2CCXdSrrhmwsVUFvDD6
         QICy+ulMdnR3KL2J5i3gJyCp9FspqRbjARTtFqXSryX0wKNGdXEHbYW3tJfhVCvYzp4d
         mgyQhIEs2c8SzWoLbTBxw7DUdF2rIOIMrOn0X8mUUlGAb4GITt3A1xXR3r4FmtHVNPpw
         gXjgiVW7mdfdYASGa/oSfIRKuGhbTKa9/ANpQoQDGxs6TIQdIehA1B7xARsBRdxMYQ0Q
         rl6Q==
X-Gm-Message-State: AOJu0YzIVwhB72TPL01UvkhqYovMqf016b9V7HQNr/tYPc0lXLc/GZpc
        vKyNnmFuIjw45s6I/Qje06XixUnt1qY=
X-Google-Smtp-Source: AGHT+IG07MG9pH5HTJVzJPJciG0e0RheT4j1cmORDoiLZ/6r3PcJWeJrx3ngVSXg6UZZzUZaTjdq22TFCA4=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:dc8d:a8c5:498f:a21c])
 (user=avagin job=sendgmr) by 2002:a17:902:e804:b0:1d0:c2be:3d9d with SMTP id
 u4-20020a170902e80400b001d0c2be3d9dmr39536plg.7.1702323051863; Mon, 11 Dec
 2023 11:30:51 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:30:47 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211193048.580691-1-avagin@google.com>
Subject: [PATCH 1/2] fs/proc: show correct device and inode numbers in /proc/pid/maps
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
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

Device and inode numbers in /proc/pid/maps have to match numbers returned by
statx for the same files.

/proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
an issue. If a mapped file is on a stackable file system (e.g.,
overlayfs), vma->vm_file is a backing file whose f_inode is on the
underlying filesystem. To show correct numbers, we need to get a user
file and shows its numbers. The same trick is used to show file paths in
/proc/pid/maps.

But it isn't the end of this story. A file system can manipulate inode numbers
within the getattr callback (e.g., ovl_getattr), so vfs_getattr must be used to
get correct numbers.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/proc/task_mmu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 435b61054b5b..abbf96c091ad 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -273,9 +273,23 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	const char *name = NULL;
 
 	if (file) {
-		struct inode *inode = file_inode(vma->vm_file);
-		dev = inode->i_sb->s_dev;
-		ino = inode->i_ino;
+		const struct path *path;
+		struct kstat stat;
+
+		path = file_user_path(file);
+		/*
+		 * A file system can manipulate inode numbers within the
+		 * getattr callback (e.g. ovl_getattr).
+		 */
+		if (!vfs_getattr_nosec(path, &stat, STATX_INO, AT_STATX_DONT_SYNC)) {
+			dev = stat.dev;
+			ino = stat.ino;
+		} else {
+			struct inode *inode = d_backing_inode(path->dentry);
+
+			dev = inode->i_sb->s_dev;
+			ino = inode->i_ino;
+		}
 		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
 	}
 
-- 
2.43.0.472.g3155946c3a-goog

