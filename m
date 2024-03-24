Return-Path: <linux-kernel+bounces-114491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C08888AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3EB1F26940
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733702888F2;
	Sun, 24 Mar 2024 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d01wfdtb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798B14BFBD;
	Sun, 24 Mar 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321956; cv=none; b=JkMP5ctOjtKmIsukVwX0lf2AV9o/O/HvPKRAPCbNJQp96Ae+h0Yw/hPwjeAmbHygaa50rccbc3Dx8PhB0mN8sz5AK4SuGL9CQPFI++T6tCjlxaKczHNDrGTSmNuepGSZRlBRZGfj0y3xIHesks63H82cnkV8G9ImxaRl6KCA2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321956; c=relaxed/simple;
	bh=vdkbPj+PFhQKjWVJYcrhGD7J8o8ZdlE3izlhiVJaqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOv+bN/S6fPSZw8O2HFZS0oOvxdtm+n1akAezsvSRXveXwV6COxnB6wCpT/lcNC0WiuDfW3DG3UJdqz9qjRtweUOfG6Q9jppprqaXvMUyBAIRm7Quxlejcv0kc2lrNkuzL04B+lWYn9i4NvJyoR0PRNqmKKYfbqI8dKR0mFdrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d01wfdtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C09C43390;
	Sun, 24 Mar 2024 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321955;
	bh=vdkbPj+PFhQKjWVJYcrhGD7J8o8ZdlE3izlhiVJaqxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d01wfdtbxN3TDH/q6ZFcddxsioXDWP5DM4X5pfE7l4wlKewBcZEWk/BRwyU0G4K9t
	 L20w8M/YRsZtH827usBfatfjHyTsEviR0Dd2tsbXGqOP4dDYDPWue7X/qExnQMFCUI
	 fhhToNZD03pjSgoi/wOZ6e6P3GXEvO/4tHoYTnfObQAdinW47hWYIdbFYB3T4Z4LAv
	 N2+/g2JSNFNMRmWy7CRAuodRj74BV6ocpB2B7gyIJReU/u532lRWdiwTcolyb4eBPj
	 vD2A5nO9NzVmPBojGbDo2poXW8s2b4qC13XBG8uDoI7evEciUCz2dXE9RtaZYaynOe
	 npnj/B8g1aO7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/451] gen_compile_commands: fix invalid escape sequence warning
Date: Sun, 24 Mar 2024 19:05:03 -0400
Message-ID: <20240324231207.1351418-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


