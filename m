Return-Path: <linux-kernel+bounces-87007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D186CE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941A02820A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAA1525CA;
	Thu, 29 Feb 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPpxjfTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA01525DE;
	Thu, 29 Feb 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221852; cv=none; b=YwmTC2Z4hfWT0BwmH+lECraYUb0FAuFfH+1+uxD8YwsGQTtICw1Kg1XNXW7Zm1og/utzElnKNiPLMvDBvA7W2AXE5pTdBx0eLVzsGDpgN1AiSPf1DESs3chnBIlIMImRLFwYpxtyiGCgEDtaQsaIbPOtmJfqcQJR5z2+MKk7PDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221852; c=relaxed/simple;
	bh=vdkbPj+PFhQKjWVJYcrhGD7J8o8ZdlE3izlhiVJaqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB1/fTmGbB9XnbD09K5Oygx+C61ds5nan6ZGo/cQ1JvNCpEaWO24UkCnJ5lpFxCGBRiXvHHhmHgnzejBcMWgIrOXrshlHfNePogBB36igOxALNeZTG+icCqT4UkMVUjGhGAnvZwOu2H5tQ3xwJTf9iH9Tw1nIsfgyXR8nf8Di+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPpxjfTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78C5C433B2;
	Thu, 29 Feb 2024 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221852;
	bh=vdkbPj+PFhQKjWVJYcrhGD7J8o8ZdlE3izlhiVJaqxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPpxjfTq1hEybs+CLWRCR+MJgSP4EG3Kwb7FLwfEtk1vHu6nfqzhzj29iUZXG/MP/
	 /UQSS2+zMBR/6QR2icSDkBe8tzly9Fnb5rPHuexv+UIhIIRSXWBRlvcz+7vNsl8MHY
	 eWlTGDl/il691CB8czDNDeZzfLc9IdmLFAJeodn2ps0FeCVif7gVVjpOB7K087f+hm
	 9NG5sG6/0m2TeeGlWVaxxcTb/UrkKxuAFA6bPzEZbRC/daECQh+vxmU6/86vGawdvm
	 v3Md7HFl3M24jWi+gbOrAZZdKd/GhlQ7eklBXsJXHZCAeDYk5s1DDzGxUxp1H710ve
	 u6JW7zM/LT3Ww==
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
Subject: [PATCH AUTOSEL 6.1 11/12] gen_compile_commands: fix invalid escape sequence warning
Date: Thu, 29 Feb 2024 10:50:28 -0500
Message-ID: <20240229155032.2850566-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155032.2850566-1-sashal@kernel.org>
References: <20240229155032.2850566-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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
index d800b2c0af977..4f414ab706bd8 100755
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


