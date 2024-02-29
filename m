Return-Path: <linux-kernel+bounces-86974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C608C86CDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043301C20CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F204AEDC;
	Thu, 29 Feb 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8jXWu1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596F6CC0E;
	Thu, 29 Feb 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221777; cv=none; b=AceajJha5FKX8H3tPYVdDuko5w6VyTcWJrzKz6E8eOcjEyMATr/uh6JiYZMqE2Vl9UVzbnH/grWft0ElgqoVnNY6q2Jr19wxZmnTf4POc76s2v9NC3pY1gfYz8REEjMSsfeVIgSDbYBqeLtyDHryrTEcAFrPpjEJFtu7QlwtGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221777; c=relaxed/simple;
	bh=3wlScet/gGLXlUYxf1X1RksuP6JQN/1vtVXO9KjdtqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5XbO1ZjVZL4jCjX9+CT8hm1Sx5S3AmMJNbgedpaGZgG5bOP1EHumMQxArqXw3KFO8w08zLrWCKCBL5Cft4csfxS7gNr2Mh+fsqMlie6Rjb6PNPzz5SN+e5Z7d6odvouJX2gl5u+CVAHaKstO7Xpb40IxkhDXO4ZphODl+F9TwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8jXWu1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2ABC43399;
	Thu, 29 Feb 2024 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221777;
	bh=3wlScet/gGLXlUYxf1X1RksuP6JQN/1vtVXO9KjdtqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8jXWu1UQ0XiYy7VfaEyYNgCM5+zhUEm4UmiNMRt2VgZLNnjQlIlctvXIh4iBJ0/3
	 Q/K4+jvUQ0sMVFJSUMt4n+uOvCJL4PhqS5UhFksDAL1M969aosOr2E0pyLTDWpLYQV
	 lBD0CW6DVqfnBPmqKEV4ogVsBNsT9/zg+1tb22Dqcl6DKepaLkWS5kYm4Cn15K4AA9
	 +thidoI6rC1HeI3dPJbWMUd4A4799iUCSAhKNRk4dOhO1gj69Voourn1D1aEz2Syzh
	 XFcc1tfMpisKGe9PjsR7O6OHUU5xuySrbuqYsxl79TvyV0BYuYxKE969y7Nh0wHgmk
	 3/HBf9baB+X6g==
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
Subject: [PATCH AUTOSEL 6.7 25/26] gen_compile_commands: fix invalid escape sequence warning
Date: Thu, 29 Feb 2024 10:48:44 -0500
Message-ID: <20240229154851.2849367-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 5dea4479240bc..e4fb686dfaa9f 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Return the canonical path, eliminating any symbolic links encountered in the path.
     abs_path = os.path.realpath(os.path.join(root_directory, file_path))
-- 
2.43.0


