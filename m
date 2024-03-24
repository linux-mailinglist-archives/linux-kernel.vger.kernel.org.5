Return-Path: <linux-kernel+bounces-113757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF588866F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D642C1F2474A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B314B073;
	Sun, 24 Mar 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG3IODSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FC1272DD;
	Sun, 24 Mar 2024 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320764; cv=none; b=jvRmzPtLl3AMdVgZuafOud89+ta/1eRk88K5hbzZSM7B7pLhR8Yte/2AYf1rZX7ZQGYwN9L8EFaJ6QUBUbrEMWdBHiRwdjmlIUWNuHSGSQJAImfoMR9PpBeBdedTQvqF/xZOKbVlr9DMabt+CKhAJow4zqyMJlu5n1VUwrUWDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320764; c=relaxed/simple;
	bh=YNZbHaV8JW7SkCNxUeXarPC6P7Kv6wqn4pMipRrje38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcS0VOjpRrwu4GsHqwtiQehORo7P6CsDS89zcDG3sJHui1H90WO2xf633zgHed4RjRE0bhQG5waiqYLvfK08KQxNYZ6TLJ74BAMNybBf1Mwo75j8tMQg55NvHIj0HfeWes1/ESPLSXr24akx4U0T0z8uS+Rs1+FFZZExhmJC0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG3IODSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDE2C43399;
	Sun, 24 Mar 2024 22:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320763;
	bh=YNZbHaV8JW7SkCNxUeXarPC6P7Kv6wqn4pMipRrje38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OG3IODSysIr0OO2eoVcUOfFdTvHYbT2s6aaDWWJm8CS/MXcRtj5GPdfDr/Z62PjUJ
	 3yKL9zIzY70080i2V7fu380UJWChmRNvTDgTVjYN27viRbEkgtXREJB9hnzseTr1JW
	 0ioXX9GalFu4tzM783n4p7Zyyn1HQRw5nUohJx0EGSxvTC1GhWfREQGdIi2mndJlsq
	 Jt59IjlmSQ17roFHKHTxwy2C6F1JZHWpU3VQflODl/4zqxORfUYK0XnQxwM2cF1fHo
	 6hBZR5cKOUdm5570yA6GZSXl0NSvzlzzQVurBdTvcYo3kdBvGMM62gfcnxuKEyBPMr
	 a+0LLjpgIrWmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 327/713] objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks
Date: Sun, 24 Mar 2024 18:40:53 -0400
Message-ID: <20240324224720.1345309-328-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index e94756e09ca9f..167603f839851 100644
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


