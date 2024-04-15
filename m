Return-Path: <linux-kernel+bounces-145474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9E8A56A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851C8283712
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC779B8E;
	Mon, 15 Apr 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyoqXAAz"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF979945;
	Mon, 15 Apr 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195610; cv=none; b=gUvoMs1UKin+cmP6vrabC7eegmXC/cS8e74OmYIAL6DerZTSLgQZJvSSmAczJoQ22qlWzsI+kTDIk5ZFS7AAWL7DHidfmOk2GueYGQG1oHpJ66NXyUzCEPmd6lDdVlTAWEMgqGhdq6Dor7odoRJ48aaQlOKFmU10hirVzi3/zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195610; c=relaxed/simple;
	bh=HJrc8pdWVl7s0NIcPWqAkeXX4IopbqYycZeDyyLdV5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WklUbNMGxQqgxurMXHkbZ60dTz26q20ntT6eIzyImp2GNntMJCquBXpuP9DrCWwFLDQNxGNZSh8MXTa4bJGfOGP7cnVMZyAAa5eMrrmpGYWAW3gzyZyvq4vfMsm8f66H18BCzhC9nwbGe7ID2kIdpiis7ysWSqze8/FjpXxFQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyoqXAAz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so2124315a12.1;
        Mon, 15 Apr 2024 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713195608; x=1713800408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJwYmGeajWnyhfmhvhXH4yIzBpJk9yhRWIfhSSJVJjo=;
        b=dyoqXAAz4I8N4sHOOkfF2dHS5w4rCH+ZRTgnIFgWySVow7ZqjiS3NCe2nJwdX4ONJ7
         vefA7/Um64sjDrll1ipyA7d4VsiZhGRE9MvxYpIzqgaDtugW9labd7Hwhf41BXAf9S42
         gLtJSGN6V+zl12aWuVZ2TPlWETS96h1kCc/wmho5sSG9ipoy1WKgdDdY0UqlfAf14cJO
         XFFzFRkkWajD+3NO8q8g3HMXPYH/xw+hr1rNwoM0Do3gOgkHlbjTHm9ndBqQytL0XxRM
         UQXJ4Ih/KEYsdu6t9e0bLc/aYRfKjj7OLHikx3Qt4B6eqPAgwjVnlNyuBtdMZQQavqLg
         MfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195608; x=1713800408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJwYmGeajWnyhfmhvhXH4yIzBpJk9yhRWIfhSSJVJjo=;
        b=ULDDOf0xcVgLG6FxeTzOt1LuntNqV1xBOyWU1uN41dqvOn8ftPEXtnuo5ewgyjo/G/
         5yfCpkM4L/gUJYDGEp1Qw/6N6NnzdcSS+wwfzSm+xvs8vKfeE5ASuEZqBtdYbZgCti8V
         Oc+Udm3K5sDrMVj4ymyCCwWTY1UXCPMXlmO0CsxCF19JKEsMFcLhFpcqAzJf3xBvXGNX
         ISOWptx/awI+mzNPvFkNjNVJSsivZWIWOwjyndp58la511lT1slsUYBbNg8sg1/Mqi9d
         8HzbJW9l7eOM92R43notqCFKjDFimaqwIWd2+ctWN+F55Lg5Sv8wC99ABgIrl9zUG+xl
         WfuA==
X-Forwarded-Encrypted: i=1; AJvYcCW0H7qWXcFyVoHeSV5fQLNLOKKsbJr3bSaRRrzj3vRNQWhJ4snaLJCE8e0n3ABxgOrsb/qzmOfpg91kRZERbIpmsxGD46TRTwEw12dd
X-Gm-Message-State: AOJu0YxFhnE1jGLuAKFn7W74aGXt4UaFffbQ1WJtzs+ZaQrWoqiT4iI0
	6NfoU63IGTxbTTr7j+KLCY75VioavQRrRRD8lNyBouzqHFsumOyi
X-Google-Smtp-Source: AGHT+IF8qChUKseubeCjGhDo0oZmlYjsyW1V61iA0n0tPvMqtYxJOzrRJwlw2eNCFoplaUiBjIvoeA==
X-Received: by 2002:a17:90b:1243:b0:2a5:bf83:8db8 with SMTP id gx3-20020a17090b124300b002a5bf838db8mr7695825pjb.4.1713195608296;
        Mon, 15 Apr 2024 08:40:08 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b0029c3bac0aa8sm10035805pjh.4.2024.04.15.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:40:07 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] nilfs: Fix OOB in nilfs_set_de_type
Date: Tue, 16 Apr 2024 00:40:02 +0900
Message-Id: <20240415154002.151149-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


static void nilfs_set_de_type(struct nilfs_dir_entry *de, struct inode *inode)
{
	umode_t mode = inode->i_mode;

	de->file_type = nilfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT]; // oob
}



The size of the nilfs_type_by_mode array in the fs/nilfs2/dir.c file is defined 
as "S_IFMT >> S_SHIFT", but the nilfs_set_de_type() function, which uses this array, 
specifies the index to read from the array in the same way as "(mode & S_IFMT) >> S_SHIFT".

However, when the index is determined this way, an out-of-bounds (OOB) error occurs by referring 
to an index that is 1 larger than the array size when the condition "mode & S_IFMT == S_IFMT" is satisfied. 
Therefore, a patch to resize the nilfs_type_by_mode array should be applied to prevent OOB errors.



Reported-and-tested-by: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/nilfs2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index bc846b904b68..aee40db7a036 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -240,7 +240,7 @@ nilfs_filetype_table[NILFS_FT_MAX] = {
 
 #define S_SHIFT 12
 static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
        [S_IFREG >> S_SHIFT]    = NILFS_FT_REG_FILE,
        [S_IFDIR >> S_SHIFT]    = NILFS_FT_DIR,
        [S_IFCHR >> S_SHIFT]    = NILFS_FT_CHRDEV,

