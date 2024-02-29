Return-Path: <linux-kernel+bounces-87022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE1586CE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15AD1F237C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603615E04E;
	Thu, 29 Feb 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBiASsyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8915E03A;
	Thu, 29 Feb 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221885; cv=none; b=WYYlgL774JDHGQhD7fd+V4DYoEQmo0UIPaxyq9z3BnfbH6AI3UPDS5CbgHUvqt2Op76VP9th8Br5iyHPO0syaOzigOj6xK+vDrDLBX07Mbo7I8WvXzsguzzdqiCTcxY62QUO5qRDMlcvPBYomiIYt27ZZnbcXrmcU8zmciQ7JQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221885; c=relaxed/simple;
	bh=iDEiulklPJxiT0KxN848Zac4TFlvECiWKebGAJuHqZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9Go6UsWUZiBh8x4FdxRyuSbXKKTz8CCHljMhIRueoim7SU0tzH3Ko+Zid+CIuE5jbE+y6jFwJXEBfjclae9KKuoeQzC7aoN8cuU0RiptSCxA+FoQkHXKHU2TvJjipN6LXClva1bk4y+NZzb4czHsFjPfLEuifVHqxqLTR0ZD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBiASsyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8576C433F1;
	Thu, 29 Feb 2024 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221885;
	bh=iDEiulklPJxiT0KxN848Zac4TFlvECiWKebGAJuHqZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBiASsycXTDZ5NiRfOw1SSJuZsGWGjfc013+iG36KMlrmBFpE0o8Z9EW/D9UddWmQ
	 txexwDCboCQRZAqF/OBTcLvume2rG/cBm2xLnI8MSXyMATTYvQex1ncJL0ev7Ym8Ol
	 v40nkSSQ7ubqzMOvtiRQhWKfvr0MEO3S7cXehVIAhc+3MP6JtRSQziWMMDhRwzUPy9
	 herUJ76XMWT2Hwh/1YnIzKhcNRtoTwPuN5dnfbCbSUkt0Dg1972r3BoESLQZ+eoVfQ
	 ZXmXd2DAD5WT2kQQUUsla1qJatejSH3gRwR/kMhJ50q4UvKpSuIsv8tI6MOK/svu4H
	 0F+FBBnmH1oLw==
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
Subject: [PATCH AUTOSEL 5.10 7/7] gen_compile_commands: fix invalid escape sequence warning
Date: Thu, 29 Feb 2024 10:51:11 -0500
Message-ID: <20240229155112.2851155-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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


