Return-Path: <linux-kernel+bounces-83475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF22869A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10D4B2D7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676913EFE9;
	Tue, 27 Feb 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csF3uiYA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C713AA38
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046498; cv=none; b=JbV8Kg1cK/TJu2Wyt0TfxXIDwlU2/lh39gPIYPMDSBW/72NcQBZ+Jj0yZJ83S5dA85fFwxUvXSVhfwnHN5wxYo+selOWbO9JzOcWjy4kK9E/hJyIg1oQaoBgSMsmSBPY/BfoKmJRfQgg2TuXsBWOYsucDzzP79pUyNicCNsmgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046498; c=relaxed/simple;
	bh=shSEqvzoYcW9i9bedM9kkMWWgl1mlPbsKYHAmRts1zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tb5KEcz5kXcnece1g2ivn0fsQPMWVNGmZqjDZW/AKLq82GoEaxaXIt9EiNT4fdsAlgaL6PJ2M5tgvbg6phQnosP4DYHx8yOutPjEtvY/4Z5RyCBfmh17LnIw4MW3X+hZWhYxlPicE9+Ry43vyYUKH+1awBRjgGezmA1YNInzDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csF3uiYA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512b700c8ebso5456752e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046494; x=1709651294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNPyITx0UoynK6dHtAKEbnzfq8iXUV38jg8rhOlQ0zw=;
        b=csF3uiYAVx0vB87PIiAq3XjoX9ivtpwIarNubHNBES/dwe/PqmAn4TTVjedKRKGRV2
         7Z4RyCc8IxO0YV79OTMoZpVxbmqJqSCrWbUg6Y26jyvs+Oa2a2bagemjZLKGxgVa9xAL
         xTAnd+wISm/vUABS6PfQajQe2qPpb2z220bZHpdq4Qp34NGTX0fPZ8nAoNhbpzMUSZVf
         Hbr9J59QqZNoXcwsFoMemw7vQANahrZMNLlshP54WAaDcbGMgxthb5RvKq1dbFGypvEl
         kByMe1e0EtUXXS62iAr5275yw6dzuYmLtXKoMmT/Hn9AumMyqGBuXVIVtkFfk7BqaTiL
         wI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046494; x=1709651294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNPyITx0UoynK6dHtAKEbnzfq8iXUV38jg8rhOlQ0zw=;
        b=NMcHcyY2tZRSI1wbWc8akHHlQebAbRWRgKpAfyUsXWxKH3ei0soEu26bZA+cMURpG6
         aZ4EPIPlkKIZzNXS+2FvG1aLOCTE8ghiTBZ4jPMAxIlCRzNzjyQG3OnCrI8lMsM285QU
         cu9WzNf63aOPuVmDK8PcaIci0TgYzmeiRMhbUJ52vqKBhilgjM4O4xWhplZqDLs5lU7k
         PGvIKtGtYRBkmELjIW/3SZjGK7ViIXgv5cVTcqJvudwmwOk22gemL+8b0Nx05MdZu5B7
         7Yk6vZWxm3jwc1zcz4Rv7wa64N65FIft0UxLvjLcs1SUQUcuvMN7GxtP1npcvUZjeUKl
         FMuA==
X-Forwarded-Encrypted: i=1; AJvYcCUBx3oiEmBa9n8GsvHWxRZ6ynFljLUgDcsXVOkgjZ/DGVBCtorPspcajjFan3SYjEFYMzLhwuOpmgbo+pIUaAJxMvJsuQluUHOdB5B4
X-Gm-Message-State: AOJu0YyxVIW9uniwsLIAPZXt6/X5zNxnwx6pilOI2/JUcrU+gdEq0CQV
	NO9mewdsd1roIdjJFsLy0vQgEKZD6tzL8b8jwFihcOQKJPjql2gx7g97waoBeL7svA==
X-Google-Smtp-Source: AGHT+IFTZRgv21FYparaZiB0Jua8XYz44Z4aaCzCqBK/D3ZJPgxICJLyUKu+bYL34LTN+JZJTvwq3A==
X-Received: by 2002:a05:6512:24c:b0:512:cb9e:e358 with SMTP id b12-20020a056512024c00b00512cb9ee358mr7125892lfo.9.1709046494219;
        Tue, 27 Feb 2024 07:08:14 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id l7-20020ac25547000000b00512f2a11d70sm1201050lfk.283.2024.02.27.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:08:13 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: jonathankim@gctsemi.com
Cc: deanahn@gctsemi.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: gdm724x: Remove spurious whitespace in macro definition and tidy up defines
Date: Tue, 27 Feb 2024 16:07:20 +0100
Message-Id: <20240227150720.104092-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following changes:
 * Removes extra whitespace in macro definition and
 * Removes extra newlines between macro definitions

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.h b/drivers/staging/gdm724x/gdm_tty.h
index afec97ced476..3e0d5b621b25 100644
--- a/drivers/staging/gdm724x/gdm_tty.h
+++ b/drivers/staging/gdm724x/gdm_tty.h
@@ -7,8 +7,7 @@
 #include <linux/types.h>
 #include <linux/tty.h>
 
-#define TTY_MAX_COUNT		2
-
+#define TTY_MAX_COUNT 2
 #define MAX_ISSUE_NUM 3
 
 enum TO_HOST_RESULT {
-- 
2.40.1


