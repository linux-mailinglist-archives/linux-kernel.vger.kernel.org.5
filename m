Return-Path: <linux-kernel+bounces-15548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A9822DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415D51C2270D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164E199A1;
	Wed,  3 Jan 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1EAJyIS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A3199A2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D224C433C7;
	Wed,  3 Jan 2024 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704287143;
	bh=qy1B/hVtV9MM5lWSYrtrT8fgfP6SIBH1VGhcHFiT9yY=;
	h=From:To:Cc:Subject:Date:From;
	b=t1EAJyISncSnz5PGeFlyA9kbqbxPNviKX8PD5T4nilzclBHEpUmxRdW5+vxcxThP8
	 +R3U0j/shTqpfxy5IFw7drdbekMeUt9M5nfm2ijQuOnoB9MvGMxTnQ3jnAOQ8tTX9+
	 s5wNtB/17rJLyESY/2RXqHB5V9bu1kj2oBDUmd4n/HIBFvAodKc/VjuitS0U7/TQoU
	 CjdzAkC5PKwlC9vgqGuMVrw64q1BfRgKn2IynBja3BYRIYC/nYJz57n1BBUnEDy5sA
	 hhubRjLlCMkVyp98fBklxGS+mo5oqj+0QcO4uV9yLcwdN8LYeWJMiNeELz3hHF0zmE
	 H0aBGvfH+ip7w==
From: alexs@kernel.org
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexsshi@tencent.com>,
	curlinhuang@tencent.com
Subject: [PATCH] execve: argument list space enlargement
Date: Wed,  3 Jan 2024 21:07:22 +0800
Message-ID: <20240103130722.1551670-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexsshi@tencent.com>

Wechat using too long gcc parameters, then get a strace complain:
  execve(...) = -1 E2BIG (Argument list too long)
Have to increase the parameter space for this, stack has enough
space for this enlargement.

Signed-off-by: Alex Shi <alexsshi@tencent.com>
Cc: Alex Shi <alexsshi@tencent.com>
To: linux-kernel@vger.kernel.org
To: linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
---
 include/uapi/linux/binfmts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
index c6f9450efc12..717f6cafe8dd 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -12,7 +12,7 @@ struct pt_regs;
  * prevent the kernel from being unduly impacted by misaddressed pointers.
  * MAX_ARG_STRINGS is chosen to fit in a signed 32-bit integer.
  */
-#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
+#define MAX_ARG_STRLEN (PAGE_SIZE * 128)
 #define MAX_ARG_STRINGS 0x7FFFFFFF
 
 /* sizeof(linux_binprm->buf) */
-- 
2.43.0


