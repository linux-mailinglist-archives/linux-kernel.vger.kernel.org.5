Return-Path: <linux-kernel+bounces-82807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865DB8689F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83001C20DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EB55E6F;
	Tue, 27 Feb 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQPJ6f7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3A54BEF;
	Tue, 27 Feb 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019331; cv=none; b=rWg801GNkgUTEtB6yFlxUcnQZVTVkCBmA/tLSotwmZSuJbNkjB6JNPxSrmuPcU/bAG48R9uUJaANBzLiAeRzc8ipEW/Z64qGHk3SURqWxPI22bYyWc9rcHelslS/3zx6O1dd8fLi45vrkfi2FmONZ1MUqwySnTNTxsNGa5tFT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019331; c=relaxed/simple;
	bh=y3D8WUkWKPmkFY3KmSBBbE7wj43kaGpM0J+XoS+kZLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mizGi0FLiOQ1pOWdNQGTy68JkHbcw9V8Il+GdQ54GnWciJcI6hD3eXICNYHn0PexdhLCNJJ5W4k0WYuhziTqI9jQUjuyOf2NhsWZL8BaqjeI8RW8VIJkdgXNc1YkWEcf11zh50j6809DzV1P/wUr/u9XjB/OZGSsayT2IaDHv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQPJ6f7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5481DC433F1;
	Tue, 27 Feb 2024 07:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709019329;
	bh=y3D8WUkWKPmkFY3KmSBBbE7wj43kaGpM0J+XoS+kZLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQPJ6f7ug8Rcs+DxLj4aM6bqai7HwJ1Jig7eLPf79CJ41+TQuTnxTQb2+yU/JzFNn
	 7/zJlyV0Nkrx1LumAZ+f5pmChx4ctfSC6iA5GxQ9U8vScWtkB3Afc1fGTzaoYV54W+
	 82xOhGUNBqdEl6Hp9WZ6LEOf8JD0L9afQDSO9mRd1/gT2Sspp7dJ4dDZl/6Q05444U
	 R2TOFWTb3J3FqfYpvN6G6GDCxuelsF2Nxep3FJszvjxmOwBqYdG4FhK7b90GB0Tn7E
	 LKBR/RP+pd4rFNaBxDt1zYmcSzN++OiFu8o/hqJmlCMddbQSYm9EAjmaSUiDOdaHBi
	 qOrNJX7crk8pw==
Date: Mon, 26 Feb 2024 23:35:27 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks
Message-ID: <20240227073527.avcm5naavbv3cj5s@treble>
References: <202402240702.zJFNmahW-lkp@intel.com>
 <202402231632.D90831AE51@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402231632.D90831AE51@keescook>

On Fri, Feb 23, 2024 at 04:45:22PM -0800, Kees Cook wrote:
> Josh, Peter, can you give a clue about what's happened here? For
> added context, the referenced commit is changing a noreturn function
> prototype[1], which I know gets some special objtool handling, but it's
> converting a pointer arg to a u8... I can't imagine what has gone weird
> here. :P

I think this convinced GCC to reshuffle some basic blocks, which
uncovered an objtool bug.  Or, objtool just wasn't smart enough, as the
warning says ;-)

This should fix it, absent any more warnings.  Kees, feel free to take
it in your branch if that helps.

---8<---

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] objtool: Fix UNWIND_HINT_{SAVE,RESTORE} across basic blocks

If SAVE and RESTORE unwind hints are in different basic blocks, and
objtool sees the RESTORE before the SAVE, it errors out with:

  vmlinux.o: warning: objtool: vmw_port_hb_in+0x242: objtool isn't smart enough to handle this CFI save/restore combo

In such a case, defer following the RESTORE block until the
straight-line path gets followed later.

Fixes: 8faea26e6111 ("objtool: Re-add UNWIND_HINT_{SAVE_RESTORE}")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402240702.zJFNmahW-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00..c4c2f75eadfd 100644
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


