Return-Path: <linux-kernel+bounces-87015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4786CE44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D198E1C2180A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08541547E5;
	Thu, 29 Feb 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG/bI6e5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DE1547C0;
	Thu, 29 Feb 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221871; cv=none; b=TXRyvNlS3C3ZhJOUaEbxT9/t9K5WOEjqujxvp5sr1I5Elqgm72HH4RFT2pZzckWyfgLtRrVrHFeD3obHNxGPE8H+ZHeXsS44P1fxFFSFkyDF4XsaBclghef3mcey+shYRryUQI8U/loOFS3B9XT2C6+grI7v76O6hLgWQ+jPb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221871; c=relaxed/simple;
	bh=69LnKLUw/CQjKGQSReO/Q4FoKZ4LF/t7TUj6z3/ixkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu7poZZOLaVbjp1RdDKm0laiiqs9e2RwL0DeWOrqRZpa1E5YvTt2hmMqKIdcfIArMm7oGzi/XzvOGYm+SCoNifgK3B9J8wimDYqE+8fSsaHS7zTXtOVkFdcvd1qa6rybSrlNvr4VfjWOJYlk/i6GyATBv1xLBWGm9ICfsWTblJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG/bI6e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB9EC433A6;
	Thu, 29 Feb 2024 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221869;
	bh=69LnKLUw/CQjKGQSReO/Q4FoKZ4LF/t7TUj6z3/ixkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vG/bI6e5rfNDahHMEPZkpsug2URLCzd87SvqgrLr0K+deloLOSx6R39zdTZB5VKxu
	 Ntu0t/yi8J8A01iVcmOAk8DdSq2bUG/AGzxK44W0h2r8ZmImaH4OqHgIWm5xIUjpBY
	 gRxSDMB5MBr9ibnE7m+tjW7Mc8I1et4RPV3YBaDyHakZGSTJQ32gvdxtx7P6Y3vbx4
	 99wgbBkQw+UFnkkri0q0e3IIJ0Gm/NKEcgGA4vNmPFErKEKf6qcvT0bRQ4rk6YTYaU
	 UIxiAJeJv1zDdjIBDtguM0dyKZJGZAfV/KasExrHbwiU4/S+afkD51mNdV4wLyvGEM
	 IOig/uGqJCllg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev,
	linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 7/7] gen_compile_commands: fix invalid escape sequence warning
Date: Thu, 29 Feb 2024 10:50:56 -0500
Message-ID: <20240229155057.2850873-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155057.2850873-1-sashal@kernel.org>
References: <20240229155057.2850873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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


