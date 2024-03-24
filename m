Return-Path: <linux-kernel+bounces-116004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436C988955B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E50297E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2717921F;
	Mon, 25 Mar 2024 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PODXOJQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B458272973;
	Sun, 24 Mar 2024 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323311; cv=none; b=aaTQoZ3Iq9zujildyatln7a4pd18IoVDvl3qSYtk0p80y0WedjlvNWXJJ4UZLYk4C39+BYHd7DJ0c/ILZnGhVUdC3cOKbxVPYLhJAUx92iQIHu7kVZ6ejwi2aE8dP+OOapXgwlqMk+SKUUH8AsVu08z4s5A4y+JJRp8v1lgYqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323311; c=relaxed/simple;
	bh=69LnKLUw/CQjKGQSReO/Q4FoKZ4LF/t7TUj6z3/ixkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl8QKkmQo4ymUJcmLUK+P01vS+rZ0KA6RzGIZ8pmplET6t1488gB+2YbGE7+DS1ZJO2sVpZT+j7UIu/1JOGJ42tNVMQ2rPPI6d8e2n3xI43fcsstfWaWZmVeUBQGuufUDIRnkxB5ZhpF0Xd09GUx+HCUetiofF9tfInB1AWLCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PODXOJQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825B4C433C7;
	Sun, 24 Mar 2024 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323311;
	bh=69LnKLUw/CQjKGQSReO/Q4FoKZ4LF/t7TUj6z3/ixkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PODXOJQ27NQFlUkWzhP2zdv+ujxYdrbQGcUHGjPBslHrjqc8Agk4FFuihu6FZ2idb
	 hTIJutnzqgFZXokRMVU2i+0UM7y51fCfJsbWFGFjTe2ZqBoS8/eKrBeh2tG/VnovOT
	 BhlfdlmrFny9qpijpoksM1pUWgK9BW/zCtpjFxil9/ZpmKtRKcuYJpi8PUFXYwaPyl
	 nldESaGaPCm6NBwI2ES4ciFdcup3s6Nbxotawsk9vbuAPcGbLkateioiKH7MKbqbzb
	 5C1lvFPNzF9/EqzYzL3654BoEXdz9MMNJQi45HJTDLIgZElK4eAtcFQA+Sxno2vSfU
	 FeDN8jshF3sBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/317] gen_compile_commands: fix invalid escape sequence warning
Date: Sun, 24 Mar 2024 19:29:51 -0400
Message-ID: <20240324233458.1352854-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 1d1bde1fd45eb..3ac949b64b309 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -184,7 +184,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Use os.path.abspath() to normalize the path resolving '.' and '..' .
     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
-- 
2.43.0


