Return-Path: <linux-kernel+bounces-125657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A004892A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF31F2237E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44440846;
	Sat, 30 Mar 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIiZZARl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD3208B6;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=Y8MZ/ai17tIfKV3SOXN4whHZrOx4W1mSmBncyZg4Vv0JdXOmL+pdJDnJai3bFgXO2c2iXhghjN736sacLNdt/ls9LQwhXwB+KpEbUtPWAIqBH5M/phK3gAkEUhDwTWtSZMkIgK73He+4tm8BJchNDgcpFdz8wEGKbSz97b8ynvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=lhcM6K3TrpZBNI30rUUArfcpy+N8YiTmUvxeRdnrB5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtRpjaxQYOX4RyPcxSNxQLaqMWYFU51tD6z/Y+NYFxUX/qTFwyiEif1tXLniCQi41PYxagpKFuyY0J3jQfzBgPPGUI8LGUWCpnoGSM00GtUWBddLz1yl6XUx1dxKj8bBatReDQzCqqWMZ1LHIJWrLmQ/qQOmK3HQROQbEQCye6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIiZZARl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 277F1C433B2;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=lhcM6K3TrpZBNI30rUUArfcpy+N8YiTmUvxeRdnrB5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eIiZZARle/xlgXKw20QrbbCRJt0vYL5/z4leI4zsHCLp9cNlF/mJ2/PduJARKA40b
	 JIfsBYRKqn2if1aVgQzQzuV8bxUAWn6ZVpzLWSzpdBokkYJd3IpLnZA/Xw7z7QkpK+
	 sQFWWycg99PAhY9A3214AkVS/qg2aqj/CF8qCNDCHXgupZ4vGDoI/1IkyiS+UCoc6S
	 NK1dw4+vPKBr4L6jl/6D+MhZ2C8G8T6V0xURZ7Q9CeXdI2ryDja9DNGExmv1rtK41Y
	 u3h9Sdcoy8Me1JijmJkLJ79YOBNGeDkF3yGIrVsohxoMO4fRLeM4VHI15NWg88ohmc
	 BaM6ONovnIpZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206F3CD1290;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:43 +0100
Subject: [PATCH 07/10] sparc64: Fix prototype warnings in adi_64.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-7-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=1998;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=4x3bdFE7JXKdL9191J0m+VT2gS8HRbYF0N4eZvrNsnU=;
 b=KqifCim/T+astHCsES+LmkrKBcWtdEitfmvxz1BoClBokgS1XQlcr/JHLjv9RGX/Od9w5o4aOkH0
 f0LJ8jV5CPZjNphmsQqyVbM3ErgZW6krl3I5AYTISzKCQum0oi8T
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warnings:
arch/sparc/kernel/adi_64.c:124:21: warning: no previous prototype for ‘find_tag_store’
arch/sparc/kernel/adi_64.c:156:21: warning: no previous prototype for ‘alloc_tag_store’
arch/sparc/kernel/adi_64.c:299:6: warning: no previous prototype for ‘del_tag_store’

None of the functions were used outside the file, so declare them static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/adi_64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
index ce332942de2d..e0e4fc527b24 100644
--- a/arch/sparc/kernel/adi_64.c
+++ b/arch/sparc/kernel/adi_64.c
@@ -121,9 +121,9 @@ void __init mdesc_adi_init(void)
 		mdesc_release(hp);
 }
 
-tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
-				   struct vm_area_struct *vma,
-				   unsigned long addr)
+static tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
+					  struct vm_area_struct *vma,
+					  unsigned long addr)
 {
 	tag_storage_desc_t *tag_desc = NULL;
 	unsigned long i, max_desc, flags;
@@ -153,9 +153,9 @@ tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
 	return tag_desc;
 }
 
-tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
-				    struct vm_area_struct *vma,
-				    unsigned long addr)
+static tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
+					   struct vm_area_struct *vma,
+					   unsigned long addr)
 {
 	unsigned char *tags;
 	unsigned long i, size, max_desc, flags;
@@ -296,7 +296,7 @@ tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
 	return tag_desc;
 }
 
-void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
+static void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
 {
 	unsigned long flags;
 	unsigned char *tags = NULL;

-- 
2.34.1



