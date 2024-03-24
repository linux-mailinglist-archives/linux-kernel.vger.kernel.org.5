Return-Path: <linux-kernel+bounces-113169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B445888202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570DC288136
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92C174EF0;
	Sun, 24 Mar 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYUUpFl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAA174ED7;
	Sun, 24 Mar 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319971; cv=none; b=mVPxbkTxrdQ0lj5uSO48tzwvJs+lLT5HFMZTcSviWZtnQ8gw3avzMkFjIKStmF0dukDKQ0gCG3X/vmt9ZMu8Whxuv4kqntUj8BH0vkrjkB9EyAOaH4+IWvGGsBSglGdefYTxoupcQJH0a9nHcLOilso8hCY8xNEVZ52uI4emA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319971; c=relaxed/simple;
	bh=1lcqNUEnQ0ADi75cyhwnE7U3PFvqMXBMU/9HDfCGPls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l267XDpf8iHn85K6/jH9XxAc1e27CZ/KxR4T1cbSSYBJpNxWno/QEDLulxpQUyWCqLwUiXjiIOpIDHiw3zRFB5EmJLB9Tk6pDFVqkfJYjn3AaolZeilEa/7Z0MvZ1S9NyrNKZePsVRcYXhpVmu+W/LeB/fhOlgyAgjD8JOT4tKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYUUpFl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0985C43390;
	Sun, 24 Mar 2024 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319971;
	bh=1lcqNUEnQ0ADi75cyhwnE7U3PFvqMXBMU/9HDfCGPls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYUUpFl7yONBbk83JSCG45Ll6vKnZ/6hZwiDDNt/519sC/zIosumNX/YxytSYWe+y
	 5U3QYCIROEPBqA3y0hLW9pZFDDwXoZYsIbnYvFbYYDrgMKVAxRIAVXDlUv8MWJpHh3
	 n/Id7nU5TYShuP6c+nSj+PqZsFTp74fRcK/lO5YvrByIUeyqvVApkk451lInD2R1RF
	 YMPMLu1H9WIw/FUKvF8SMjaG0Buze50hb+E9ZCfQvoE2jSBKl4fDLZ3HPvfMkKrcq9
	 FBPEVfKsPLpWlOGfuOpKP3LFE4GvSApOrgj6DHS85m+kTQfyVLbVGHeYQIkoJ4LdeL
	 AkcI0l7q0sF2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 278/715] objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks
Date: Sun, 24 Mar 2024 18:27:37 -0400
Message-ID: <20240324223455.1342824-279-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 10b4c4bce3f5541f54bcc2039720b11d2bc96d79 ]

If SAVE and RESTORE unwind hints are in different basic blocks, and
objtool sees the RESTORE before the SAVE, it errors out with:

  vmlinux.o: warning: objtool: vmw_port_hb_in+0x242: objtool isn't smart enough to handle this CFI save/restore combo

In such a case, defer following the RESTORE block until the
straight-line path gets followed later.

Fixes: 8faea26e6111 ("objtool: Re-add UNWIND_HINT_{SAVE_RESTORE}")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402240702.zJFNmahW-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240227073527.avcm5naavbv3cj5s@treble
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00c..c4c2f75eadfd9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3620,6 +3620,18 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 
 				if (!save_insn->visited) {
+					/*
+					 * If the restore hint insn is at the
+					 * beginning of a basic block and was
+					 * branched to from elsewhere, and the
+					 * save insn hasn't been visited yet,
+					 * defer following this branch for now.
+					 * It will be seen later via the
+					 * straight-line path.
+					 */
+					if (!prev_insn)
+						return 0;
+
 					WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/restore combo");
 					return 1;
 				}
-- 
2.43.0


