Return-Path: <linux-kernel+bounces-86995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC90986CE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9E8B22BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227D147740;
	Thu, 29 Feb 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLf+WgC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E161433AC;
	Thu, 29 Feb 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221824; cv=none; b=MNC3n89eaOqzkEKGVurysfWSPTsFrjfGNS0jHyzSxB3cbpFWh5zNRzNp1Rzzja+h11sqEm5ckm5aTa9nBD7Q6MeEvBoyiLG2zkVB/p3FeZIEiRPspw5/uhfVXfD0Pa2LNSMa/QhjktCxpKbF42jhH7m7CEaNjdrtIk8KS3CVQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221824; c=relaxed/simple;
	bh=gIBzsxEfqCELs+orQBkAqqxwLcIB/dzP3lehUdOAuRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY9tEo/tJcZyjeGC72kTuVJRF8og31n0bLe3cqEqsiefXpIkzQ40xXqw3NJBEqEJ6xPc3haHk0N8nW7M8SspmprOhWDTy3V7ty/cwELggCNg2VgQgb6YiYo30ZREwTlwdQ7vysMYQQ8xtmBIKfxQT+H4eqSyy5LHS6ZSRTmKkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLf+WgC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD61C433B2;
	Thu, 29 Feb 2024 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221824;
	bh=gIBzsxEfqCELs+orQBkAqqxwLcIB/dzP3lehUdOAuRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLf+WgC8LkENgBw7/i/sHQkW3qub7yJxZRNx+AjSwwlWnGa52Pw6Pz6ZQsliZakd5
	 5EEd1qCIpEyWzFN/m/Esyk799sCdfdecXcFPgpDWLUCISnY673IbB3nP4mB0sU60lF
	 sE61YhADLSPDwXm4OIzf05uemawsBHJoQb44pLPVDDJQ4IppAWAjC+rQMIv+sqcOlW
	 49cDGOw6EqEWYymLOnp2dIywNSgnY87rpPWWSu7Jl+mVyccyfcz9f4Fogp8xaxEjaE
	 voumk675xi5eib9KqDFLUx4D/bzYL/PqBZaKyVuKm2Hc2A3UKjVGo1kaHxVsn/1RiS
	 InLqe9rJpkEvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 20/21] gen_compile_commands: fix invalid escape sequence warning
Date: Thu, 29 Feb 2024 10:49:40 -0500
Message-ID: <20240229154946.2850012-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


