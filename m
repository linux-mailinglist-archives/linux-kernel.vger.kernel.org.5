Return-Path: <linux-kernel+bounces-125653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63282892A38
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC41C2149C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ECD29CF7;
	Sat, 30 Mar 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUxcK34M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E407200A6;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=PYThi49YGKvKTceauJDlDRxsegLivyIYR6pm2WffXwYcJvCCIkq4rGAloV4WlWrt2jF53j7J3I+tkmbEk894lIe+i4QHf6rJx39vRbHPLoi0C40IQfXUMruquqBuw67lF96FjFON2RWjq36erP9aclNS+Ta2z0T9qLhwVhnL6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=F2ZcqOvsB6gLqMjloYzhDex1+N0kVg8On75ida+P8PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/Mog53OArUxtiDCrU2IrpdBMho0jtlWjqJh5LBd1RdpgJfRpDEcBzxzk+RSWpgHiYgx4fQVuvATfHSpaFYgZ8K/8uFPMQZK3EKcYiP7RN2dqlZmAvV5ZOJz12/nOYxoLKgWgcyAVSDlWpbT+3EEjmrAeHmvPohthgJE9mOmlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUxcK34M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E50C1C433F1;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792676;
	bh=F2ZcqOvsB6gLqMjloYzhDex1+N0kVg8On75ida+P8PM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PUxcK34MA+2z/WsdF6ogE90nplqBeqv41gqT+akDadPUUSdujPJ+thcxS+/j8hG2z
	 ZbApKgti2m/mX1z3P5+thrtCu738EwHD0iy7mAroO88dIY4hnnKFydVIbqLDIQU7Kk
	 kDQlvmcBJ0b+BUIFWK4kA3mOihRbYXFXRlcgSJuGwuG2BP54B7z2iv2Sl8xxwJGynk
	 vblf00ZPuCq7qL131UabB4OrIfsfq111lLUBO0lqoEFKk9Agwg1nuM0e42clZfU0Uy
	 l8j7XmIzh9ejr0bWpACcdj3OUn4+9PoBi69ksh6XAOlUN6RoBF3mc2IcZYJSv8NZv1
	 zIgYJLq6p+fiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C06CD128D;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:37 +0100
Subject: [PATCH 01/10] sparc64: Fix prototype warning for init_vdso_image
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-1-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=1128;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=N9b4/JHlSvx7NLzDXct2fVraabjc7Gt8Q7BQyF6OslM=;
 b=pqCSBh8K2ae9bOOHPujcfnCWfW2c5NPkgwVpUmfkAUcvddT2O83UJiZhFCoDwOvrMIzqVXWX7XJB
 OCUNfTFQDk483lfMK9cJTCWlpEz4kMSy069ZmTRUAiKTkt+BsfeR
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for ‘init_vdso_image’

init_vdso_image has no users outside vma.c, make it static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/vdso/vma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 1bbf4335de45..bab7a59575e8 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -243,8 +243,9 @@ static int stick_patch(const struct vdso_image *image, struct vdso_elfinfo *e, b
  * Allocate pages for the vdso and vvar, and copy in the vdso text from the
  * kernel image.
  */
-int __init init_vdso_image(const struct vdso_image *image,
-			   struct vm_special_mapping *vdso_mapping, bool elf64)
+static int __init init_vdso_image(const struct vdso_image *image,
+				  struct vm_special_mapping *vdso_mapping,
+				  bool elf64)
 {
 	int cnpages = (image->size) / PAGE_SIZE;
 	struct page *dp, **dpp = NULL;

-- 
2.34.1



