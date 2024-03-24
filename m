Return-Path: <linux-kernel+bounces-114022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE21888F17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333C328A44B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F499229D8E;
	Sun, 24 Mar 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYAfcsho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7D1E5F65;
	Sun, 24 Mar 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321297; cv=none; b=btRjn9jEXeuXJQd8jyi+qUjHDI1SWXVrd4FDfzpqgYxuZVoklwLny1y/VqyroXOO05pzToSnsuA7r8WjcPlqaDlp1QP5W6K5YajAnPRHYp3aOIUx/H17iBk4clCmeeN3oPx/KJubx6/WaTKle7Xx+vZY2uTAD7t5isAQ/1CsqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321297; c=relaxed/simple;
	bh=gIBzsxEfqCELs+orQBkAqqxwLcIB/dzP3lehUdOAuRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO2K3ugOPj15grBDvMYctiCzjbaKi8ggQnmbrBMSwQUgnlGB3qbSgr5QEuo/mTG/qg4drMofNzrDLDSoXkXEny+HbX/gueAMoPap2vuktQebZknQe0XgvGVCKFg/F1kU1qv9CT1j+RjC/qB/URmsv94+GUq2aoF2AZ8CjbUN8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYAfcsho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291C6C43399;
	Sun, 24 Mar 2024 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321296;
	bh=gIBzsxEfqCELs+orQBkAqqxwLcIB/dzP3lehUdOAuRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYAfcshoB2ixfBStZKMNi24jYwPAZHXZyoZ4Xv1CZP62Hb3Em2s05josGDSPHFcll
	 Lj8XXNioblGS/nHK2qQMGJ7hkz8pqmeJtXzhJeNznDjUIGOp4JQT8OOCT1nusmrZRv
	 TP5iaxreTL+M3YZCVz1wo0Ps/HWelWPLB5hYzlAANdtyW7CRWmsUERjlBAy+tuhV+D
	 HjfvWEK6FYUctcqzOzixsedbIp3CV1v7qhsFGk+Wj0GH2zmOmcgFZvgxqbiqSj5IxB
	 Fv4+hEmjl4MldfgalmiPdvoj7BUjovfkbzXSvdBsJP7B7JSdH59aPggKDvNWI5lA8c
	 2Vzdnn2fIq2ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/638] gen_compile_commands: fix invalid escape sequence warning
Date: Sun, 24 Mar 2024 18:50:56 -0400
Message-ID: <20240324230116.1348576-20-sashal@kernel.org>
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

From: Andrew Ballance <andrewjballance@gmail.com>

[ Upstream commit dae4a0171e25884787da32823b3081b4c2acebb2 ]

With python 3.12, '\#' results in this warning
    SyntaxWarning: invalid escape sequence '\#'

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index a84cc5737c2c6..bc005cac19441 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Use os.path.abspath() to normalize the path resolving '.' and '..' .
     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
-- 
2.43.0


