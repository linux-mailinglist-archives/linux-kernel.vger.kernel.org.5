Return-Path: <linux-kernel+bounces-67638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BB856E59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46411F237B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ACE13AA39;
	Thu, 15 Feb 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVEBMI2W"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842341A81
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027860; cv=none; b=FzjCwLHOhaLVcF/FhPOSNLLe/cS1tuNPTQv7WuT5JNQcckCOqfODcEDvHBoUI5MdNfCXywWfQVVfNkxzEQRPgtDAAxrEaLCRDfZO3XrtNmLjckMRWuSbUluyK6W1+T5PbRnlTC806SK1UFIwzrscGsBR9XYexYqwZIjAyMQv9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027860; c=relaxed/simple;
	bh=L1miiKpB/+MLq5mIW3X4o0VGLTONgRex6fAxxjHMNRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nqzg+rZ678M5iQ/drw8Q8fyY0YSvjagCEUa6sfopDU2XpO/jUqAC3r67cfmAsajb7qb2Zb2mVEdm70n6YOu5O8Agl9uP7yXtHbj6gyl60ZG7O5OrM/VpQW2ahpDaK3qKN6U+uiprWKyxYQ/KCUqnz+OTg1dtUqLYL0geaIhqRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVEBMI2W; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1180638a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708027858; x=1708632658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYLTFvOYvCyE+kba2OweNWpInmcv7a9h94/NURW8+cU=;
        b=CVEBMI2WEWR5sHcHcjzxK3ZVY/NM4XYV7Tm8MGRywJTY3ZOyhEJJ5VjfUwGlsUrOQn
         IZW2/RRxH+BAYIRJn3lFS5C7rUfmZqTaaKLV6pJXe/1sCa64QPaf9nL3Nwse0whKxBwS
         Pwr3WvxPDIsKljoyGpCebJF0OuvBodYD+mmgTuuE09Y3mQ8eTbqwjqzOyFuNdxp4/rOw
         Eg0/8rVW6hkTNcF8r4n40F0zSx681cByZTOHMjRW8ugn4jbSlHskRM+s9nIryWnqgtuO
         hgmCHaWzRQ/do7C8ElGTrDWio0hoDol6vfRIjbitd+mMrlFsrkZZIddCSrGyab7QIpxY
         7Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027858; x=1708632658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYLTFvOYvCyE+kba2OweNWpInmcv7a9h94/NURW8+cU=;
        b=tY+utRvWO2Qysi0KyIiqflWyfzQjNWzxYMBTHe4hGWT9MoexPcsxhQ+WpmrJfPfHpy
         T6zchKKPIHT6wIitfI74Q7+s0hKEWRPhOWmorrzw2YDr71CQEc96c+W50Y3u5yIp4I1m
         Rx2XJ67c7NmzXtC0UGFnkl8OKxxxbyL4YqUfmorPwRMeJrY5ndTPPhcMWJiQoQdaE7Wo
         vSWez4MkRz+O015wqnu3CUG/ZK6+tM1Ju/ipiraWDAeAHiaKfXu//gaNsRV8en3JyHm0
         yahYe8HL4zNnBkTPg5Fl1hoZ7zOte/VL/p1YEjz2JM1bPRr99+r9zDR+36zcvRIjbCKR
         mHBQ==
X-Gm-Message-State: AOJu0YxvQ2tw8O8efhXXOvk1X6RLZctzGm3Sb98HJtF+Z2Pg3s/1v6+4
	mHH7/QgfsqxBsSIwYl1eMgvYgU8OYuYgxA+2sxULHMzs2hwHQdvHMHQrHTqB
X-Google-Smtp-Source: AGHT+IF/f1VEogR6Uy8rp0FVSURwgFmslmsw9/F+c36lGr0fuaLy2YqoQeWhc9ydqLeBf6xnhL/51Q==
X-Received: by 2002:a17:90b:2398:b0:299:3174:74df with SMTP id mr24-20020a17090b239800b00299317474dfmr203778pjb.20.1708027857570;
        Thu, 15 Feb 2024 12:10:57 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:3772:8174:2d71:3b60])
        by smtp.gmail.com with ESMTPSA id st13-20020a17090b1fcd00b00298ca3a93f1sm3842499pjb.4.2024.02.15.12.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:10:57 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs_io: add lseek command to execute lseek()
Date: Thu, 15 Feb 2024 12:10:53 -0800
Message-ID: <20240215201053.2364270-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Added lseek command to support lseek() for SEEK_DATA and SEEK_HOLE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index e7d286a..b5c5b97 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1630,6 +1630,43 @@ static void do_removexattr(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define lseek_desc "do lseek for SEEK_DATA or SEEK_HOLE for a file"
+#define lseek_help					\
+"f2fs_io lseek [whence] [offset] [file_path]\n\n"	\
+"Do lseek file data in file_path\n"			\
+"whence can be\n"					\
+"  data     : SEEK_DATA, return the file offset to the next data location from offset\n"\
+"  hole     : SEEK_HOLE, return the file offset to the next hole from offset\n"
+
+static void do_lseek(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd, whence;
+	off_t offset, ret;
+
+	if (argc != 4) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	offset = atoi(argv[2]);
+
+	if (!strcmp(argv[1], "data"))
+		whence = SEEK_DATA;
+	else if (!strcmp(argv[1], "hole"))
+		whence = SEEK_HOLE;
+	else
+		die("Wrong whence type");
+
+	fd = xopen(argv[3], O_RDONLY, 0);
+
+	ret = lseek(fd, offset, whence);
+	if (ret < 0)
+		die_errno("lseek failed");
+	printf("returned offset=%ld\n", ret);
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -1671,6 +1708,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(listxattr),
 	CMD(setxattr),
 	CMD(removexattr),
+	CMD(lseek),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.43.0.687.g38aa6559b0-goog


