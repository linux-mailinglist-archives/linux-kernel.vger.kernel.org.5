Return-Path: <linux-kernel+bounces-115335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40DC889ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010CF1C21975
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8A1E5F4C;
	Mon, 25 Mar 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0K3gwX9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385079DB9;
	Sun, 24 Mar 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320464; cv=none; b=tg2fx0JjdUWcTbsNzKRT/IaFQ4U5/XBQAPe4CoRo700P3ZnihDeJIIPt1Z3v/PvCK4QHENrLJmyBfW6TTjLikI5GVORu62yzGyh+ludvvyq1YbOBQTAehTCFswsXzg1S81yZ7t0FsZymKdTf3gliPypmdrLhRRoi3E70kWqpXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320464; c=relaxed/simple;
	bh=3wlScet/gGLXlUYxf1X1RksuP6JQN/1vtVXO9KjdtqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mpqwht+wOhrIFDRKVMiS1ayVikmBC12dNG3JDCQvMkTPYkA4cQjC/I4yKrgo3eg+KmB+7NPoSTMVV+HG8tWXLbj/G/vSVldGK6hbIlSzoHkLbqzQXjMEWWTAxCLYocJoXn9Wxge6uxF0bS3+ic7WnNPwOGNncLtlWaaOkMNAGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0K3gwX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3F5C43390;
	Sun, 24 Mar 2024 22:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320464;
	bh=3wlScet/gGLXlUYxf1X1RksuP6JQN/1vtVXO9KjdtqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0K3gwX9Gc+CVYZgdPMWXV7nRonHFm00YElGH/2CzRLXIEKylihy95vOQDEh8FXor
	 9mdqzr76wp5BCJpvWkbfbb2GcivuEppRZ7Yr4PF5YBhUnwN/6LyZUEY+gp99tRPqiC
	 HpJdcIoCD0VeT5Fly50erw1TOonDxgMcncjhPcXyxvVVgxJjmVh8KdcKob2NAlyelZ
	 ZZ0Fcut4ZStOTlcQNBF27sWHKMCoTg6q9YaUZkPD78gLL5jYcs5PKvqezeIGp3PZXn
	 EOud5CKnJ1eRAAVFYZuOhCN3C8yAxIG+c3mYRzHPK649cpSL4jjkqgjr7AefknXiw+
	 wfPZnP7giha+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 023/713] gen_compile_commands: fix invalid escape sequence warning
Date: Sun, 24 Mar 2024 18:35:49 -0400
Message-ID: <20240324224720.1345309-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


