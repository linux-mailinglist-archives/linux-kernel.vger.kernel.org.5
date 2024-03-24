Return-Path: <linux-kernel+bounces-114934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533C888C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A55C1F28C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40942D8E55;
	Mon, 25 Mar 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU1Nz0Z2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C84178314;
	Sun, 24 Mar 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323641; cv=none; b=MCIaELb1CuJJq0L0Xl2oG4mVeU8kC+OWh07jykEjQof91LUHE1/ESa+S2LA4akz1HXvSz9Gfd4g7uX89uxfHsmQda2QgCeEummcKKX8lZbrsgOs3d6V8TbT2ucpw12PUdBW4mp7dUTjppouKoSFYUEd+ktyHcXMkuMlu5WnrgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323641; c=relaxed/simple;
	bh=iDEiulklPJxiT0KxN848Zac4TFlvECiWKebGAJuHqZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DruqDhclsRUsSe0xiLUnR2wW//n5CAi8OQjcGiQyMp6lQ5/Bmu+XJZ5aHTlWzmfOYdqb4mp1b8MtQo29L25iU9p/ycRADC0gZERnVLgX6IkJrGJceuYcNb7TMbJme2wDgrUYcQzciEKX97JCzIlhXgzd8x7aj+gh2yXLP5HCv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU1Nz0Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3788AC43390;
	Sun, 24 Mar 2024 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323639;
	bh=iDEiulklPJxiT0KxN848Zac4TFlvECiWKebGAJuHqZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JU1Nz0Z2Qgo99S+NqdvIyMOMJ4sBukR4JF/R2n4DyfTmetIQEIvilrKDH8msJJ9pz
	 WNd1kndaGzbd8OsxZUh5pCy4EKv0mmge67N26RC8LrUgyrGQJzQLxvlNx3e2dxKwFN
	 y9SjCT6AmYTsQGTgaXsfEd001c90Vzn4az3uibdgbvuC899iQ60U2IS5gr9pu9E8r6
	 7nNLq6kYb4IAkUtFR94PGsBAwU/u1+8L4yI+GYdK2ErxYt8MTOqoPJa9doLzj03zY7
	 WJOTgI6F7fswK+UgTQtWGFhj/0Nr4+y3nrRJ/yyK7GXU9Ay6jLRQlXpaCOXmYjAtL/
	 fdOfjGfkNSFpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 011/238] gen_compile_commands: fix invalid escape sequence warning
Date: Sun, 24 Mar 2024 19:36:39 -0400
Message-ID: <20240324234027.1354210-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 8bf55bb4f515c..96e4865ee934d 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -176,7 +176,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Use os.path.abspath() to normalize the path resolving '.' and '..' .
     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
-- 
2.43.0


