Return-Path: <linux-kernel+bounces-115660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62D889465
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A6F292B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC066353017;
	Mon, 25 Mar 2024 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6FMd3s+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D6137C22;
	Sun, 24 Mar 2024 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321555; cv=none; b=FkCpKQNQtozW/iRPXc+wPAbSJiUu8HTuftbPVb6x9jUHfkz0sQxkobGw8qCmM2BUFA/95hYd4twTmNLlZ2ZsS4z5bXOT2WWUxJFrZFFVV9KiVySqVhNtDjnnwUYThDHdnWtf4WCiCivBnR5YWUu2BCjXzze+xtYyz+1QWUIs1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321555; c=relaxed/simple;
	bh=Oy4cmeOCNXlltoZON9vom6KxuGfFKgp8FtaL4HrwVTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knGkzqN6USgVUHb+KIxoQG6nkUj7zzYNi5zl6OjoCokdsPULbOAC8lZVyuFmrElxsHnS9ClLwC7k6CbKfCVLWezhLw8qercdiYYLjIM0eNXdhuCQ3cpqvzC5zixM1lNRclFGtrfHRW/ve7jANzdksdVQ5huxmSsBn9pPBy5U5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6FMd3s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C173C433C7;
	Sun, 24 Mar 2024 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321553;
	bh=Oy4cmeOCNXlltoZON9vom6KxuGfFKgp8FtaL4HrwVTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6FMd3s+lk+08q5clbCFwCENSmkRYqJek8jCyPInHvbFtcHw6mjwGoT79cjkLFA+K
	 JHY0djz7ANeUVtTyr/lBy425enhe6bLk8J5Bik/vwPTQjjUFYbkimXQk+wlYuG1R2A
	 H/91U19UoKiBNqfa5GgD0Vy8UTh8kJ/tRhBRBxXZUGGKaL3Yz0xN9pe7a22GyXH30e
	 1RtGlq1j3nMuBypBXSNOQyMt/8n6EYS/eoI4yEixkeiIfXLEctiKwD5YzCEvkFw4dL
	 ilX0KKPxwSPjaHeiV9n8B7u7mqFkfH6QIcw+fp59QBkeZXEz6xBjBG5X3ztASdgbjw
	 QxMTYwZjwT2aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 282/638] objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks
Date: Sun, 24 Mar 2024 18:55:19 -0400
Message-ID: <20240324230116.1348576-283-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index e308d1ba664ef..e3fc263b1b206 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3604,6 +3604,18 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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


